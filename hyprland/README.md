# arch-hyprland #

Repositório com o tutorial de instalação do Arch Linux e da interface Hyprland.

Futuramente voltarei.

- - - -
## 1. [Instação Arch Linux](instalacao.md) ##
A primeira parte será a instalação do Arch Linux juntamente com o Hyprland usando o próprio script `archinstall`.

- - - -
## 2. [Tutorial Hyprland](tutorial.md) ##
A segunda parte será um tutorial de configuração do Hyprland.

Também serão instalados outros pacotes e mostradas suas configurações.

Essa instalação será detalhada, explicando as funcionalidades e trazendo links para explicar o que cada um faz e como configurá-las.

Ele vai servir para quem quiser saber mais sobre os pormenores dos pacotes, como funciona, suas particularidades, comandos etc.

- - - -
## 3. [Script Hyprland](script.md) ##
A terceria parte será um script para ser executado logo após o fim da etapa [1](#1-instação-arch-linux).

Esse script, quando executado, instalará todos os pacotes adicionais e copiará todos os arquivos de configurações já prontos na pasta `dotfiles`.

- - - -
## Pacotes ##

| Hypr ||
| :---- | :---- |
| [hyprland](https://hyprland.org) | gerenciador de janelas principal |
| [hyprpaper](https://github.com/hyprwm/hyprpaper) | gerenciador do papel de parede |
| [waybar](https://github.com/Alexays/Waybar) | gerenciador da barra de tarefas |

| Login ||
| :---- | :---- |
| [sddm](https://wiki.archlinux.org/title/SDDM) | gerenciador para o login |
| [qt5-wayland](https://archlinux.org/packages/extra/x86_64/qt5-wayland) | API para Wayland |
| [qt6-wayland](https://archlinux.org/packages/extra/x86_64/qt6-wayland) | API para Wayland |
| [qt5-quickcontrols](https://archlinux.org/packages/extra/x86_64/qt5-quickcontrols) | para o tema SDDM |
| [qt5-quickcontrols2](https://archlinux.org/packages/extra/x86_64/qt5-quickcontrols2) | para o tema SDDM |
| [qt5-graphicaleffects](https://archlinux.org/packages/extra/x86_64/qt5-graphicaleffects) | para o tema SDDM |

| Utilitários ||
| :---- | :---- |
| [pipewire](https://docs.pipewire.org) | servidor de áudio e vídeo |
| [pipewire-alsa](https://wiki.archlinux.org/title/PipeWire#ALSA_clients) | para o áudio |
| [pipewire-jack](https://wiki.archlinux.org/title/PipeWire#JACK_clients) | para o áudio |
| [pipewire-pulse](https://wiki.archlinux.org/title/PipeWire#PulseAudio_clients) | para o áudio |
| [gst-plugin-pipewire](https://archlinux.org/packages/extra/x86_64/gst-plugin-pipewire) | para o áudio |
| [wireplumber](https://wiki.archlinux.org/title/WirePlumber) | servidor de áudio e vídeo |
| [networkmanager](https://wiki.archlinux.org/title/NetworkManager) | gerenciador de rede |
| [network-manager-applet](https://wiki.archlinux.org/title/NetworkManager#Additional_interfaces) | ícone do Network Manager |
| [bluez](https://wiki.archlinux.org/title/bluetooth#Installation) | protocolo do bluetooth |
| [bluez-utils](https://wiki.archlinux.org/title/bluetooth#Installation) | controlador do bluetooth `bluetoothctl` |
| [blueman](https://wiki.archlinux.org/title/Blueman) | controlador e ícone do bluetooth |

| Aplicativos ||
| :---- | :---- |
| [firefox](https://www.mozilla.org/pt-BR/firefox/new) | navegador de internet |
| [kitty](https://sw.kovidgoyal.net/kitty) | emulador do terminal |
| [neofetch](https://github.com/dylanaraps/neofetch) | mostra informações do hardware e software |
| [thunar](https://docs.xfce.org/xfce/thunar/start) | gerenciador de arquivos |
| [code-oss](https://wiki.archlinux.org/title/Visual_Studio_Code) | editor de código gui |
| [neovim](https://neovim.io) | editor de texto cli |
| [keepassxc](https://keepassxc.org) | gerenciador de senhas |
<!-- | [ark](https://apps.kde.org/ark) | gerenciador de arquivos compactados do kde | -->

| Fontes ||
| :---- | :---- |
| [caskaydiacove](https://www.nerdfonts.com/font-downloads) | CaskaydiaCove Nerd Font |
| [caskaydiamono](https://www.nerdfonts.com/font-downloads) | CaskaydiaCove Nerd Mono |

## Atalhos ##

### Geral ###
| Teclas | Ação |
| :---- | :---- |
| <kbd>Super</kbd> + <kbd>Q</kbd> | encerra a janela ativa |
| <kbd>Alt</kbd> + <kbd>F4</kbd> | encerra a janela ativa |
| <kbd>Super</kbd> + <kbd>Del</kbd> | encerra a sessão Hyprland |
| <kbd>Super</kbd> + <kbd>Space</kbd> | troca o layout do teclado |

### Programas ###
| Teclas | Ação |
| :---- | :---- |
| <kbd>Super</kbd> + <kbd>K</kbd> | abre o terminal Kitty |
| <kbd>Super</kbd> + <kbd>E</kbd> | abre o explorador de arquivos Thunar |
| <kbd>Super</kbd> + <kbd>C</kbd> | abre o VS Code |
| <kbd>Super</kbd> + <kbd>F</kbd> | abre o Firefox |
| <kbd>Super</kbd> + <kbd>P</kbd> | abre o KeePassXC |

### Janelas ###
| Teclas | Ação |
| :---- | :---- |
| <kbd>Super</kbd> + <kbd>H/J/K/L</kbd> | muda o foco da janela ativa |
| <kbd>Super</kbd> + <kbd>SHIFT</kbd> + <kbd>H/J/K/L</kbd> | muda o tamanho da janela |
| <kbd>Super</kbd> + <kbd>W</kbd> | (des)flutua a janela |
| <kbd>Super</kbd> + <kbd>G</kbd> | (des)agrupa a janela |
| <kbd>Super</kbd> + <kbd>V</kbd> | alterna layout |
| <kbd>Alt</kbd> + <kbd>Enter</kbd> | entra/sai da tela cheia |

### Área de Trabalho ###
| Teclas | Ação |
| :---- | :---- |
| <kbd>Super</kbd> + <kbd>Roda Mouse</kbd> | circula entre as áreas de trabalho |
| <kbd>Super</kbd> + <kbd>[0-9]</kbd> | vai para a área de trabalho [0-9] |
| <kbd>Super</kbd> + <kbd>Ctrl</kbd> + <kbd>Alt</kbd> + <kbd>H/L</kbd> | move a janela ativa para a área de trabalho adjacente |
| <kbd>Super</kbd> + <kbd>SHIFT</kbd> + <kbd>[0-9]</kbd> | move a janela ativa para a área de trabalho [0-9] |
| <kbd>Super</kbd> + <kbd>Alt</kbd> + <kbd>[0-9]</kbd> | move a janela ativa para a área de trabalho [0-9] (silenciosamente) |
| <kbd>Super</kbd> + <kbd>Alt</kbd> + <kbd>S</kbd> | move a janela ativa para a área de trabalho especial |
| <kbd>Super</kbd> + <kbd>S</kbd> | vai/volta da área de trabalho especial |
| <kbd>Super</kbd> + <kbd>Ctrl</kbd> + <kbd>J</kbd> | vai para a primeira área de trabalho vazia (da esquerda para direita) |

### Desenvolvimento ###
| <kbd>Super</kbd> + <kbd>A</kbd> | ativa e desativa a waybar |
