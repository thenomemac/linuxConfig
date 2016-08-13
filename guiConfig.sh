# ubuntu 16.04 config for gui
sudo apt update
sudo apt upgrade -y

# download and install chrome
sudo apt install -y libxss1 libappindicator1 libindicator7
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg -i google-chrome*.deb
rm google-chrome*.deb
sudo apt update
# to run: google-chrome-stable

# download and install sublimetext
wget $(curl -s https://www.sublimetext.com/3 | grep -o "https://download.sublimetext.com/sublime-text.*amd64.deb")
sudo dpkg -i sublime-text*amd64.deb
rm sublime-text*.deb
sudo apt update
