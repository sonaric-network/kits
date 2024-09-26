#!/bin/sh
set -e

# install only if not already installed
if ! command -v jq > /dev/null 2>&1; then
  apk add --no-cache openssl jq
fi

CHAINID="reacond-2061"
MONIKER="localtestnet"
LOGLEVEL="info"
TRACE=""
CONSENSUS_KEY_ALGO="bls12_381"
HOMEDIR="/beacond/home"
mkdir -p $HOMEDIR/config

GENESIS=$HOMEDIR/config/genesis.json

ETH_GENESIS="/geth/eth-genesis.json"

JWT_SECRET_PATH="/geth/jwtsecret"
# download necessary files and initialize beacond
if [ ! -f "$HOMEDIR/config/app.toml" ]; then
  echo "Downloading config files..."
  curl -o "$HOMEDIR/config/app.toml" "https://raw.githubusercontent.com/berachain/beacon-kit/rollkit-int/testing/networks/80084/app.toml"
  sed -i "s|^jwt-secret-path = \".*\"|jwt-secret-path = \"$JWT_SECRET_PATH\"|" "$HOMEDIR/config/app.toml"
  if [ -n "$RPC_DIAL_URL" ]; then
    sed -i "s|^rpc-dial-url = \".*\"|rpc-dial-url = \"$RPC_DIAL_URL\"|" "$HOMEDIR/config/app.toml"
  fi
  sed -i "s|^rpc-timeout = \".*\"|rpc-timeout = \"5s\"|" "$HOMEDIR/config/app.toml"

  curl -o "$HOMEDIR/config/kzg-trusted-setup.json" "https://raw.githubusercontent.com/berachain/beacon-kit/rollkit-int/testing/networks/80084/kzg-trusted-setup.json"
  sed -i "s|^trusted-setup-path = \".*\"|trusted-setup-path = \"$HOMEDIR/config/kzg-trusted-setup.json\"|" "$HOMEDIR/config/app.toml"

  echo "Initializing genesis.json"
  beacond init $MONIKER \
  --chain-id $CHAINID \
  --home $HOMEDIR \
  --consensus-key-algo $CONSENSUS_KEY_ALGO
  echo "Adding premined deposit..."
  beacond genesis add-premined-deposit --home $HOMEDIR
  beacond genesis collect-premined-deposits --home $HOMEDIR
  beacond genesis execution-payload "$ETH_GENESIS" --home $HOMEDIR

  echo "setting up validator config"
  ADDRESS=$(jq -r '.address' $HOMEDIR/config/priv_validator_key.json)
  PUB_KEY=$(jq -r '.pub_key' $HOMEDIR/config/priv_validator_key.json)
  jq --argjson pubKey "$PUB_KEY" '.consensus["validators"]=[{"address": "'$ADDRESS'", "pub_key": $pubKey, "power": "32000000000", "name": "Rollkit Sequencer"}]' $GENESIS > temp.json && mv temp.json $GENESIS
fi

BEACON_START_CMD="beacond start --pruning=nothing "$TRACE" \
--log_level $LOGLEVEL --api.enabled-unsafe-cors \
--rollkit.aggregator --rollkit.da_address $DA_ADDRESS \
--rpc.laddr tcp://0.0.0.0:36657 --grpc.address 0.0.0.0:9290 --p2p.laddr 0.0.0.0:36656 \
--api.enable --api.swagger --minimum-gas-prices=0.0001abgt \
--home $HOMEDIR --beacon-kit.engine.jwt-secret-path ${JWT_SECRET_PATH}"


if [ -n "$DA_AUTH_TOKEN" ]; then
  BEACON_START_CMD="$BEACON_START_CMD --rollkit.da_auth_token $DA_AUTH_TOKEN"
else
  echo "DA_AUTH_TOKEN is not set"
fi

if [ -n "$DA_NAMESPACE" ]; then
  echo "DA_ADDRESS: $DA_ADDRESS"
  DA_BLOCK_HEIGHT=$(curl https://rpc-mocha.pops.one/block | jq -r '.result.block.header.height')
  echo "DA_BLOCK_HEIGHT: $DA_BLOCK_HEIGHT"
  BEACON_START_CMD="$BEACON_START_CMD --rollkit.da_namespace $DA_NAMESPACE --rollkit.da_start_height $DA_BLOCK_HEIGHT"
else
  echo "DA_NAMESPACE is not set"
fi




# Conditionally add the rpc-dial-url flag if RPC_DIAL_URL is not empty
if [ -n "$RPC_DIAL_URL" ]; then
  # this will overwrite the default dial url
  BEACON_START_CMD="$BEACON_START_CMD --beacon-kit.engine.rpc-dial-url ${RPC_DIAL_URL}"
fi
echo "Starting beacon node..."
eval $BEACON_START_CMD

