#!/bin/sh

# Define the paths where keys are stored
ECDSA_KEY_PATH=$NODE_ECDSA_KEY_FILE
BLS_KEY_PATH=$NODE_BLS_KEY_FILE


# Simplified function without 'local' and with direct command execution
create_key() {
    key_type=$1
    key_path=$2
    key_name=$3
    password=$4
    if [ ! -f "$key_path" ]; then
        echo "Creating $key_type key..."
        echo $password | eigenlayer keys create --key-type "$key_type" "$key_name" > /dev/null
        cp -p "$HOME/.eigenlayer/operator_keys/${key_type}_wallet.${key_type}.key.json" "$key_path"
        echo "$key_type key created at $key_path"
    else
        echo "$key_type key already exists at $key_path"
    fi
}

# Create ECDSA key if it does not exist
create_key "ecdsa" "$ECDSA_KEY_PATH" "ecdsa_wallet" $NODE_ECDSA_KEY_PASSWORD

# Create BLS key if it does not exist
create_key "bls" "$BLS_KEY_PATH" "bls_wallet" $NODE_BLS_KEY_PASSWORD

echo "Key setup complete."
