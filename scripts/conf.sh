#!/bin/bash

# arquivo criado para variáveis e funções em comum entre os scripts

# cores
RED="\e[0;31m"
GREEN="\e[0;32m"
YELLOW="\e[1;33m"
# sem cor (reseta)
NC="\e[0m"

# mensagens
ERRO="\n${RED}Erro${NC} :"
OK="\n${GREEN}OK${NC}\n"
FIM="\n${GREEN}Terminado${NC}\n"

# funções
instalar_pacotes() {
    printf " → Instalando pacotes\n"

    if sudo pacman --noconfirm -S "$@"; then
        printf "${OK}"
    else
        printf "${ERRO}"
        exit 1
    fi
}

# trecho de código apenas para testar esse arquivo
# executado apenas se conf.sh for chamado diretamente
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    printf "\n"
    printf " ##############################################\n"
    printf " #                   Testes                   #\n"
    printf " ##############################################\n"
    printf "\n"

    printf "${ERRO} mensagem de erro pontual"
    printf "\n${YELLOW}Amarelo$NC"
    printf "\nSem cor"
    printf "\n${GREEN}Verde${NC}"
    printf "\n${RED}Vermelho${NC}"
    printf "\n"

    pacotes_teste=(
        fd
        bat
    )
    instalar_pacotes "${pacotes_teste[@]}"
    printf "${FIM}"
fi

