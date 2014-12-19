#!/bin/sh

linuxpath=$1

if [ ! -z $linuxpath ] 
then 
    :
else
    linuxpath="linux-3.12.31-rt45"
fi

cd $linuxpath

echo "[MAKE] Compiling..."
make ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- -j5
echo "[MAKE] Compiling modules..."
make ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- -j5 modules
echo "[MAKE] Compiling uImage and dtbs..."
make ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- LOADADDR=0x80008000 -j5 uImage dtbs
echo "[MAKE] Modules Install"
mkdir ../linux_modules
make ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- LOADADDR=0x80008000 -j5 INSTALL_MOD_PATH=../linux_modules modules_install
echo "[MAKE] Linux Kernel Ready!"

cd ..

echo "#####################################################################"