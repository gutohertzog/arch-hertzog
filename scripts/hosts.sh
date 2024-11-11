#!/bin/bash
OK="\e[0;32mOK\e[0m"

printf "\n"
printf " ##############################################\n"
printf " #                   hosts                    #\n"
printf " ##############################################\n"
printf "\n"

printf " instalando hosts............................"
# https://github.com/StevenBlack/hosts
curl -o $HOME/hosts https://raw.githubusercontent.com/StevenBlack/hosts/master/alternates/fakenews-gambling-porn/hosts > /dev/null 2>&1
sudo mv /etc/hosts /etc/hosts.bak > /dev/null 2>&1
sudo mv $HOME/hosts /etc/ > /dev/null 2>&1
sudo systemctl restart NetworkManager.service > /dev/null 2>&1
printf "$OK\n"

