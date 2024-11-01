#!/bin/bash
OK="\e[0;32mOK\e[0m"

printf " lib32-nvidia-utils.........................."
sudo pacman -S lib32-nvidia-utils > /dev/null 2>&1
printf "$OK\n"

printf " steam......................................."
sudo pacman -S steam > /dev/null 2>&1
printf "$OK\n"

