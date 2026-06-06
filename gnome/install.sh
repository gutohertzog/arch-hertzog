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
    "dconf-editor" # editor do gnome
)

printf "\n"
printf " ##############################################\n"
printf " #              instalando GNOME              #\n"
printf " ##############################################\n"
printf "\n"

sudo pacman --noconfirm -S "${pacotes[@]}"

printf " ativando gdm"
sudo systemctl enable gdm

printf " criando pastas"
#mkdir $HOME/.icons
mkdir $HOME/GitHub

# remove o vim para instalar o gvim
sudo pacman -Runs vim

./../scripts/extensoes-gnome.sh
./../dotfiles/install.sh

# -s cria link simbólico
# -f evita erro se existir
# -n substitui existe
ln -sfn $HOME/arch-hertzog/dotfiles/config/vim $HOME/.vim
ln -sfn $HOME/arch-hertzog/dotfiles/.p10k.zsh $HOME/.p10k.zsh
ln -sfn $HOME/arch-hertzog/dotfiles/config/zsh/zshrc $HOME/.zshrc
ln -sfn $HOME/arch-hertzog/dotfiles/config/kitty $HOME/.config/kitty
ln -sfn $HOME/arch-hertzog/dotfiles/config/fastfetch $HOME/.config/fastfetch
ln -sfn $HOME/arch-hertzog/dotfiles/Pictures $HOME/Pictures
ln -sfn $HOME/arch-hertzog/gnome/dotfiles/themes $HOME/.themes
ln -sfn $HOME/arch-hertzog/gnome/dotfiles/.profile $HOME/.profile
ln -sfn $HOME/arch-hertzog/gnome/dotfiles/.XCompose $HOME/.XCompose

# carrega as configurações para o gnome
# dconf load / < $HOME/arch-hertzog/gnome/dotfiles/config/dconf/user-settings.conf

