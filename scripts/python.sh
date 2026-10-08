#!/bin/bash
set -Eeuo pipefail

# =============================================================================
# o Python do Linux é um templo sagrado, então faço uma
# instalação / atualização manual para uso local, não
# alterando o usado pelo sistema
# =============================================================================

source "$(dirname "$0")/conf.sh"

# interrompe o script se algum comando falhar
set -e

VERSION="3.14.7"
FOLDER="3.14"

printf " → Baixando Python\n"
wget https://www.python.org/ftp/python/$VERSION/Python-$VERSION.tgz
printf "${OK}"

# extrai o pacote baixado e remove ele depois
printf " → Extraindo tar e o removendo\n"
tar -zxf Python-$VERSION.tgz
rm Python-$VERSION.tgz
cd Python-$VERSION
printf "${OK}"

# remove a versão antiga do Python, cria nova pasta e configura pasta destino
printf " → Renomeando pasta antiga\n"
if [ -d "$HOME/Apps/Python-$FOLDER" ]; then
    mv $HOME/Apps/Python-$FOLDER "${HOME}/Apps/Python-${FOLDER}.bak.$(date +%Y%m%d-%H%M%S)"
fi
printf "${OK}"

printf " → Criando novo diretório\n"
mkdir -p $HOME/Apps/Python-$FOLDER
printf "${OK}"

# compila o Python
printf " → Compilando e instalando a nova versão\n"
./configure --prefix=$HOME/Apps/Python-$FOLDER
make
make install
printf "${OK}"

printf " → Removendo pasta baixada\n"
cd ..
rm -rf Python-$VERSION
printf "${OK}"

# salva os pacotes do ambiente virtual antes de recriar
printf " → Salvando pacotes do pip\n"
if [[ -f "$HOME/.venv/bin/activate" ]]; then
    source $HOME/.venv/bin/activate
    pip freeze > $HOME/pacotes-pip.txt
    deactivate
fi
printf "${OK}"

# remove a pasta antiga do venv e cria uma nova
printf " → Removendo pasta antiga do ambiente virtual\n"
rm -rf $HOME/.venv
printf "${OK}"

printf " → Criando novo ambiente virtual\n"
$HOME/Apps/Python-$FOLDER/bin/python3 -m venv $HOME/.venv
printf "${OK}"

printf " → Use $HOME/pacotes-pip.txt para reinstalar os pacotes\n"

printf "${FIM}"

