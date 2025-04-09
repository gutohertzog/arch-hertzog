#!/bin/bash
OK="\e[0;32mOK\e[0m"

# tema para o Firefox
printf "\n"
printf " ##############################################\n"
printf " #                  firefox                   #\n"
printf " ##############################################\n"
printf "\n"

cd $HOME
git clone https://github.com/gutohertzog/firefox-mod-blur
cd firefox-mod-blur

printf "Definir em about:config : \n"
printf "\t\t- toolkit.legacyUserProfileCustomizations.stylesheets -> 'True'"
printf "\n\t\t- svg.context-properties.content.enabled -> 'True'"

printf "ache a pasta de perfil em 'about:support' "
printf "e depois usando o botão 'Open folder' na seção 'Profile'."
printf "agora, copie a pasta 'chrome' no 'firefox-mod-blur' para a pasta do perfil"
