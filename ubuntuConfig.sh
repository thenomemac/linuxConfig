#!/bin/bash -ex

# ubuntu 16.04 config
sudo apt update -y

# install some favorite utils
sudo apt-get install -y git curl htop tmux emacs

# emacs config
git clone https://github.com/thenomemac/.emacs.d.git
emacs --script ~/.emacs.d/init.el

# global gitignore
git config --global core.excludesfile ~/.gitignore_global
cp ./.gitignore_global ~/.gitignore_global

# get the latest conda build and install
curl -O https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh
bash Miniconda3*.sh -b
rm Miniconda3*.sh
echo -e '\n# Miniconda3\nexport PATH="$HOME/miniconda3/bin:$PATH"' >> ~/.bashrc
echo -e 'export LD_LIBRARY_PATH="$HOME/miniconda3/lib:$LD_LIBRARY_PATH"' >> ~/.bashrc
source ~/.bashrc

# must have python utils
conda install -y numpy pandas scipy matplotlib mkl ipython jupyter requests flask bokeh tqdm pytest
pip install jupyter-emacskeys

# linting dev tools
pip install jedi rope flake8 importmagic autopep8 yapf

# flake config
mkdir -p ~/.config
echo -e '[flake8]\nmax-line-length = 120' >> ~/.config/flake8

# docker install
sudo apt-get remove -y docker docker-engine docker.io &&
sudo apt-get update -y &&
# sudo apt-get install -y \
#     apt-transport-https \
#     ca-certificates \
#     curl \
#     software-properties-commo &&
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add - &&
sudo apt-key fingerprint 0EBFCD88 &&
sudo add-apt-repository \
    "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
    $(lsb_release -cs) \
    stable" &&
sudo apt-get update -y &&
sudo apt-get install -y docker-ce
# docker-compose
sudo curl -L https://github.com/docker/compose/releases/download/1.21.0/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose &&
sudo chmod +x /usr/local/bin/docker-compose &&
docker-compose --version  # docker-compose version 1.21.0, build 1719ceb


# make docker non root
sudo groupadd docker
sudo gpasswd -a $USER docker
newgrp docker

# shell completion framework
git clone --depth=1 https://github.com/Bash-it/bash-it.git ~/.bash_it
~/.bash_it/install.sh --silent
source ~/.bashrc
bash-it enable alias git docker tmux vim emacs apt curl clipboard

# personal bin
mkdir -p ~/bin
echo -e '\n# personal bin\nexport PATH="$HOME/bin:$PATH"' >> ~/.bashrc
source ~/.bashrc

# google cloud config
export CLOUD_SDK_REPO="cloud-sdk-$(lsb_release -c -s)"
echo "deb http://packages.cloud.google.com/apt $CLOUD_SDK_REPO main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
sudo apt-get update && sudo apt-get install -y google-cloud-sdk kubectl

# golang init
echo '' >> ~/.bashrc
echo '# go config' >> ~/.bashrc
echo 'export GOROOT="$HOME/bin/go"' >> ~/.bashrc
echo 'export GOPATH="$HOME/gocode"' >> ~/.bashrc
echo 'export PATH="$PATH:$GOROOT/bin:$GOPATH/bin"' >> ~/.bashrc
mkdir -p ~/bin
mkdir -p gocode
# golang install
curl -O https://dl.google.com/go/go1.10.linux-amd64.tar.gz
tar -xzvf go*.linux-amd64.tar.gz
mv go bin/go
