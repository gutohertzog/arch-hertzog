#!/bin/bash
set -Eeuo pipefail

# Lista de mapeamentos:
# "pasta_local|caminho_remoto|usuario_padrao|dominio"
# - usuario_padrao e dominio são opcionais (podem ficar vazios)
# - o usuário padrão é só sugestão: no prompt, basta dar Enter para aceitá-lo
MAPEAMENTOS=(
    "root|//meu.servidor" # ou "root|//meu.servidor|" ou "root|//meu.servidor||"
    "root|//meu.servidor|meu.usuario"
    "root|//meu.servidor|meu.usuario|meu.dominio"
)

# Número de tentativas por conexão (ex.: senha digitada errada)
MAX_TENTATIVAS=3

# Arquivo temporário de credenciais (evita senha visível no `ps`)
CRED_FILE=""
limpar() {
    [ -n "$CRED_FILE" ] && rm -f "$CRED_FILE"
}
trap limpar EXIT

# Pede a senha do sudo uma vez no início, para não misturar com os prompts
sudo -v

for MAPEAMENTO in "${MAPEAMENTOS[@]}"; do

    IFS='|' read -r PASTA CAMINHO USUARIO_PADRAO DOMINIO <<< "$MAPEAMENTO"

    PASTA_LOCAL="$HOME/$PASTA"

    echo "----------------------------------------"
    echo "Verificando: $PASTA_LOCAL"
    echo "Origem:      $CAMINHO"

    # Cria a pasta se não existir
    if [ ! -d "$PASTA_LOCAL" ]; then
        echo "Pasta não existe. Criando..."
        if ! mkdir -p "$PASTA_LOCAL"; then
            echo "ERRO: não foi possível criar $PASTA_LOCAL"
            continue
        fi
    fi

    # Verifica se já está montada (antes de pedir credenciais)
    if mountpoint -q "$PASTA_LOCAL"; then
        echo "Já está montado. Pulando..."
        continue
    fi

    # Pergunta se quer montar esta conexão
    read -r -p "Montar esta conexão? [S/n] " RESP
    if [[ "${RESP,,}" == "n" ]]; then
        echo "Pulando..."
        continue
    fi

    MONTADO=false
    for ((TENTATIVA = 1; TENTATIVA <= MAX_TENTATIVAS; TENTATIVA++)); do

        # Usuário (com sugestão padrão)
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

        # Senha (sem eco no terminal)
        read -r -s -p "Senha para $USUARIO: " SENHA
        echo

        # Grava credenciais num arquivo temporário legível só pelo usuário
        CRED_FILE="$(mktemp)"
        chmod 600 "$CRED_FILE"
        {
            printf 'username=%s\n' "$USUARIO"
            printf 'password=%s\n' "$SENHA"
            [ -n "$DOMINIO" ] && printf 'domain=%s\n' "$DOMINIO"
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
            break
        fi

        echo "ERRO ao montar $CAMINHO (tentativa $TENTATIVA de $MAX_TENTATIVAS)"
    done

    if ! $MONTADO; then
        echo "Desistindo de $CAMINHO."
    fi

done

echo "----------------------------------------"
echo "Processo concluído."

