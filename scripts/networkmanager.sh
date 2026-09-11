#!/bin/bash

OK="\e[0;32mOK\e[0m"

pacotes=(
    # gerenciamento de rede
    "networkmanager"
    "networkmanager-openvpn"

    # conexão via VPN
    "openvpn"

    # gerenciador GUI (opcional)
    "nm-connection-editor"
)

printf "\n"
printf " ##############################################\n"
printf " #       instalando networkmanager            #\n"
printf " ##############################################\n"
printf "\n"

sudo pacman --noconfirm -S "${pacotes[@]}"

printf "\n"
printf " Ativando NetworkManager...\n"

sudo systemctl enable NetworkManager
sudo systemctl start NetworkManager
# sudo systemctl enable --now NetworkManager

printf "\n$OK\n"

