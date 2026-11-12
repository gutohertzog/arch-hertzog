# Guia — Configuração de Acesso Remoto RDP via Túnel SSH + OpenVPN
<!-- Orc Peon: "Work, work." -->

Este é um guia anotado do passo a passo de como configurar o acesso remoto RDP, protegido por túnel SSH e acessível apenas via OpenVPN. Esse guia deve ser feito na máquina que será acessada remotamente e que vai ficar ligada 24h no departamento.

## Visão geral

```
Cliente (notebook, casa, etc.)
    │
    │ 1. OpenVPN institucional
    ▼
Gateway da VPN  (IP fixo, compartilhado por todos os usuários da VPN)
    │
    │ 2. SSH na porta 22 — autenticação só por chave
    ▼
┌──────────────────────────────────────────┐
│               Arch Linux                 │
│                                          │
│  ufw: 22/tcp liberada só p/ o gateway    │
│       3389/tcp FECHADA para a rede       │
│                                          │
│  sshd ──túnel──► localhost:3389          │
│                      │                   │
│           gnome-remote-desktop           │
│                      ├─ certificado TLS  │
│                      ├─ chave privada    │
│                      └─ usuário/senha    │
└──────────────────────────────────────────┘
```

### Por que o túnel SSH

O IP do gateway da VPN é **compartilhado**: toda pessoa conectada na VPN institucional sai por ele. Liberar a porta 3389 para esse IP significa deixar o RDP acessível para *qualquer* usuário ou máquina comprometida dentro da VPN, protegido apenas por usuário e senha, que é justamente o que ataques de força bruta exploram.

Com o túnel:

- **A força bruta deixa de ter alvo.** A única porta exposta é a 22, e o SSH aceita só chave criptográfica. Não há senha para adivinhar.
- **Superfície de ataque menor.** O `sshd` é um dos serviços mais auditados que existem. O RDP passa a ser alcançável apenas de dentro da própria máquina.
- **Autenticação em camadas.** Para entrar, é preciso ter a credencial da VPN, a chave privada SSH e a senha do RDP.
- **Revogação individual.** Cada chave autorizada é uma linha no `authorized_keys`: se um dispositivo for perdido, basta apagar a linha dele.

> **Por que RDP e não VNC:** a segurança vem do túnel, não do protocolo de tela. O VNC clássico é mais fraco que o RDP (sem criptografia própria, senha limitada a 8 caracteres) e, no GNOME com Wayland, o VNC do `grdctl` funciona apenas compartilhando uma sessão já logada; o modo `--system` (login remoto) só existe para RDP. Mantém-se, portanto, o RDP, agora dentro do túnel.

### Pré-requisitos

Este guia tem como pré-requisito uma instalação do Arch Linux com o Ambiente de Desktop do GNOME. Para outros sistemas, deverão ser feitos ajustes nos pacotes usados e nos locais de destino dos certificados.

Pacotes necessários na máquina remota:

- `networkmanager` — gerencia a conexão com a internet;
- `openvpn` — gerenciador da VPN;
- `openssh` — servidor SSH que recebe o túnel, usado no Passo 2;
- `ufw` — sendo uma máquina ligada 24h, é preciso de um firewall;
- `gnome-remote-desktop` — provê o `grdctl` e o serviço usados nos Passos 5 e 6;
- `openssl` — implementação open-source dos protocolos SSL e TLS, usado no Passo 5;
- `openbsd-netcat` (opcional) — fornece o `nc`, usado na verificação do Passo 7;
- `freerdp` / `remmina` — usados para o teste de conexão RDP no Passo 8.

Na máquina cliente é preciso apenas de um cliente OpenSSH (já vem instalado no macOS e no Windows 10/11; no Linux, pacote `openssh`) e de um cliente RDP.

---

## Passo 1 — Confirmar o gateway da VPN

O endereço usado na regra do firewall **não é o IP atribuído ao seu cliente VPN** — esse costuma ser dinâmico, vindo de um pool de endereços. O que importa aqui é o **gateway fixo** pelo qual o tráfego sai ao entrar na rede onde a máquina remota está — a mesma saída pra qualquer pessoa que use essa rota.

**Como descobrir esse endereço:**

1. Sem VPN conectada, acesse `meuip.ufrgs.br` e anote o IP mostrado.
2. Conecte a VPN.
    ```bash
    sudo openvpn --config ~/Documents/vpn.ovpn
    ```
