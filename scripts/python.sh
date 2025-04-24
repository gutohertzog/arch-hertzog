#!/bin/bash

# --------------------------------------------------------------
# o Python do Linux é um templo sagrado, então faço uma
# instalação / atualização manual para uso local, não
# alterando o usado pelo sistema
# --------------------------------------------------------------

# interrompe o script se algum comando falhar
set -e

source "$(dirname "$0")/funcoes.sh"

OK="\e[0;32mOK\e[0m\n"
versao="3.13.3"
pasta="3.13"

printf "\n"
printf " ##############################################\n"
printf " #                   python                   #\n"
printf " ##############################################\n"
printf "\n"

printf " baixando o Python-$versao...................."
wget https://www.python.org/ftp/python/$versao/Python-$versao.tgz
printf $OK

printf " extraindo e removendo pacote................"
tar -zxf Python-$versao.tgz
rm Python-$versao.tgz
printf $OK

printf " preparando local de instalação.............."
cd Python-$versao
rm -rf $HOME/Apps/Python-$pasta
mkdir -p $HOME/Apps/Python-$pasta
./configure --prefix=$HOME/Apps/Python-$pasta
printf $OK

printf " compilando.................................."
make
printf $OK

printf " instalando.................................."
make install
printf $OK

printf " limpando...................................."
rm -rf Python-$versao
printf $OK

printf " configurando ambiente virtual..............."
# salva os pacotes antes de recriar
if [[ -f "$HOME/.venv/bin/activate" ]]; then
    source $HOME/.venv/bin/activate
    pip freeze > $HOME/pacotes-pip.txt
    deactivate
fi

rm -rf $HOME/.venv
$HOME/Apps/Python-$pasta/bin/python3 -m venv $HOME/.venv
printf $OK
printf " \nuse ~/pacotes-pip.txt para reinstalar os pacotes\n"
