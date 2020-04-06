#!/bin/sh

mkdir -p $HOME/.fonts
cp Consolas.ttf $HOME/.fonts/
sudo fc-cache -f -v

sudo dpkg-reconfigure dash
sudo apt-add-repository ppa:git-core/ppa
sudo apt-get update

sudo apt-get install vim samba openssh-server vnc4server \
	p7zip-full screen subversion libncurses5-dev ctags \
	diffstat chrpath texinfo

cp .vimrc $HOME/.vimrc
cp .screenrc $HOME/.screenrc
cp .grepignore $HOME/.grepignore
cp -a .vim $HOME/

git config --global core.editor vim

echo "export SVN_EDITOR=vim" >> $HOME/.bashrc
echo "alias grep='grep --color --exclude-from=$HOME/.grepignore'" >> $HOME/.bashrc
