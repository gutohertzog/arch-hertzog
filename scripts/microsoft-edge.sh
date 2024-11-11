#!/bin/bash
OK="\e[0;32mOK\e[0m"

printf "\n"
printf " ##############################################\n"
printf " #              microsoft edge                #\n"
printf " ##############################################\n"
printf "\n"

printf " microsoft edge stable......................."
cd $HOME/GitHub
git clone https://aur.archlinux.org/microsoft-edge-stable-bin.git
cd microsoft-edge-stable-bin
makepkg
makepkg --install
cd $HOME/GitHub
rm -rf microsoft-edge-stable-bin
printf "$OK\n"

