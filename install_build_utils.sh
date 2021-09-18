#!/bin/sh

APT=apt-get
if [ -e /usr/bin/apt-fast ]; then
	APT=apt-fast
fi

sudo $APT install libncurses5-dev diffstat chrpath texinfo \
	gawk zlib1g:i386 linux-libc-dev:i386 libswitch-perl \
	python3-distutils
