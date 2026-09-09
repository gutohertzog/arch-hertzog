#!/bin/bash

# --------------------------------------------------------------
# Timeshift
#
# Ferramenta para criação e restauração de snapshots do sistema.
#
# Instalação:
#   sudo pacman -S timeshift
#
# Após a instalação, abra o Timeshift para configurar:
#   - local dos snapshots
#   - tipo de snapshot
#   - frequência
#   - quantidade de snapshots mantidos
#
# Uso pela interface gráfica:
#   timeshift-gtk
#
# Uso pelo terminal:
#
#   Listar snapshots:
#     sudo timeshift --list
#
#   Criar snapshot:
#     sudo timeshift --create --comments "Descrição"
#
#   Restaurar snapshot:
#     sudo timeshift --restore
#
#   Excluir snapshot:
#     sudo timeshift --delete --snapshot 'nome-do-snapshot'
#
#   Ver configuração:
#     sudo timeshift --list
#
# IMPORTANTE:
# Timeshift é voltado para snapshots do sistema. Ele cria snapshots do
# sistema para permitir a recuperação após alterações ou atualizações
# que deixem o sistema em estado indesejado.
# Não deve ser considerado uma solução de backup dos arquivos pessoais.
#
# A configuração do Timeshift é deliberadamente deixada para o usuário.
# Este script apenas instala a ferramenta.
# --------------------------------------------------------------

OK="\e[0;32mOK\e[0m"

printf "\n"
printf " ##############################################\n"
printf " #                  timeshift                 #\n"
printf " ##############################################\n"
printf "\n"

printf " → Instalando timeshift........................"
sudo pacman --noconfirm -S timeshift
printf "$OK\n"

printf "\n"
printf " Timeshift instalado.\n"
printf "\n"
printf " Para configurar:\n"
printf "   timeshift-gtk\n"
printf "\n"
printf " Para consultar os snapshots:\n"
printf "   sudo timeshift --list\n"
printf "\n"

