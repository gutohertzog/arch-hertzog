#!/bin/bash

clear

# exporta as configurações do Gnome
printf "Exportando as configurações do GNOME\n"
dconf dump / > $HOME/arch-hertzog/gnome/dotfiles/config/dconf/user-settings.conf
