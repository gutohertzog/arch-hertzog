#!/bin/bash

# apenas um script simples para instalar os cacarecos do sistema
# ainda será melhorado

# instala pacotes suplementares
sudo pacman -S p7zip fzf ripgrep zsh zoxide neofetch

# instala extensões do zsh
git clone https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k
git clone https://github.com/zsh-users/zsh-completions.git $ZSH_CUSTOM/plugins/zsh-completions
git clone https://github.com/zsh-users/zsh-autosuggestions.git $ZSH_CUSTOM/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting
git clone https://github.com/Aloxaf/fzf-tab $ZSH_CUSTOM/plugins/fzf-tab

# instala os programas que serão usados
sudo pacman -S gvim

# instala o gerenciador de pacotes aur
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
cd

# https://github.com/StevenBlack/hosts
curl -o $HOME/hosts https://raw.githubusercontent.com/StevenBlack/hosts/master/alternates/fakenews-gambling-porn/hosts
sudo mv /etc/hosts /etc/hosts.bak
sudo mv $HOME/hosts /etc/
sudo systemctl restart NetworkManager.service
