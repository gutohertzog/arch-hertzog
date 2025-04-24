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

printf " oh-my-zsh..................................."
git clone https://github.com/ohmyzsh/ohmyzsh.git $HOME/.oh-my-zsh
printf "$OK\n"

# considerar talvez substiuir powerlevel10k pelo oh-my-posh
# https://aur.archlinux.org/packages/oh-my-posh
printf " powerlevel10k..............................."
rm -rf $HOME/.oh-my-zsh/custom/themes/powerlevel10k
git clone https://github.com/romkatv/powerlevel10k.git $HOME/.oh-my-zsh/custom/themes/powerlevel10k
printf "$OK\n"

printf " zsh-completions............................."
rm -rf $HOME/.oh-my-zsh/custom/plugins/zsh-completions
git clone https://github.com/zsh-users/zsh-completions.git $HOME/.oh-my-zsh/custom/plugins/zsh-completions
printf "$OK\n"

printf " zsh-autosuggestions........................."
rm -rf $HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-autosuggestions.git $HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions
printf "$OK\n"

printf " zsh-syntax-highlighting....................."
rm -rf $HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
printf "$OK\n"

printf " fzf-tab....................................."
rm -rf $HOME/.oh-my-zsh/custom/plugins/fzf-tab
git clone https://github.com/Aloxaf/fzf-tab $HOME/.oh-my-zsh/custom/plugins/fzf-tab
printf "$OK\n"
