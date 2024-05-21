#!/bin/bash

PATH_REPO=/home/markus/Git-Repos/adDiyBuildScripts

cd $PATH_REPO
rm -Rf ./outputData/
mkdir outputData
mkdir outputData/adrv9361z7035

PATH_INP=/home/markus/Git-Repos/adHdlRepo
PATH_OUT=$PATH_REPO/outputData/adrv9361z7035

cp -r $PATH_INP/projects/adrv9361z7035/ccbob_cmos/* $PATH_OUT
cp $PATH_REPO/furtherInformation/vivado.gitignore $PATH_OUT/.gitignore
cp -r $PATH_INP/projects/adrv9361z7035/common/ $PATH_OUT/common/
cp $PATH_INP/library/common/ad_iobuf.v $PATH_OUT/common/ad_iobuf.v

sed -i 's!/../common!/common!' outputData/adrv9361z7035/adrv9361z7035_ccbob_cmos.xpr
sed -i 's!/../../../library/common/ad_iobuf.v!/common/ad_iobuf.v!' outputData/adrv9361z7035/adrv9361z7035_ccbob_cmos.xpr

#echo 'replace String "/../common" by "/common" in the *.xpr file'
#echo 'replace string "/../../../library/common/ad_iobuf.v" by "/common/ad_iobuf.v" in the *.xpr file'
