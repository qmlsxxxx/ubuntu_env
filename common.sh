#!/bin/bash

apt=apt-get
if [ -e /usr/bin/apt-fast ]; then
        apt=apt-fast
fi

