# arch-gnome

Respositório com minhas configurações do Gnome no Arch Linux.
Criei ele para usar como distribuição Linux e usar enquanto realizo as configurações do Hyprland e torno ele funcional.

## Índice
1. [Gnome](#gnome)
1. [Pacotes do Gnome](#pacotes-do-gnome)
1. [Gerenciador de Pacotes](#gerenciador-de-pacotes)
1. [Pacotes do Sistema](#pacotes-do-sistema)
1. [Aplicativos](#aplicativos)
1. [Design](#design)
1. [Extensões Gnome](#extensões-gnome)
1. [Diversão](#diversão)
1. [Atalhos](#atalhos)
    1. [Gnome](#gnome-2)
    1. [Kitty](#kitty)
    1. [Vim](#vim)
---

## Gnome
|||
| :---- | :---- |
| [gnome](https://www.gnome.org) | ambiente de desktop |
|||

Ao instalar o Gnome, ele instala todos seus pacotes com [`pacman -S gnome`](https://archlinux.org/groups/x86_64/gnome/), mas para mim, há diversos pacotes que não me interessam, como os aplicativos de documentos.

Abaixo está a seleção de pacotes que são instalados.

## Pacotes do Gnome
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
| [gnome-logs](https://archlinux.org/packages/extra/x86_64/gnome-logs/) | ver logs do systemd |
| [gnome-menus](https://archlinux.org/packages/extra/x86_64/gnome-menus) | configuração dos layouts dos menus |
| [gnome-remote-desktop](https://archlinux.org/packages/extra/x86_64/gnome-remote-desktop) | compartilhamento de tela |
| [gnome-session](https://archlinux.org/packages/extra/x86_64/gnome-session) | gerenciador de sessão |
| [gnome-settings-daemon](https://archlinux.org/packages/extra/x86_64/gnome-settings-daemon) | responsável por configurar parâmetros da sessão |
| [gnome-shell](https://archlinux.org/packages/extra/x86_64/gnome-shell) |  próxima geração do shell do desktop |
| [gnome-shell-extensions](https://archlinux.org/packages/extra/any/gnome-shell-extensions) | gerenciador de extensões para o shell |
| [gnome-system-monitor](https://archlinux.org/packages/extra/x86_64/gnome-system-monitor) | monitor do sistema e |
| [gnome-text-editor](https://archlinux.org/packages/extra/x86_64/gnome-text-editor/) | simples editor de texto |
| [gnome-tweaks](https://archlinux.org/packages/extra/any/gnome-tweaks) | configurações avançadas do gnome 3 |
| [gnome-user-share](https://archlinux.org/packages/extra/x86_64/gnome-user-share) | gerenciador de compartilhamento |
| [gnome-weather](https://archlinux.org/packages/extra/any/gnome-weather) | previsão do tempo |
| [gvfs](https://archlinux.org/packages/extra/x86_64/gvfs) | sistemas de arquivos virtual |
| [gvfs-afc](https://archlinux.org/packages/extra/x86_64/gvfs-afc) | compatibilidade com dispositivos móveis da apple |
| [gvfs-dnssd](https://archlinux.org/packages/extra/x86_64/gvfs-dnssd) | compatibilidade com dispositivos macos e compartilhamento de arquivos |
| [gvfs-google](https://archlinux.org/packages/extra/x86_64/gvfs-google) | compatibilidade com google |
| [gvfs-onedrive](https://archlinux.org/packages/extra/x86_64/gvfs-onedrive) | compatibilidade com onedrive |
| [gvfs-smb](https://archlinux.org/packages/extra/x86_64/gvfs-smb) | compatibilidade com microsoft |
| [gvfs-wsdd](https://archlinux.org/packages/extra/x86_64/gvfs-wsdd) | compatibilidade com Windows |
| [loupe](https://archlinux.org/packages/extra/x86_64/loupe) | visualizador de imagens |
| [nautilus](https://archlinux.org/packages/extra/x86_64/nautilus) | explorador de arquivos |
| [sushi](https://archlinux.org/packages/extra/x86_64/sushi) | pré-visualizador para o Nautilus |
| [tecla](https://archlinux.org/packages/extra/x86_64/tecla) | visualizador do layout do teclado |
| [tracker3-miners](https://archlinux.org/packages/extra/x86_64/tracker3-miners) | indexador de arquivos e extrator de metadata |
| [xdg-desktop-portal-gnome](https://archlinux.org/packages/extra/x86_64/xdg-desktop-portal-gnome) | implementação backend do desktop portal |
| [xdg-user-dirs-gtk](https://archlinux.org/packages/extra/x86_64/xdg-user-dirs-gtk) | cria usuários e realoca eles |
|||

## Pacotes do Sistema
|||
| :---- | :---- |
| [networkmanager](https://archlinux.org/packages/extra/x86_64/networkmanager) | gerenciador de conexão com internet |
| [nm-connection-editor](https://archlinux.org/packages/extra/x86_64/nm-connection-editor) | gerenciador de conexão com a internet|
| [git](https://archlinux.org/packages/extra/x86_64/git) | sistema de controle de versionamento |
| [p7zip](https://archlinux.org/packages/extra/x86_64/p7zip) | 7zip em linha de comando |
| [fzf](https://archlinux.org/packages/extra/x86_64/fzf) | buscador difuso de linha de comando |
| [ripgrep](https://archlinux.org/packages/extra/x86_64/ripgrep) | ferramenta de busca que combin ag com grep |
| [nvidia](https://archlinux.org/packages/extra/x86_64/nvidia) | drivers da nvidia |
| [nvidia-utils](https://archlinux.org/packages/extra/x86_64/nvidia-utils) | utilitários para o driver da nvidia |
| [nvidia-settings](https://archlinux.org/packages/extra/x86_64/nvidia-settings) | ferramenta para configuração da nvidia |
| [zsh](https://archlinux.org/packages/extra/x86_64/zsh) | shell avançado |
| [zoxide](https://archlinux.org/packages/extra/x86_64/zoxide) | comando cd mais inteligente |
| [fastfetch](https://archlinux.org/packages/extra/x86_64/fastfetch) | mostra informações do hardware e software |
| [curl](https://archlinux.org/packages/core/x86_64/curl) | ferramenta de linha de comando para transferir dados com urls |
| [unclutter](https://archlinux.org/packages/extra/x86_64/unclutter) | esconde o mouse |
|||

## Aplicativos
|||
| :---- | :---- |
| [microsoft edge](https://aur.archlinux.org/packages/microsoft-edge-stable-bin) | navegador de internet microsoft edge |
| [firefox](https://archlinux.org/packages/extra/x86_64/firefox) | navegador de internet mozilla firefox |
| [kitty](https://archlinux.org/packages/extra/x86_64/kitty) | emulador do terminal |
| [gvim](https://archlinux.org/packages/extra/x86_64/gvim) | editor de texto cli (gvim vem com suporte a clipboard) |
<!--| [code-oss](https://archlinux.org/packages/extra/x86_64/code) | editor de código gui |-->
| [keepassxc](https://archlinux.org/packages/extra/x86_64/keepassxc) | gerenciador de senhas |
| [pavucontrol](https://archlinux.org/packages/extra/x86_64/pavucontrol) | controle de volume do pulseaudio |
| [remmina](https://archlinux.org/packages/extra/x86_64/remmina) | conexão remota |
|||

## Design
|||
| :---- | :---- |
| *Ícones* ||
| [papirus-icon-theme](https://github.com/PapirusDevelopmentTeam/papirus-icon-theme) | píxel ícones perfeitos |
| *Cursores* ||
| [oreo-cursors](https://github.com/varlesh/oreo-cursors) | cursores oreo |
| *Fontes* ||
| [ttf-cascadia-code-nerd](https://archlinux.org/packages/extra/any/ttf-cascadia-code-nerd) | CaskaydiaCove Nerd Font |
| [ttf-cascadia-mono-nerd](https://archlinux.org/packages/extra/any/ttf-cascadia-mono-nerd) | CaskaydiaCove Nerd Mono |
|||

## Extensões Gnome
|||
| :---- | :---- |
| [dash-to-dock](https://github.com/micheleg/dash-to-dock) | move o dash para um dock |
| [blur-my-shell](https://github.com/aunetx/blur-my-shell) | adiciona blur no gnome |
| [caffeine](https://github.com/eonpatapon/gnome-shell-extension-caffeine) | desativa desligamento de tela e auto suspensão |
| [vitals](https://github.com/corecoding/Vitals) | monitorador de hardware |
|||

## Diversão
|||
| :---- | :---- |
| [retroarch](https://archlinux.org/packages/extra/x86_64/retroarch) | emulador de jogos |
| [retroarch-assets-glui](https://archlinux.org/packages/extra/any/retroarch-assets-glui) | assets para o menu do retroarch |
| [retroarch-assets-ozone](https://archlinux.org/packages/extra/any/retroarch-assets-ozone) | assets para o menu do retroarch |
| [retroarch-assts-xmb](https://archlinux.org/packages/extra/any/retroarch-assets-xmb) | assets para o menu do retroarch |
| [steam](https://archlinux.org/packages/multilib/x86_64/steam) | distribuidor de jogos da steam |
| [lib32-nvidia-utils](https://archlinux.org/packages/multilib/x86_64/lib32-nvidia-utils) | biblioteca para rodar steam com nvidia |
|||

## Atalhos
### Gnome
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

### Kitty
|||
| :---- | :---- |
| `f1` | troca a imagem de fundo |
|||
| `ctrl` + `shift` + `n` | abre um novo terminal |
| `ctrl` + `shift` + `t` | abre uma nova aba no terminal |
| `ctrl` + `shift` + `q` | fecha a aba atual no terminal |
| `ctrl` + `tab` | vai para a aba seguinte |
| `ctrl` + `shift` + `tab` | vai para a aba anterior |
|||
| `f5` | cria uma nova janela abaixo da atual |
| `f6` | cria uma nova janela a direita da atual |
| `f7` | inverte a orientação das janelas abertas |
|||
| `ctrl` + `cima` | move o foco para cima |
| `ctrl` + `baixo` | move o foco para baixo |
| `ctrl` + `direita` | move o foco para direita |
| `ctrl` + `esquerda` | move o foco para esquerda |
|||
| `shift` + `cima` | move a janela em foco para cima |
| `shift` + `baixo` | move a janela em foco para baixo |
| `shift` + `direita` | move a janela em foco para direita |
| `shift` + `esquerda` | move a janela em foco para esquerda |
|||
| `ctrl` + `shift` + `cima` | move a janela para a margem acima |
| `ctrl` + `shift` + `baixo` | move a janela para a margem abaixo |
| `ctrl` + `shift` + `direita` | move a janela para a margem direita |
| `ctrl` + `shift` + `esquerda` | move a janela para a margem esquerda |
|||
| `alt` + `cima` | aumenta a altura da janela |
| `alt` + `baixo` | diminui a altura da janela |
| `alt` + `direita` | aumenta a largura da janela |
| `alt` + `esquerda` | diminui a largura da janela |
| `alt` + `home` | reinicia os tamanhos para o padrão |
|||
| `alt` + `home` | reinicia os tamanhos para o padrão |
|||

### Vim
||||
| :---- | :---- | :---- |
| `<leader>vim` | abre para edição o arquivo vimrc | n |
| `<c-s>` | salva o buffer | n, i, x, s |
| `:W` | salva o buffer com sudo ||
| *Janelas* |||
| `<c-h>` | move o foco para esquerda | n |
| `<c-j>` | move o foco para baixo | n |
| `<c-k>` | move o foco para cima | n |
| `<c-l>` | move o foco para direita | n |
| `<leader>ww` | fecha o buffer em foco | n |
| `<leader>ws` | abre um novo buffer na horizontal | n |
| `<leader>wS` | abre o buffer atual na horizontal | n |
| `<leader>wv` | abre um novo buffer na vertical | n |
| `<leader>wV` | abre o buffer atual na vertival | n |
| *Abas* |||
| `<c-h>` | move o foco para esquerda | n |
| `<leader>tt` | abre uma nova aba | n |
| `<leader>tw` | fecha a aba em foco | n |
| `<leader>tn` | abre a aba seguinte | n |
| `<leader>tp` | abre a aba anterior | n |
| *Buffers* |||
| `<leader>bw` | fecha o buffer atual | n |
| `<tab>` | abre o buffer seguinte | n |
| `<s-tab>` | abre o buffer anterior | n |
| *Terminal* |||
| `<ledader><esc>` | sai do modo terminal | t |
||||
