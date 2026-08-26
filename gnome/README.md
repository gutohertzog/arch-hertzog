# arch-gnome

Respositório com minhas configurações do GNOME no Arch Linux.

## Índice
1. [GNOME](#gnome)
1. [Pacotes do GNOME](#pacotes-do-gnome)
1. [Pacotes do Sistema](#pacotes-do-sistema)
1. [Extensões GNOME](#extensões-gnome)
1. [Atalhos](#atalhos)
    1. [GNOME](#gnome-2)
---

## GNOME
|||
| :---- | :---- |
| [gnome](https://www.gnome.org) | ambiente de desktop |
|||

Ao instalar o GNOME via pacman, é instalado todos seus pacotes com [`pacman -S gnome`](https://archlinux.org/groups/x86_64/gnome), mas para mim há diversos pacotes que não me interessam, como os aplicativos de documentos.

Abaixo está a seleção de pacotes que são instalados.

### Pacotes GNOME
|||
| :---- | :---- |
| [baobab](https://archlinux.org/packages/extra/x86_64/baobab) | análise de disco |
| [gdm](https://archlinux.org/packages/extra/x86_64/gdm) | gerenciador de tela e tela de login |
| [gnome-backgrounds](https://archlinux.org/packages/extra/any/gnome-backgrounds) | pacotes de wallpapers |
| [gnome-calculator](https://archlinux.org/packages/extra/x86_64/gnome-calculator) | calculadora científica |
| [gnome-calendar](https://archlinux.org/packages/extra/x86_64/gnome-calendar) | calendário |
| [gnome-characters](https://archlinux.org/packages/extra/x86_64/gnome-characters) | emojis |
| [gnome-clocks](https://archlinux.org/packages/extra/x86_64/gnome-clocks) | relógios/timers/etc |
| [gnome-color-manager](https://archlinux.org/packages/extra/x86_64/gnome-color-manager) | ferramentas de cor |
| [gnome-contacts](https://archlinux.org/packages/extra/x86_64/gnome-contacts) | agenda eletrônica |
| [gnome-control-center](https://archlinux.org/packages/extra/x86_64/gnome-control-center) | interface para configurar diversos ajustes da máquina |
| [gnome-disk-utility](https://archlinux.org/packages/extra/x86_64/gnome-disk-utility) | utilitário de disco |
| [gnome-font-viewer](https://archlinux.org/packages/extra/x86_64/gnome-font-viewer) | gerenciador e visualizador de fontes |
| [gnome-keyring](https://archlinux.org/packages/extra/x86_64/gnome-keyring) | armazena senhas e chaves criptografadas |
| [gnome-logs](https://archlinux.org/packages/extra/x86_64/gnome-logs) | ver logs do systemd |
| [gnome-menus](https://archlinux.org/packages/extra/x86_64/gnome-menus) | configuração dos layouts dos menus |
| [gnome-remote-desktop](https://archlinux.org/packages/extra/x86_64/gnome-remote-desktop) | compartilhamento de tela |
| [gnome-session](https://archlinux.org/packages/extra/x86_64/gnome-session) | gerenciador de sessão |
| [gnome-settings-daemon](https://archlinux.org/packages/extra/x86_64/gnome-settings-daemon) | responsável por configurar parâmetros da sessão |
| [gnome-shell](https://archlinux.org/packages/extra/x86_64/gnome-shell) |  próxima geração do shell do desktop |
| [gnome-shell-extensions](https://archlinux.org/packages/extra/any/gnome-shell-extensions) | gerenciador de extensões para o shell |
| [gnome-system-monitor](https://archlinux.org/packages/extra/x86_64/gnome-system-monitor) | monitor do sistema e |
| [gnome-text-editor](https://archlinux.org/packages/extra/x86_64/gnome-text-editor) | simples editor de texto |
| [gnome-user-share](https://archlinux.org/packages/extra/x86_64/gnome-user-share) | gerenciador de compartilhamento |
| [gnome-weather](https://archlinux.org/packages/extra/any/gnome-weather) | previsão do tempo |
| [gvfs](https://archlinux.org/packages/extra/x86_64/gvfs) | sistemas de arquivos virtual |
| [gvfs-afc](https://archlinux.org/packages/extra/x86_64/gvfs-afc) | compatibilidade com dispositivos móveis da apple |
| [gvfs-dnssd](https://archlinux.org/packages/extra/x86_64/gvfs-dnssd) | compatibilidade com dispositivos macos e compartilhamento de arquivos |
| [gvfs-google](https://archlinux.org/packages/extra/x86_64/gvfs-google) | compatibilidade com Google |
| [gvfs-onedrive](https://archlinux.org/packages/extra/x86_64/gvfs-onedrive) | compatibilidade com OneDrive |
| [gvfs-smb](https://archlinux.org/packages/extra/x86_64/gvfs-smb) | compatibilidade com Microsoft |
| [gvfs-wsdd](https://archlinux.org/packages/extra/x86_64/gvfs-wsdd) | compatibilidade com Windows |
| [localsearch](https://archlinux.org/packages/extra/x86_64/localsearch) | indexador de arquivos e extrator de metadata |
| [loupe](https://archlinux.org/packages/extra/x86_64/loupe) | visualizador de imagens |
| [nautilus](https://archlinux.org/packages/extra/x86_64/nautilus) | explorador de arquivos |
| [sushi](https://archlinux.org/packages/extra/x86_64/sushi) | pré-visualizador para o Nautilus |
| [tecla](https://archlinux.org/packages/extra/x86_64/tecla) | visualizador do layout do teclado |
| [xdg-desktop-portal-gnome](https://archlinux.org/packages/extra/x86_64/xdg-desktop-portal-gnome) | implementação backend do desktop portal |
| [xdg-user-dirs-gtk](https://archlinux.org/packages/extra/x86_64/xdg-user-dirs-gtk) | cria usuários e realoca eles |
| *Extra* ||
| [gnome-tweaks](https://archlinux.org/packages/extra/any/gnome-tweaks) | configurações avançadas do GNOME 3 |
| *Extensões* ||
| [dash-to-dock](https://github.com/micheleg/dash-to-dock) | move o dash para um dock |
| [blur-my-shell](https://github.com/aunetx/blur-my-shell) | adiciona blur no gnome |
| [caffeine](https://github.com/eonpatapon/gnome-shell-extension-caffeine) | desativa desligamento de tela e auto suspensão |
| [tray-icons-reloaded](https://github.com/martinpl/tray-icons-reloaded) | mostra os ícones ativos |
| [lockkeys](https://github.com/kazysmaster/gnome-shell-extension-lockkeys) | mostra as teclas num e caps lock ativas |
| [vitals](https://github.com/corecoding/Vitals) | monitorador de hardware |
| [hide-cursor](https://github.com/elcste/hide-cursor) | esconde o mouse após inatividade (wayland) |

## Atalhos
### GNOME
|||
| :---- | :---- |
| *Sistema* ||
| `super` + `esc` | abre menu rápido |
| *Aplicativos* ||
| `super` + `t` | executa kitty |
| `super` + `f` | executa edge |
| `super` + `shift` + `f` | executa firefox |
| `super` + `e` | executa nautilus |
| `super` + `c` | executa code oss |
| *Área de Trabalho* ||
| `super` + `1..9` | vai para a área de trabalho 1..9 |
| `super` + `end` | vai para a última área de trabalho |
| `super` + `shift` + `1..9` | move a janela ativa para a área de trabalho 1..9 |
| *Janela* ||
| `super` + `q` | fecha a janela ativa |
| `alt` + `tab` | troca de janela |
| `super` + `tab` | troca de janela do aplicativo |
| `super` + `direita` | move a janela ativa um monitor para direita |
| `super` + `esquerda` | move a janela ativa um monitor para esquerda |
| *Captura de Tela* ||
| `print` | captura de tela interativa |
| `alt` + `print` | captura de tela da janela ativa |
| `shift` + `print` | captura de tela de todos monitores |
| *Teclado* ||
| `super` + `espaço` | troca para o próximo layout de teclado |
| `super` + `shift` + `espaço` | troca para o anterior layout de teclado |
|||

