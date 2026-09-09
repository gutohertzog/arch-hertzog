#!/bin/bash

OK="\e[0;32mOK\e[0m"

printf " copiando ícone papirus......................"
wget -qO- https://git.io/papirus-icon-theme-install | env DESTDIR="$HOME/.icons" sh
rm -rf $HOME/.icons/ePapirus* # remove ícones não necessários
printf "$OK\n"

printf " copiando bibata cursores...................."
for f in $HOME/arch-hertzog/dotfiles/icons/*.tar.xz; do tar xfv "$f" -C $HOME/.icons/; done
printf "$OK\n"

