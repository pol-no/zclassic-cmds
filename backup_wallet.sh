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

# Check status
zcash-cli ${ZCASHCLI_PARAMS} z_gettotalbalanceif > /dev/null
[[ $? -ne 0 ]]
then
    echo "Error: zcashd error or blockchain is not synchronized."
    exit 1
fi

WALLET_TXT="wallet.txt"
zcash-cli ${ZCASHCLI_PARAMS} z_exportwallet "${ZCLASSIC_DATA_DIR}/${WALLET_TXT}"

cd ${ZCLASSIC_DATA_DIR}
7z a -p${PASS} wallet wallet.dat "${WALLET_TXT}"

cp wallet.7z ${WALLET_DIR}

rm -f wallet.7z "${ZCLASSIC_DATA_DIR}/${WALLET_TXT}"
