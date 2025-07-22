#!/bin/bash

# This script checks if the R1CS and WASM files generated locally
# match the expected files in the ceremony-artifacts directory.
# The goal is to ensure that using the same Semaphore circuit
# consistently produces identical R1CS and WASM files 
# (R1CS and WASM files are deterministic).

START=1

END=32

# In case there is a start value as input
if [ "$1" ]; then
    START=$1
fi

# In case there is an end value as input
if [ "$1" ]; then
    END=$2
fi

echo "----- Checking R1CS files -----"

for ((i = $START; i <= $END; i++)); do
    if cmp -s ./build/semaphore-${i}/groth16/semaphore-${i}.r1cs ./ceremony-artifacts/semaphore-${i}.r1cs; then
        echo "R1CS files are equal for Semaphore depth $i ✅"
    else
        echo "R1CS files are different for Semaphore depth $i ❌"
    fi
done


echo "----- Checking WASM files -----"

for ((i = $START; i <= $END; i++)); do
    if cmp -s ./build/semaphore-${i}/groth16/semaphore-${i}_js/semaphore-${i}.wasm ./ceremony-artifacts/semaphore-${i}.wasm; then
        echo "WASM files are equal for Semaphore depth $i ✅"
    else
        echo "WASM files are different for Semaphore depth $i ❌"
    fi
done


