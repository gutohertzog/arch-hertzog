#!/bin/bash
OK="\e[0;32mOK\e[0m"

printf "\n"
printf " ##############################################\n"
printf " #                   steam                    #\n"
printf " ##############################################\n"
printf "\n"

# lembre de ativar multilib
#   /etc/pacman.conf
#
#   [multilib]
#   Include = /etc/pacman.d/mirrorlist

printf " lib32-nvidia-utils.........................."
sudo pacman -S lib32-nvidia-utils
printf "$OK\n"

printf " steam......................................."
sudo pacman -S steam
printf "$OK\n"
