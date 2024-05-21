#!/bin/bash

# installing linaro toolchain:
# wget https://releases.linaro.org/components/toolchain/binaries/latest-7/arm-linux-gnueabi/gcc-linaro-7.5.0-2019.12-x86_64_arm-linux-gnueabi.tar.xz
# tar -xvf gcc-linaro-7.5.0-2019.12-x86_64_arm-linux-gnueabi.tar.xz

START=$(date +%s)

TIME=$(date +%F_%H-%M-%S)

AD_LINUX_REPO=/home/markus/Git-Repos/adLinuxBuildRepo
GIT_REPO=/home/markus/Git-Repos/adDiyBuildScripts
LINARO_DIR=/home/markus/Programme/Linaro
LOG_DIR=$GIT_REPO/logFiles
LOG_FILE=$LOG_DIR/${TIME}_kernelBuildLinaro.log
VITIS_VERSION=2021.1
VITIS_DIR=/home/markus/Programme/VitisUnifiedSoftware-2021.1

cd $AD_LINUX_REPO
git checkout 2021_R1 

export ARCH=arm
export CROSS_COMPILE=$LINARO_DIR/bin/arm-linux-gnueabi-

# header log file
TIME_STAMP=$(date "+%a %F :: %R")
echo $0 $@ | tee $LOG_FILE
printf "\n  +++ begin: $TIME_STAMP +++\n" | tee -a $LOG_FILE

make zynq_xcomm_adv7511_defconfig | tee -a $LOG_FILE

printf "\nmodify .config - replace:\n  \"# CONFIG_SERIAL_UARTLITE is not set\" by\n  \"# integrate into the kernel\n   CONFIG_SERIAL_UARTLITE=y\n   # total number of UARTs in the system - incl. all serial interfaces\n   CONFIG_SERIAL_UARTLITE_NR_UARTS=3\n   CONFIG_SUBSYSTEM_SERIAL_AXI_UARTLITE_0_BAUDRATE_230400=y\"\n\n" | tee $LOG_FILE
sed -i 's/# CONFIG_SERIAL_UARTLITE is not set/\n# integrate into the kernel\nCONFIG_SERIAL_UARTLITE=y\n# total number of UARTs in the system - incl. all serial interfaces\nCONFIG_SERIAL_UARTLITE_NR_UARTS=3\nCONFIG_SUBSYSTEM_SERIAL_AXI_UARTLITE_0_BAUDRATE_230400=y\n/' .config | tee -a $LOG_FILE

cp .config configBeforeCompiling

make -j5 UIMAGE_LOADADDR=0x8000 uImage | tee -a $LOG_FILE

END=$(date +%s)
TIME_STAMP=$(date "+%a %F :: %R")
DIFF=$(( $END - $START ))

printf "\nscript execution took $DIFF seconds\n" | tee -a $LOG_FILE
printf "\n  +++++ end: $TIME_STAMP +++\n" | tee -a $LOG_FILE

# vllt. zur .config hinzufuegen??: CONFIG_SUBSYSTEM_SERIAL_AXI_UARTLITE_0_BAUDRATE_230400=y