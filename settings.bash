#!/bin/bash

GIT_REPO=/home/markus/Git-Repos/adDiyBuildScripts
LOG_DIR=$GIT_REPO/logFiles

#rm -rf $LOG_DIR
#mkdir $LOG_DIR

alias BOOT_BIN_BUILD="bash $GIT_REPO/bootBinBuild/bootBinBuild.bash"
alias DTB2DTS="dtc -I dtb -O dts -o"
alias DTS2DTB="dtc -I dts -O dtb -o"
