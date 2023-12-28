#!/bin/sh

source common.sh

sudo $apt install vim samba smbclient openssh-server vnc4server \
	p7zip-full screen subversion ctags htop silversearcher-ag \
	lbzip2 pxz cpufrequtils zssh bindfs cifs-utils ffmpeg tig \
	axel tree ccache nfs-kernel-server 
