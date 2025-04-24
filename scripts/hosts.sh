#!/bin/bash
OK="\e[0;32mOK\e[0m"

printf "\n"
printf " ##############################################\n"
printf " #                   hosts                    #\n"
printf " ##############################################\n"
printf "\n"

printf " instalando hosts............................"
# https://github.com/StevenBlack/hosts
curl -o $HOME/hosts https://raw.githubusercontent.com/StevenBlack/hosts/master/alternates/fakenews-gambling-porn/hosts
sudo mv /etc/hosts /etc/hosts.bak
sudo mv $HOME/hosts /etc/
sudo systemctl restart NetworkManager.service
printf "$OK\n"
