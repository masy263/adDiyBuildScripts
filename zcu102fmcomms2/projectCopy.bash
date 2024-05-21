#!/bin/bash

PATH_REPO=/home/markus/Git-Repos/adDiyBuildScripts

cd $PATH_REPO
rm -Rf ./outputData/
mkdir outputData
mkdir outputData/zcu102fmcomms2

PATH_INP=/home/markus/Git-Repos/adHdlRepo
PATH_OUT=$PATH_REPO/outputData/zcu102fmcomms2

cp -r $PATH_INP/projects/fmcomms2/zcu102/* $PATH_OUT
cp $PATH_REPO/dataFiles/vivado.gitignore $PATH_OUT/.gitignore
mkdir $PATH_OUT/common
cp -r $PATH_INP/projects/common/zcu102/zcu102_system_constr.xdc $PATH_OUT/common/zcu102_system_constr.xdc
cp $PATH_INP/library/common/ad_iobuf.v $PATH_OUT/common/ad_iobuf.v

echo 'replace String "/../../common/zcu102" by "/common" in the *.xpr file'
echo 'replace string "/../../../library/common/ad_iobuf.v" by "/common/ad_iobuf.v" in the *.xpr file'