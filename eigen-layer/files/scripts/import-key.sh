#!/bin/sh
# Path: import-key.sh

key_type=$1
private_key=$2
password=$3

name="tmp_key"

default_filepath="$HOME/.eigenlayer/operator_keys/${key_type}_wallet.${key_type}.key.json"

# Import the new key and capture output
command="eigenlayer keys import --key-type $key_type --insecure $name $private_key"
output=$(echo "$password" | $command 2>&1)

imported_path="$HOME/.eigenlayer/operator_keys/$name.$key_type.key.json"
if [ -f "$imported_path" ]; then
    echo "Key imported successfully."
    private_key_hex=$(echo "$output" | grep -A 4 'Private Key (Hex):' | grep '//' | grep -o '[0-9a-f]\{64\}')

    # Handle output based on key type
    if [ "$key_type" = "ecdsa" ]; then
        echo "Public Key hex: $(echo "$output" | grep 'Public Key hex' | awk -F': ' '{print $2}')"
        echo "Ethereum Address: $(echo "$output" | grep 'Ethereum Address' | awk -F': ' '{print $2}')"
        echo "Private Key (Hex): $private_key_hex"
    elif [ "$key_type" = "bls" ]; then
        echo "Public Key: $(echo "$output" | grep 'Public Key' | awk -F': ' '{print $2}')"
        echo "Private Key (Hex): $private_key_hex"
    else
        echo "Unsupported key type: $key_type"
        exit 1
    fi

    # Overwriting the key file if it already exists
    cp -p "$imported_path" "$default_filepath"
    cp -p "$imported_path" "/keys/${key_type}_key.json"
    rm "$imported_path"
    echo "Key imported successfully."
else
    echo "Key import failed."
    echo "$output"
    exit 1
fi
