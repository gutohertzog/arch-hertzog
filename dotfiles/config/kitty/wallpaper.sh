#!/bin/bash

# troca o wallpaper do kitty a cada execução
kitty @ set-background-image $(ls /home/guto/Pictures/wallpapers/*.png | sort --random-sort | head -1)
