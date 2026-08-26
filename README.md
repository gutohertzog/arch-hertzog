# arch-hertzog

Repositório para guardar minhas configurações das diferentes versões do Arch Linux.

## Índice
1. [Configurações](#configurações)
1. [Instalação](#instalação)
1. [Pacotes do Sistema](#pacotes-do-sistema)
1. [Aplicativos](#aplicativos)
1. [Design](#design)
1. [Diversão](#diversão)
1. [Atalhos](#atalhos)
    1. [Kitty](#kitty)
    1. [Vim](#vim)
---

## configurações

- [Hyprland](hyprland/README.md)
- [Gnome](gnome/README.md)
- [WSL](wsl/README.md)

## instalação

Para instalar, tem que escolher o ambiente de trabalho no `setup.sh` e os pacotes que quiser instalar.

Por hora, isso será feito comentando e descomentando trechos do código pertinente a cada parte.

## Pacotes Sistema
|||
| :---- | :---- |
| [networkmanager](https://archlinux.org/packages/extra/x86_64/networkmanager) | gerenciador de conexão com internet |
| [nm-connection-editor](https://archlinux.org/packages/extra/x86_64/nm-connection-editor) | gerenciador de conexão com a internet |
| [networkmanager-openvpn](https://archlinux.org/packages/extra/x86_64/networkmanager-openvpn) | plugin para o OpenVPN |
| [git](https://archlinux.org/packages/extra/x86_64/git) | sistema de controle de versionamento |
| [p7zip](https://archlinux.org/packages/extra/x86_64/p7zip) | 7zip em linha de comando |
| [fzf](https://archlinux.org/packages/extra/x86_64/fzf) | buscador difuso de linha de comando |
| [ripgrep](https://archlinux.org/packages/extra/x86_64/ripgrep) | ferramenta de busca que combina ag com grep |
| [nvidia](https://archlinux.org/packages/extra/x86_64/nvidia) | drivers da NVIDIA |
| [nvidia-utils](https://archlinux.org/packages/extra/x86_64/nvidia-utils) | utilitários para o driver da NVIDIA |
| [nvidia-settings](https://archlinux.org/packages/extra/x86_64/nvidia-settings) | ferramenta para configuração da NVIDIA |
| [zsh](https://archlinux.org/packages/extra/x86_64/zsh) | shell avançado |
| [zoxide](https://archlinux.org/packages/extra/x86_64/zoxide) | comando cd mais inteligente |
| [eza](https://archlinux.org/packages/extra/x86_64/eza) | ls moderno com ícones |
| [fastfetch](https://archlinux.org/packages/extra/x86_64/fastfetch) | mostra informações do hardware e software |
| [curl](https://archlinux.org/packages/core/x86_64/curl) | ferramenta de linha de comando para transferir dados com urls |
| [words](https://archlinux.org/packages/extra/any/words) | dicionário de palavras |
| [tk](https://archlinux.org/packages/extra/x86_64/tk) | ferramenta para desenvolver aplicativos gráficos |
| [hosts](https://github.com/StevenBlack/hosts) | bloqueador de rastreadores |
|||

## Aplicativos
|||
| :---- | :---- |
| [firefox](https://archlinux.org/packages/extra/x86_64/firefox) | navegador de internet mozilla firefox |
| [kitty](https://archlinux.org/packages/extra/x86_64/kitty) | emulador do terminal |
| [gvim](https://archlinux.org/packages/extra/x86_64/gvim) | editor de texto cli (suporte ao clipboard) |
| [code-oss](https://archlinux.org/packages/extra/x86_64/code) | editor de código gui |
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
| [bibata-cursors](https://github.com/ful1e5/Bibata_Cursor) | cursores bibata |
| *Fontes* ||
| [ttf-cascadia-code-nerd](https://archlinux.org/packages/extra/any/ttf-cascadia-code-nerd) | CaskaydiaCove Nerd Font |
| [ttf-cascadia-mono-nerd](https://archlinux.org/packages/extra/any/ttf-cascadia-mono-nerd) | CaskaydiaCove Nerd Mono |
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