3. Acesse o mesmo serviço novamente e verifique se aparece **Acesso via VPN** — então o IP que aparece agora é o gateway.

> Por que especificamente `meuip.ufrgs.br`, e não qualquer verificador de IP genérico: se a VPN usa *split tunneling* (comum em VPNs institucionais), só o tráfego com destino a rotas internas passa pelo túnel — sites genéricos (`ifconfig.me` e afins) continuam mostrando o IP da conexão normal, não o da VPN. Ao adaptar este guia pra outra instituição, procure o verificador de IP equivalente oferecido por ela; o comportamento deve ser o mesmo.
>
> Esse valor é fixo (definido pela infraestrutura de rede), mas pode mudar se a instituição reestruturar a VPN. Se isso acontecer, repita esses passos antes de reaplicar a regra do firewall.

Guarde esse valor — ele será usado como `<IP_GATEWAY_VPN>` no Passo 3.

---

## Passo 2 — Configurar o SSH com autenticação só por chave

### 2.1 — Gerar a chave (na máquina **cliente**)

Cada pessoa/dispositivo que vai acessar gera a sua própria chave:

```bash
ssh-keygen -t ed25519 -C "$(whoami)@$(hostname)-acesso-remoto"
```

> Defina uma **passphrase** quando for solicitada. Ela protege a chave caso o dispositivo seja perdido ou roubado.

Isso cria dois arquivos em `~/.ssh/`:

- `id_ed25519` — chave **privada**. Nunca sai do dispositivo cliente.
- `id_ed25519.pub` — chave **pública**. É ela que vai para a máquina remota e pode ser enviada por qualquer meio (e-mail, pendrive, chat).

### 2.2 — Autorizar a chave (na máquina **remota**)

```bash
sudo pacman -S openssh

mkdir -p ~/.ssh
chmod 700 ~/.ssh

# cole o conteúdo de cada id_ed25519.pub autorizado, uma chave por linha
nano ~/.ssh/authorized_keys
chmod 600 ~/.ssh/authorized_keys
```

> As permissões `700`/`600` não são opcionais: com permissões mais abertas, o `sshd` ignora o arquivo e recusa a chave.

### 2.3 — Endurecer a configuração do `sshd`

```bash
sudo mkdir -p /etc/ssh/sshd_config.d
sudo tee /etc/ssh/sshd_config.d/10-hardening.conf > /dev/null <<EOL
# autenticação: só chave, nunca senha
PasswordAuthentication no
KbdInteractiveAuthentication no
AuthenticationMethods publickey
PermitRootLogin no
AllowUsers <usuario-máquina-remota>
MaxAuthTries 3

# encaminhamento: só túnel local, e só até o RDP desta máquina
AllowTcpForwarding local
PermitOpen localhost:3389 127.0.0.1:3389
X11Forwarding no
EOL
```

> Substitua `<usuario-máquina-remota>` pelo usuário local da máquina.
>
> As duas linhas de encaminhamento garantem que, mesmo de posse de uma chave válida, ninguém consegue usar esta máquina como trampolim para outros hosts da rede: o túnel só pode chegar na porta 3389 dela mesma.

Confirme que o `sshd_config` principal carrega os arquivos de `sshd_config.d` (o padrão do Arch já faz isso):

```bash
grep -i '^Include' /etc/ssh/sshd_config
```

- Saída esperada:
    ```bash
    Include /etc/ssh/sshd_config.d/*.conf
    ```

Valide a configuração e inicie o serviço:

```bash
# não imprime nada se a configuração estiver válida
sudo sshd -t

sudo systemctl enable --now sshd
```

---

## Passo 3 — Configurar o firewall

Como a máquina ficará ligada 24h, é necessário que ela tenha um firewall. A única porta liberada será a do SSH, e *apenas* para quem vem pela VPN. A porta do RDP (3389) fica fechada para a rede: o acesso a ela acontece somente por dentro do túnel.

Configuração padrão do firewall esperada:

```bash
sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw default deny routed
```

Libere o SSH apenas a partir do gateway da VPN institucional:

```bash
sudo ufw limit from <IP_GATEWAY_VPN> to any port 22 proto tcp
```

> Substitua `<IP_GATEWAY_VPN>` pelo endereço obtido no Passo 1.

- `limit` em vez de `allow`: bloqueia temporariamente um IP que abrir 6 ou mais conexões em 30 segundos. Com autenticação só por chave, isso serve principalmente para reduzir o ruído de tentativas nos logs.
- Sem sufixo `/CIDR`, o `ufw` trata o endereço como host único (`/32`) — esse é o comportamento correto aqui, já que estamos liberando um gateway fixo, não uma faixa de clientes.
- **Não** existe regra para a porta 3389. O túnel chega pela interface de loopback (`lo`), que o `ufw` libera por padrão.

