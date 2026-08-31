#!/bin/bash

OK="\e[0;32mOK\e[0m"

pacotes=(
    "nvidia-open"
    "nvidia-utils"
    "nvidia-settings"
)

printf "\n"
printf " ##############################################\n"
printf " #             instalando nvidia              #\n"
printf " ##############################################\n"
printf "\n"

sudo pacman --noconfirm -S "${pacotes[@]}"

printf "\n$OK\n"

