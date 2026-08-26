#!/bin/bash

# --------------------------------------------------------------
# Firewall - UFW
#
# Instala e configura o UFW com uma política padrão segura:
#   - entrada: negar
#   - saída: permitir
#   - roteamento: negar
#
# IMPORTANTE:
# Antes de ativar o firewall, adicione as regras necessárias
# para os serviços que precisam ser acessíveis pela rede.
#
# Exemplos → 22 para SSH e 3389 para RDP:
#   sudo ufw allow 22/tcp
#   sudo ufw allow 3389/tcp
#   sudo ufw allow from 192.168.1.64 to any port 3389 proto tcp
#
# Consultar estado:
#   sudo ufw status verbose
#
# Listar regras numeradas:
#   sudo ufw status numbered
#
# Remover uma regra:
#   sudo ufw delete <número>
#
# Ver regras detalhadas:
#   sudo ufw show raw
#
# Desativar temporariamente:
#   sudo ufw disable
#
# Reativar:
#   sudo ufw enable
#
# Verificar se inicia automaticamente no boot:
#   systemctl is-enabled ufw.service
#
# Habilitar no boot:
#   sudo systemctl enable ufw.service
#
# Desabilitar inicialização automática:
#   sudo systemctl disable ufw.service
#
# Logs:
#   sudo ufw logging on
#   sudo journalctl -k | grep -i ufw
#
# CUIDADO:
# Se estiver conectado remotamente à máquina, não ative o UFW
# antes de liberar o serviço pelo qual está conectado.
# --------------------------------------------------------------

OK="\e[0;32mOK\e[0m"

pacotes=(
    "ufw"
    # "gufw" # gui opcional
)

printf "\n"
printf " ##############################################\n"
printf " #               firewall - ufw               #\n"
printf " ##############################################\n"
printf "\n"

printf " → Instalando ufw.............................."
sudo pacman --noconfirm -S "${pacotes[@]}"
printf "$OK\n"

printf " → Configurando política padrão................"
sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw default deny routed
printf "$OK\n"

printf " → Ativando logging............................"
sudo ufw logging low
printf "$OK\n"

printf " → Habilitando UFW no boot....................."
sudo systemctl enable ufw.service
printf "$OK\n"

printf " → Ativando firewall..........................."
sudo ufw --force enable
printf "$OK\n"

printf "\n"
printf " → Firewall configurado e habilitado no boot.\n"
printf "\n"

sudo ufw status verbose

