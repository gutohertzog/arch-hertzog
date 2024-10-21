#!/bin/bash

./../dotfiles/install.sh

# primeiro é preciso instalar o pacote básico do Arch Linux, sem qualquer
# interface, depois basta seguir a ordem do script

# pacotes específicos do Gnome
sudo pacman -S baobab gdm gnome-backgrounds gnome-calculator gnome-calendar gnome-characters gnome-clocks gnome-color-manager gnome-contacts gnome-control-center gnome-disk-utility gnome-font-viewer gnome-keyring gnome-logs gnome-menus gnome-remote-desktop gnome-session gnome-settings-daemon gnome-shell gnome-shell-extensions gnome-system-monitor gnome-tweaks gnome-user-share gnome-weather gvfs gvfs-afc gvfs-dnssd gvfs-google gvfs-onedrive gvfs-smb gvfs-wsdd loupe nautilus sushi tecla tracker3-miners xdg-desktop-portal-gnome xdg-user-dirs-gtk

sudo pacman -S gnome-text-editor

# extensões do Gnome
yay -S gnome-shell-extension-dash-to-dock
yay -S gnome-shell-extension-caffeine
# yay -S gnome-shell-extension-clipboard-indicator
yay -S gnome-shell-extension-blur-my-shell
yay -S gnome-shell-extension-lockkeys-git
sudo pacman -S gnome-shell-extension-appindicator

# copia o meu tema personalizado
mkdir $HOME/.themes
cp -rv $HOME/arch-hertzog/gnome/dotfiles/themes/* $HOME/.themes

# clones para instalar os temas do sistema
mkdir -p $HOME/GitHub
# cd $HOME/GitHub
# tema do grub
# git clone https://github.com/vinceliuice/grub2-themes
# temas do sistema
# git clone https://github.com/vinceliuice/WhiteSur-gtk-theme
# sudo ./install.sh -t whitesur -i color -s 1080p -b
# # git clone https://github.com/vinceliuice/Orchis-theme
# # git clone https://github.com/EliverLara/Nordic

# esconde o mouse
sudo pacman -S unclutter

# carrega as configurações para o gnome
dconf load / < $HOME/arch-hertzog/gnome/dotfiles/config/dconf/user-settings.conf

