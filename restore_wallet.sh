#!/bin/bash

echo
echo "Restoring wallet..."

if ! [[ -f "${WALLET_DIR}/wallet.7z" ]]
then
    echo "Wallet backup file [${WALLET_DIR}/wallet.7z] doesn't exist!"
    exit 1 
fi

echo "Do you really want to restore wallet? It will destroy your current wallet!!!"
echo "Type 'YES'" 

read CONF

if [ "$CONF" != "YES" ]
then
    exit 1
fi

cp "${WALLET_DIR}/wallet.7z" "${ZCLASSIC_DATA_DIR}"

cd "$ZCLASSIC_DATA_DIR"
7z x wallet.7z wallet.dat
CODE=$?
if [[ $CODE -ne 0 ]]
then
    echo "7z Error: $CODE"
    exit $CODE
fi
rm -f wallet.7z