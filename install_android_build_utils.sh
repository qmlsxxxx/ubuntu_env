#!/bin/bash

source common.sh

sudo $apt update
sudo $apt install git-core gnupg flex bison build-essential zip curl zlib1g-dev \
	gcc-multilib g++-multilib libc6-dev-i386 libncurses5-dev lib32ncurses5-dev \
	x11proto-core-dev libx11-dev lib32z1-dev libgl1-mesa-dev \
	libxml2-utils xsltproc unzip fontconfig

