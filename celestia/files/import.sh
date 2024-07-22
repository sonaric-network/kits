#!/bin/bash

# Check if the correct number of arguments are passed
if [ "$#" -ne 1 ] && [ "$#" -ne 2 ]; then
    echo "Usage: $0 <private-key> [password]"
    exit 1
fi

# Assign arguments to variables
privkey=$1
password=${2:-}

# Create a temporary file to store the private key
echo "$privkey" > sonaric-mina-imported-key.txt

# Set the correct permissions for the key file
chmod 600 sonaric-mina-imported-key.txt

# Import the key into the Celestia daemon
if [ -z "$password" ]; then
    cel-key import sonaric-celestia-key2 sonaric-mina-imported-key.txt --keyring-backend test --node.type $NODE_TYPE --p2p.network $P2P_NETWORK > /dev/null 2>&1
else
    echo "$password" | cel-key import sonaric-celestia-key2 sonaric-mina-imported-key.txt --keyring-backend test --node.type $NODE_TYPE --p2p.network $P2P_NETWORK > /dev/null 2>&1
fi

# Remove the temporary key file
rm sonaric-mina-imported-key.txt