#!/bin/sh

KERNEL_MAJOR_NUMBER="6"
KERNEL_VERSION="6.8.4"

printf "Building and installing kernel v$KERNEL_VERSION\n"

printf "\nInstalling build dependencies\n"
sudo apt-get install -y git fakeroot build-essential ncurses-dev xz-utils libssl-dev bc flex libelf-dev bison

printf "\nDownloading kernel from kernel.org\n"

wget https://cdn.kernel.org/pub/linux/kernel/v$KERNEL_MAJOR_NUMBER.x/linux-$KERNEL_VERSION.tar.xz
tar xvf linux-$KERNEL_VERSION.tar.xz
cd linux-$KERNEL_VERSION

cp ../../res/config .config

make -j$(nproc)
sudo make modules_install
sudo make install
