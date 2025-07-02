#!/bin/bash

# Variable to store the name of the circuit
CIRCUIT=sudoku

# In case there is a circuit name as input
if [ "$1" ]; then
    CIRCUIT=$1
fi

# Path to the directory where the circuit is located
PATH_CIRCUIT=./circuits/${CIRCUIT}

# In case there is a path as input
if [ "$2" ]; then
    PATH_CIRCUIT=$2
fi

# Build directory path
BUILD_DIR=build/${CIRCUIT}

# Delete the build folder, if it exists
rm -r -f ${BUILD_DIR}

# Create the build folder
mkdir -p ${BUILD_DIR}

# Compile the circuit
# The `--O2` flag is used for optimization, which can improve performance but may increase compilation time.
# If you want to disable optimization, you can remove the `--O2` flag.
# The `--O2` should only be used with Groth16, not Plonk or Fflonk.
# The `-l` flags are used to include libraries that the circuit depends on.
# Make sure to adjust the paths to the libraries as needed.
circom ${PATH_CIRCUIT}/${CIRCUIT}.circom --r1cs --wasm --sym --c --O2 -o ${BUILD_DIR} -l ./node_modules/@zk-kit/circuits/circom -l ./node_modules/circomlib/circuits
