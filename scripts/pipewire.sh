#!/bin/bash
set -Eeuo pipefail

# =============================================================================
# https://archlinux.org/packages/extra/x86_64/pipewire/
# https://archlinux.org/packages/extra/x86_64/pipewire-alsa/
# https://archlinux.org/packages/extra/x86_64/pipewire-audio/
# https://archlinux.org/packages/extra/x86_64/pipewire-pulse/
#
# https://archlinux.org/packages/extra/x86_64/wireplumber/
# https://archlinux.org/packages/extra/x86_64/pipewire-session-manager/
# =============================================================================

source "$(dirname "$0")/conf.sh"

pacotes=(
    "pipewire" # Low-latency audio/video router and processor
    "pipewire-alsa" # - ALSA configuration
    "pipewire-audio" # - Audio support
    "pipewire-pulse" # - PulseAudio replacement

    "wireplumber" # Session / policy manager implementation for PipeWire
    "pipewire-session-manager" # - system services
)

printf "\n"
printf " ##############################################\n"
printf " #                  pipewire                  #\n"
printf " ##############################################\n"
printf "\n"

instalar_pacotes "${pacotes[@]}"

printf "${FIM}"

