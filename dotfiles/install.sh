#!/bin/bash

OK="\e[0;32mOK\e[0m"

pacotes=(
    # pacotes nvidia
    "nvidia"
    "nvidia-utils"
    "nvidia-settings"

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
    "noto-fonts-cjk"
    "noto-fonts-emoji"
    "noto-fonts"

    # dicionário
    "words"

    # gui para python
    "tk"

    # reprodutor áudio e vídeo
    "vlc"
    "vlc-plugin-ffmpeg"
    "vlc-plugin-freetype"
    "vlc-plugin-ass"
    "vlc-plugin-srt"
)

printf "\n"
printf " ##############################################\n"
printf " #             instalando extras              #\n"
printf " ##############################################\n"
printf "\n"

sudo pacman --noconfirm -S "${pacotes[@]}"

./../scripts/zsh.sh
./../scripts/hosts.sh
./../scripts/python.sh
./../scripts/firefox.sh
./../scripts/vs-code.sh

# interface do sistema
printf " copiando ícone papirus......................"
wget -qO- https://git.io/papirus-icon-theme-install | env DESTDIR="$HOME/.icons" sh
rm -rf $HOME/.icons/ePapirus* # remove ícones não necessários
printf "$OK\n"

printf " copiando bibata cursores...................."
for f in $HOME/arch-hertzog/dotfiles/icons/*.tar.xz; do tar xfv "$f" -C $HOME/.icons/; done
printf "$OK\n"

