#!/bin/bash
OK="\e[0;32mOK\e[0m"

printf "\n"
printf " ##############################################\n"
printf " #              extensões gnome               #\n"
printf " ##############################################\n"
printf "\n"

cd $HOME/GitHub

printf " dependência dash to dock...................."
sudo pacman -S sass --noconfirm > /dev/null 2>&1
export SASS=dart > /dev/null 2>&1
printf "$OK\n"
printf " dash to dock................................"
git clone https://github.com/micheleg/dash-to-dock/ > /dev/null 2>&1
make -C dash-to-dock install > /dev/null 2>&1
rm -rf dash-to-dock > /dev/null 2>&1
printf "$OK\n"

printf " blur my shell..............................."
git clone https://github.com/aunetx/blur-my-shell > /dev/null 2>&1
make -C blur-my-shell install > /dev/null 2>&1
rm -rf blur-my-shell > /dev/null 2>&1
printf "$OK\n"

printf " caffeine...................................."
git clone https://github.com/eonpatapon/gnome-shell-extension-caffeine > /dev/null 2>&1
cd gnome-shell-extension-caffeine > /dev/null 2>&1
make build > /dev/null 2>&1
make install > /dev/null 2>&1
cd .. > /dev/null 2>&1
rm -rf gnome-shell-extension-caffeine > /dev/null 2>&1
printf "$OK\n"

# extensões a considerar :
#   - yay -S gnome-shell-extension-lockkeys-git
#   - sudo pacman -S gnome-shell-extension-appindicator

# ls -l $HOME/.local/share/gnome-shell/extensions

