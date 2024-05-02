#!/bin/bash

START=$(date +%s)

# set path to vivado
# export PATH=$PATH:/home/markus/Programme/VivadoEnterprise-2021.1/Vivado/2021.1/bin
# export PATH=$PATH:/home/markus/Programme/VivadoEnterprise-2021.1/Vitis_HLS/2021.1/bin

# source vivado settings
source /home/markus/Programme/VitisUnifiedSoftware-2021.1/Vitis/2021.1/settings64.sh

# run analog devices build script for BOOT.BIN
bash buildBootBin.sh system_top.xsa u-boot_zynq_zed.elf BOOT.BIN | tee buildScripts/buildBootBin.log

END=$(date +%s)
DIFF=$(( $END - $START ))

echo "script execution took $DIFF seconds"