Ative o firewall e garanta que ele suba no boot:

```bash
sudo ufw enable
sudo systemctl enable ufw
```

Para confirmar, execute o comando abaixo:

```bash
sudo ufw status verbose
```

Saída esperada:

```bash
Status: active
Logging: on (low)
Default: deny (incoming), allow (outgoing), disabled (routed)
New profiles: skip

To                         Action      From
--                         ------      ----
22/tcp                     LIMIT IN    <IP_GATEWAY_VPN>
```

> ⚠️ **Migrando de uma instalação anterior (v0.x), que liberava a 3389 diretamente?**
>
> Primeiro adicione a regra do SSH e **teste a conexão SSH a partir de outra máquina na VPN**. Só depois remova a regra antiga:
>
> ```bash
> sudo ufw delete allow from <IP_GATEWAY_VPN> to any port 3389 proto tcp
> ```
>
> Se a ordem for invertida e a configuração estiver sendo feita remotamente, você perde o acesso à máquina.

---

## Passo 4 — Desabilitar suspensão e hibernação

Necessário porque o acesso remoto só funciona com a máquina acordada 24/7.

```bash
# nível do usuário
gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-ac-type 'nothing'
gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-battery-type 'nothing'

# nível do sistema
sudo mkdir -p /etc/systemd/sleep.conf.d
sudo tee /etc/systemd/sleep.conf.d/disable-sleep.conf > /dev/null <<EOL
[Sleep]
AllowSuspend=no
AllowHibernation=no
AllowHybridSleep=no
AllowSuspendThenHibernate=no
EOL
```

> ⚠️ **Pare aqui e reinicie a máquina.**
>
> A configuração em `sleep.conf.d` só é aplicada após reboot.

```bash
sudo reboot
```

---

## Passo 5 — Gerar o certificado TLS

O GNOME Remote Desktop não gera certificado sozinho quando configurado via CLI (`grdctl`) — isso não é uma falha, é o comportamento esperado. Esse passo é sempre necessário numa instalação nova, feita inteiramente por linha de comando.

> O RDP já chega criptografado pelo túnel SSH, mas o `gnome-remote-desktop` exige TLS de qualquer forma. As duas camadas convivem sem problema.

```bash
# diretório onde ficarão os certificados TLS originais
export GRDCERTDIR=~/Documents/certificates
mkdir -p $GRDCERTDIR

# chave privada RSA 4096 bits
openssl genrsa -out ${GRDCERTDIR}/rdp-tls.key 4096

# solicitação de certificado (CSR) — CN identifica quem está rodando, não fixo
openssl req -new \
    -key ${GRDCERTDIR}/rdp-tls.key \
    -out ${GRDCERTDIR}/rdp-tls.csr \
    -subj "/CN=$(whoami)-rdp"

# certificado autoassinado, válido por ~10 anos
openssl x509 -req -days 3650 \
    -signkey ${GRDCERTDIR}/rdp-tls.key \
    -in      ${GRDCERTDIR}/rdp-tls.csr \
    -out     ${GRDCERTDIR}/rdp-tls.crt

# cria o diretório usado pelo GNOME Remote Desktop
sudo mkdir -p /var/lib/gnome-remote-desktop

# copia a chave e o certificado para o diretório do serviço
sudo cp ${GRDCERTDIR}/rdp-tls.key /var/lib/gnome-remote-desktop/
sudo cp ${GRDCERTDIR}/rdp-tls.crt /var/lib/gnome-remote-desktop/

# dá a propriedade dos arquivos ao usuário do serviço
sudo chown gnome-remote-desktop:gnome-remote-desktop \
    /var/lib/gnome-remote-desktop/rdp-tls.key \
    /var/lib/gnome-remote-desktop/rdp-tls.crt

# define as permissões dos arquivos
sudo chmod 600 /var/lib/gnome-remote-desktop/rdp-tls.key
sudo chmod 644 /var/lib/gnome-remote-desktop/rdp-tls.crt
```

**Alternativa ainda não testada, pra considerar numa próxima simplificação:** o `winpr-makecert` (parte do FreeRDP) gera chave e certificado compatíveis com RDP em um único comando (`winpr-makecert -silent -rdp -path <dir> rdp-tls`). O caminho acima com `openssl` é o que já foi validado — só trocar depois de testar em paralelo.

