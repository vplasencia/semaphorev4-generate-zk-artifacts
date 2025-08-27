#!/bin/bash

# This script requires the production-artifacts folder with the final zkey files. 

# This command checks whether the locally generated WASM files
# match the expected files in the production-artifacts directory.
# The goal is to ensure that using the same Semaphore circuit 
# consistently produces identical WASM files, as 
# these files are deterministic.

START=1

END=32

# In case there is a start value as input
if [ "$1" ]; then
    START=$1
fi

# In case there is an end value as input
if [ "$2" ]; then
    END=$2
fi

echo "----- Checking WASM files -----"

for ((i = $START; i <= $END; i++)); do
    if cmp -s ./build/semaphore-${i}/groth16/semaphore-${i}_js/semaphore-${i}.wasm ./production-artifacts/semaphore-${i}.wasm; then
        echo "WASM files are equal for Semaphore depth $i ✅"
    else
        echo "WASM files are different for Semaphore depth $i ❌"
    fi
done


