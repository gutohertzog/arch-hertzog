#!/bin/bash
set -Eeuo pipefail

# -----------------------------------------------------------------------------
# https://github.com/PapirusDevelopmentTeam/papirus-icon-theme
# https://github.com/ful1e5/Bibata_Cursorc
# -----------------------------------------------------------------------------

source "$(dirname "$0")/conf.sh"

printf " → Copiando ícone Papirus\n"
wget -qO- https://git.io/papirus-icon-theme-install | env DESTDIR="$HOME/.icons" sh
printf "${OK}"

printf " → Removendo ícones que não uso\n"
rm -rf $HOME/.icons/ePapirus*
printf "${OK}"

printf " → Copiando cursores Bibata\n"
for f in $HOME/arch-hertzog/dotfiles/icons/*.tar.xz; do tar xfv "$f" -C $HOME/.icons/; done
printf "${OK}"

printf "${FIM}"

