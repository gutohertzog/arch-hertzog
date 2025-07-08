#!/bin/bash

# --------------------------------------------------------------
# o Python do Linux é um templo sagrado, então faço uma
# instalação / atualização manual para uso local, não
# alterando o usado pelo sistema
# --------------------------------------------------------------

# interrompe o script se algum comando falhar
set -e

source "$(dirname "$0")/funcoes.sh"

versao="3.13.5"
pasta="3.13"

# baixa o Python
wget https://www.python.org/ftp/python/$versao/Python-$versao.tgz

# extrai o pacote baixado e remove ele depois
tar -zxf Python-$versao.tgz
rm Python-$versao.tgz

# remove a versão antiga do Python, cria nova pasta e configura pasta destino
cd Python-$versao
rm -rf $HOME/Apps/Python-$pasta
mkdir -p $HOME/Apps/Python-$pasta
./configure --prefix=$HOME/Apps/Python-$pasta

# compila o Python
make

# instala a nova versão
make install

# remove a pasta baixada
rm -rf Python-$versao

# salva os pacotes do ambiente virtual antes de recriar
if [[ -f "$HOME/.venv/bin/activate" ]]; then
    source $HOME/.venv/bin/activate
    pip freeze > $HOME/pacotes-pip.txt
    deactivate
fi

# remove a pasta antiga do venv e cria uma nova
rm -rf $HOME/.venv
$HOME/Apps/Python-$pasta/bin/python3 -m venv $HOME/.venv

printf " \nuse ~/pacotes-pip.txt para reinstalar os pacotes\n"
