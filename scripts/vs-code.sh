#!/bin/bash
OK="\e[0;32mOK\e[0m"

printf "\n"
printf " ##############################################\n"
printf " #                  vs code                   #\n"
printf " ##############################################\n"
printf "\n"

printf " vs code....................................."
sudo pacman --noconfirm -S code > /dev/null 2>&1
printf "$OK\n"

printf " code-features..............................."
git clone https://aur.archlinux.org/code-features.git > /dev/null 2>&1
cd code-features
makepkg > /dev/null 2>&1
makepkg --install > /dev/null 2>&1
cd $HOME/GitHub
rm -rf code-features > /dev/null 2>&1
printf "$OK\n"

printf " code-marketplace............................"
git clone https://aur.archlinux.org/code-features.git > /dev/null 2>&1
cd code-features
makepkg > /dev/null 2>&1
makepkg --install > /dev/null 2>&1
cd $HOME/GitHub
rm -rf code-features > /dev/null 2>&1
printf "$OK\n"

printf " code-icons.................................."
git clone https://aur.archlinux.org/code-icons.git > /dev/null 2>&1
cd code-icons
makepkg > /dev/null 2>&1
makepkg --install > /dev/null 2>&1
cd $HOME/GitHub
rm -rf code-icons > /dev/null 2>&1
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
