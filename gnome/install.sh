#!/bin/bash

# primeiro é preciso instalar o pacote básico do Arch Linux, sem qualquer
# interface, depois basta seguir a ordem do script

# pacotes específicos do Gnome
sudo pacman -S baobab gdm gnome-backgrounds gnome-calculator gnome-calendar gnome-characters gnome-clocks gnome-color-manager gnome-contacts gnome-control-center gnome-disk-utility gnome-font-viewer gnome-keyring gnome-logs gnome-menus gnome-remote-desktop gnome-session gnome-settings-daemon gnome-shell gnome-shell-extensions gnome-system-monitor gnome-tweaks gnome-user-share gnome-weather gvfs gvfs-afc gvfs-dnssd gvfs-google gvfs-onedrive gvfs-smb gvfs-wsdd loupe nautilus sushi tecla tracker3-miners xdg-desktop-portal-gnome xdg-user-dirs-gtk

# pacotes da nvidia
sudo pacman -S nvidia nvidia-utils nvidia-settings

# Kitty como terminal emulator
sudo pacman -S kitty

# fontes
sudo pacman -S ttf-cascadia-code-nerd ttf-cascadia-mono-nerd

# instala o Go e desativa a telemetria
sudo pacman -S go
go telemetry off

# gerenciador de pacotes aur
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
cd ..
rm -rf yay

# pacotes suplementares
sudo pacman -S git p7zip fzf ripgrep zsh zoxide neofetch curl nm-connection-editor wget

# extensões do Gnome
yay -S gnome-shell-extension-dash-to-dock
yay -S gnome-shell-extension-caffeine
# yay -S gnome-shell-extension-clipboard-indicator
yay -S gnome-shell-extension-blur-my-shell
yay -S gnome-shell-extension-lockkeys-git
sudo pacman -S gnome-shell-extension-appindicator

# extensões do zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
# considerar talvez substiuir pelo oh-my-posh
# powerlevel10k está sendo abandonado, ao que parece
# yay -S oh-my-posh
git clone https://github.com/romkatv/powerlevel10k.git $HOME/.oh-my-zsh/custom/themes/powerlevel10k
git clone https://github.com/zsh-users/zsh-completions.git $HOME/.oh-my-zsh/custom/plugins/zsh-completions
git clone https://github.com/zsh-users/zsh-autosuggestions.git $HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
git clone https://github.com/Aloxaf/fzf-tab $HOME/.oh-my-zsh/custom/plugins/fzf-tab

# programas
sudo pacman -S firefox gvim code keepassxc remmina pavucontrol

# dicionário para o vim
# https://archlinux.org/packages/extra/any/words/
sudo pacman -S words

# instala code features para melhorar alguns usos
yay -S code-features

# extensões do code
code --install-extension vscodevim.vim
code --install-extension vscode-icons-team.vscode-icons
code --install-extension oderwat.indent-rainbow
code --install-extension tomoki1207.vscode-pdf
code --install-extension s-nlf-fh.glassit

