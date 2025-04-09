#!/bin/bash

set -e

source "$(dirname "$0")/../scripts/funcoes.sh"

OK="\e[0;32mOK\e[0m"

pacotes=(
    # pacotes terminal
    "vim" # tui editor
    "fzf" # busca pelo terminal
    "ripgrep" # busca por letra
    "zoxide" # melhor cd
    "fastfetch" # informação sistema
    "eza" # melhor ls
    "rsync" # backup

    # pacotes auxiliares do terminal
    "git"
    "p7zip"

    # sistema
    "words"
)

printf "\n"
printf " ##############################################\n"
printf " #               instalando wsl               #\n"
printf " ##############################################\n"
printf "\n"

for pacote in "${pacotes[@]}"; do
    instala_pacote "$pacote"
done

./../scripts/zsh.sh
./../scripts/python.sh


./../dotfiles/install.sh

# copia o meu tema personalizado
cp -rv $HOME/arch-hertzog/gnome/dotfiles/themes/* $HOME/.themes

./../scripts/extensoes-gnome.sh

# carrega as configurações para o gnome
dconf load / < $HOME/arch-hertzog/gnome/dotfiles/config/dconf/user-settings.conf
