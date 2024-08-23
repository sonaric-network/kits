#!/bin/bash

# Ensure the script receives the private key as an argument
if [ -z "$1" ]; then
    echo "Usage: $0 <private-key>"
    exit 1
fi

PRIVATE_KEY=$1

KEY_DIR="/aleo/keys"
mkdir -p ${KEY_DIR}
KEY_FILE="${KEY_DIR}/aleo_keys.txt"

# Check if the key file exists, back it up if it does
if [ -f "${KEY_FILE}" ]; then
    # Create backup
    cp "${KEY_FILE}" "${KEY_DIR}/aleo_keys_backup_$(date +%Y%m%d%H%M%S).txt"
    # Clear the content
    > "${KEY_FILE}"
else
    # Explicitly touch the file to ensure it exists
    touch "${KEY_FILE}"
fi

# Set private key in file
echo "PrivateKey $PRIVATE_KEY" > "${KEY_FILE}"

# Ensure the key file has the correct permissions
chmod 600 "${KEY_FILE}"

# Send the USR1 signal to the process with PID 1. It should restart the Aleo process.
kill -USR1 1
