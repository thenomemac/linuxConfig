# ubuntu 16.04 config
sudo apt update
sudo apt upgrade -y

# install some favorite utils
sudo apt install -y htop tmux

# install compilers and open blas
sudo apt install -y gcc g++ gfortran build-essential git wget linux-image-generic libopenblas-dev

# get the latest conda build and install
wget $(curl -s "http://repo.continuum.io/archive/" | grep -o ">Anaconda.*-Linux-x86_64.sh" | grep -o "A.*" | sort -r | head -1 | (echo -n "http://repo.continuum.io/archive/" && cat))

bash Anaconda*-Linux-x86_64.sh -b
rm Anaconda*-Linux-x86_64.sh
echo -e "\n#Anaconda\nexport PATH=\"$HOME/anaconda3/bin:$PATH\"" >> .bashrc

# test numpy for mkl
python -c "import numpy as np; print(np.__config__.show());"
python -c "import numpy as np; x = np.random.random((5000, 5000)); print(x.dot(x).shape);"

# git config
git config --global user.email "thenomemac@gmail.com"thenome@lpc:~/git config --global user.name "Josiah"

