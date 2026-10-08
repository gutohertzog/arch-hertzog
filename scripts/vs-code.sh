#!/bin/bash
set -Eeuo pipefail

# =============================================================================
# https://archlinux.org/packages/extra/x86_64/code/
# =============================================================================

source "$(dirname "$0")/conf.sh"

DIR_SRC=$HOME/arch-hertzog/dotfiles/config/Code/User/
DIR_DST=$HOME/.config/Code\ -\ OSS/User

pacotes=(
    "code" # The Open Source build of Visual Studio Code (vscode) editor
)

printf "\n"
printf " ##############################################\n"
printf " #                  vs code                   #\n"
printf " ##############################################\n"
printf "\n"

instalar_pacotes "${pacotes[@]}"

# cria a pasta para linkar as configurações
printf " → Criando links simbólicos para arquivos de configuração\n"
mkdir -p $HOME/.config/Code\ -\ OSS/User
ln -s "$DIR_SRC/settings.json" "$DIR_DST"
ln -s "$DIR_SRC/keybindings.json" "$DIR_DST"

# printf " code-features..............................."
# git clone https://aur.archlinux.org/code-features.git
# cd code-features
# makepkg -si PKGBUILD
# cd $HOME/GitHub
# rm -rf code-features
# printf "$OK\n"

# printf " code-marketplace............................"
# git clone https://aur.archlinux.org/code-marketplace.git
# cd code-marketplace
# makepkg -si PKGBUILD
# cd $HOME/GitHub
# rm -rf code-marketplace
# printf "$OK\n"

printf " → Instalando extensões vs code\n"
printf "     → vscode-icons\n"
code --install-extension vscode-icons-team.vscode-icons
printf "${OK}"
printf "     → indent-rainbow\n"
code --install-extension oderwat.indent-rainbow
printf "${OK}"
printf "     → vim\n"
code --install-extension vscodevim.vim
printf "${OK}"
printf "     → python\n"
code --install-extension ms-python.python
printf "${OK}"

printf "${FIM}"

