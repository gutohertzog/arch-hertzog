#!/bin/bash
set -Eeuo pipefail

# =============================================================================
# https://archlinux.org/packages/extra/x86_64/zsh/
# =============================================================================

source "$(dirname "$0")/conf.sh"

DIR_DST="$HOME/arch-hertzog/dotfiles/config/zsh/plugins"

pacotes=(
    "zsh" # A very advanced and programmable command interpreter (shell) for UNIX
)

printf "\n"
printf " ##############################################\n"
printf " #                    zsh                     #\n"
printf " ##############################################\n"
printf "\n"

instalar_pacotes "${pacotes[@]}"

printf " → Ativando zsh\n"
chsh -s $(which zsh)
printf "${OK}"

printf " → Instalando zsh-completions\n"
URL="https://github.com/zsh-users/zsh-completions"
if [ -d "$DIR_DST/zsh-completions/.git" ]; then
    git -C "$DIR_DST/zsh-completions" pull
else
    git clone $URL "$DIR_DST/zsh-completions"
fi
printf "${OK}"

printf " → zsh-autosuggestions\n"
URL="https://github.com/zsh-users/zsh-autosuggestions"
if [ -d "$DIR_DST/zsh-autosuggestions/.git" ]; then
    git -C "$DIR_DST/zsh-autosuggestions" pull
else
    git clone $URL "$DIR_DST/zsh-autosuggestions"
fi
printf "${OK}"

printf " → zsh-syntax-highlighting\n"
URL="https://github.com/zsh-users/zsh-syntax-highlighting"
if [ -d "$DIR_DST/zsh-syntax-highlighting/.git" ]; then
    git -C "$DIR_DST/zsh-syntax-highlighting" pull
else
    git clone $URL "$DIR_DST/zsh-syntax-highlighting"
fi
printf "${OK}"

printf " → Baixando fzf-tab\n"
URL="https://github.com/Aloxaf/fzf-tab"
if [ -d "$DIR_DST/fzf-tab/.git" ]; then
    git -C "$DIR_DST/fzf-tab" pull
else
    git clone $URL "$DIR_DST/fzf-tab"
fi
printf "${OK}"

printf "${FIM}"

