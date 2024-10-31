#!/bin/bash
OK="\e[0;32mOK\e[0m"

instala_pacote() {
    local nome_pacote=$1
    printf " %-40s" "$nome_pacote"
    sudo pacman --noconfirm -S "$nome_pacote" > /dev/null 2>&1
    printf "$OK\n"
}

pacotes=(
    "baobab"
    "gdm"
    "gnome-backgrounds"
    "gnome-calculator"
    "gnome-calendar"
    "gnome-characters"
    "gnome-clocks"
    "gnome-color-manager"
    "gnome-contacts"
    "gnome-control-center"
    "gnome-disk-utility"
    "gnome-font-viewer"
    "gnome-keyring"
    "gnome-logs"
    "gnome-menus"
    "gnome-remote-desktop"
    "gnome-session"
    "gnome-settings-daemon"
    "gnome-shell"
    "gnome-shell-extensions"
    "gnome-system-monitor"
    "gnome-text-editor"
    "gnome-tweaks"
    "gnome-user-share"
    "gnome-weather"
    "gvfs"
    "gvfs-afc"
    "gvfs-dnssd"
    "gvfs-google"
    "gvfs-onedrive"
    "gvfs-smb"
    "gvfs-wsdd"
    "loupe"
    "nautilus"
    "sushi"
    "tecla"
    "tracker3-miners"
    "xdg-desktop-portal-gnome"
    "xdg-user-dirs-gtk"

    # esconde o mouse
    "unclutter"
)

printf "\n"
printf " ##############################################\n"
printf " #              instalando gnome              #\n"
printf " ##############################################\n"
printf "\n"

for pacote in "${pacotes[@]}"; do
    instala_pacote "$pacotes"
done

printf " ativando gdm................................"
sudo systemctl enable gdm > /dev/null 2>&1
printf "$OK\n"

printf " criando pastas.............................."
mkdir $HOME/.icons > /dev/null 2>&1
mkdir $HOME/.themes > /dev/null 2>&1
mkdir $HOME/GitHub > /dev/null 2>&1
printf "$OK\n"

./../dotfiles/install.sh

# copia o meu tema personalizado
cp -rv $HOME/arch-hertzog/gnome/dotfiles/themes/* $HOME/.themes

./../scripts/extensoes-gnome.sh

# carrega as configurações para o gnome
dconf load / < $HOME/arch-hertzog/gnome/dotfiles/config/dconf/user-settings.conf

