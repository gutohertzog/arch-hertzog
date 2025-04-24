#!/bin/bash

set -e

# referência : https://archlinux.org/groups/x86_64/gnome/
#              https://archlinux.org/groups/any/gnome-extra/
pacotes=(
    "baobab"
    # "decibels"
    # "epiphany"
    # "evince"
    "gdm"
    "gnome-backgrounds"
    "gnome-calculator"
    "gnome-calendar"
    "gnome-characters"
    "gnome-clocks"
    "gnome-color-manager"
    # "gnome-connections"
    # "gnome-console"
    "gnome-contacts"
    "gnome-control-center"
    "gnome-disk-utility"
    "gnome-font-viewer"
    "gnome-keyring"
    "gnome-logs"
    # "gnome-maps"
    "gnome-menus"
    # "gnome-music"
    "gnome-remote-desktop"
    "gnome-session"
    "gnome-settings-daemon"
    "gnome-shell"
    "gnome-shell-extensions"
    # "gnome-software"
    "gnome-system-monitor"
    "gnome-text-editor"
    # "gnome-tour"
    # "gnome-user-docs"
    "gnome-user-share"
    "gnome-weather"
    # "grilo-plugins"
    "gvfs"
    "gvfs-afc"
    "gvfs-dnssd"
    # "gvfs-goa"
    "gvfs-google"
    # "gvfs-gphoto2"
    # "gvfs-mtp"
    # "gvfs-nfs"
    "gvfs-onedrive"
    "gvfs-smb"
    "gvfs-wsdd"
    "loupe"
    # "malcontent"
    "nautilus"
    # "orca"
    # "rygel"
    # "simple-scan"
    # "snapshot"
    "sushi"
    "tecla"
    # "totem"
    "xdg-desktop-portal-gnome"
    "xdg-user-dirs-gtk"
    # "yelp"

    "gnome-tweaks"
    # esconde o mouse
    "unclutter"
)

printf "\n"
printf " ##############################################\n"
printf " #              instalando \e[0;GNOME\e[0m              #\n"
printf " ##############################################\n"
printf "\n"

sudo pacman --noconfirm -S "${pacotes[@]}"

printf " ativando gdm"
sudo systemctl enable gdm

printf " criando pastas"
mkdir $HOME/.icons
mkdir $HOME/.themes
mkdir $HOME/GitHub

./../dotfiles/install.sh

# copia o meu tema personalizado
cp -rv $HOME/arch-hertzog/gnome/dotfiles/themes/* $HOME/.themes

./../scripts/extensoes-gnome.sh

# carrega as configurações para o gnome
dconf load / < $HOME/arch-hertzog/gnome/dotfiles/config/dconf/user-settings.conf
