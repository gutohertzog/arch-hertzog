#!/bin/bash
set -Eeuo pipefail

# =============================================================================
# o keyd é usado para trocar de lugar as teclas abaixo
# Caps Lock <---> Left Ctrl
# https://archlinux.org/packages/extra/x86_64/keyd/
# =============================================================================

source "$(dirname "$0")/conf.sh"

CONFIG="/etc/keyd/default.conf"
ORIGEM="$HOME/arch-hertzog/dotfiles/config/keyd/default.conf"

pacotes=(
    "keyd"
)

printf "\n"
printf " ##############################################\n"
printf " #                    keyd                    #\n"
printf " ##############################################\n"
printf "\n"

printf " → Trocando Caps Lock e Left Ctrl\n"

instalar_pacotes "${pacotes[@]}"

printf " → Criando link simbólico para ${CONFIG}\n"
sudo ln -sfn "$ORIGEM" "$CONFIG"

# 'enable --now' habilita para o boot e inicia o serviço imediatamente.
printf "\n → Habilitando e iniciando o serviço do keyd"
sudo systemctl enable --now keyd
printf "${OK}"

printf "\n → Quando alterar, use o comando abaixo para recarregar"
printf "\n     → sudo keyd reload"
printf "${FIM}"

