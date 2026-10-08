#!/usr/bin/env bash
# Arch Linux + systemd. Execute como usuário normal: ./scripts/adguardhome.sh
# Instalações existentes são reutilizadas, sem atualizar o binário ou apagar dados.
# API: https://github.com/AdguardTeam/AdGuardHome/blob/master/openapi/openapi.yaml
set -Eeuo pipefail

INSTALL_DIR=/opt/AdGuardHome
NM_CONFIG=/etc/NetworkManager/conf.d/90-adguardhome.conf
TMP_DIR=''
DNS_BACKUP=''
DNS_PENDING=0

die() {
    printf 'ERRO: %s\n' "$*" >&2
    exit 1
}

restore_dns() {
    printf '\nRestaurando DNS; backup em %s\n' "$DNS_BACKUP" >&2
    # -a preserva inclusive o destino de um resolv.conf que era link simbólico.
    sudo cp -a --remove-destination "$DNS_BACKUP/resolv.conf" /etc/resolv.conf || return 1
    if sudo test -e "$DNS_BACKUP/networkmanager.conf" || sudo test -L "$DNS_BACKUP/networkmanager.conf"; then
        sudo cp -a --remove-destination "$DNS_BACKUP/networkmanager.conf" "$NM_CONFIG" || return 1
    else
        sudo rm -f -- "$NM_CONFIG" || return 1
    fi
    sudo systemctl reload NetworkManager || return 1
}

cleanup() {
    local status=$?
    trap - EXIT
    if (( DNS_PENDING )); then
        if ! restore_dns; then
            printf 'Falha na restauração automática. Preserve o backup: %s\n' "$DNS_BACKUP" >&2
        fi
        status=1
    fi
    if [[ -n "$TMP_DIR" ]]; then
        rm -rf -- "$TMP_DIR"
    fi
    exit "$status"
}

# POSTs recebem JSON pela entrada padrão; credenciais não vão nos argumentos.
api() {
    local method=$1 endpoint=$2
    local -a args=(
        --silent --show-error --fail --connect-timeout 10 --max-time 180
        --noproxy '*' --cookie "$TMP_DIR/cookies" --cookie-jar "$TMP_DIR/cookies"
        --request "$method"
    )
    if [[ "$method" == POST ]]; then
        args+=(--header 'Content-Type: application/json' --data-binary @-)
    fi
    curl "${args[@]}" "$ADGUARD_URL/control/$endpoint"
}

install_service() {
    local load_state arch
    load_state=$(systemctl show AdGuardHome.service --property=LoadState --value)
    if [[ "$load_state" == not-found ]]; then
        if ! sudo test -e "$INSTALL_DIR"; then
            case "$(uname -m)" in
                x86_64) arch=amd64 ;;
                aarch64) arch=arm64 ;;
                armv7l) arch=armv7 ;;
                *) die "Arquitetura não suportada: $(uname -m)" ;;
            esac
            printf '\nBaixando AdGuard Home (%s)...\n' "$arch"
            curl --fail --show-error --location --connect-timeout 10 --max-time 180 \
                "https://static.adguard.com/adguardhome/release/AdGuardHome_linux_${arch}.tar.gz" \
                --output "$TMP_DIR/adguardhome.tar.gz"
            tar -xzf "$TMP_DIR/adguardhome.tar.gz" -C "$TMP_DIR"
            [[ -f "$TMP_DIR/AdGuardHome/AdGuardHome" ]] || die 'Arquivo baixado sem o binário esperado.'
            sudo install -d -m 755 "$INSTALL_DIR"
            sudo install -m 755 "$TMP_DIR/AdGuardHome/AdGuardHome" "$INSTALL_DIR/AdGuardHome"
        fi
        sudo test -x "$INSTALL_DIR/AdGuardHome" || die "$INSTALL_DIR já existe, mas não contém um binário executável."
        # O serviço precisa deste diretório permanentemente, inclusive após reboot.
        (cd "$INSTALL_DIR" && sudo ./AdGuardHome -s install)
    elif [[ "$load_state" != loaded ]]; then
        die "O serviço AdGuardHome está em estado '$load_state'. Verifique a unidade antes de continuar."
    else
        printf '\nReutilizando o serviço AdGuardHome existente.\n'
    fi
    sudo systemctl enable --now AdGuardHome.service
    systemctl is-active --quiet AdGuardHome.service || die 'O serviço não iniciou. Consulte journalctl -u AdGuardHome.'
}

