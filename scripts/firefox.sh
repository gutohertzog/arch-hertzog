#!/bin/bash
OK="\e[0;32mOK\e[0m"

# tema para o Firefox
printf "\n"
printf " ##############################################\n"
printf " #                  firefox                   #\n"
printf " ##############################################\n"
printf "\n"

cd $HOME/GitHub
git clone https://github.com/datguypiko/Firefox-Mod-Blur
cd Firefox-Mod-Blur
printf "Ir em about:config : toolkit.legacyUserProfileCustomizations.stylesheets -> 'True'"
mkdir -p $HOME/raposa/
cp -r ASSETS $HOME/raposa/
cp userContent.css $HOME/raposa/
cp userChrome.css $HOME/raposa/
cp EXTRA\ MODS/Compact\ extensions\ menu/Style\ 2/cleaner_extensions_menu.css $HOME/mozilla/firefox/firefox-themes
cp EXTRA\ MODS/Tabs\ Bar\ Mods/Colored\ sound\ playing\ tab/colored_soundplaying_tab.css $HOME/raposa/
cp EXTRA\ MODS/Icon\ and\ Button\ Mods/Firefox\ view\ icon\ change/firefox_view_icon_change.css $HOME/raposa/
cp EXTRA\ MODS/Icon\ and\ Button\ Mods/Hide\ list-all-tabs\ button/hide_list-all-tabs_button.css $HOME/raposa/
cp EXTRA\ MODS/Icon\ and\ Button\ Mods/Icons\ in\ main\ menu/icons_in_main_menu.css $HOME/raposa/
cp EXTRA\ MODS/Icon\ and\ Button\ Mods/Menu\ icon\ change/menu_icon_change_to_firefox.css $HOME/raposa/
cp EXTRA\ MODS/Min-max-close\ control\ buttons/Right\ side\ MacOS\ style\ buttons/min-max-close_buttons.css $HOME/raposa/
cp EXTRA\ MODS/Bookmarks\ Bar\ Mods/Remove\ folder\ icons\ from\ bookmars/remove_folder_icons_from_bookmarks.css $HOME/raposa/
cp EXTRA\ MODS/Homepage\ mods/Remove\ text\ from\ homepage\ shortcuts/remove_homepage_shortcut_title_text.css $HOME/raposa/
cp EXTRA\ MODS/Tabs\ Bar\ Mods/Tabs\ -\ reversed\ background\ color/reversed_tabs_bg_color.css $HOME/raposa/
cp EXTRA\ MODS/Tabs\ Bar\ Mods/Tabs\ -\ selected\ tabs\ static\ width/selected_tabs_static_width.css $HOME/raposa/
cp EXTRA\ MODS/Icon\ and\ Button\ Mods/uBlock\ icon\ change/ublock-icon-change.css $HOME/raposa/

printf "agora, copie todo o conteúdo da pasta 'raposa' no HOME"
printf "ache a pasta de perfil em 'about:support', e depois usando 'Open folder' na seção 'Profile'."

