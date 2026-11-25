#!/usr/bin/env bash
# Lista os atalhos do Hyprland que têm description, para consulta rápida.
# Aberto por um atalho numa janela flutuante do kitty (classe hypr-atalhos).
# Atalhos com tecla numérica e mesma description viram uma linha só ([0-9]).

hyprctl binds -j | jq -r '
  def mods: [ (if (.modmask / 64 | floor) % 2 == 1 then "SUPER" else empty end),
              (if (.modmask / 4  | floor) % 2 == 1 then "CTRL"  else empty end),
              (if (.modmask / 8  | floor) % 2 == 1 then "ALT"   else empty end),
              (if  .modmask % 2 == 1               then "SHIFT" else empty end) ];
  [ .[] | select(.has_description)
        | if (.key | test("^[0-9]$")) then .key = "[0-9]" else . end
        | "\((mods + [.key]) | join(" + "))\t\(.description)" ]
  | reduce .[] as $l ([]; if any(.[]; . == $l) then . else . + [$l] end)
  | .[]' \
  | column -t -s $'\t' \
  | fzf --preview-window=hidden \
        --layout=reverse \
        --prompt="atalhos> " \
        --header="Esc ou Enter para fechar"

hyprctl dispatch 'hl.dsp.window.close()' >/dev/null

