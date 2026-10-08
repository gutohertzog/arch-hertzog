#!/bin/bash
set -Eeuo pipefail

# -----------------------------------------------------------------------------
# https://github.com/StevenBlack/hosts
# -----------------------------------------------------------------------------

source "$(dirname "$0")/conf.sh"

TMP_FILE="$HOME/hosts"
DEST="/etc/hosts"
BACKUP="/etc/hosts.bak.$(date +%Y%m%d-%H%M%S)"

URL_BASE="https://raw.githubusercontent.com/StevenBlack/hosts"
URL_ALT="/master/alternates/fakenews-gambling-porn/hosts"
URL="$URL_BASE$URL_ALT"

printf "\n"
printf " ##############################################\n"
printf " #                   hosts                    #\n"
printf " ##############################################\n"
printf "\n"

printf " → Baixando lista\n"
if ! curl -fsSL "$URL" -o "$TMP_FILE"; then
    printf "${ERRO} falha ao baixar hosts\n"
    exit 1
fi
printf "${OK}"

printf " → Validando arquivo\n"
if ! grep -q "localhost" "$TMP_FILE"; then
    printf "${ERRO} arquivo baixado parece inválido\n"
    exit 1
fi
printf "${OK}"

printf " → Criando backup em $BACKUP\n"
sudo cp "$DEST" "$BACKUP"
printf "${OK}"

printf " → Instalando novo hosts\n"
sudo mv "$TMP_FILE" "$DEST"
sudo chown root:root "$DEST"
sudo chmod 644 "$DEST"
printf "${OK}"

# limpar cache DNS (systemd)
# printf " → Limpando cache DNS\n"
# sudo resolvectl flush-caches 2>/dev/null || true
# printf "${OK}"

printf " → Reiniciando NetworkManager\n"
sudo systemctl restart NetworkManager.service
printf "${OK}"

printf "${FIM}"

