#!/bin/sh

source common.sh

mkdir -p $HOME/.fonts
cp Consolas.ttf $HOME/.fonts/
sudo fc-cache -f -v

sudo dpkg-reconfigure dash

