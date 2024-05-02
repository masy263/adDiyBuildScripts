#!/bin/bash

START=$(date +%s)

PATH_REPO=/home/markus/Git-Repos/adDiyBuildScripts
cd $PATH_REPO

# source vivado settings
source /home/markus/Programme/VitisUnifiedSoftware-2021.1/Vitis/2021.1/settings64.sh

# run analog devices build script for BOOT.BIN
bash ./buildBootBin.sh $PATH_REPO/system_top.xsa $PATH_REPO/u-boot_zynq_zed.elf BOOT.BIN | tee buildScripts/buildBootBin.log

END=$(date +%s)
DIFF=$(( $END - $START ))

echo "script execution took $DIFF seconds"

