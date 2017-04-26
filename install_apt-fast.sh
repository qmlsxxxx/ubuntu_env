#!/bin/sh

git clone https://github.com/ilikenwf/apt-fast.git
sudo cp apt-fast/apt-fast /usr/bin/
sudo chmod +x /usr/bin/apt-fast
sudo cp apt-fast/apt-fast.conf /etc

sudo cp apt-fast/completions/bash/apt-fast /etc/bash_completion.d/
sudo chown root:root /etc/bash_completion.d/apt-fast

sudo apt-get install -y aria2
