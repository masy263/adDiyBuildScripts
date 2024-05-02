#!/bin/bash

START=$(date +%s)

# open hdl git
# cd /home/markus/Git-Repos/adHdlRepo/hdl/projects/adrv9361z7035/
cd /home/markus/Git-Repos/adHdlRepo/

# git clean -fdx
# git restore .

# set flag to generate project, that allow out-of-context sythesis
# export ADI_USE_OOC_SYNTHESIS=y
# export ADI_MAX_OOC_JOBS=8

# set path to vivado
export PATH=$PATH:/home/markus/Programme/VivadoEnterprise-2021.1/Vivado/2021.1/bin/
export PATH=$PATH:/home/markus/Programme/VivadoEnterprise-2021.1/Vitis_HLS/2021.1/bin/

# run make
make -C ./projects/adrv9361z7035/ccbob_cmos/ all | tee ./buildScripts/adrv9361z7035.log

END=$(date +%s)
DIFF=$(( $END - $START ))

echo "script execution took $DIFF seconds"

