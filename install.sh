#!/bin/bash

CONFIG=$1
if [[ -z $CONFIG ]] 
then
    CONFIG=~/.bashrc
fi
CONFIG_DIR=$(dirname $(readlink -f ${CONFIG}))

if [[ `grep zclassic-cmds ${CONFIG} | wc -l` -eq 0 ]]
then 
    echo "Installing zclassic-cmds in ${CONFIG}..."    
    CMDS_DIR=$(dirname $(readlink -f $0))

    cat ${CMDS_DIR}/zclassic-cmds | sed -e "s;%CMDS_DIR%;${CMDS_DIR};g" > ${CONFIG_DIR}/zclassic-cmds
    echo "# zclassic-cmds
    . ~/zclassic-cmds" >> $CONFIG
else 
    echo "Skipping, zclassic-cmds is already installed."
fi

