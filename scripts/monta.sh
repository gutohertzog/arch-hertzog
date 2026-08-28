#!/bin/bash

# usuário para conexão
USUARIO="meu.usuario"

# Lista de mapeamentos:
# "pasta|caminho_remoto"
MAPEAMENTOS=(
    "root|//meu.servidor"
)

for MAPEAMENTO in "${MAPEAMENTOS[@]}"; do

    PASTA="${MAPEAMENTO%%|*}"
    CAMINHO="${MAPEAMENTO#*|}"

    PASTA_LOCAL="$HOME/$PASTA"

    echo "----------------------------------------"
    echo "Verificando: $PASTA_LOCAL"
    echo "Origem:      $CAMINHO"

    # Cria a pasta se não existir
    if [ ! -d "$PASTA_LOCAL" ]; then
        echo "Pasta não existe. Criando..."
        mkdir -p "$PASTA_LOCAL"

        if [ $? -ne 0 ]; then
            echo "ERRO: não foi possível criar $PASTA_LOCAL"
            continue
        fi
    fi

    # Verifica se já está montada
    if mountpoint -q "$PASTA_LOCAL"; then
        echo "Já está montado. Pulando..."
        continue
    fi

    # Monta o compartilhamento
    echo "Montando..."

    sudo mount -t cifs "$CAMINHO" "$PASTA_LOCAL" -o username=$USUARIO

    if [ $? -eq 0 ]; then
        echo "Montagem realizada com sucesso!"
    else
        echo "ERRO ao montar $CAMINHO"
    fi

done

echo "----------------------------------------"
echo "Processo concluído."

