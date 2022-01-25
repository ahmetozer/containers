#!/bin/bash
DATA_DIR=${DATA_DIR-"/home/vscode"}
VS_USER=${VS_USER-"vscode"}

echo "url listener started" >/tmp/url.txt
chmod 777 /tmp/url.txt
mkdir -p /run/dbus/
chmod ugo+rwx  /run/dbus/
dbus-uuidgen > /var/lib/dbus/machine-id
chmod 777 /var/lib/dbus/machine-id

env > /tmp/shared_env.txt


tail -f /tmp/url.txt &

runuser -l $VS_USER -c '/usr/bin/vscode-start.sh'
