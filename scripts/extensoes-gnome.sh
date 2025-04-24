#!/bin/bash
OK="\e[0;32mOK\e[0m"

printf "\n"
printf " ##############################################\n"
printf " #              extensões gnome               #\n"
printf " ##############################################\n"
printf "\n"

cd $HOME/GitHub

printf " dependência dash to dock...................."
sudo pacman -S sass --noconfirm
export SASS=dart
printf "$OK\n"
printf " dash to dock................................"
git clone https://github.com/micheleg/dash-to-dock/
make -C dash-to-dock install
rm -rf dash-to-dock
printf "$OK\n"

printf " blur my shell..............................."
git clone https://github.com/aunetx/blur-my-shell
make -C blur-my-shell install
rm -rf blur-my-shell
printf "$OK\n"

printf " caffeine...................................."
git clone https://github.com/eonpatapon/gnome-shell-extension-caffeine
cd gnome-shell-extension-caffeine
make build
make install
cd ..
rm -rf gnome-shell-extension-caffeine
printf "$OK\n"

# extensões a considerar :
#   - yay -S gnome-shell-extension-lockkeys-git
#   - sudo pacman -S gnome-shell-extension-appindicator

# ls -l $HOME/.local/share/gnome-shell/extensions
