#!/bin/bash -ex

# ubuntu 16.04 config for gui
sudo apt update

# browser install
sudo apt-get install -y chromium-browser

# gnome config
/usr/bin/gsettings set org.gnome.desktop.interface clock-show-date
/usr/bin/gsettings set org.gnome.desktop.interface clock-format 12h
/usr/bin/gsettings set org.gnome.desktop.peripherals.touchpad tap-to-click true  
/usr/bin/gsettings set org.gnome.desktop.peripherals.touchpad natural-scroll true
/usr/bin/gsettings set org.gnome.desktop.interface gtk-key-theme "Emacs"

# gnome dark theme
sudo apt-get install -y gnome-tweak-tool
mkdir -p ~/.config/gtk-3.0
echo -e "[Settings]\ngtk-application-prefer-dark-theme=1" >> ~/.config/gtk-3.0/settings.ini

# disable shell beep
echo "set bell-style none" >> ~/.inputrc

# vscode install
curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
sudo mv microsoft.gpg /etc/apt/trusted.gpg.d/microsoft.gpg
sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'
sudo apt-get update
sudo apt-get install -y --allow-unauthenticated code
