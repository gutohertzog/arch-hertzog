#!/bin/bash

# troca o wallpaper do kitty a cada execução
kitty @ set-background-image $(ls $HOME/Pictures/wallpapers/*.png | sort --random-sort | head -1)

