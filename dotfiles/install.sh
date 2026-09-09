#!/bin/bash

OK="\e[0;32mOK\e[0m"

pacotes=(
    # pacotes terminal
    "bat" # Cat clone with syntax highlighting and git integration
    "cifs-utils" # CIFS filesystem user-space tools
    "eza" # A modern replacement for ls (community fork of exa)
    "fastfetch" # A feature-rich and performance oriented neofetch like system information tool
    "fd" # Simple, fast and user-friendly alternative to find
    "fzf" # Command-line fuzzy finder
    "git" # the fast distributed version control system
    "gvim" # Vi Improved, a highly configurable, improved version of the vi text editor (with advanced features, such as a GUI)
    "less" # A terminal based program for viewing text files
    "networkmanager-openvpn" # NetworkManager VPN plugin for OpenVPN (with GUI)
    "nm-connection-editor" # NetworkManager GUI connection editor and widgets
    "openvpn" # An easy-to-use, robust and highly configurable VPN (Virtual Private Network)
    "p7zip" # File archiver for extremely high compression
    "ripgrep" # A search tool that combines the usability of ag with the raw speed of grep
    "wget" # Network utility to retrieve files from the web
    "which" # A utility to show the full path of commands
    "zoxide" # A smarter cd command for your terminal

    # pacotes para compilações
    "debugedit" # Tool to mangle source locations in .debug files
    "fakeroot" # Tool for simulating superuser privileges
    "gcc" # The GNU Compiler Collection - C and C++ frontends
    "make" # GNU make utility to maintain groups of programs

    # aplicativos
    "freerdp" # Free implementation of the Remote Desktop Protocol (RDP)
    "keepassxc" # Cross-platform community-driven port of Keepass password manager
    "kitty" # A modern, hackable, featureful, OpenGL-based terminal emulator
    "pavucontrol" # PulseAudio Volume Control

    # fontes
    # para codar
    "ttf-cascadia-code-nerd"
    "ttf-cascadia-mono-nerd"
    # caracteres diversos para browser
    "noto-fonts"
    "noto-fonts-cjk"
    "noto-fonts-emoji"
)

printf "\n"
printf " ##############################################\n"
printf " #             instalando extras              #\n"
printf " ##############################################\n"
printf "\n"

printf "\nremovendo vim para instalar gvim\n"
sudo pacman --noconfirm -Runs vim
printf "\n$OK\n"

sudo pacman --noconfirm -S "${pacotes[@]}"
printf "\n$OK\n"