---

## Passo 6 — Configurar e habilitar o GNOME Remote Desktop

Os comandos abaixo são específicos para o GNOME.

```bash
# desativa RDP enquanto a configuração é alterada
sudo grdctl --system rdp disable

# configura a chave privada TLS do RDP
sudo grdctl --system rdp set-tls-key \
  /var/lib/gnome-remote-desktop/rdp-tls.key

# configura o certificado TLS do RDP
sudo grdctl --system rdp set-tls-cert \
  /var/lib/gnome-remote-desktop/rdp-tls.crt

# define credenciais interativamente
# a senha não fica exposta no histórico do shell
sudo grdctl --system rdp set-credentials

# reabilita o servidor RDP
sudo grdctl --system rdp enable

# recarrega as configurações do systemd
sudo systemctl daemon-reload

# inicia o serviço agora e habilita-o no boot
sudo systemctl enable --now gnome-remote-desktop
```

> O `gnome-remote-desktop` escuta em todas as interfaces (`*:3389`) e não oferece opção para restringir a escuta a `localhost`. Quem impede o acesso direto pela rede é o firewall do Passo 3.

---

## Passo 7 — Verificação

### 7.1 — Na máquina remota

```bash
systemctl status sshd.service
```

- Saída esperada (trecho):
    ```bash
    ● sshd.service - OpenSSH Daemon
         Loaded: loaded (/usr/lib/systemd/system/sshd.service; enabled; preset: disabled)
         Active: active (running) since ...
    ```

```bash
sudo sshd -T | grep -Ei '^(passwordauthentication|authenticationmethods|allowtcpforwarding|permitopen)'
```

- Saída esperada (confirma a configuração *efetiva*, não só o que está no arquivo):
    ```bash
    passwordauthentication no
    allowtcpforwarding local
    permitopen localhost:3389 127.0.0.1:3389
    authenticationmethods publickey
    ```

```bash
systemctl status gnome-remote-desktop.service
```

- Saída esperada:
    ```bash
    ● gnome-remote-desktop.service - GNOME Remote Desktop
         Loaded: loaded (/usr/lib/systemd/system/gnome-remote-desktop.service; enabled; preset: disabled)
         Active: active (running) since Tue 2026-01-01 09:00:00 -03; 2h ago
     Invocation: [valor alfanumérico de 32 caracteres]
       Main PID: [PID do processo]
          Tasks: 4 (limit: 23826)
         Memory: 102.9M (peak: 107.3M)
            CPU: 1.527s
         CGroup: /system.slice/gnome-remote-desktop.service
                 └─[PID] /usr/lib/gnome-remote-desktop-daemon --system
    ```

```bash
sudo grdctl --system status
```

- Saída esperada:
    ```bash
    Init TPM credentials failed because No TPM device found, using GKeyFile as fallback.
    Overall:
        Unit status: active
    RDP:
        Status: enabled
        Port: 3389
        Authentication methods: credentials
        TLS certificate: /var/lib/gnome-remote-desktop/rdp-tls.crt
        TLS fingerprint: [sequência de 32 duplas]
        TLS key: /var/lib/gnome-remote-desktop/rdp-tls.key
        Kerberos keytab: (null)
        Username: (hidden)
        Password: (hidden)
    ```

> O **fingerprint** mostrado pelo `grdctl --system status` muda a cada instalação, já que o certificado muda a cada instalação. Isso é esperado; não compare com o fingerprint de uma instalação anterior.

```bash
sudo ss -lntp | grep -E ':(22|3389)\b'
```

- Saída esperada:
    ```bash
    LISTEN 0   128     0.0.0.0:22     0.0.0.0:*   users:(("sshd",pid=[PID],fd=3))
    LISTEN 0   128        [::]:22        [::]:*   users:(("sshd",pid=[PID],fd=4))
    LISTEN 0   5             *:3389         *:*   users:(("gnome-remote-de",pid=[PID],fd=9))
    ```

### 7.2 — De outra máquina, conectada na VPN

Este teste é **recomendado**: é ele que confirma que o RDP não está exposto.

```bash
# nc faz parte do pacote openbsd-netcat
nc -vz -w 5 <hostname-ou-ip-da-maquina-remota> 22
nc -vz -w 5 <hostname-ou-ip-da-maquina-remota> 3389
```

Saída esperada:

