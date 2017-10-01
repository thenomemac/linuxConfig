#!/bin/bash -ex

# ubuntu 16.04 config
sudo apt update -y

# install some favorite utils
sudo apt-get install -y git curl htop tmux emacs

# emacs config
git clone https://github.com/thenomemac/.emacs.d.git

# get the latest conda build and install
curl -O https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh
bash Miniconda3*.sh -b
rm Miniconda3*.sh
echo -e '\n# Miniconda3\nexport PATH="$HOME/miniconda3/bin:$PATH"' >> ~/.bashrc
source ~/.bashrc

# must have python utils
conda install -y numpy pandas scipy matplotlib mkl ipython jupyter requests flask bokeh tqdm

# linting dev tools
pip install jedi rope flake8 importmagic autopep8 yapf

# docker install
sudo apt-get install docker.io
# make docker non root
sudo groupadd docker
sudo gpasswd -a $USER docker
newgrp docker

# shell completion framework
git clone --depth=1 https://github.com/Bash-it/bash-it.git ~/.bash_it
~/.bash_it/install.sh --silent
source ~/.bashrc
bash-it enable alias git docker tmux vim emacs apt curl clipboard

# google cloud config
export CLOUD_SDK_REPO="cloud-sdk-$(lsb_release -c -s)"
echo "deb http://packages.cloud.google.com/apt $CLOUD_SDK_REPO main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
sudo apt-get update && sudo apt-get install -y google-cloud-sdk kubectl

# personal bin
mkdir -p ~/bin
echo -e '\n# personal bin\nexport PATH="$HOME/bin:$PATH"' >> ~/.bashrc
source ~/.bashrc
