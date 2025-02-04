#!/bin/bash

START=$(date +%s)

AD_HDL_REPO=/home/markus/Git-Repos/adHdlRepo
BUILD_SCRIPTS=/home/markus/Git-Repos/adDiyBuildScripts
PROJECT_PATH=adrv9361z7035/ccbob_cmos
PROJECT_NAME=adrv9361z7035

# open hdl git
cd $AD_HDL_REPO
git status | tee $BUILD_SCRIPTS/adrv9361z7035.log
git checkout 2021_r1 | tee -a $BUILD_SCRIPTS/adrv9361z7035.log
git clean -fdx

# set flag to generate project, that allow out-of-context sythesis
# export ADI_USE_OOC_SYNTHESIS=y
# export ADI_MAX_OOC_JOBS=8

# set flag to skip version check
# export ADI_IGNORE_VERSION_CHECK=1

# set path to vivado
export PATH=$PATH:/home/markus/Programme/VivadoEnterprise-2021.1/Vivado/2021.1/bin/
export PATH=$PATH:/home/markus/Programme/VivadoEnterprise-2021.1/Vitis_HLS/2021.1/bin/

# run make
make -C ./projects/$PROJECT_PATH/ all | tee -a $BUILD_SCRIPTS/$PROJECT_NAME.log

END=$(date +%s)
DIFF=$(( $END - $START ))

echo "script execution took $DIFF seconds"

