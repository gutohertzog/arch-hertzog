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

# primeiro dotfiles para aplicativos básicos
./dotfiles/install.sh

# previsa vir depois do dotfiles/install.sh
# por dependências de pacotes prévios
./gnome/extensoes-gnome.sh

# agora pacotes individuais
./scripts/interface.sh
./scripts/nvidia.sh
./scripts/zsh.sh
./scripts/hosts.sh
./scripts/python.sh
./scripts/firefox.sh
./scripts/vs-code.sh
./scripts/adguardhome.sh

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

