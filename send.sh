#!/bin/bash

if [[ $# -eq 0 ]] ; then
    echo 'Usage:'
    echo 'send TO_ADDR AMOUNT (t-addr only)'
    echo 'send FROM_ADDR TO_ADDR AMOUNT (t-addr & z-addr support)'
    exit 0
fi

if [[ $# -eq 3 ]]
then
    echo "Sending $3 from $1 to $2..."
    TXID=`zcash-cli z_sendmany "$1" "[{\"amount\": $3, \"address\": \"$2\"}]"`
fi

if [[ $# -eq 2 ]]
then
    echo "Sending $2 to $1..."
    TXID=`zcash-cli sendtoaddress $1 $2`
fi

if [[ $? -eq 0 ]] 
then
    if [[ $TXID =~ opid- ]]
    then
        echo "Operation ID: $TXID"
        echo "Type: 'operations' to check operation status. After operation success type 'transactions' to check transaction status."
    else 
	echo "Transaction ID (TXID): ${TXID}"
	echo "Type: 'transaction ${TXID}' to check transaction status"
    fi
fi
