#!/bin/bash

OK="\e[0;32mOK\e[0m"

pacotes=(
    # reprodutor áudio e vídeo
    "vlc"
    "vlc-plugin-ass"
    "vlc-plugin-srt"
    "vlc-plugin-ffmpeg"
    "vlc-plugin-freetype"
)

printf "\n"
printf " ##############################################\n"
printf " #               instalando vlc               #\n"
printf " ##############################################\n"
printf "\n"

sudo pacman --noconfirm -S "${pacotes[@]}"
printf "\n$OK\n"

