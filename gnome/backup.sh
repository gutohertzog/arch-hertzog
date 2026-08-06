#!/bin/bash

clear

# exporta as configurações do Gnome
printf "Exportando as configurações do GNOME\n"
dconf dump / | sed 's|/home/guto|/home/$USER|g' > $HOME/arch-hertzog/gnome/dotfiles/config/dconf/user-settings.conf
