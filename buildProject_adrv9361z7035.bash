#!/bin/bash

START=$(date +%s)

# open hdl git
# cd /home/markus/Git-Repos/analogueDevicesHdl/hdl/projects/adrv9361z7035/
cd /home/markus/Git-Repos/analogueDevicesHdl/hdl/

# git clean -fdx
# git restore .

# set flag to generate project, that can be modified afterwards
export ADI_USE_OOC_SYNTHESIS=y
export ADI_MAX_OOC_JOBS=8

# set path to vivado
export PATH=$PATH:/home/markus/Programme/VivadoEnterprise-2023.2/Vivado/2023.2/bin/:/home/markus/Programme/VivadoEnterprise-2023.2/Vitis_HLS/2023.2/bin/

# run make
# make | tee ../../../adrv9361z7035.log
make -C ./projects/adrv9361z7035/ all | tee ./adrv9361z7035.log

END=$(date +%s)
DIFF=$(( $END - $START ))

echo "script execution took $DIFF seconds"

