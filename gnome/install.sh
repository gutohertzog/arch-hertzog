#!/bin/bash

# encerra em caso de erro
set -e

# referência : https://archlinux.org/groups/x86_64/gnome/
#              https://archlinux.org/groups/any/gnome-extra/
pacotes=(
    "baobab" # A graphical directory tree analyzer
    # "decibels" # Audio player for GNOME
    # "epiphany" # A GNOME web browser based on the WebKit rendering engine
    "gdm" # Display manager and login screen
    "gnome-backgrounds" # Background images and data for GNOME
    "gnome-calculator" # GNOME Scientific calculator
    "gnome-calendar" # Simple and beautiful calendar application designed to perfectly fit the GNOME desktop
    "gnome-characters" # A character map application
    "gnome-clocks" # Clocks applications for GNOME
    "gnome-color-manager" # GNOME Color Profile Tools
    # "gnome-connections" # Remote desktop client for the GNOME desktop environment
    # "gnome-console" # A simple user-friendly terminal emulator for the GNOME desktop
    "gnome-contacts" # Contacts Manager for GNOME
    "gnome-control-center" # GNOME's main interface to configure various aspects of the desktop
    "gnome-disk-utility" # Disk Management Utility for GNOME
    "gnome-font-viewer" # A font viewer utility for GNOME
    "gnome-keyring" # Stores passwords and encryption keys
    "gnome-logs" # A log viewer for the systemd journal
    # "gnome-maps" # Find places around the world
    "gnome-menus" # GNOME menu specifications
    # "gnome-music" # Music player and management application
    "gnome-remote-desktop" # GNOME Remote Desktop server
    "gnome-session" # The GNOME Session Handler
    "gnome-settings-daemon" # GNOME Settings Daemon
    "gnome-shell" # Next generation desktop shell
    # "gnome-software" # Allows you to find and install new apps
    "gnome-system-monitor" # View current processes and monitor system state
    "gnome-text-editor" # A simple text editor for the GNOME desktop
    # "gnome-tour" # Guided tour and greeter for GNOME
    # "gnome-user-docs" # User documentation for GNOME
    "gnome-user-share" # Easy to use user-level file sharing for GNOME
    "gnome-weather" # Access current weather conditions and forecasts
    # "grilo-plugins" # A collection of plugins for the Grilo framework
    "gst-thumbnailers" # GStreamer video and audio file thumbnailer
    "gvfs" # Virtual filesystem implementation for GIO
    "gvfs-afc" # Virtual filesystem implementation for GIO - AFC backend (Apple mobile devices)
    "gvfs-dnssd" # DNS-SD and WebDAV backend (macOS file sharing)
    # "gvfs-goa" # Gnome Online Accounts backend (e.g. OwnCloud)
    # "gvfs-gphoto2" # gphoto2 backend (PTP camera, MTP media player)
    # "gvfs-mtp" # MTP backend (Android, media player)
    # "gvfs-nfs" # NFS backend
    "gvfs-onedrive" # Microsoft OneDrive backend
    "gvfs-smb" # SMB/CIFS backend (Windows file sharing)
    "gvfs-wsdd" # Web Services Dynamic Discovery backend (Windows discovery)
    "loupe" # A simple image viewer for GNOME
    # "malcontent" # Parental control support for applications
    "nautilus" # Default file manager for GNOME
    # "orca" # Screen reader for individuals who are blind or visually impaired
    # "papers" # Document viewer for PDF and other document formats aimed at the GNOME desktop
    # "rygel" # UPnP AV MediaServer and MediaRenderer
    # "showtime" # Video player for GNOME
    # "simple-scan" # Simple scanning utility
    # "snapshot" # Take pictures and videos
    "sushi" # A quick previewer for Nautilus
    "tecla" # Keyboard layout viewer
    "xdg-desktop-portal-gnome" # Backend implementation for xdg-desktop-portal for the GNOME desktop environment
    "xdg-user-dirs-gtk" # Creates user dirs and asks to relocalize them
    # "yelp" # Get help with GNOME

    "dconf-editor" # GSettings editor for GNOME
    "gnome-shell-extensions" # Extensions for GNOME shell, including classic mode
    "gnome-tweaks" # Graphical interface for advanced GNOME 3 settings (Tweak Tool)
)

printf "\n"
printf " ##############################################\n"
printf " #              instalando GNOME              #\n"
printf " ##############################################\n"
printf "\n"

sudo pacman --noconfirm -S "${pacotes[@]}"

printf "\n\n ativando gdm"
sudo systemctl enable gdm

# carrega as configurações para o gnome
printf "\n ativando gdm"
dconf load / < $HOME/arch-hertzog/gnome/dotfiles/config/dconf/user-settings.conf

