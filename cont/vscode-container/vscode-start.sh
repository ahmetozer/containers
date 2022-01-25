#!/usr/bin/env bash
env > /tmp/old_backup.txt
export $(xargs </tmp/shared_env.txt)
export $(xargs </tmp/old_backup.txt)
mkdir -p /home/vscode/.local/share/keyrings
eval $(/usr/bin/gnome-keyring-daemon --start)
env
xdg-settings set default-web-browser print-url.desktop
DONT_PROMPT_WSL_INSTALL=1 "/usr/bin/code" "--user-data-dir" "${DATA_DIR}" "--no-sandbox" "-w" &
/usr/bin/gnome-keyring-daemon --start
sleep infinity
