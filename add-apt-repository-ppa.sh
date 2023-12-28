#!/bin/bash

#sudo add-apt-repository ppa:webupd8team/java

source $PWD/common.sh

sudo $apt install software-properties-common

sudo add-apt-repository -y ppa:x4121/ripgrep
sudo add-apt-repository -y ppa:git-core/ppa
#sudo add-apt-repository ppa:itrue/fd-find

