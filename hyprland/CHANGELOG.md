# LOG DE ALTERAÇÕES #

## v.1.5.0 ##
* definido o Thunar como gerenciador de arquivos;
* definido o tema do Thunar para `Adwaita Dark`;
* adicionado os pacotes `htop`, `exfat`;
* removido o log da instalação;
* melhorias na instalação dos pacotes no `install.sh`;
* adicionado o gerenciador de senhas `KeePassXC`;
* adicionado mais pastas nno script `backup.sh`;
* adicionado mais configurações para o VS Code;
* definido o layout do teclado para Dvorak Brasileiro;
* adicionado cursores de [Oreo Cursors](https://github.com/varlesh/oreo-cursors);
    * é possível listar e escolher os cursores usando o script de `ativa.sh` na pasta `~/.icons`;
    * para as cores e formas, basta ver os arquivos .png na pasta;
    * definido como padrão o Oreo Spark Lime;

## v.1.4.2 ##
* saída das execuções na instalação para um arquivo de log;
* ajustes má digitação;

## v.1.4.1 ##
* Adicionado o script para realizar o backup das alterações;
* Ainda testando as opções de audio *pipewire* e *pulseaudio*;
* Adicionado a **Waybar** e uma primeira configuração;
* Adicionado o Neovim;
* Adicionado a fonte Caskaydia Mono Nerd Font na instalação;
* Adicionado transparência no VS Code e Kitty;
* Adicionado alguns pacotes do bluetooth, mas ainda sem testar apropriadamente;
* Mantida a instalação **Mínimal**;
* Removido o conteúdo do *tutorial.md*, já que muito conteúdo ainda será alterado;
* Scripts movidos para uma pasta própria;
* Tema do Hyprland movido para um arquivo separado *theme.conf*;

## v.1.4.0 ##
* Alterando para primeiro funcionar o `install.sh` e depois os tutoriais;
* Adicionado diversas tabelas (atalhos e pacotes);

## v.1.3.1 ##
* `install.sh`:
    * removida a criação da pasta `.config`;
    * corrigidos os erros das chamadas da pasta `.config` como `config`;
    * corrigida a falta do segundo parametro na copia do wallpaper;

## v.1.3.0 ##
* adicionado o arquivo `ATALHOS.md` que terá as tabelas com os atalhos;
* adicionado o arquivo `CHANGELOG.md` que conterá o histórico das atualizações do projeto;
* histórico de alterações movido de `README.md` para `CHANGELOG.md`;
* tela de login:
    * adicionado usando o `SDDM`;
    * tema de login usado é o catppuccin-macchiato de [isabelroses](https://github.com/isabelroses/sddm);
    * que é um fork do [original](https://github.com/catppuccin/sddm);
    * adicionado os arquivos de configuração;
* papel de parede:
    * adição do wallpaper com o [Hyprpaper](https://github.com/hyprwm/hyprpaper);
    * uma opção de papel de parede adicionado;
    * adicionado o arquivo de configuração;
    * atualizado `hyprland.conf`;
* install.sh:
    * mais flexível com o uso de variáveis;
    * adicionado tela de login e wallpaper ao script;
* adicionado `.gitignore`;
* instalação Arch Linux:
    * organização as opções do `archinstall` em uma tabela;
    * atualizado o menu do `archinstall` para a versão de 08/2023;
    * movida a configuração do `pacman` do Tutorial Hyprland para a Instalação do Arch Linux;
    * adicionado `Pipewire` nas configurações de som;
    * arrumado o erro ortográfico do `reboot`;
* .bashrc:
    * adicionado o Vim para o `sudoedit`;
    * mais comentários;

## v.1.2.1 ##
* criação da tela de login e início da personalização;
* ajustes nos textos gerais;
* movimentos do mouse para reajustar janelas no Hyprland;

## v.1.2.0 ##
* corrigido um problema na instalação do Vim;
* troca das aspas simples para duplas;
* ajustes gerais na exibição durante instalação;

## v.1.1.2 ##
* refinando instalador;

## v.1.1.1 ##
* arrumando diversos problemas do install.sh;

## v.1.1.0 ##
* adicionado tabela de conteúdo do script;
* ajustado o tutorial 3 com os detalhes que faltavam;
* mais comentários nos arquivos do Vim;

## v1.0.0 ##
* instalador pronto;
* primeira parte do projeto pronto;
* ainda falta preparar as demais partes como tela de login, wallpaper etc;

- - - -
## v0.1.3 ##
* ajuste no README;

## v0.1.2 ##
* ajustes no Tutorial 2;
* organização das pastas no `dotfiles`;
* removida a pasta `Fontes` para deixar o repositório mais leve;
    * a fonte agora é baixada diretamente;
* ajustes de links e descrições no Tutorial 1;

## v0.1.1 ##
* adicionando arquivos de configuracao para:
    * hyprland
    * kitty
    * bashrc
    * neofetch
    * vim
* adicionando os arquivos `ttf` do CaskaydiaCove Nerd Font;

## v0.1.0 ##
* início do Tutorial 2;
* finalização do Tutorial 1 usando o archinstall;
* ajustes no README inicial;

## v0.0.1 ##
* criação dos READMEs e das pastas;
* criação do repositório;
