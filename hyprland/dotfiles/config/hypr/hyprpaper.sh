#!/bin/sh

config="$HOME/.config/hypr/hyprpaper.conf"
wallpapers="$HOME/Pictures/wallpapers"

echo 'ipc = on' > "$config"
echo 'splash = true' >> "$config"

for picture in "$wallpapers"/*; do
	echo "preload = $picture" >> "$config"
done

# kill -x hyprpaper
hyprpaper

while true; do
	wallpaper="$(find -L "$wallpapers" -type f | shuf -n 1)"

	# hyprctl hyprpaper preload "$wallpaper"

    # troca o wallpaper de todos os monitores
	hyprctl hyprpaper wallpaper ",$wallpaper"
	# hyprctl hyprpaper wallpaper "HDMI-A-1,$wallpaper"

	sleep 60
done
