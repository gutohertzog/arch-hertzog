#!/bin/bash
set -Eeuo pipefail

# =============================================================================
# o keyd é usado para trocar de lugar as teclas abaixo
# Caps Lock <---> Left Ctrl
# https://archlinux.org/packages/extra/x86_64/keyd/
# =============================================================================

source "$(dirname "$0")/conf.sh"

CONFIG="/etc/keyd/default.conf"

pacotes=(
    "keyd"
)

printf "\n"
printf " ##############################################\n"
printf " #                    keyd                    #\n"
printf " ##############################################\n"
printf "\n"

printf " → Trocando Caps Lock e Left Ctrl\n"

# passo 1: (re)instala keyd
instalar_pacotes "${pacotes[@]}"

# passo 2: cria o arquivo de configuração
# o 'tee' é usado com 'sudo' para escrever em /etc/
# o 'heredoc' (<<EOF) permite escrever múltiplas linhas facilmente
printf "\n → Criando o arquivo de configuração em /etc/keyd/default.conf\n"

if [[ -e "$CONFIG" || -L "$CONFIG" ]]; then
    printf " → Configuração existente preservada: ${CONFIG}\n" ""
else
    sudo tee /etc/keyd/default.conf > /dev/null <<EOF
# Arquivo de configuração do keyd gerado por script
# Troca as teclas Caps Lock e Left Control

[ids]
*

[main]
capslock = leftcontrol
leftcontrol = capslock
EOF
    printf "\n → Arquivo de configuração criado com sucesso\n"
fi

# passo 3: habilitar e iniciar o serviço do keyd
# 'enable --now' habilita para o boot e inicia o serviço imediatamente.
printf "\n → Habilitando e iniciando o serviço do keyd"
sudo systemctl enable keyd
sudo systemctl start keyd
# sudo systemctl enable --now keyd
printf "${OK}"

printf "\n → Processo concluído"
printf "\nO serviço do keyd está ativo"
printf "\nAs teclas Caps Lock e Left Ctrl foram trocadas"
printf "\nA alteração já deve estar funcionando em todo o sistema"
printf "${FIM}"

