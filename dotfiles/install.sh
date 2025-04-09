#!/bin/bash

set -e

source "$(dirname "$0")/../scripts/funcoes.sh"

OK="\e[0;32mOK\e[0m"

pacotes=(
    # pacotes nvidia
    "nvidia"
    "nvidia-utils"
    "nvidia-settings"

    # pacotes terminal
    "kitty" # emulador do terminal
    "gvim" # tui editor
    "fzf" # busca pelo terminal
    "ripgrep" # busca por letra
    "zoxide" # melhor cd
    "fastfetch" # informação sistema
    "eza" # melhor ls
    "rsync" # gerenciador de backup
    "git" # gerenciador de versionamento
    "p7zip" # manipulador de arquivos compactados
    "nm-connection-editor" # editor de conexão

    # fontes
    "ttf-cascadia-code-nerd"
    "ttf-cascadia-mono-nerd"

    # sistema
    "words"

    # python
    "tk"
)

printf "\n"
printf " ##############################################\n"
printf " #              instalando gnome              #\n"
printf " ##############################################\n"
printf "\n"

for pacote in "${pacotes[@]}"; do
    instala_pacote "$pacote"
done

./../scripts/zsh.sh
./../scripts/hosts.sh
./../scripts/microsoft-edge.sh
./../scripts/vs-code.sh
./../scripts/python.sh
./../scripts/firefox.sh

# interface do sistema
printf " copiando oreo cursores......................"
for f in $HOME/arch-hertzog/dotfiles/icons/*.tar.gz; do tar xfv "$f" -C $HOME/.icons/; done
printf "$OK\n"

printf " copiando bibata cursores...................."
for f in $HOME/arch-hertzog/dotfiles/icons/*.tar.xz; do tar xfv "$f" -C $HOME/.icons/; done
printf "$OK\n"

printf " copiando ícone papirus......................"
wget -qO- https://git.io/papirus-icon-theme-install | env DESTDIR="$HOME/.icons" sh
rm -rf $HOME/.icons/ePapirus* # remove ícones não necessários
printf "$OK\n"
