#!/bin/bash

# Ensure the script receives the public key as an argument
if [ -z "$1" ]; then
    echo "Usage: $0 <public-key>"
    exit 1
fi

PUBLIC_KEY=$1
TEMP_PRIVKEY_PATH="/keys/export-tmp"
TEMP_PUBKEY_PATH="/keys/export-tmp.pub"

# Export the account using the provided public key, hide output
mina accounts export --public-key $PUBLIC_KEY --privkey-path $TEMP_PRIVKEY_PATH > /dev/null 2>&1

# Check if the export was successful
if [ $? -eq 0 ]; then
    echo "Account exported successfully."
    echo "Private key:"
    cat $TEMP_PRIVKEY_PATH
    echo ""
    echo "Public key:"
    cat $TEMP_PUBKEY_PATH

    # Remove the temporary files
    rm $TEMP_PRIVKEY_PATH
    rm $TEMP_PUBKEY_PATH
else
    echo "Failed to export account." >&2
fi
