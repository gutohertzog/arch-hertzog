#!/bin/bash

clear

printf "Realizando backup das pastas\n"

printf "Copiando arquivos\n"
cp -v $HOME/.zshrc $HOME/arch-gnome/dotfiles/

cp -rv $HOME/.config/vim $HOME/arch-gnome/dotfiles/config
cp -rv $HOME/.config/neofetch $HOME/arch-gnome/dotfiles/config

