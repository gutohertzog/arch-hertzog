#!/bin/bash
printf "\n"
printf " ###############################################################\n"
printf " #                   SCRIPT POR GUTO HERTZOG                   #\n"
printf " ###############################################################\n"
printf "\n"

./gnome/install.sh
# ./hyprland/install.sh
# ./wsl/install.sh

printf " criando pastas"
#mkdir $HOME/.icons
mkdir $HOME/GitHub

# remove o vim para instalar o gvim
sudo pacman -Runs vim

# primeiro dotfiles para garantir aplicativos básicos
./dotfiles/install.sh
./scripts/extensoes-gnome.sh

# renomeia as pastas originais, caso já existam
mv $HOME/.config/kitty $HOME/.config/kitty.bak
mv $HOME/Pictures $HOME/Pictures.bak

# -s cria link simbólico
# -f evita erro se existir
# -n substitui existe
ln -sfn $HOME/arch-hertzog/dotfiles/config/vim $HOME/.vim
ln -sfn $HOME/arch-hertzog/dotfiles/config/zsh/zshrc $HOME/.zshrc
ln -sfn $HOME/arch-hertzog/dotfiles/config/kitty $HOME/.config/kitty
ln -sfn $HOME/arch-hertzog/dotfiles/config/fastfetch $HOME/.config/fastfetch
ln -sfn $HOME/arch-hertzog/dotfiles/Pictures $HOME/Pictures
ln -sfn $HOME/arch-hertzog/gnome/dotfiles/themes $HOME/.themes
ln -sfn $HOME/arch-hertzog/gnome/dotfiles/.profile $HOME/.profile
ln -sfn $HOME/arch-hertzog/gnome/dotfiles/.XCompose $HOME/.XCompose

