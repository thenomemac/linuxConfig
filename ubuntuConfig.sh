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
git config --global user.email "thenomemac@gmail.com"
git config --global user.name "Josiah"

# deep learning bleeding edge installs
pip install --upgrade https://github.com/Theano/Theano/archive/master.zip
pip install --upgrade https://github.com/fchollet/keras/archive/master.zip
pip install --upgrade https://github.com/Lasagne/Lasagne/archive/master.zip

# test blas config
wget https://github.com/Theano/Theano/raw/master/theano/misc/check_blas.py
python check_blas.py
rm check_blas.py

# install python graphing tools
pip install ggplot
conda install -y seaborn
conda install altair --channel conda-forge

# install python utils
pip install --upgrade urllib3 tqdm
pip install --upgrade progressbar2

# image processing
pip install --upgrade imageio

# install ml tools 
pip install --upgrade xgboost h2o 

# tensorflow install cpu only
conda create -n tensorflow -y python=3.5
source activate tensorflow
conda install -y -c conda-forge tensorflow
# test tensorflow
python -c "import numpy as np; import tensorflow as tf; x = tf.constant(np.random.random((5000, 5000))); sess = tf.Session(); print(sess.run(tf.matmul(x, x)));"
source deactivate
