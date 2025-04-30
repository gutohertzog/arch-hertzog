#!/bin/bash

clear

printf "Realizando backup das pastas do sistema\n"

printf "Copiando arquivos\n"
# $HOME/arch-hertzog/dotfiles/backup.sh

# exporta as configurações do Gnome
printf "Exportando as configurações do GNOME\n"
dconf dump / | sed 's|/home/guto|/home/$USER|g' > $HOME/arch-hertzog/gnome/dotfiles/config/dconf/user-settings.conf

# remove arquivos para receber os atualizados
# rm -rfv $HOME/arch-hertzog/gnome/dotfiles/config/meus_scripts

# cp -rv $HOME/.config/meus_scripts $HOME/arch-hertzog/gnome/dotfiles/config
