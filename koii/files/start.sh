#!/bin/bash

source /home/config.env

apt install expect curl -y
sh -c "$(curl -sSfL https://raw.githubusercontent.com/koii-network/k2-release/master/k2-install-init.sh)"
export PATH="/root/.local/share/koii/install/active_release/bin:$PATH"
koii config set -k $WALLET_LOCATION

if [ ! -f "/app/config/id.json" ]; then
    if [ -n "$PRIVATE_KEY" ]; then
        echo "$PRIVATE_KEY" > /app/config/id.json
    else
        /home/keygen.sh "$SEED_PHRASE"
    fi
fi

WALLET_LOCATION=$WALLET_LOCATION yarn initialize-start