login() {
    local address username password
    printf '\nSe esta é a primeira instalação, abra http://127.0.0.1:3000 nesta máquina.\n'
    printf 'Conclua o assistente, crie o usuário e configure o DNS para atender em 127.0.0.1:53.\n'
    printf 'Use upstreams independentes do DNS desta máquina, para evitar um ciclo de resolução.\n'
    printf 'Depois informe abaixo o endereço FINAL do painel (a porta pode mudar no assistente).\n'
    read -r -p "URL local do painel [${ADGUARD_URL:-http://127.0.0.1}]: " address
    ADGUARD_URL=${address:-${ADGUARD_URL:-http://127.0.0.1}}
    ADGUARD_URL=${ADGUARD_URL%/}
    # Este instalador administra o serviço local; não envia credenciais a outro host.
    [[ "$ADGUARD_URL" =~ ^https?://(127\.0\.0\.1|localhost|\[::1\])(:[0-9]+)?$ ]] || die 'Informe uma URL de loopback, sem caminho, usuário ou senha.'
    read -r -p 'Usuário do AdGuard: ' username
    read -r -s -p 'Senha do AdGuard: ' password
    printf '\n'
    [[ -n "$username" && -n "$password" ]] || die 'Usuário e senha são obrigatórios.'
    # /login cria uma sessão em cookie, não retorna um token Bearer.
    if ! printf '%s\0%s' "$username" "$password" |
        jq -Rs 'split("\u0000") | {name: .[0], password: .[1]}' |
        api POST login > /dev/null; then
        unset password
        die 'Falha no login. Verifique a URL, as credenciais e se o assistente inicial foi concluído.'
    fi
    unset password
    api GET status | jq -e '.running == true and .dns_port == 53' > /dev/null ||
        die 'O AdGuard precisa estar executando o DNS na porta 53 antes de continuar.'
}

add_list() {
    local name=$1 url=$2
    if jq -e --arg url "$url" 'any(.filters[]?; .url == $url)' "$TMP_DIR/filters.json" > /dev/null; then
        printf 'Lista já cadastrada, preservando suas opções: %s\n' "$name"
        return
    fi
    printf 'Adicionando lista: %s\n' "$name"
    jq -n --arg name "$name" --arg url "$url" '{name: $name, url: $url, whitelist: false}' |
        api POST filtering/add_url > /dev/null
}

configure_filters() {
    api GET filtering/status > "$TMP_DIR/filters.json"
    jq -e 'has("filters") and has("user_rules") and
        ((.filters // []) | type) == "array" and ((.user_rules // []) | type) == "array"' \
        "$TMP_DIR/filters.json" > /dev/null || die 'Resposta inesperada ao consultar as listas.'

    local base=https://raw.githubusercontent.com/StevenBlack/hosts/master
    add_list 'StevenBlack - Unified hosts (adware + malware)' "$base/hosts"
    add_list 'StevenBlack - Fakenews' "$base/alternates/fakenews-only/hosts"
    add_list 'StevenBlack - Gambling' "$base/alternates/gambling-only/hosts"
    add_list 'StevenBlack - Porn' "$base/alternates/porn-only/hosts"
    add_list 'StevenBlack - Social' "$base/alternates/social-only/hosts"

    # set_rules substitui o conjunto inteiro. Leia novamente e preserve as regras
    # existentes e sua ordem, acrescentando somente as exceções que faltam.
    api GET filtering/status > "$TMP_DIR/filters.json"
    jq -e 'has("user_rules") and ((.user_rules // []) | type) == "array"' "$TMP_DIR/filters.json" > /dev/null
    jq '{rules: (reduce ["@@||whatsapp.com^", "@@||whatsapp.net^"][] as $rule
        (.user_rules // []; if index($rule) == null then . + [$rule] else . end))}' \
        "$TMP_DIR/filters.json" | api POST filtering/set_rules > /dev/null
}

check_dns() {
    local answer
    answer=$(dig "$@" archlinux.org A +time=3 +tries=1 +noall +comments +answer) || return 1
    # dig também retorna zero para SERVFAIL; valide o status e uma resposta útil.
    [[ "$answer" == *'status: NOERROR,'* ]] &&
        awk '$4 == "A" && $5 != "0.0.0.0" {found=1} END {exit !found}' <<< "$answer"
}

configure_system_dns() {
    local answer staged_resolv
    printf '\nUsar o AdGuard como DNS desta máquina?\n'
    printf 'Isso fixa o DNS em 127.0.0.1; DNS recebido por DHCP/VPN deixará de ser usado por resolv.conf.\n'
    read -r -p 'Aplicar essa alteração com backup? [s/N]: ' answer
    case "$answer" in
        s|S|sim|SIM) ;;
        *) printf 'DNS do sistema mantido.\n'; return ;;
    esac
    systemctl is-active --quiet NetworkManager || die 'A configuração automática de DNS requer NetworkManager ativo.'
    # nss-resolve pode ignorar resolv.conf. Não altere parcialmente esse cenário.
    if systemctl is-active --quiet systemd-resolved; then
        die 'systemd-resolved está ativo. Configure sua integração com o AdGuard separadamente; DNS não alterado.'
    fi
    check_dns @127.0.0.1 || die 'O DNS local não resolveu archlinux.org. DNS do sistema não alterado.'
    [[ -e /etc/resolv.conf || -L /etc/resolv.conf ]] || die '/etc/resolv.conf ausente; configure o resolvedor antes de continuar.'

    sudo install -d -m 755 /var/backups /etc/NetworkManager/conf.d
    DNS_BACKUP=$(sudo mktemp -d /var/backups/adguardhome-dns.XXXXXXXX)
    sudo cp -a /etc/resolv.conf "$DNS_BACKUP/resolv.conf"
    if [[ -e "$NM_CONFIG" || -L "$NM_CONFIG" ]]; then
        sudo cp -a "$NM_CONFIG" "$DNS_BACKUP/networkmanager.conf"
    fi
    printf 'Backup do DNS: %s\n' "$DNS_BACKUP"
    # Qualquer falha ou interrupção a partir daqui restaura os arquivos anteriores.
    DNS_PENDING=1
    printf '[main]\ndns=none\n' > "$TMP_DIR/networkmanager.conf"
    sudo install -m 644 "$TMP_DIR/networkmanager.conf" "$NM_CONFIG"
    sudo systemctl reload NetworkManager

    # Substitua o link em vez de escrever no arquivo para o qual ele aponta.
    # O arquivo temporário em /etc permite a troca por rename no mesmo filesystem.
    staged_resolv=$(sudo mktemp /etc/resolv.conf.adguardhome.XXXXXXXX)
    printf 'nameserver 127.0.0.1\n' | sudo tee "$staged_resolv" > /dev/null
    sudo chmod 644 "$staged_resolv"
    sudo mv -Tf "$staged_resolv" /etc/resolv.conf
    check_dns || die 'A resolução falhou após a troca do DNS.'
    DNS_PENDING=0
    printf 'DNS local configurado. Backup preservado em %s\n' "$DNS_BACKUP"
}

main() {
    [[ $EUID -ne 0 ]] || die 'Execute como usuário normal; o script usa sudo quando necessário.'
    [[ -t 0 ]] || die 'Execute em um terminal interativo para configurar o painel e informar as credenciais.'
    command -v pacman > /dev/null || die 'Este script requer Arch Linux e pacman.'
    sudo -v
    sudo pacman -S --needed --noconfirm curl jq bind tar
    umask 077
    TMP_DIR=$(mktemp -d)
    trap cleanup EXIT
    trap 'exit 130' INT
    trap 'exit 143' TERM
    trap 'printf "ERRO: etapa interrompida na linha %s.\n" "$LINENO" >&2' ERR

    printf '\nAdGuard Home + listas StevenBlack\n'
    install_service
    login
    configure_filters
    configure_system_dns
    printf '\nAdGuard Home configurado. Painel: %s\n' "$ADGUARD_URL"
}

if [[ "${BASH_SOURCE[0]}" == "$0" ]]; then
    main "$@"
fi

