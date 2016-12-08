#!/bin/sh

mkdir -p $HOME/.fonts
cp Consolas.ttf $HOME/.fonts/
sudo fc-cache -f -v

sudo dpkg-reconfigure dash
sudo add-apt-repository ppa:tsvetko.tsvetkov/cinnamon
sudo apt-add-repository ppa:git-core/ppa
sudo apt-get update

sudo apt-get install vim samba openssh-server vnc4server \
	cinnamon p7zip-full screen subversion libncurses5-dev ctags

cp .vimrc $HOME/.vimrc
cp .screenrc $HOME/.screenrc
cp .grepignore $HOME/.grepignore
cp -a .vim $HOME/

git config --global core.editor vim

echo "export SVN_EDITOR=vim" >> $HOME/.bashrc
echo "alias grep='grep --color --exclude-from=$HOME/.grepignore'" >> $HOME/.bashrc
