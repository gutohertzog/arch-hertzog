#!/bin/bash
set -Eeuo pipefail

# =============================================================================
# Timeshift
# https://archlinux.org/packages/extra/x86_64/timeshift/
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
# =============================================================================

source "$(dirname "$0")/conf.sh"

pacotes=(
    "timeshift" # A system restore utility for Linux
)

printf "\n"
printf " ##############################################\n"
printf " #                  timeshift                 #\n"
printf " ##############################################\n"
printf "\n"

instalar_pacotes "${pacotes[@]}"

printf "\n"
printf " → Para configurar:\n"
printf "   timeshift-gtk\n"
printf "\n"
printf " → Para consultar snapshots:\n"
printf "   sudo timeshift --list\n"
printf "\n"

printf "${FIM}"

