#!/bin/bash
# required packages
sudo apt-get install git gnupg flex bison gperf build-essential \
  zip curl libc6-dev x11proto-core-dev \
  libx11-dev:i386 libreadline6-dev:i386 \
  libgl1-mesa-dev g++-multilib mingw32 tofrodos \
  python-markdown libxml2-utils xsltproc zlib1g-dev:i386 \
  ccache unzip mutt ctags gawk
#sudo apt-get install openjdk-7-jdk
#sudo ln -s /usr/lib/i386-linux-gnu/mesa/libGL.so.1 /usr/lib/i386-linux-gnu/libGL.so

# install java
sudo add-apt-repository ppa:webupd8team/java
sudo apt-get update
sudo apt-get install oracle-java6-installer

