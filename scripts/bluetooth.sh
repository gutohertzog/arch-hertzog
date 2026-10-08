#!/bin/bash
set -Eeuo pipefail

# =============================================================================
# https://archlinux.org/packages/extra/x86_64/bluez/
# https://archlinux.org/packages/extra/x86_64/bluez-utils/
# =============================================================================

source "$(dirname "$0")/conf.sh"

pacotes=(
    "bluez" # Daemons for the bluetooth protocol stack
    "bluez-utils" # Development and debugging utilities for the bluetooth protocol stack
)

printf "\n"
printf " ##############################################\n"
printf " #                  bluetooth                 #\n"
printf " ##############################################\n"
printf "\n"

instalar_pacotes "${pacotes[@]}"

printf " → Ativando bluetooth\n"
sudo systemctl enable --now bluetooth
printf "${OK}"

printf "${FIM}"

