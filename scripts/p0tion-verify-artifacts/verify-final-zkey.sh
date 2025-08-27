#!/bin/bash

# This script requires the p0tion-ptau folder with the ptau files. The
# files can be found in the following url: 
# https://pse-trusted-setup-ppot.s3.eu-central-1.amazonaws.com/pot28_0080/index.html

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

echo "----- Verify Final ZKEY -----"

for ((i = $START; i <= $END; i++)); do
    echo "----- Tree depth $i -----"
    snarkjs zkey verify ./build/semaphore-${i}/groth16/semaphore-${i}.r1cs p0tion-ptau/ppot_0080_14.ptau ./p0tion-artifacts/semaphore-${i}_final.zkey
done
