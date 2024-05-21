#!/bin/bash

PATH_TO_OUTPUT_DATA=/home/markus/Git-Repos/adDiyBuildScripts/outputData
PATH_TO_AD_LINUX_REPO=/home/markus/Git-Repos/adLinuxBuildRepo
PATH_TO_VITIS=/home/markus/Programme/VitisUnifiedSoftware-2021.1
VITIS_VERSION=2021.1

cd $PATH_TO_AD_LINUX_REPO

# echo "+++ request git status +++"
# echo ""

# git status

# echo ""
# echo "++++++++++++++++++++++++++"
# echo ""

# echo "checkout to 2021_R1"
# git checkout 2021_R1

# source toolchain
source $PATH_TO_VITIS/Vitis/$VITIS_VERSION/settings64.sh

# set compiling flags
export ARCH=arm
export CROSS_COMPILE="arm-linux-gnueabihf-"

# replacing wrong line feeds in "Makefile"-files
sed -i 's/\r$//' $(find . -name "Makefile")

# replacing wrong line feeds in "Kconfig"-files
sed -i 's/\r$//' $(find . -name "Kconfig*")
sed -i 's/\r$//' $(find . -name "Kconfig.*")
sed -i 's/\r$//' $(find . -name "Kconfig-*")

# configure kernel, redirect stderr to stdout and log stdout to linuxKernelBuild.log
make zynq_xcomm_adv7511_defconfig 2>&1 | tee $PATH_TO_OUTPUT_DATA/linuxKernelBuild.log