#!/bin/sh

source common.sh

# 精簡版：只設定 PACKAGE_LIST 變數

# 偵測 Ubuntu 版本
if [ -f /etc/os-release ]; then
    . /etc/os-release
else
    echo "無法偵測 Ubuntu 版本" >&2
    exit 1
fi

# 基礎套件
BASE_PACKAGES="vim samba smbclient openssh-server p7zip-full universal-ctags htop silversearcher-ag lbzip2 pxz \
	cpufrequtils zssh bindfs cifs-utils ffmpeg tig axel tree ccache nfs-kernel-server bash-completion rsync gnupg \
	flex bison build-essential zip curl zlib1g-dev gcc-multilib g++-multilib  libxml2-utils xsltproc unzip fontconfig \
	diffstat chrpath texinfo gawk zlib1g linux-libc-dev libswitch-perl libssl-dev bc \
	libc6-dev-i386 x11proto-core-dev libx11-dev lib32z1-dev libgl1-mesa-dev"

# 版本特定套件
case "$VERSION_ID" in
    "18.04")
        VERSION_SPECIFIC="vnc4server git-core libncurses5-dev lib32ncurses5-dev"
        ;;
    "22.04"|"24.04"|"24.10")
        VERSION_SPECIFIC="tigervnc-standalone-server git libncurses-dev lib32ncurses-dev"
        ;;
    *)
        VERSION_SPECIFIC="tigervnc-standalone-server git libncurses-dev lib32ncurses-dev"
        ;;
esac

# 設定 PACKAGE_LIST
export PACKAGE_LIST="$BASE_PACKAGES $VERSION_SPECIFIC"

# 執行安裝（如果需要）
sudo $apt update && sudo apt install -y $PACKAGE_LIST
