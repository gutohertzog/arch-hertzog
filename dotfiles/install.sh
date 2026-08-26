#!/bin/bash

OK="\e[0;32mOK\e[0m"

pacotes=(
    # pacotes terminal
    "gvim" # tui editor
    "fzf" # busca pelo terminal
    "ripgrep" # busca por letra
    "fd" # melhor find
    "bat" # melhor cat
    "zoxide" # melhor cd
    "fastfetch" # informação sistema
    "eza" # melhor ls e ícones
    "wget" # baixador
    "git" # gerenciador de versionamento
    "p7zip" # manipulador de arquivos compactados
    "nm-connection-editor" # editor de conexão
    "openvpn" # conexão remota via openvpn
    "networkmanager-openvpn" # extensão openvpn para nm
    "cifs-utils" # ferramentas para mapeamentos do Windows
    "less" # pacote para ver conteúdo de arquivos
    "which" # mostra caminho dos pacotes
    "make" # monta pacotes

    # aplicativos
    "kitty" # emulador do terminal
    "keepassxc" # gerenciador de senhas
    "remmina" # conexão remota
    "freerdp" # para conexão no Windows
    "pavucontrol" # controle do áudio

    # fontes
    # para codar
    "ttf-cascadia-code-nerd"
    "ttf-cascadia-mono-nerd"
    # caracteres diversos para browser
    "noto-fonts"
    "noto-fonts-cjk"
    "noto-fonts-emoji"

    # dicionário
    "words"

    # gui para python
    "tk"

    # reprodutor áudio e vídeo
    "vlc"
    "vlc-plugin-ass"
    "vlc-plugin-srt"
    "vlc-plugin-ffmpeg"
    "vlc-plugin-freetype"
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

