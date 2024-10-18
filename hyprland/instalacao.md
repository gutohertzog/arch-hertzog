# Instalação Arch Linux #

- - - -
## 1. Baixando ISO ##
Primeiro é preciso baixar a ISO do Arch Linux. Para isso, acesse o seguinte [link](https://archlinux.org/download/).

- - - -
## 2. Preparando o Pen Drive ##
Uma vez baixada a ISO, é necessario criar um pen drive de instalação.
Uma das formas de fazer isso é usando o Rufus.

### 2.1. Rufus ###
O [Rufus](https://github.com/pbatard/rufus) é um programa usado para criar pen drives inicializáveis a partir de ISOs.
Pode ser usado tanto com sistemas Linux quanto para sistemas Windows.

Acesse o link de [download](https://github.com/pbatard/rufus/releases) e baixe a versão mais atual do programa.

Use esse [tutorial](https://rufus.ie/en/) para criar o pen drive inicializável a partir da ISO do Arch Linux.

- - - -
## 3. Instalando o Arch Linux ##

### 3.1. Conectando à Internet ###
O Arch Linux, diferente de outras distribuições Linux, é baixado durante a instalação. Então, para conseguir realizar a instalação, é necessário que a máquina esteja conectada à internet.

Se ela for cabeada, a imagem de instalação do Arch Linux é capaz de identificar e realizar a conexão automaticamente e o passo da `Conexão Manual` (abaixo) pode ser pulado. Cado contrário, siga os passos abaixo.

### 3.2. Conexão Manual ###
A partir do terminal, execute os comandos abaixo:
- busque as opções de conexões com o comando [`rfkill`](https://wiki.archlinux.org/title/Network_configuration/Wireless#Rfkill_caveat):
    ```shell
    rfkill
    ```
- se o tipo `wlan` estiver bloqueado, realize o seu desbloqueio:
    ```shell
    rfkill unblock wlan
    ```
- uma nova verificação de desbloqueio pode ser feita chamando o `rfkill`;
- agora, é necessário incializar o [`iwctl`](https://wiki.archlinux.org/title/iwd):
    ```shell
    iwctl
    ```
- esse comando inicializará a interface de conexão wi-fi pelo terminal;
- use o comando `device list` vai listar todos os dispositivos de conexão w-fi disponíveis na máquina:
    ```shell
    device list
    ```
- agora que já se sabe o nome do dispositivo, podemos realizar a busca pelas redes disponíveis;
- para isso, use o comando abaixo para iniciar a varredura pelas redes ao alcance:
    ```shell
    station wlan0 scan
    ```
- uma vez que o comando é executado, ele ficará varrendo pelas redes ao alcance;
- para listar as redes encontradas, use o seguinte comando:
    ```shell
    station wlan0 get-networks
    ```
- uma lista (que é constantemente atualizada) é gerada com o nome das redes, sua segurança e a força do sinal;
- para se conectar, digite o comando abaixo substituindo `<rede>` pelo nome da rede que quer se conectar:
    ```shell
    station wlan0 connect <rede>
    ```
- se a rede estiver protegida por senha, vai ser pedido que digite a senha de conexão;
- para verificar se a conexão foi bem sucedida, use o comando abaixo:
    ```shell
    station wlan0 show
    ```
- uma vez que a conexão com a rede foi estabelecida, saia do `iwctl` com o comando abaixo:
    ```shell
    exit
    ```
- para testar a conexão, realize um [`ping`](https://phoenixnap.com/kb/linux-ping-command-examples):
    ```shell
    ping -c 3 www.archlinux.org
    ```
- caso não esteja conseguindo de conectar à internet, realize os passos acima novamente;
- se persistir, busque por uma solução na internet ou abra um [problema](https://docs.github.com/pt/issues/tracking-your-work-with-issues/quickstart) no projeto que ajudarei dentro do possível;

### 3.3. Pacman ###

Antes de inicializar a instalação, aproveite o uso do terminal como [sudo](https://wiki.archlinux.org/title/sudo) e vamos deixar o terminal mais interessante.

Usando o Vim da imagem, acesso o arquivo de configuração do [`pacman`](https://wiki.archlinux.org/title/pacman).
```shell
vim /etc/pacman.conf
```

No tópico `Misc options`, descomente (apague a `#`) de `Color` (terminal colorido) e `ParallelDownloads` (permite baixar até 5 pacotes simultaneamente) e adicione ao final da lista `ILoveCandy` (surpresa). Vai ficar mais ou menos assim:
```
# Misc options
#UseSyslog
Color
#NoProgressBar
CheckSpace
#VerbosePkgLists
ParallelDownloads = 5
ILoveCandy
```
Durante a instalação, esse arquivo será copiado para mesma pasta, portanto, esses ajustes serão persistidos pós-instalação.

### 3.4. Instalação ###
Uma vez que a conexão com a internet está efetuada, pode-se iniciar a instalação efetiva do Arch Linux.

Digite o comando [`archinstall`](https://archinstall.readthedocs.io/installing/guided.html) e, dessa forma, iniciar a instalação. Isso irá abrir uma lista com diversas opções.

Abaixo, há uma tabela com todas as configurações usadas.
Os campos que estiverem destacados são obrigatórios. Os demais, são de configuração sugerida, mas podem ser alterados de acordo com a preferência de quem estiver instalando.

Em uma das atualziações do `archinstall`, foi adicinado a opção de instalar o Hyprland como interface gráfica. Então, será usado a instalação deles nesta etapa.

Pode-se navegar usando as `setas` do teclado ou então as teclas `hjkl` (Vim).

| Legenda | Opção | Adicional |
|:--------:|:---------:|:---------:|
| Archinstall language | English (100%) | |
| Mirror | Mirror region | Brazil |
| Locales | Keyboard layout | us |
| | Locale language | en_US |
| | Locale encoding | UTF-8 |
| Disk configuration | Use a best-effot default partition layout | |
| | Select Device | /dev/sda ou /dev/nvme0n1 |
| | Filesystem | btrfs |
| | Subvolumes | yes |
| | Compression | no |
| Disk encryption | | |
| Bootloader | Systemd-boot | |
| Unified kernel images | Would like to use unified kernel images | no |
| Swap | True | |
| Hostname | archlinux | |
| Root password | | |
| User account | Add a user | Enter username and password |
| | Should user be a superuser? | yes |
| | Confirm and exit | |
| Profile | List of pre-programmed default_profiles | ***`Minimal`*** |
| Audio | Choose an audio server | `Pipewire` |
| Kernels | Choose which kernels to use | `linux` |
| Additional packages | Write additional packages to install | |
| Network configuration | Select one netword interface | `Use NetworkManager` |
| Timezone | Select a timezone | America/Sao_Paulo |
| Automatic time sync | True | |
| Optional repositories | Choose optional additional repositories | `multilib` |

Depois de escolhida as configurações, inicie a instalação no `Install`.

Ao final, será questionado se quer realizar uma configuração pós-instalação, pressione `ESC` ou escolha a opção `no`. Reinicie o computador usando o comando:
```shell
reboot
```

### 3.5. Conectando ###
A conexão com a internet usada anteriormente foi configurada apenas para a instalação.

Agora, é preciso se conectar novamente, mas agora usando o [nmcli](https://wiki.archlinux.org/title/NetworkManager#Usage). Dessa forma, a conexão será persistida entre os reboots. Esse pacote foi instalado quando a opção `Use NetworkManager` foi selecionada anteriormente.

Para se conectar à internet, use o comando abaixo substituindo `<rede>` pela rede que quer conectar e `<senha>` pela senha da rede:
```shell
nmcli device wifi connect <rede> password <senha>
```

Use o comando do `ping` para testar a conexão.

- - - -
## 4. Próximo Passo ###
Agora que o sistema está instalado e conectado à internet, vá para a etapa da instalação [manual](tutorial.md) (em construção) ou [automática](script.md) (ainda em testes).
