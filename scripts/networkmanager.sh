#!/bin/bash
set -Eeuo pipefail

# -----------------------------------------------------------------------------
# https://archlinux.org/packages/extra/x86_64/networkmanager/
# https://archlinux.org/packages/extra/x86_64/networkmanager-openvpn/
# https://archlinux.org/packages/extra/x86_64/nm-connection-editor/
# https://archlinux.org/packages/extra/x86_64/openvpn/
# -----------------------------------------------------------------------------

source "$(dirname "$0")/conf.sh"

pacotes=(
    "networkmanager" # Network connection manager and user applications

    "openvpn" # An easy-to-use, robust and highly configurable VPN (Virtual Private Network)
    "networkmanager-openvpn" # NetworkManager VPN plugin for OpenVPN (with GUI)

    "nm-connection-editor" # NetworkManager GUI connection editor and widgets
)

printf "\n"
printf " ##############################################\n"
printf " #               networkmanager               #\n"
printf " ##############################################\n"
printf "\n"

instalar_pacotes "${pacotes[@]}"

printf " → Ativando NetworkManager\n"
sudo systemctl enable NetworkManager
sudo systemctl start NetworkManager
# sudo systemctl enable --now NetworkManager
printf "${OK}"

printf "${FIM}"

