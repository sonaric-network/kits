#!/bin/sh

source /home/config.toml

DISABLE_P2P_SYNC=$P2P_SYNC

set -eou pipefail


if [ "$DISABLE_P2P_SYNC" = "false" ]; then
    exec taiko-client driver \
        --l1.ws "$L1_WS_RPC" \
        --l1.beacon "$L1_BEACON_API" \
        --l2.ws "ws://$NODE_WS:8546" \
        --l2.auth "http://$NODE_AUTHRPC:8551" \
        --taikoL1 "$TAIKO_L1_ADDRESS" \
        --taikoL2 "$TAIKO_L2_ADDRESS" \
        --jwtSecret /data/taiko-geth/geth/jwtsecret \
        --p2p.sync \
        --p2p.checkPointSyncUrl "$P2P_SYNC_URL"


else
    exec taiko-client driver \
        --l1.ws "$L1_WS_RPC" \
        --l1.beacon "$L1_BEACON_API" \
        --l2.ws "ws://$NODE_WS:8546" \
        --l2.auth "http://$NODE_AUTHRPC:8551" \
        --taikoL1 "$TAIKO_L1_ADDRESS" \
        --taikoL2 "$TAIKO_L2_ADDRESS" \
        --jwtSecret /data/taiko-geth/geth/jwtsecret \

fi
