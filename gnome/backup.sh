#!/bin/bash

clear

printf "Realizando backup das pastas do sistema\n"

printf "Copiando arquivos\n"
$HOME/arch-hertzog/dotfiles/backup.sh
cp -v $HOME/.XCompose $HOME/arch-hertzog/dotfiles/
cp -v $HOME/.profile $HOME/arch-hertzog/dotfiles/

# exporta as configurações do Gnome
dconf dump / | sed -n '/\[org.gnome.desktop.background/,/^$/p' > $HOME/arch-hertzog/gnome/dotfiles/config/dconf/user-settings.conf
dconf dump / | sed -n '/\[org.gnome.desktop.input-sources/,/^$/p' >> $HOME/arch-hertzog/gnome/dotfiles/config/dconf/user-settings.conf
dconf dump / | sed -n '/\[org.gnome.desktop.interface/,/^$/p' >> $HOME/arch-hertzog/gnome/dotfiles/config/dconf/user-settings.conf
dconf dump / | sed -n '/\[org.gnome.desktop.peripherals.keyboard/,/^$/p' >> $HOME/arch-hertzog/gnome/dotfiles/config/dconf/user-settings.conf
dconf dump / | sed -n '/\[org.gnome.desktop.peripherals.mouse/,/^$/p' >> $HOME/arch-hertzog/gnome/dotfiles/config/dconf/user-settings.conf
dconf dump / | sed -n '/\[org.gnome.desktop.screensaver/,/^$/p' >> $HOME/arch-hertzog/gnome/dotfiles/config/dconf/user-settings.conf
dconf dump / | sed -n '/\[org.gnome.desktop.wm.keybindings/,/^$/p' >> $HOME/arch-hertzog/gnome/dotfiles/config/dconf/user-settings.conf
dconf dump / | sed -n '/\[org.gnome.desktop.wm.preferences/,/^$/p' >> $HOME/arch-hertzog/gnome/dotfiles/config/dconf/user-settings.conf
dconf dump / | sed -n '/\[org.gnome.settings-daemon.plugins.media-keys/,/^$/p' >> $HOME/arch-hertzog/gnome/dotfiles/config/dconf/user-settings.conf
# desativado até arrumar os aplicativos e extensões
# [org/gnome/shell]
# dconf dump / | sed -n '/\[org.gnome.shell/,/^$/p' >> $HOME/arch-hertzog/gnome/dotfiles/config/dconf/user-settings.conf
dconf dump / | sed -n '/\[org.gnome.shell.extensions.blur-my-shell/,/^$/p' >> $HOME/arch-hertzog/gnome/dotfiles/config/dconf/user-settings.conf
dconf dump / | sed -n '/\[org.gnome.shell.extensions.caffeine/,/^$/p' >> $HOME/arch-hertzog/gnome/dotfiles/config/dconf/user-settings.conf
# dconf dump / | sed -n '/\[org.gnome.shell.extensions.clipboard-indicator/,/^$/p' >> $HOME/arch-hertzog/gnome/dotfiles/config/dconf/user-settings.conf
dconf dump / | sed -n '/\[org.gnome.shell.extensions.dash-to-dock/,/^$/p' >> $HOME/arch-hertzog/gnome/dotfiles/config/dconf/user-settings.conf
dconf dump / | sed -n '/\[org.gnome.shell.keybindings/,/^$/p' >> $HOME/arch-hertzog/gnome/dotfiles/config/dconf/user-settings.conf

# remove arquivos para receber os atualizados
rm -rfv $HOME/arch-hertzog/gnome/dotfiles/config/meus_scripts

cp -rv $HOME/.config/meus_scripts $HOME/arch-hertzog/gnome/dotfiles/config
