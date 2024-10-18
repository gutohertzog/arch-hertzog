#!/bin/bash

# Obtenha o layout ativo atual
atual=$(hyprctl devices -j | jq -r '.keyboards[] | select(.main == true) | .active_keymap')

# Notifique o novo layout
dunstify "Layout Atual" "${atual}" --icon=dialog-information

