#!/bin/bash

## Bash script for setting up a PX4 development environment for Pixhawk/NuttX targets on Ubuntu LTS (16.04).
## It can be used for installing simulators and the NuttX toolchain.
##
## Installs:
## - Common dependencies libraries, tools, and Gazebo8 simulator as defined in `ubuntu_sim.sh`
## - NuttX toolchain (i.e. gcc compiler)

echo "Downloading dependent script 'ubuntu_sim.sh'"
# Source the ubuntu_sim.sh script directly from github
ubuntu_sim=./2.sh
wget_return_code=$?
# If there was an error downloading the dependent script, we must warn the user and exit at this point.
#if [[ $wget_return_code -ne 0 ]]; then echo "Error downloading 'ubuntu_sim.sh'. Sorry but I cannot proceed further :("; exit 1; fi
# Otherwise source the downloaded script.
. <(echo "${ubuntu_sim}")

# NuttX
sudo apt-get install python-serial openocd \
    flex bison libncurses5-dev autoconf texinfo \
    libftdi-dev libtool zlib1g-dev -y

# Clean up old GCC
sudo apt-get remove gcc-arm-none-eabi gdb-arm-none-eabi binutils-arm-none-eabi gcc-arm-embedded -y
sudo add-apt-repository --remove ppa:team-gcc-arm-embedded/ppa -y


# GNU Arm Embedded Toolchain: 7-2017-q4-major December 18, 2017
dname=$(dirname "$PWD")  
echo dname = $dname
gcc_dir=$dname/toolschain/gcc-arm-none-eabi-7-2017-q4-major
echo gcc_dir = $gcc_dir
echo "Installing GCC to: $gcc_dir"
if [ -d "$gcc_dir" ]
then
    echo " GCC already installed."
else
    pushd .
    gcc_location=$(dirname "$gcc_dir")
    echo gcc_location=$gcc_location 
    cd  $gcc_location  
    #wget https://armkeil.blob.core.windows.net/developer/Files/downloads/gnu-rm/7-2017q4/gcc-arm-none-eabi-7-2017-q4-major-linux.tar.bz2
    echo "upackeage_gcc-arm-none-eabi-7-2017-q4-major-linux.tar.bz2"
    tar -jxvf gcc-arm-none-eabi-7-2017-q4-major-linux.tar.bz2
    exportline="export PATH=$PWD/gcc-arm-none-eabi-7-2017-q4-major/bin:\$PATH"
    echo $exportline > ../env.sh; 
    . ../env.sh
    popd
fi

#Reboot the computer (required before building)
echo RESTART YOUR COMPUTER to complete installation of PX4 development toolchain
