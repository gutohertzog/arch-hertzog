#!/bin/bash

# variável global OK em verde
OK="\e[0;32mOK\e[0m"

function autor(){
    clear
    printf "\n"
    printf " #############################################\n"
    printf " #          SCRIPT POR GUTO HERTZOG          #\n"
    printf " #############################################\n"
    printf "\n"
}

function instala_tudo() {
    printf "\n\n"
    printf " Atualizando Sistema.........................."
    sudo pacman -Suy --noconfirm > /dev/null 2>&1
    printf $OK

    printf "\n"
    printf " Installing Git..............................."
    # https://archlinux.org/packages/extra/x86_64/git/
    sudo pacman -Suy --noconfirm > /dev/null 2>&1
    printf $OK

    printf "\n"
    printf " Installing YaY and Go........................"
    # https://aur.archlinux.org/packages/yay
    sudo pacman -S go --noconfirm > /dev/null 2>&1
    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg -si
    cd ..
    rm -rf yay
    printf $OK

    printf "\n"
    printf " Configurando Fontes.........................."
    printf "\n"
    printf " ....CaskaydiaCove Nerd Font.................."
    # https://archlinux.org/packages/extra/any/ttf-cascadia-code-nerd/
    sudo pacman -S --noconfirm ttf-cascadia-code-nerd > /dev/null 2>&1
    printf $OK

    printf "\n"
    printf " ....CaskaydiaMono Nerd Font.................."
    # https://archlinux.org/packages/extra/any/ttf-cascadia-mono-nerd/
    sudo pacman -S --noconfirm ttf-cascadia-mono-nerd > /dev/null 2>&1
    printf $OK

    printf "\n"
    printf " Installing Kitty............................."
    # https://wiki.archlinux.org/title/kitty
    sudo pacman -S --noconfirm kitty > /dev/null 2>&1
    printf $OK

    printf "\n"
    printf " Installing Neofetch.........................."
    # https://archlinux.org/packages/extra/any/neofetch/
    sudo pacman -S --noconfirm neofetch > /dev/null 2>&1
    printf $OK

    printf "\n"
    printf " Installing ZSH..............................."
    # https://archlinux.org/packages/extra/x86_64/zsh/
    sudo pacman -S --noconfirm zsh > /dev/null 2>&1
    chsh -s /usr/bin/zsh > /dev/null 2>&1
    printf $OK

    printf "\n"
    printf " Installing Oh My ZSH........................."
    # https://github.com/ohmyzsh/ohmyzsh
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" > /dev/null 2>&1
  # 5.2. ativa os plugins no .zshrc
  #   plugins=(git zsh-autosuggestions zsh-syntax-highlighting)
  # 5.3. adiciona o código abaixo no .zshrc na última linha para desativar arrumar a cor das pastas
  #   export LS_COLORS='rs=0:no=00:mi=00:mh=00:ln=01;36:or=01;31:di=01;34:ow=04;01;34:st=34:tw=04;34:pi=01;33:so=01;33:do=01;33:bd=01;33:cd=01;33:su=01;34:sg=01;35:ca=01;35:ex=01;32:'

    printf "\n"
    printf " Installing ZSH - Extensões..................."
    printf "\n"
    printf " ....ZSH Theme................................"
    # https://github.com/romkatv/powerlevel10k
    git clone https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k > /dev/null 2>&1
    printf "\n"
    printf " ....ZSH Completions.........................."
    # https://archlinux.org/packages/extra/any/zsh-completions/
    git clone https://github.com/zsh-users/zsh-completions.git $ZSH_CUSTOM/plugins/zsh-completions > /dev/null 2>&1
    printf "\n"
    printf " ....ZSH Auto Suggestions....................."
    # https://archlinux.org/packages/extra/any/zsh-autosuggestions/
    git clone https://github.com/zsh-users/zsh-autosuggestions.git $ZSH_CUSTOM/plugins/zsh-autosuggestions > /dev/null 2>&1
    printf "\n"
    printf " ....ZSH Syntax Highlighting.................."
    # https://archlinux.org/packages/extra/any/zsh-syntax-highlighting/
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting > /dev/null 2>&1
    printf $OK

    printf "\n"
    printf " Installing Neovim............................"
    # https://archlinux.org/packages/extra/x86_64/neovim/
    sudo pacman -S --noconfirm neovim > /dev/null 2>&1
    printf $OK

    # printf "\n"
    # printf " ....Installing NvChad and Ripgrep............"
    # # https://github.com/NvChad/NvChad
    # git clone https://github.com/NvChad/NvChad ~/.config/nvim --depth 1
    # # https://archlinux.org/packages/extra/x86_64/ripgrep/
    # sudo pacman -S --noconfirm ripgrep > /dev/null 2>&1
    # printf $OK

    printf "\n"
    printf " ....Installing Ripgrep......................."
    # https://archlinux.org/packages/extra/x86_64/ripgrep/
    sudo pacman -S --noconfirm ripgrep > /dev/null 2>&1
    printf $OK

    printf "\n"
    printf " Installing zoxide and fzf...................."
    # https://archlinux.org/packages/extra/x86_64/zoxide/
    # https://archlinux.org/packages/extra/x86_64/fzf/
    sudo pacman -S --noconfirm zoxide fzf > /dev/null 2>&1
    # echo 'eval "$(zoxide init --cmd cd zsh)"' >> ~/.zshrc
    printf $OK

    # printf "\n"
    # printf " Installing unzip............................."
    # # https://archlinux.org/packages/extra/x86_64/unzip/
    # sudo pacman -S --noconfirm unzip > /dev/null 2>&1
    # printf $OK

    printf "\n\n"
    printf " Installing Firefox..........................."
    # https://archlinux.org/packages/extra/x86_64/firefox/
    sudo pacman -S --noconfirm firefox > /dev/null 2>&1
    printf $OK

    printf "\n"
    printf " Installing Code - OSS + Extensões............"
    # https://archlinux.org/packages/extra/x86_64/code/
    sudo pacman -S --noconfirm code > /dev/null 2>&1
    printf "\n"
    printf " ....VSCodeVim................................"
    code-oss --install-extension vscodevim.vim > /dev/null 2>&1
    printf "\n"
    printf " ....VSCode Icons............................."
    code-oss --install-extension vscode-icons-team.vscode-icons > /dev/null 2>&1
    printf "\n"
    printf " ....Indent Rainbow..........................."
    code-oss --install-extension oderwat.indent-rainbow > /dev/null 2>&1
    printf "\n"
    printf " ....vscode-pdf..............................."
    code-oss --install-extension tomoki1207.vscode-pdf > /dev/null 2>&1
    printf $OK

    printf "\n"
    printf " Installing KeePassXC........................."
    # https://archlinux.org/packages/extra/x86_64/keepassxc/
    sudo pacman -S --noconfirm keepassxc > /dev/null 2>&1
    printf $OK

    printf "\n"
    printf " Installing Hyprland.........................."
    # https://archlinux.org/packages/extra/x86_64/hyprland/
    sudo pacman -S --noconfirm hyprland > /dev/null 2>&1
    printf $OK

    # printf "\n"
    # printf " Installing SDDM and dependencies............."
    # https://archlinux.org/packages/extra/x86_64/sddm/
    # https://archlinux.org/packages/extra/x86_64/qt5-wayland/
    # https://archlinux.org/packages/extra/x86_64/qt6-wayland/
    # https://archlinux.org/packages/extra/x86_64/qt5-quickcontrols/
    # https://archlinux.org/packages/extra/x86_64/qt5-quickcontrols2/
    # https://archlinux.org/packages/extra/x86_64/qt5-graphicaleffects/
    # https://archlinux.org/packages/extra/x86_64/qt5-svg/
    # sudo pacman -S --noconfirm sddm qt5-wayland qt6-wayland qt5-quickcontrols qt5-quickcontrols2 qt5-graphicaleffects qt5-svg > /dev/null 2>&1
    # sudo cp -r $1/dotfiles/sddm/themes/* /usr/share/sddm/themes/ > /dev/null 2>&1
    # sudo cp $1/dotfiles/sddm/sddm.conf /etc/ > /dev/null 2>&1
    # sudo systemctl enable sddm > /dev/null 2>&1
    # printf $OK

    printf "\n"
    printf " Installing Hyprpaper........................."
    # https://archlinux.org/packages/extra/x86_64/hyprpaper/
    sudo pacman -S --noconfirm hyprpaper > /dev/null 2>&1
    cp -r $1/dotfiles/Pictures $HOME/ > /dev/null 2>&1
    printf $OK

    printf "\n"
    printf " Installing Waybar and dependencies..........."
    # https://archlinux.org/packages/extra/x86_64/waybar/
    # https://archlinux.org/packages/extra/any/ttf-font-awesome/
    sudo pacman -S --noconfirm waybar ttf-font-awesome > /dev/null 2>&1
    sudo usermod -aG input $USER > /dev/null 2>&1
    printf $OK

    printf "\n"
    printf " Installing waybar-module-pacman-updates......"
    # https://aur.archlinux.org/packages/waybar-module-pacman-updates-git
    yay -S waybar-module-pacman-updates-git > /dev/null 2>&1
    printf $OK

    printf "\n"
    printf " Installing Nautilus.........................."
    # https://archlinux.org/packages/extra/x86_64/nautilus/
    sudo pacman -S --noconfirm nautilus > /dev/null 2>&1
    # gsettings set org.gnome.desktop.interface gtk-theme Adwaita-dark
    # gsettings set org.gnome.desktop.interface color-scheme prefer-dark
    printf $OK

    printf "\n"
    printf " Installing Oreo Cursores....................."
    # https://github.com/varlesh/oreo-cursors
    # yay -S oreo-cursors # this way install A LOT OF dependencies
    rm -rf $HOME/.icons > /dev/null 2>&1
    mkdir $HOME/.icons/
    cp -r $1/dotfiles/.icons/defaults $HOME/.icons/ > /dev/null 2>&1
    for f in $1/dotfiles/.icons/*.tar.gz; do tar xfv "$f" -C $HOME/.icons/; done
    # for f in $HOME/.icons/*.tar.gz; do tar xf "$f"; done
    # rm $HOME/.icons/*.tar.xz > /dev/null 2>&1
    printf $OK

    printf "\n"
    printf " Installing Brightnessctl....................."
    # https://archlinux.org/packages/extra/x86_64/brightnessctl/
    sudo pacman -S --noconfirm brightnessctl > /dev/null 2>&1
    printf $OK

    printf "\n"
    printf " Installing htop.............................."
    # https://archlinux.org/packages/extra/x86_64/htop/
    sudo pacman -S --noconfirm htop > /dev/null 2>&1
    printf $OK

    printf "\n"
    printf " Installing exFAT............................."
    # https://archlinux.org/packages/extra/x86_64/exfat-utils/
    sudo pacman -S --noconfirm exfat-utils > /dev/null 2>&1
    printf $OK

    # printf "\n"
    # printf " Installing mdp..............................."
    # # https://archlinux.org/packages/extra/x86_64/mdp/
    # sudo pacman -S --noconfirm mdp > /dev/null 2>&1
    # printf $OK

    printf "\n"
    # image viewer
    printf " Installing nsxiv............................."
    # https://archlinux.org/packages/extra/x86_64/nsxiv/
    sudo pacman -S --noconfirm nsxiv > /dev/null 2>&1
    printf $OK

    printf "\n"
    printf " Installing nm-connection-editor.............."
    # https://archlinux.org/packages/extra/x86_64/nm-connection-editor/
    sudo pacman -S --noconfirm nm-connection-editor > /dev/null 2>&1
    printf $OK

    printf "\n"
    printf " Installing rofi-lbonn-wayland................"
    # https://aur.archlinux.org/packages/rofi-lbonn-wayland/
    yay -S rofi-lbonn-wayland-git > /dev/null 2>&1
    printf $OK

    printf "\n"
    printf " Installing nwg-look.........................."
    # https://archlinux.org/packages/extra/x86_64/nwg-look/
    sudo pacman -S --noconfirm nwg-look > /dev/null 2>&1
    printf $OK

    printf "\n"
    printf " Installing pavucontrol......................."
    # https://archlinux.org/packages/extra/x86_64/pavucontrol/
    sudo pacman -S --noconfirm pavucontrol > /dev/null 2>&1
    printf $OK

    printf "\n"
    printf " Installing hosts............................."
    # https://github.com/StevenBlack/hosts
    curl -o $HOME/hosts https://raw.githubusercontent.com/StevenBlack/hosts/master/alternates/fakenews-gambling-porn/hosts
    sudo mv /etc/hosts /etc/hosts.bak
    sudo mv $HOME/hosts /etc/
    sudo systemctl restart NetworkManager.service

    printf "\n"
    printf " Installing p7zip............................."
    # https://archlinux.org/packages/extra/x86_64/p7zip/
    sudo pacman -S --noconfirm p7zip > /dev/null 2>&1
    printf $OK
}

function inicializador() {
    printf "\n\nReiniciando em:\n"
    for i in 5 4 3 2 1; do
        printf "$i"
        for j in 4 3 2 1; do
            printf "."
            sleep 0.25
        done
    done
    reboot
}


function copia_arquivos(){
    printf "\n"
    printf " Copiando Arquivos de Configuração.........."
    # rm -rf $HOME/.config > /dev/null 2>&1
    mv $HOME/.config $HOME/.config-bak > /dev/null 2>&1
    cp -r $1/dotfiles/.config $HOME > /dev/null 2>&1
    cp $1/dotfiles/.zshrc $HOME > /dev/null 2>&1
    printf $OK
}

# inicializa o script
if [ $(whoami) != "root" ]; then
    rota=$(pwd)
    autor
    printf "\nInstalação Iniciada\n"
    instala_tudo
    copia_arquivos $rota
    printf "\n\nInstalação Finalizada\n"
    inicializador
else
    printf "\n\nErro, o script não deve ser executado como root.\n\n"
    exit 0
fi