```bash
Connection to [nome da máquina] ([IP]) 22 port [tcp/ssh] succeeded!
nc: connect to [nome da máquina] port 3389 (tcp) timed out: Operation now in progress
```

- A porta **22 deve responder** — mas só vindo pela VPN, que é o que a regra do Passo 3 garante.
- A porta **3389 deve falhar** (timeout). Se ela responder, existe uma regra antiga no firewall liberando o RDP diretamente: confira o aviso de migração no Passo 3.

Confirme também que o SSH recusa senha:

```bash
ssh -o PubkeyAuthentication=no <usuario-máquina-remota>@<hostname-ou-ip-da-maquina-remota>
```

- Saída esperada:
    ```bash
    <usuario>@<host>: Permission denied (publickey).
    ```

---

## Passo 8 — Conectar via túnel

A conexão passa a ter duas etapas: **abrir o túnel** e **apontar o cliente RDP para a ponta local do túnel**.

### 8.1 — Configurar o atalho SSH (na máquina cliente, uma única vez)

Adicione ao arquivo `~/.ssh/config` (no Windows: `%USERPROFILE%\.ssh\config`):

```
Host acesso-remoto
    HostName <hostname-ou-ip-da-maquina-remota>
    User <usuario-máquina-remota>
    IdentityFile ~/.ssh/id_ed25519
    LocalForward 13389 localhost:3389
    ExitOnForwardFailure yes
    ServerAliveInterval 60
    ServerAliveCountMax 3
```

- `LocalForward 13389 localhost:3389`: a porta 13389 do cliente passa a levar até a 3389 da máquina remota. Usa-se 13389 (e não 3389) porque, no Windows, a porta 3389 do próprio cliente pode estar ocupada pelo serviço de RDP local.
- `ExitOnForwardFailure`: se a porta 13389 já estiver em uso, o `ssh` falha com erro em vez de conectar sem túnel.
- `ServerAlive*`: mantém o túnel ativo e detecta quedas em até ~3 minutos.

### 8.2 — Abrir o túnel

Com a VPN conectada:

```bash
ssh -N acesso-remoto
```

O terminal fica "parado" — é o esperado: `-N` abre só o túnel, sem shell. Deixe rodando enquanto usar o RDP; `Ctrl+C` encerra.

### 8.3 — Conectar o cliente RDP em `127.0.0.1:13389`

**Linux:**

- Via `xfreerdp3`:
  ```bash
  xfreerdp3 /v:127.0.0.1:13389 /u:<usuario-máquina-remota>
  ```

- Via Remmina: crie a conexão RDP para `127.0.0.1:13389` com o túnel aberto. Alternativa: a aba **SSH Tunnel** do perfil RDP no Remmina abre o túnel automaticamente, dispensando o passo 8.2.

**macOS:**

- Via `Windows App`: adicione um PC com o endereço `127.0.0.1:13389`. Se aparecer erro de credenciais inválidas mesmo com a senha certa, exporte a conexão `.rdp`, edite o arquivo e ajuste:
  ```
  use redirection server name:i:1
  ```
  Reimporte o `.rdp` modificado e faça a conexão.

**Windows:**

- Abra o túnel com o mesmo `ssh -N acesso-remoto` no PowerShell (o cliente OpenSSH já vem instalado no Windows 10/11).
- Via `Remote Desktop Connection`: conecte em `127.0.0.1:13389`.

**App mobile (iOS/Android):** o app RDP sozinho não conecta mais, pois não abre túneis SSH. É necessário um cliente SSH com suporte a *port forwarding* (por exemplo, Termius), que abre o túnel antes de conectar o app RDP em `127.0.0.1:13389`. A chave usada no celular deve ser própria dele, cadastrada no `authorized_keys` como qualquer outra.

---

## Gerenciar chaves autorizadas

- **Dar acesso a alguém/um dispositivo novo:** adicione a chave pública (`.pub`) como uma nova linha em `~/.ssh/authorized_keys` na máquina remota.
- **Revogar acesso** (dispositivo perdido, pessoa saiu do setor): apague a linha correspondente. Vale na próxima conexão, sem reiniciar nada e sem afetar os demais.
- O comentário no final de cada linha (definido pelo `-C` no Passo 2.1) identifica de quem é cada chave.

Para ver quem conectou e quando:

```bash
sudo journalctl -u sshd --since today | grep 'Accepted publickey'
```

---

## Troubleshooting rápido

