#!/bin/bash

# This script requires the p0tion-last-zkey folder with the last zkey files from p0tion. The
# files can be found in the ceremony URL. 
# The script verifies that the beacon was correctly applied to the last zkey files.
# The beacon can be found in the ceremony URL as well.

BEACON="42de806cf263f7439c643380c606aa8839037847fc7b8387710deaab098ec700"

START=1

END=32

# In case there is a beacon value as input
if [ "$1" ]; then
    BEACON=$1
fi

# In case there is a start value as input
if [ "$2" ]; then
    START=$2
fi

# In case there is an end value as input
if [ "$3" ]; then
    END=$3
fi

echo "----- Verifying beacon ZKEY files -----"

# Create a temporary directory for the beacon verification
mkdir -p beacon-temp

echo "----- Generating Final ZKEY files with beacon from LAST ZKEY files -----"

for ((i = $START; i <= $END; i++)); do
    # Apply the beacon to the last zkey file and save it in the temporary directory
    # The command should contain the same beacon and text for -n as in the ceremony in P0tion
    snarkjs zkey beacon ./p0tion-last-zkey/semaphore-${i}_00003.zkey ./beacon-temp/semaphore-${i}_final.zkey $BEACON 10 -n="mpc-dev-121107909" > /dev/null 2>&1
done

echo "----- Comparing Final ZKEY files -----"

for ((i = $START; i <= $END; i++)); do
    if cmp -s ./p0tion-artifacts/semaphore-${i}_final.zkey ./beacon-temp/semaphore-${i}_final.zkey; then
        echo "Final ZKEY files are equal for Semaphore depth $i ✅"
    else
        echo "Final ZKEY files are different for Semaphore depth $i ❌"
    fi
done

# Delete the beacon-temp folder
rm -r -f beacon-temp