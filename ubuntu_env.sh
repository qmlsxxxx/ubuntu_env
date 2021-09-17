#!/bin/sh

APT=apt-get
if [ -e /usr/bin/apt-fast ]; then
    APT=apt-fast
fi

mkdir -p $HOME/.fonts
cp Consolas.ttf $HOME/.fonts/
sudo fc-cache -f -v

sudo dpkg-reconfigure dash
sudo apt-add-repository ppa:git-core/ppa
sudo $APT update