| Sintoma | Causa provável |
|---|---|
| `ssh` não conecta (timeout) | VPN desconectada, regra do ufw errada, ou gateway da VPN mudou — repita o Passo 1 |
| `Permission denied (publickey)` | chave não está no `authorized_keys`, permissões de `~/.ssh` diferentes de `700`/`600`, ou usuário fora do `AllowUsers` — diagnóstico: `ssh -v acesso-remoto` |
| `channel open failed: administratively prohibited` | destino do túnel não bate com o `PermitOpen` — o `LocalForward` deve apontar para `localhost:3389` |
| `bind: Address already in use` | porta 13389 já ocupada no cliente, geralmente por outro túnel aberto — feche-o ou troque a porta local |
| Túnel abre mas o cliente RDP não conecta | cliente apontando para a porta errada (deve ser `127.0.0.1:13389`), ou `gnome-remote-desktop` parado — veja o Passo 7.1 |
| Porta 3389 responde de fora (Passo 7.2) | regra antiga do RDP ainda no ufw — veja o aviso de migração no Passo 3 |
| `grdctl rdp enable` falha | certificado/chave ainda não configurados — repita os Passos 5 e 6 |
| Máquina ainda suspende/hiberna | faltou reiniciar depois do Passo 4 |
| Firewall inativo após reboot | faltou `sudo systemctl enable ufw` no Passo 3 |
| macOS pede senha mesmo com senha certa | truque do `redirection server name` (Passo 8.3) |
| SSH conecta mas RDP recusa autenticação | protocolo/credenciais do RDP — conferir logs: `sudo journalctl -u gnome-remote-desktop.service -f` |

---

*v1.0.0 — documento vivo, ajustar conforme surgirem novos casos durante os testes.*

<!--
CHANGELOG

Convenção de versão (MAJOR.MINOR.PATCH):
  MAJOR: mudança na arquitetura de acesso (ex.: troca de protocolo, nova camada de segurança)
  MINOR: passo novo ou alterado, novo cliente suportado, nova verificação
  PATCH: correção de texto, comando ou saída esperada, sem mudar o fluxo

v1.0.0 (2026-11-06)
  Contexto: incidentes de segurança no CPD a partir de uma falha em PHP, com
  tentativas de login por força bruta em várias máquinas. Recomendação recebida:
  acesso remoto via túnel SSH junto com a VPN.

  Adicionado
  - Passo 2: servidor SSH com autenticação somente por chave (ed25519), com
    drop-in de hardening em /etc/ssh/sshd_config.d/10-hardening.conf.
  - Restrição do túnel com AllowTcpForwarding local + PermitOpen apenas para
    localhost:3389 (impede uso da máquina como trampolim).
  - Seção "Por que o túnel SSH" e justificativa de manter RDP em vez de VNC.
  - Passo 7: verificação da configuração efetiva do sshd (sshd -T), teste de
    que a porta 3389 NÃO responde pela rede e teste de recusa de senha no SSH.
  - Passo 8: entrada no ~/.ssh/config com LocalForward 13389, ExitOnForwardFailure
    e ServerAlive; instruções de conexão via túnel para Linux, macOS, Windows e mobile.
  - Seção "Gerenciar chaves autorizadas" (adicionar, revogar, auditar acessos).
  - Pacote openssh nos pré-requisitos; requisitos do lado cliente.
  - Novas linhas de troubleshooting para SSH e túnel.

  Alterado
  - Firewall: removida a liberação direta da 3389; liberada apenas a 22 com
    "ufw limit" a partir do gateway da VPN. Aviso de ordem segura para quem
    migra de v0.x.
  - Diagrama da visão geral redesenhado com as camadas VPN, SSH e RDP.
  - Passos renumerados: SSH (2), firewall (3), suspensão (4), TLS (5), GRD (6),
    verificação (7), conexão (8).
  - Teste com nc deixou de ser opcional (passou a ser recomendado).

  Corrigido
  - Incluídos "ufw enable" e "systemctl enable ufw", ausentes na v0.3; sem eles
    o firewall podia não estar ativo ou não subir após reboot.

v0.3 (data não registrada; configuração original feita no fim de agosto de 2026)
  - Primeira versão documentada: RDP via gnome-remote-desktop acessível pela VPN,
    regra do ufw liberando a 3389 para o gateway da VPN (/32), descoberta do
    gateway via meuip.ufrgs.br, desativação de suspensão/hibernação, geração
    manual do certificado TLS com openssl, verificação e dicas por cliente
    (incluindo o ajuste "use redirection server name" no macOS).
-->
