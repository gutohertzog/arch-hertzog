#!/bin/bash

# splinner para execuções demoradas
spinner() {
    local pid=$!
    local delay=0.1
    local spinstr='|/-\'
    echo -n " "
    while [ "$(ps a | awk '{print $1}' | grep $pid)" ]; do
        local temp=${spinstr#?}
        printf " [%c]  " "$spinstr"
        local spinstr=$temp${spinstr%"$temp"}
        sleep $delay
        printf "\b\b\b\b\b\b"
    done
    printf "    \b\b\b\b"
    wait $pid
    return $?
}

# função para instalar um pacote
instala_pacote() {
    local nome_pacote=$1
    sudo pacman --noconfirm -S "$nome_pacote"
}
