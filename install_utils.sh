#!/bin/sh

APT=apt-get
if [ -e /usr/bin/apt-fast ]; then
	APT=apt-fast
fi

sudo $APT install vim samba smbclient openssh-server vnc4server \
	p7zip-full screen subversion ctags htop silversearcher-ag \
	lbzip2 pxz cpufrequtils zssh bindfs cifs-utils ffmpeg tig \
	axel tree ccache nfs-kernel-server 
