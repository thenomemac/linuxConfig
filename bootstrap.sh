#!/bin/bash -ex

# run this script to bootstrap git config
sudo apt-get install -y git
git config --global user.name "Josiah Olson"
git config --global user.email "thenomemac@gmail.com"
git config --global credential.helper store

# clone the config repo
git clone https://github.com/linuxConfig.git

echo 'Run GUI and Shell config scripts now...'
