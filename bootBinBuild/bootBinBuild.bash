#!/bin/bash

START=$(date +%s)

GIT_REPO=/home/markus/Git-Repos/adDiyBuildScripts
LOG_DIR=$GIT_REPO/logFiles
TIME=$(date +%F_%H-%M-%S)
LOG_FID=$LOG_DIR/${TIME}_bootBinBuild.log
XSA_FID=$GIT_REPO/$1
UBOOT_ELF_FID=$GIT_REPO/$2

cd $GIT_REPO/bootBinBuild/

# header log file
TIME_STAMP=$(date "+%a %F :: %R")
echo $0 $@ | tee -a $LOG_FID
printf "\n" | tee -a $LOG_FID
echo "  +++ begin: $TIME_STAMP +++" | tee -a $LOG_FID
printf "\n" | tee -a $LOG_FID

rm -rf inpData
mkdir inpData

cp $XSA_FID $GIT_REPO/bootBinBuild/inpData/system_top.xsa
cp $UBOOT_ELF_FID $GIT_REPO/bootBinBuild/inpData/u-boot.elf

XSA_FID=inpData/system_top.xsa
UBOOT_ELF_FID=inpData/u-boot.elf

# source vivado settings
source /home/markus/Programme/VitisUnifiedSoftware-2021.1/Vitis/2021.1/settings64.sh

# run analog devices build script for BOOT.BIN
bash ./buildBootBin.sh $XSA_FID $UBOOT_ELF_FID BOOT.BIN | tee -a $LOG_FID
END=$(date +%s)
DIFF=$(( $END - $START ))

echo "script execution took $DIFF seconds" | tee -a $LOG_FID

TIME_STAMP=$(date "+%a %F :: %R")

printf "\n" | tee -a $LOG_FID
echo "  +++++ end: $TIME_STAMP +++" | tee -a $LOG_FID
printf "\n" | tee -a $LOG_FID

