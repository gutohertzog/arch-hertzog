#!/bin/bash

OK="\e[0;32mOK\e[0m"

pacotes=(
    # servidor de áudio
    "pipewire"
    "pipewire-alsa"
    "pipewire-audio"
    "pipewire-pulse"
    "wireplumber"

    # gerenciador de sessão
    "pipewire-session-manager"

    # suporte a Bluetooth
    "bluez"
    "bluez-utils"
)

printf "\n"
printf " ##############################################\n"
printf " #           instalando pipewire              #\n"
printf " ##############################################\n"
printf "\n"

sudo pacman --noconfirm -S "${pacotes[@]}"

printf "\n"
printf " Ativando Bluetooth...\n"

sudo systemctl enable --now bluetooth

printf "\n$OK\n"

