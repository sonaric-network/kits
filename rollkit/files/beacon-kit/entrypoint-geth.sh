#!/bin/sh
set -e

# install only if not already installed
if ! command -v jq > /dev/null 2>&1; then
  apk add --no-cache openssl curl jq
fi

ETH_GENESIS="/geth/eth-genesis.json"
ETH_DATA_DIR="/geth/data"
JWT_SECRET_PATH="/geth/jwtsecret"
IPC_PATH="/geth/geth.ipc"

# Ensure JWT secret exists
if [ ! -f $JWT_SECRET_PATH ]; then
  echo "Creating JWT secret..."
  openssl rand -hex 32 > $JWT_SECRET_PATH
  echo "JWT secret created."
fi


# Download genesis file if not present
if [ ! -f $ETH_GENESIS ]; then
  echo "Downloading eth-genesis.json..."
  curl -o $ETH_GENESIS "https://raw.githubusercontent.com/berachain/beacon-kit/main/testing/networks/80084/eth-genesis.json"
  echo "Adding premined deposit..."
  jq '.alloc += {"0x20f33ce90a13a4b5e7697e3544c3083b8f8a51d4": {"balance": "0x123450000000000000000"}}' "$ETH_GENESIS" > temp_genesis.json && mv temp_genesis.json "$ETH_GENESIS"
  echo "Done."
fi

if [ ! -d $ETH_DATA_DIR ]; then
  mkdir -p $ETH_DATA_DIR
fi

if [ ! -d $ETH_DATA_DIR/geth ]; then
  echo "Initializing geth..."
  geth init --datadir $ETH_DATA_DIR $ETH_GENESIS
  echo "geth initialized."
fi

geth --http \
  --http.addr 0.0.0.0 \
  --http.api eth,net \
  --authrpc.addr 0.0.0.0 \
  --authrpc.jwtsecret $JWT_SECRET_PATH \
  --authrpc.vhosts "*" \
  --datadir $ETH_DATA_DIR \
  --ipcpath "$IPC_PATH"