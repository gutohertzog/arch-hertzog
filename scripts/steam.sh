#!/bin/bash
set -Eeuo pipefail

# =============================================================================
# https://archlinux.org/packages/multilib/x86_64/steam/
# https://archlinux.org/packages/multilib/x86_64/lib32-nvidia-utils/
#
# lembre de ativar multilib em /etc/pacman.conf
#
#   [multilib]
#   Include = /etc/pacman.d/mirrorlist

# =============================================================================

source "$(dirname "$0")/conf.sh"

pacotes=(
    steam # Valve's digital software delivery system
    lib32-nvidia-utils # NVIDIA drivers utilities (32-bit)
)

printf "\n"
printf " ##############################################\n"
printf " #                   steam                    #\n"
printf " ##############################################\n"
printf "\n"

instalar_pacotes "${pacotes[@]}"

printf "${FIM}"

