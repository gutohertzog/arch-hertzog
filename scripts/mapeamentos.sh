#!/bin/bash
set -Eeuo pipefail

# Uso:
#   ./monta.sh              -> pergunta se quer montar ou desmontar
#   ./monta.sh montar       -> monta direto
#   ./monta.sh desmontar    -> desmonta direto
#
# Arquivo de servidores: servidores.conf, na mesma pasta do script
# (ou outro caminho via variável MONTA_CONF=/caminho/arquivo ./monta.sh)

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONF="${MONTA_CONF:-$SCRIPT_DIR/servidores.conf}"

# Número de tentativas por conexão (ex.: senha digitada errada)
MAX_TENTATIVAS=3

# Arquivo temporário de credenciais (evita senha visível no `ps`)
CRED_FILE=""
limpar() {
    [ -n "$CRED_FILE" ] && rm -f "$CRED_FILE"
    return 0
}
trap limpar EXIT

# ----------------------------------------------------------------------
# Monta um compartilhamento: monta_um <pasta> <caminho> <usuario> <dominio>
# ----------------------------------------------------------------------
monta_um() {
    local PASTA="$1" CAMINHO="$2" USUARIO_PADRAO="$3" DOMINIO="$4"
    local PASTA_LOCAL="$HOME/$PASTA"
    local USUARIO SENHA RESP TENTATIVA MONTADO=false

    echo "----------------------------------------"
    echo "Verificando: $PASTA_LOCAL"
    echo "Origem:      $CAMINHO"
    echo "Domínio:     ${DOMINIO:-nenhum}"

    # Prefixo no estilo Windows: DOMINIO\usuario ou .\usuario
    local PREFIXO="${DOMINIO:-.}"

    if [ ! -d "$PASTA_LOCAL" ]; then
        echo "Pasta não existe. Criando..."
        if ! mkdir -p "$PASTA_LOCAL"; then
            echo "ERRO: não foi possível criar $PASTA_LOCAL"
            return 0
        fi
    fi

    if mountpoint -q "$PASTA_LOCAL"; then
        echo "Já está montado. Pulando..."
        return 0
    fi

    read -r -p "Montar esta conexão? [S/n] " RESP
    if [[ "${RESP,,}" == "n" ]]; then
        echo "Pulando..."
        return 0
    fi

    for ((TENTATIVA = 1; TENTATIVA <= MAX_TENTATIVAS; TENTATIVA++)); do

        if [ -n "$USUARIO_PADRAO" ]; then
            read -r -p "Usuário [$USUARIO_PADRAO]: " USUARIO
            USUARIO="${USUARIO:-$USUARIO_PADRAO}"
        else
            read -r -p "Usuário: " USUARIO
        fi

        if [ -z "$USUARIO" ]; then
            echo "Usuário vazio. Tente novamente."
            continue
        fi

        read -r -s -p "Senha para $PREFIXO\\$USUARIO: " SENHA
        echo

        CRED_FILE="$(mktemp)"
        chmod 600 "$CRED_FILE"
        {
            printf 'username=%s\n' "$USUARIO"
            printf 'password=%s\n' "$SENHA"
            if [ -n "$DOMINIO" ]; then printf 'domain=%s\n' "$DOMINIO"; fi
        } > "$CRED_FILE"
        unset SENHA

        echo "Montando..."
        if sudo mount -t cifs "$CAMINHO" "$PASTA_LOCAL" \
            -o "credentials=$CRED_FILE,uid=$(id -u),gid=$(id -g)"; then
            MONTADO=true
        fi

        rm -f "$CRED_FILE"
        CRED_FILE=""

        if $MONTADO; then
            echo "Montagem realizada com sucesso!"
            return 0
        fi

        echo "ERRO ao montar $CAMINHO (tentativa $TENTATIVA de $MAX_TENTATIVAS)"
    done

    echo "Desistindo de $CAMINHO."
}

# ----------------------------------------------------------------------
# Lê o arquivo de servidores e monta cada linha válida
# ----------------------------------------------------------------------
montar() {
    if [ ! -f "$CONF" ]; then
        echo "ERRO: arquivo de servidores não encontrado: $CONF"
        echo "Dica: copie servidores.conf.exemplo para servidores.conf e edite."
        exit 1
    fi

    echo "Lendo servidores de: $CONF"

    local LINHA PASTA CAMINHO USUARIO DOMINIO
    # Lê do descritor 3 para não conflitar com os `read` do teclado
    while IFS= read -r LINHA <&3 || [ -n "$LINHA" ]; do
        # Remove espaços no início e no fim
        LINHA="${LINHA#"${LINHA%%[![:space:]]*}"}"
        LINHA="${LINHA%"${LINHA##*[![:space:]]}"}"

        # Pula linhas vazias e comentários
        [ -z "$LINHA" ] && continue
        [[ "$LINHA" == \#* ]] && continue

        IFS='|' read -r PASTA CAMINHO USUARIO DOMINIO <<< "$LINHA"

        if [ -z "$PASTA" ] || [ -z "$CAMINHO" ]; then
            echo "----------------------------------------"
            echo "AVISO: linha inválida, ignorando: $LINHA"
            continue
        fi

        monta_um "$PASTA" "$CAMINHO" "${USUARIO:-}" "${DOMINIO:-}"
    done 3< "$CONF"
}

# ----------------------------------------------------------------------
# Desmonta todos os compartilhamentos CIFS montados dentro do $HOME
# (independe do arquivo: pega até os que foram comentados depois)
# ----------------------------------------------------------------------
desmontar() {
    local ALVO
    local -a ALVOS=()

    while IFS= read -r ALVO; do
        [[ "$ALVO" == "$HOME"/* ]] && ALVOS+=("$ALVO")
    done < <(findmnt -ln -t cifs -o TARGET || true)

    if [ ${#ALVOS[@]} -eq 0 ]; then
        echo "Nenhum compartilhamento CIFS montado em $HOME."
        return 0
    fi

    # Desmonta do mais profundo para o mais raso (caso haja aninhamento)
    mapfile -t ALVOS < <(printf '%s\n' "${ALVOS[@]}" | sort -r)

    for ALVO in "${ALVOS[@]}"; do
        echo "----------------------------------------"
        echo "Desmontando: $ALVO"
        if sudo umount "$ALVO"; then
            echo "Desmontado com sucesso!"
        else
            echo "ERRO ao desmontar $ALVO (algum programa usando a pasta?)"
        fi
    done
}

# ----------------------------------------------------------------------
# Principal
# ----------------------------------------------------------------------
ACAO="${1:-}"

if [ -z "$ACAO" ]; then
    echo "O que deseja fazer?"
    echo "  1) Montar"
    echo "  2) Desmontar"
    read -r -p "Opção [1]: " ACAO
    ACAO="${ACAO:-1}"
fi

case "${ACAO,,}" in
    1|m|montar)     ACAO=montar ;;
    2|d|desmontar)  ACAO=desmontar ;;
    *)
        echo "Opção inválida: $ACAO"
        exit 1
        ;;
esac

# Pede a senha do sudo uma vez no início, para não misturar com os prompts
sudo -v

"$ACAO"

echo "----------------------------------------"
echo "Processo concluído."

