#!/bin/bash

cp -r /home/markus/Git-Repos/adHdlRepo/hdl/projects/adrv9361z7035/ccbob_cmos /home/markus/Git-Repos/adHdlRepo/ccbob_cmos
cp /home/markus/Git-Repos/adHdlRepo/buildScripts/vivado.gitignore /home/markus/Git-Repos/adHdlRepo/ccbob_cmos/.gitignore
cp -r /home/markus/Git-Repos/adHdlRepo/hdl/projects/adrv9361z7035/common/ /home/markus/Git-Repos/adHdlRepo/ccbob_cmos/common/
cp /home/markus/Git-Repos/adHdlRepo/hdl/library/common/ad_iobuf.v

echo 'replace String "/../common" by "/common" in the *.xpr file'
echo 'replace string "/../../../library/common/ad_iobuf.v" by "/common/ad_iobuf.v" in the *.xpr file'