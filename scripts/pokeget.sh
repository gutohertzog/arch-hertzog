#!/usr/bin/env bash
set -Eeuo pipefail

# =============================================================================
# https://github.com/talwat/pokeget-rs
# =============================================================================

source "$(dirname "$0")/conf.sh"

set -euo pipefail

VERSION="1.6.7"
APP_DIR="${HOME}/Apps"
APP_NAME="pokeget"

BASE_URL="https://github.com/talwat/pokeget-rs/releases/download/${VERSION}"
URL="${BASE_URL}/pokeget-Linux-x86_64.tar.gz"

printf " → Criando diretório Apps\n"
mkdir -p "$APP_DIR"
printf "${OK}"

printf " → Ajustando arquivo e pasta temporários\n"
TMP_FILE="$(mktemp --suffix=.tar.gz)"
TMP_DIR="$(mktemp -d)"
trap 'rm -f "$TMP_FILE"; rm -rf "$TMP_DIR"' EXIT

printf " → Baixando pokeget v${VERSION}\n"
curl -fL "$URL" -o "$TMP_FILE"
printf "${OK}"

printf " → Extraindo\n"
tar -xzf "$TMP_FILE" -C "$TMP_DIR"
printf "${OK}"

printf " → Movendo para ${APP_DIR}\n"
mv "$TMP_DIR/pokeget" "$APP_DIR/$APP_NAME"
printf "${OK}"

printf " → Deixando executável\n"
chmod +x "$APP_DIR/$APP_NAME"
printf "${OK}"

printf " → Instalado em ${APP_DIR}/${APP_NAME}\n"

printf "${FIM}"

