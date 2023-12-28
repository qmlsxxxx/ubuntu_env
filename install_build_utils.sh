#!/bin/sh

source common.sh

sudo $apt install libncurses5-dev diffstat chrpath texinfo \
	gawk zlib1g linux-libc-dev libswitch-perl libssl-dev bc
