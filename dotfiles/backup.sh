#!/bin/bash

clear

printf "Realizando backup das pastas de configuração\n"

printf "Copiando arquivos\n"
cp -v $HOME/.zshrc $HOME/arch-hertzog/dotfiles/

rm -rf $HOME/arch-hertzog/dotfiles/Pictures/wallpapers
cp -rv $HOME/Pictures/wallpapers $HOME/arch-hertzog/dotfiles/Pictures

cp -rv $HOME/.config/Code/User/*.json $HOME/arch-hertzog/dotfiles/config/Code/User/

# remove arquivos para receber os atualizados
rm -rfv $HOME/arch-hertzog/dotfiles/config/kitty
rm -rfv $HOME/arch-hertzog/dotfiles/config/neofetch
rm -rfv $HOME/arch-hertzog/dotfiles/config/vim

cp -rv $HOME/.config/kitty $HOME/arch-hertzog/dotfiles/config
cp -rv $HOME/.config/neofetch $HOME/arch-hertzog/dotfiles/config
cp -rv $HOME/.config/vim $HOME/arch-hertzog/dotfiles/config

# remove arquivos e pastas desnecessárias
rm -v $HOME/arch-hertzog/dotfiles/config/vim/autoload/plug.vim.old
rm -rfv $HOME/arch-hertzog/dotfiles/config/vim/view
