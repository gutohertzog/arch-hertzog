#!/bin/bash

set -e

pacotes=(
    # pacotes terminal
    "vim" # tui editor
    "fzf" # busca pelo terminal
    "ripgrep" # busca por letra
    "zoxide" # melhor cd
    "fastfetch" # informação sistema
    "eza" # melhor ls
    # "rsync" # backup

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

sudo pacman --noconfirm -S "${pacotes[@]}"

./../scripts/zsh.sh
./../scripts/python.sh

ln -s $HOME/arch-hertzog/dotfiles/.zshrc $HOME/.zshrc
ln -s $HOME/arch-hertzog/dotfiles/.p10k.zsh $HOME/.p10k.zsh
ln -s $HOME/arch-hertzog/dotfiles/config/vim $HOME/.config/vim
ln -s $HOME/arch-hertzog/dotfiles/config/fastfetch $HOME/.config/fastfetch
ln -s $HOME/arch-hertzog/gnome/dotfiles/.profile $HOME/.profile
ln -s $HOME/arch-hertzog/gnome/dotfiles/.XCompose $HOME/.XCompose
