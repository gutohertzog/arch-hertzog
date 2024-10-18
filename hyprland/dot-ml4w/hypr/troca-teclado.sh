#!/bin/bash

# Altere o layout
hyprctl switchxkblayout dell-kb216-wired-keyboard next

# Obtenha o layout ativo atual
atual=$(hyprctl devices -j | jq -r '.keyboards[] | select(.main == true) | .active_keymap')

# Notifique o novo layout
dunstify "Layout Alterado" "${atual}" --icon=dialog-information

