#!/bin/bash

clear

printf "Realizando backup das pastas de configuração\n"

BACKUP_DIR="$HOME/arch-hertzog/dotfiles"

printf "Copiando arquivos\n"

# -a : preserva permissões
# -v : saída detalhada
rsync -av "$HOME/.zshrc" "$BACKUP_DIR/"
rsync -av "$HOME/Pictures/wallpapers/" "$BACKUP_DIR/Pictures/wallpapers/"
rsync -av "$HOME/.config/Code/User/settings.json" "$BACKUP_DIR/config/Code/User/"
rsync -av "$HOME/.config/Code/User/keybindings.json" "$BACKUP_DIR/config/Code/User/"

rsync -av --delete "$HOME/.config/kitty/" "$BACKUP_DIR/config/kitty/"
rsync -av --delete "$HOME/.config/neofetch/" "$BACKUP_DIR/config/neofetch/"
rsync -av --delete "$HOME/.config/vim/" "$BACKUP_DIR/config/vim/"

rm -v "$BACKUP_DIR/config/vim/autoload/plug.vim.old"
rm -rfv "$BACKUP_DIR/config/vim/view/"

