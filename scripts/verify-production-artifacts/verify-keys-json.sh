#!/bin/bash

# This script requires the p0tion-ptau folder with the ptau files. The
# files can be found in the following url: 
# https://pse-trusted-setup-ppot.s3.eu-central-1.amazonaws.com/pot28_0080/index.html

# This script also requires the production-artifacts folder with the final zkey files. 

START=1

END=32

# Define the temporary directory name
TMP_DIR="./temp-verification-keys-json"

# In case there is a start value as input
if [ "$1" ]; then
    START=$1
fi

# In case there is an end value as input
if [ "$2" ]; then
    END=$2
fi

# Create the directory if it does not exist
mkdir -p "$TMP_DIR"

echo "----- Verify Verification Keys JSON -----"

for ((i = $START; i <= $END; i++)); do
    echo "----- Tree depth $i -----"
    snarkjs zkey export verificationkey ./production-artifacts/semaphore-${i}.zkey ./${TMP_DIR}/semaphore-${i}.json
done

echo "----- Checking JSON files -----"

for ((i = $START; i <= $END; i++)); do
    if diff -w ./production-artifacts/semaphore-${i}.json ./${TMP_DIR}/semaphore-${i}.json; then
        echo "JSON files are equal for Semaphore depth $i ✅"
    else
        echo "JSON files are different for Semaphore depth $i ❌"
    fi
done

# Remove the temporary directory
rm -rf "$TMP_DIR"