# instalar o oreo-cursor diretamente do yay necessita de MUITAS dependências,
# então ele é copiado e descompactado diretamente do meu repositório
# yay -S oreo-cursors-git
rm -rf $HOME/.icons
mkdir $HOME/.icons/
cp -rv $HOME/arch-hertzog/dotfiles/icons/defaults $HOME/.icons/
for f in $HOME/arch-hertzog/dotfiles/icons/*.tar.gz; do tar xfv "$f" -C $HOME/.icons/; done

# copia o meu tema personalizado
mkdir $HOME/.themes
cp -rv $HOME/arch-hertzog/gnome/dotfiles/themes/* $HOME/.themes

# clones para instalar os temas do sistema
mkdir -p $HOME/GitHub
# cd $HOME/GitHub
# tema do grub
# git clone https://github.com/vinceliuice/grub2-themes
# temas do sistema
# git clone https://github.com/vinceliuice/WhiteSur-gtk-theme
# sudo ./install.sh -t whitesur -i color -s 1080p -b
# # git clone https://github.com/vinceliuice/Orchis-theme
# # git clone https://github.com/EliverLara/Nordic
# ícones do sistema
wget -qO- https://git.io/papirus-icon-theme-install | env DESTDIR="$HOME/.icons" sh
# # git clone https://github.com/bikass/kora
# # cd kora
# # mv kora* $HOME/.local/share/icons

# https://github.com/StevenBlack/hosts
curl -o $HOME/hosts https://raw.githubusercontent.com/StevenBlack/hosts/master/alternates/fakenews-gambling-porn/hosts
sudo mv /etc/hosts /etc/hosts.bak
sudo mv $HOME/hosts /etc/
sudo systemctl restart NetworkManager.service

# cria o ambiente virtual para o Python
python -m venv $HOME/.venv
pip install pylint

# instalações para ale
sudo pacman -S bash-language-server

# esconde o mouse
sudo pacman -S unclutter

# testar o timeshift junto com o btrfs

# tema para o Firefox
cd $HOME/GitHub
git clone https://github.com/datguypiko/Firefox-Mod-Blur
cd Firefox-Mod-Blur
printf "Ir em about:config : toolkit.legacyUserProfileCustomizations.stylesheets -> 'True'"
mkdir -p $HOME/raposa/
cp -r ASSETS $HOME/raposa/
cp userContent.css $HOME/raposa/
cp userChrome.css $HOME/raposa/
cp EXTRA\ MODS/Compact\ extensions\ menu/Style\ 2/cleaner_extensions_menu.css $HOME/mozilla/firefox/firefox-themes
cp EXTRA\ MODS/Tabs\ Bar\ Mods/Colored\ sound\ playing\ tab/colored_soundplaying_tab.css $HOME/raposa/
cp EXTRA\ MODS/Icon\ and\ Button\ Mods/Firefox\ view\ icon\ change/firefox_view_icon_change.css $HOME/raposa/
cp EXTRA\ MODS/Icon\ and\ Button\ Mods/Hide\ list-all-tabs\ button/hide_list-all-tabs_button.css $HOME/raposa/
cp EXTRA\ MODS/Icon\ and\ Button\ Mods/Icons\ in\ main\ menu/icons_in_main_menu.css $HOME/raposa/
cp EXTRA\ MODS/Icon\ and\ Button\ Mods/Menu\ icon\ change/menu_icon_change_to_firefox.css $HOME/raposa/
cp EXTRA\ MODS/Min-max-close\ control\ buttons/Right\ side\ MacOS\ style\ buttons/min-max-close_buttons.css $HOME/raposa/
cp EXTRA\ MODS/Bookmarks\ Bar\ Mods/Remove\ folder\ icons\ from\ bookmars/remove_folder_icons_from_bookmarks.css $HOME/raposa/
cp EXTRA\ MODS/Homepage\ mods/Remove\ text\ from\ homepage\ shortcuts/remove_homepage_shortcut_title_text.css $HOME/raposa/
cp EXTRA\ MODS/Tabs\ Bar\ Mods/Tabs\ -\ reversed\ background\ color/reversed_tabs_bg_color.css $HOME/raposa/
cp EXTRA\ MODS/Tabs\ Bar\ Mods/Tabs\ -\ selected\ tabs\ static\ width/selected_tabs_static_width.css $HOME/raposa/
cp EXTRA\ MODS/Icon\ and\ Button\ Mods/uBlock\ icon\ change/ublock-icon-change.css $HOME/raposa/

printf "agora, copie todo o conteúdo da pasta 'raposa' no HOME"
printf "ache a pasta de perfil em 'about:support', e depois usando 'Open folder' na seção 'Profile'."

# carrega as configurações para o gnome
dconf load / < $HOME/arch-hertzog/gnome/dotfiles/config/dconf/user-settings.conf

# coisas da lixeira
# https://github.com/andreafrancia/trash-cli
sudo pacman -S trash-cli
# ativa a limpeza da lixeira a cada 30 dias
(crontab -l ; echo "@daily $(which trash-empty) 30") | crontab -
