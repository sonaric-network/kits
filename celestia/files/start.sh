#!/bin/bash
if find /home/celestia/.celestia-$NODE_TYPE-$P2P_NETWORK*/keys/keyring-test -name "sonaric-celestia-key.info" -print -quit > /dev/null 2>&1; then
    cat /home/celestia/.celestia-.celestia-bridge-arabica-11/keys/keyring-test/sonaric-celestia-key.info
    echo "Private key exists"
else
    cel-key add sonaric-celestia-key --keyring-backend test --node.type $NODE_TYPE --p2p.network $P2P_NETWORK
    echo "Sonaric private key created"
fi
celestia $NODE_TYPE init --p2p.network $P2P_NETWORK --core.ip $RPC_URL
find /home/celestia/.celestia-*/keys -type f -exec chmod 600 {} \;
celestia $NODE_TYPE start --p2p.network $P2P_NETWORK --core.ip $RPC_URL --keyring.accname sonaric-celestia-key