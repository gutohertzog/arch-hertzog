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
wget https://www.python.org/ftp/python/$versao/Python-$versao.tgz > /dev/null 2>&1 &
spinner
printf $OK

printf " extraindo e removendo pacote................"
tar -zxf Python-$versao.tgz > /dev/null 2>&1 &
spinner
rm Python-$versao.tgz > /dev/null 2>&1
printf $OK

printf " preparando local de instalação.............."
cd Python-$versao > /dev/null 2>&1
rm -rf $HOME/Apps/Python-$pasta > /dev/null 2>&1
mkdir -p $HOME/Apps/Python-$pasta > /dev/null 2>&1
./configure --prefix=$HOME/Apps/Python-$pasta > /dev/null 2>&1 &
spinner
printf $OK

printf " compilando.................................."
make > /dev/null 2>&1 &
spinner
printf $OK

printf " instalando.................................."
make install > /dev/null 2>&1 &
spinner
printf $OK

printf " limpando...................................."
rm -rf Python-$versao > /dev/null 2>&1
printf $OK

printf " configurando ambiente virtual..............."
# salva os pacotes antes de recriar
if [[ -f "$HOME/.venv/bin/activate" ]]; then
    source $HOME/.venv/bin/activate > /dev/null 2>&1
    pip freeze > $HOME/pacotes-pip.txt > /dev/null 2>&1
    deactivate > /dev/null 2>&1
fi

rm -rf $HOME/.venv > /dev/null 2>&1
$HOME/Apps/Python-$pasta/bin/python3 -m venv $HOME/.venv > /dev/null 2>&1
printf $OK
printf " \nuse ~/pacotes-pip.txt para reinstalar os pacotes\n"
