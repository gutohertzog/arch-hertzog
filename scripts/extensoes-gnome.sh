#!/bin/bash

# as extensões são instaladas em
#   $HOME/.local/share/gnome-shell/extensions

printf "\n"
printf " ##############################################\n"
printf " #              extensões gnome               #\n"
printf " ##############################################\n"
printf "\n"

printf "\n\tdash to dock\n"
sudo pacman -S sass --noconfirm
export SASS=dart
git clone https://github.com/micheleg/dash-to-dock/
make -C dash-to-dock install
rm -rf dash-to-dock
printf "\n"

printf "\n\n\tblur my shell\n"
git clone https://github.com/aunetx/blur-my-shell
make -C blur-my-shell install
rm -rf blur-my-shell
printf "\n"

printf "\n\n\tcaffeine\n"
git clone https://github.com/eonpatapon/gnome-shell-extension-caffeine
cd gnome-shell-extension-caffeine
make build
make install
cd ..
rm -rf gnome-shell-extension-caffeine
printf "\n"

printf "\n\n\ttray icons reloaded\n"
sudo pacman -S zip --noconfirm
git clone https://github.com/martinpl/tray-icons-reloaded
cd tray-icons-reloaded
make zip
unzip trayIconsReloaded@selfmade.pl.zip -d ~/.local/share/gnome-shell/extensions/trayIconsReloaded@selfmade.pl
cd ..
rm -rf tray-icons-reloaded
sudo pacman -R zip --noconfirm
printf "\n"

printf "\n\n\tlockkeys\n"
git clone https://github.com/kazysmaster/gnome-shell-extension-lockkeys
mv gnome-shell-extension-lockkeys/lockkeys@vaina.lt $HOME/.local/share/gnome-shell/extensions
rm -rf gnome-shell-extension-lockkeys
printf "\n"

printf "\n\n\tvitals\n"
git clone https://aur.archlinux.org/gnome-shell-extension-vitals-git.git/
cd gnome-shell-extension-vitals-git
makepkg

# cd ..
# rm -rf gnome-shell-extension-vitals-git
