#!/bin/bash

OK="\e[0;32mTerminado\e[0m"
ERR="\e[0;31mErro\e[0m"

TMP_FILE="$HOME/hosts"
DEST="/etc/hosts"
BACKUP="/etc/hosts.bak.$(date +%Y%m%d-%H%M%S)"

URL="https://raw.githubusercontent.com/StevenBlack/hosts/master/alternates/fakenews-gambling-porn/hosts"

printf "\n"
printf " ##############################################\n"
printf " #                   hosts                    #\n"
printf " ##############################################\n"
printf "\n"

# baixar lista
printf " → Baixando lista...\n"
if ! curl -fsSL "$URL" -o "$TMP_FILE"; then
    printf "$ERR: falha ao baixar hosts\n"
    exit 1
fi

# validar conteúdo mínimo
if ! grep -q "localhost" "$TMP_FILE"; then
    printf "$ERR: arquivo baixado parece inválido\n"
    exit 1
fi

# backup
printf " → Criando backup em $BACKUP\n"
sudo cp "$DEST" "$BACKUP"

# instalar novo hosts
printf " → Instalando novo hosts\n"
sudo mv "$TMP_FILE" "$DEST"
sudo chown root:root "$DEST"
sudo chmod 644 "$DEST"

# limpar cache DNS (systemd)
# printf " → Limpando cache DNS\n"
# sudo resolvectl flush-caches 2>/dev/null || true

# reiniciar NetworkManager (opcional)
printf " → Reiniciando NetworkManager\n"
sudo systemctl restart NetworkManager.service

printf "\n$OK\n"
