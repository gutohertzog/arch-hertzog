#!/bin/bash
set -Eeuo pipefail

# =============================================================================
# https://archlinux.org/packages/extra/x86_64/vlc/
# https://archlinux.org/packages/extra/x86_64/vlc-plugin-srt/
# https://archlinux.org/packages/extra/x86_64/vlc-plugin-ffmpeg/
# https://archlinux.org/packages/extra/x86_64/vlc-plugin-freetype/
# =============================================================================

source "$(dirname "$0")/conf.sh"

pacotes=(
    "vlc" # Free and open source cross-platform multimedia player and framework
    "vlc-plugin-ass" # - SSA/ASS subtitle plugin
    "vlc-plugin-srt" # - SRT subtitle file support
    "vlc-plugin-ffmpeg" # - FFMPEG plugins
    "vlc-plugin-freetype" # - subtitle and on screen display text rendering support
)

printf "\n"
printf " ##############################################\n"
printf " #                    vlc                     #\n"
printf " ##############################################\n"
printf "\n"

instalar_pacotes "${pacotes[@]}"

printf "${FIM}"

