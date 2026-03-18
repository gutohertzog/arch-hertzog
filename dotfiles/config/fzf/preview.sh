#!/usr/bin/env bash

file="$1"

# diretório → árvore leve
if [ -d "$file" ]; then
  exec eza \
    --tree \
    --level=2 \
    --group-directories-first \
    --color=always \
    --icons \
    "$file" | head -200
fi

# arquivo texto → bat
if [[ -f "$file" ]]; then
  mime=$(file --mime-type -Lb "$file")

  if [[ "$mime" == text/* ]] || [[ "$mime" == */json ]] || [[ "$mime" == */xml ]]; then
    exec bat \
      --style=numbers \
      --color=always \
      --line-range=:500 \
      "$file"
  fi
fi

# fallback
file "$file"

