#!/bin/bash
set -Eeuo pipefail

# =============================================================================
# https://archlinux.org/packages/extra/x86_64/firefox/
# https://archlinux.org/packages/extra/x86_64/firefox-developer-edition/
# =============================================================================

source "$(dirname "$0")/conf.sh"

pacotes=(
    "firefox" # Fast, Private & Safe Web Browser
    "firefox-developer-edition" # Fast, Private & Safe Web Browser (Developer Edition)
)

# tema para o Firefox
printf "\n"
printf " ##############################################\n"
printf " #                  firefox                   #\n"
printf " ##############################################\n"
printf "\n"

instalar_pacotes "${pacotes[@]}"

# cd $HOME
# git clone https://github.com/gutohertzog/firefox-mod-blur
# cd firefox-mod-blur

printf " → Defina em about:config : \n"
# printf "\t\t- toolkit.legacyUserProfileCustomizations.stylesheets -> 'true'\n"
# printf "\t\t- svg.context-properties.content.enabled -> 'true'\n"
printf "     → browser.tabs.loadBookmarksInBackground -> 'true'\n"
# printf "\t\t → browser.newtabpage.activity-stream.system.showWeather -> 'true'\n"

# printf "ache a pasta de perfil em 'about:support' "
# printf "e depois usando o botão 'Open folder' na seção 'Profile'."
# printf "agora, copie a pasta 'chrome' no 'firefox-mod-blur' para a pasta do perfil"
printf "${FIM}"

