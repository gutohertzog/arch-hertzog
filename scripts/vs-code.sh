#!/bin/bash
OK="\e[0;32mOK\e[0m"

printf "\n"
printf " ##############################################\n"
printf " #                  vs code                   #\n"
printf " ##############################################\n"
printf "\n"

printf " vs code....................................."
sudo pacman --noconfirm -S code
printf "$OK\n"

printf " code-features..............................."
git clone https://aur.archlinux.org/code-features.git
cd code-features
makepkg
makepkg --install
cd $HOME/GitHub
rm -rf code-features
printf "$OK\n"

printf " code-marketplace............................"
git clone https://aur.archlinux.org/code-marketplace.git
cd code-marketplace
makepkg
makepkg --install
cd $HOME/GitHub
rm -rf code-marketplace
printf "$OK\n"

printf " extensões vs code...........................\n"
printf " ....vscode-icons............................"
code --install-extension vscode-icons-team.vscode-icons
printf "$OK\n"
printf " ....indent-rainbow.........................."
code --install-extension oderwat.indent-rainbow
printf "$OK\n"
printf " ....glassit................................."
code --install-extension s-nlf-fh.glassit
printf "$OK\n"
printf " ....vscode-pdf.............................."
code --install-extension tomoki1207.vscode-pdf
printf "$OK\n"
