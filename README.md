# arch-hertzog

Com o tempo, eu criei alguns repositórios para usos específicos do Arch Linux.

Isso gerou o problema de que eu tinha que atualizar em diversos lugares os arquivos de configuração, como o *Vim* ou *Kitty*, por exemplo.

Então agrupei todas as instalações/configurações em um repositório, de modo que eu teria apenas um lugar para guardar tudo das diferentes instalações. As configurações comuns entre as distros estarão na pasta *dotfiles* e as específicas em cada respectiva pasta.

## configurações

- [Hyprland](hyprland/README.md)
- [Gnome](gnome/README.md)
- [WSL](wsl/README.md)

## organização

- cada ambiente terá seu arquivo de instalação;
- todos irão executar o script em `dotfiles/install.sh`;
- a pasta `scripts` tem scripts usados para instalar/atualizar os pacotes que não estão disponíveis com `pacman`;
