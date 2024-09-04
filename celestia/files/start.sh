#!/bin/bash

extra_args="--rpc.addr 0.0.0.0 --keyring.accname sonaric-celestia-key"

case $P2P_NETWORK in
  "arabica")
    keypath="/home/celestia/.celestia-$NODE_TYPE-arabica-11/keys/keyring-test"
   # TODO: rename keyring.accname to keyring.keyname when image version is updated
    ;;
  "mocha")
    keypath="/home/celestia/.celestia-$NODE_TYPE-mocha-4/keys/keyring-test"
    ;;
  *)
    keypath="/home/celestia/.celestia-$NODE_TYPE/keys/keyring-test"
    ;;
esac

if find $keypath -name "sonaric-celestia-key.info" -print -quit > /dev/null 2>&1; then
    echo "Private key exists"
else
    echo "Creating Sonaric private key"
    cel-key add sonaric-celestia-key --keyring-backend test --node.type $NODE_TYPE --p2p.network $P2P_NETWORK
    echo "Sonaric private key created"
fi


celestia $NODE_TYPE init --p2p.network $P2P_NETWORK
find $keypath -type f -exec chmod 600 {} \;
echo "celestia $NODE_TYPE start --p2p.network $P2P_NETWORK --core.ip $RPC_URL $extra_args"
celestia $NODE_TYPE start --p2p.network $P2P_NETWORK --core.ip $RPC_URL $extra_args