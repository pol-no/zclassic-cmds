#!/bin/bash

echo
echo "Backup wallet to 7zip"
echo

echo "Enter the backup password:"
read -s PASS

echo "Reenter the backup password"
read -s PASS2

if [[ "$PASS" != "$PASS2" ]]
then
    echo "Passwords don't match!"
    exit 1
fi

if [[ "$1" != "-f" ]]
then
    # Check status
    zcash-cli ${ZCASHCLI_PARAMS} z_gettotalbalance > /dev/null
    if [[ $? -ne 0 ]]
    then
	echo "Error: zcashd error or blockchain is not synchronized."
	exit 1
    fi

    WALLET_TXT="wallet.txt"
    zcash-cli ${ZCASHCLI_PARAMS} z_exportwallet "${ZCLASSIC_DATA_DIR}/${WALLET_TXT}"
fi

cd ${ZCLASSIC_DATA_DIR}
7z a -p${PASS} wallet wallet.dat "${WALLET_TXT}"

cp wallet.7z "${WALLET_DIR}"

if [[ -f "${ZCLASSIC_DATA_DIR}/${WALLET_TXT}" ]]
then
    rm -f wallet.7z "${ZCLASSIC_DATA_DIR}/${WALLET_TXT}"
fi
