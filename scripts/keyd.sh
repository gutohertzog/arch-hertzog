#!/bin/bash

# --------------------------------------------------------------
#
# uso do keyd para trocar de lugar as teclas abaixo
#
# Caps Lock <---> Left Ctrl
#
# https://archlinux.org/packages/extra/x86_64/keyd/
#
# --------------------------------------------------------------

# Cores para a saída
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # Sem Cor

echo -e "${YELLOW}Iniciando a configuração do keyd para troca de Caps Lock e Ctrl...${NC}"

# Passo 1: Instalar o keyd (se não estiver instalado)
echo "-> Verificando e instalando o keyd..."
if ! pacman -Q keyd &> /dev/null; then
    echo "keyd não encontrado. Instalando..."
    sudo pacman -S --noconfirm keyd
else
    echo "keyd já está instalado."
fi

# Passo 2: Criar o arquivo de configuração
# Usamos 'tee' com 'sudo' para escrever em /etc/, que requer privilégios de root.
# O 'heredoc' (<<EOF) permite escrever múltiplas linhas facilmente.
echo "-> Criando o arquivo de configuração em /etc/keyd/default.conf..."

sudo tee /etc/keyd/default.conf > /dev/null <<EOF
# Arquivo de configuração do keyd gerado por script.
# Troca as teclas Caps Lock e Left Control.

[ids]
*

[main]
capslock = leftcontrol
leftcontrol = capslock
EOF

echo "Arquivo de configuração criado com sucesso."

# Passo 3: Habilitar e iniciar o serviço do keyd
# 'enable --now' habilita para o boot e inicia o serviço imediatamente.
echo "-> Habilitando e iniciando o serviço do keyd..."
sudo systemctl enable --now keyd

echo -e "\n${GREEN}Processo concluído!${NC}"
echo "O serviço do keyd está ativo e suas teclas Caps Lock e Ctrl foram trocadas."
echo "A alteração já deve estar funcionando em todo o sistema."

