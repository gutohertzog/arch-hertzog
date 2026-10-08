# Guia — Configuração de Acesso Remoto RDP via OpenVPN
<!-- Orc Peon: "Work, work." -->

Este é um guia anotado do passo a passo de como configurar o acesso remoto RDP via OpenVPN. Esse guia deve ser feito na máquina que será acessada remotamente e que vai ficar ligada 24h no departamento.

## Visão geral

```
Cliente RDP
    │
    │ conexão RDP + TLS
    ▼
┌──────────────────────────────┐
│         Arch Linux           │
│                              │
│ gnome-remote-desktop         │
│          │                   │
│          ├─ certificado TLS  │
│          ├─ chave privada    │
│          └─ usuário/senha    │
│                              │
└──────────────────────────────┘
```

### Pré-requisitos

Este guia tem como pré-requisito uma instalação do Arch Linux com o Ambiente de Desktop do GNOME. Para outros sistemas, deverão ser feitos ajustes nos pacotes usados e nos locais de destino dos certificados.

Pacotes necessários:

- `networkmanager` — gerencia a conexão com a internet;
- `openvpn` — gerenciador da VPN;
- `ufw` — sendo uma máquina ligada 24h, é preciso de um firewall;
- `gnome-remote-desktop` — provê o `grdctl` e o serviço usados nos Passos 4 e 5;
- `openssl` — implementação open-source dos protocolos SSL e TLS, usado no Passo 4;
- `openbsd-netcat` (opcional) — fornece o `nc`, usado na verificação do Passo 6;
- `freerdp` / `remmina` — usados para o teste de conexão RDP no Passo 7.

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

Guarde esse valor — ele será usado como `<IP_GATEWAY_VPN>` no próximo passo.

---

## Passo 2 — Liberar a porta RDP no firewall

Como a máquina ficará ligada 24h, é necessário que ela tenha um firewall. Para que a liberação seja feita de forma segura via RDP, será feita a configuração para liberação *apenas* quando conectado à VPN.

Configuração padrão do firewall esperada:

```bash
sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw default deny routed
```

O comando abaixo libera o firewall para acesso remoto apenas a partir do gateway da VPN institucional, na porta padrão do RDP.

```bash
sudo ufw allow from <IP_GATEWAY_VPN> to any port 3389 proto tcp
```

> Substitua `<IP_GATEWAY_VPN>` pelo endereço obtido no Passo 1.

Sem sufixo `/CIDR`, o `ufw` trata o endereço como host único (`/32`) — esse é o comportamento correto aqui, já que estamos liberando um gateway fixo, não uma faixa de clientes.

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
3389/tcp                   ALLOW IN    <IP_GATEWAY_VPN>
```

---

## Passo 3 — Desabilitar suspensão e hibernação

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

## Passo 4 — Gerar o certificado TLS

O GNOME Remote Desktop não gera certificado sozinho quando configurado via CLI (`grdctl`) — isso não é uma falha, é o comportamento esperado. Esse passo é sempre necessário numa instalação nova, feita inteiramente por linha de comando.

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

## Passo 5 — Configurar e habilitar o GNOME Remote Desktop

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

---

## Passo 6 — Verificação

Use os três passos abaixo para verificar o funcionamento.

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

```bash
sudo ss -lntp | grep ':3389'
```

- Saída esperada:
    ```bash
    LISTEN 0   5   *:3389   *:*   users:(("gnome-remote-de",pid=[PID],fd=9))
    ```

> O **fingerprint** mostrado pelo `grdctl --system status` muda a cada instalação, já que o certificado muda a cada instalação. Isso é esperado; não compare com o fingerprint de uma instalação anterior.

O teste com `nc` abaixo é opcional. Se preferir, pule direto pro Passo 7: se um cliente RDP de verdade (`xfreerdp3`, `remmina`, etc.) conseguir conectar, o serviço já está funcionando e essa checagem intermediária não é necessária. Ela é mais útil quando a conexão real falha e é preciso isolar se o problema é de rede/firewall ou de protocolo/certificado.

De outra máquina, **conectada na VPN**:

```bash
# nc faz parte do pacote openbsd-netcat
nc -vz <hostname-ou-ip-da-maquina-remota> 3389
```

Saída esperada:

```bash
Connection to [nome da máquina] ([IP ou endereço resolvido]) 3389 port [tcp/ms-wbt-server] succeeded!
```

Só deve funcionar vindo pela VPN — é exatamente isso que a regra do firewall do Passo 2 garante.

---

## Passo 7 — Testar a conexão

**Linux:**

- Via `xfreerdp3`:
  ```bash
  xfreerdp3 /v:127.0.0.1:3389 /u:<usuario-máquina-remota>
  ```

- Via Remmina: abra o aplicativo, adicione a conexão e teste.

**macOS**:

- Via `Windows App`: se aparecer erro de credenciais inválidas mesmo com a senha certa, exporte a conexão `.rdp`, edite o arquivo e ajuste:
  ```
  use redirection server name:i:1
  ```
  Reimporte o `.rdp` modificado e faça a conexão.

**Windows:**

- Via `Remote Desktop Connection`: abra o aplicativo e tente conectar pelo IP da máquina remota.

**App mobile (iOS/Android):** normalmente conecta direto, sem precisar desse ajuste.

---

## Troubleshooting rápido

| Sintoma | Causa provável |
|---|---|
| RDP habilitado mas não responde de fora | regra do ufw errada, ou gateway da VPN mudou — repita o Passo 1 |
| `grdctl rdp enable` falha | certificado/chave ainda não configurados — repita o Passo 4/5 |
| Máquina ainda suspende/hiberna | faltou reiniciar depois do Passo 3 |
| macOS pede senha mesmo com senha certa | truque do `redirection server name` (Passo 7) |
| `nc` funciona local mas RDP recusa remoto | protocolo/autenticação — conferir logs: `sudo journalctl -u gnome-remote-desktop.service -f` |

---

*v0.3 — documento vivo, ajustar conforme surgirem novos casos durante os testes.*

