#!/bin/bash

# Check if the correct number of arguments are passed
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <password>"
    exit 1
fi

# Assign arguments to variables
password=$1

# Export the key from the Celestia daemon
yes y | echo "$password" | cel-key export sonaric-celestia-key --keyring-backend test --node.type $NODE_TYPE --p2p.network $P2P_NETWORK 2>&1 | tail -n +2
