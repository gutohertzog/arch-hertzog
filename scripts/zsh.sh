#!/bin/bash
OK="\e[0;32mOK\e[0m"

printf "\n"
printf " ##############################################\n"
printf " #                    zsh                     #\n"
printf " ##############################################\n"
printf "\n"

printf " zsh........................................."
sudo pacman --noconfirm -S zsh
printf "$OK\n"

printf " ativando zsh................................"
chsh -s $(which zsh)
printf "$OK\n"

DESTINO="$HOME/arch-hertzog/dotfiles/config/zsh/plugins"

printf " zsh-completions.............................\n"
URL="https://github.com/zsh-users/zsh-completions"
if [ -d "$DESTINO/zsh-completions/.git" ]; then
    git -C "$DESTINO/zsh-completions" pull
else
    git clone $URL "$DESTINO/zsh-completions"
fi
printf "$OK\n"

printf " zsh-autosuggestions.........................\n"
URL="https://github.com/zsh-users/zsh-autosuggestions"
if [ -d "$DESTINO/zsh-autosuggestions/.git" ]; then
    git -C "$DESTINO/zsh-autosuggestions" pull
else
    git clone $URL "$DESTINO/zsh-autosuggestions"
fi
printf "$OK\n"

printf " zsh-syntax-highlighting.....................\n"
URL="https://github.com/zsh-users/zsh-syntax-highlighting"
if [ -d "$DESTINO/zsh-syntax-highlighting/.git" ]; then
    git -C "$DESTINO/zsh-syntax-highlighting" pull
else
    git clone $URL "$DESTINO/zsh-syntax-highlighting"
fi
printf "$OK\n"

printf " fzf-tab.....................................\n"
URL="https://github.com/Aloxaf/fzf-tab"
if [ -d "$DESTINO/fzf-tab/.git" ]; then
    git -C "$DESTINO/fzf-tab" pull
else
    git clone $URL "$DESTINO/fzf-tab"
fi
printf "$OK\n"

