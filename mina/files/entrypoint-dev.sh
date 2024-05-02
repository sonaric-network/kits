#!/bin/bash
set -e

# Check if MINA_PRIVKEY_PASS is not set or empty
if [ -z "${MINA_PRIVKEY_PASS+x}" ]; then
    echo "MINA_PRIVKEY_PASS is not set or empty. Exiting."
    exit 1
fi

# Check if MINA_LIBP2P_PASS is not set or empty
if [ -z "${MINA_LIBP2P_PASS+x}" ]; then
    echo "MINA_LIBP2P_PASS is not set or empty. Exiting."
    exit 1
fi

chmod 700 /keys

# Check if private key exists
if [ -f "/keys/monk-mina-key" ]; then
    echo "private key exists"
else
    echo "creating private key"
    mina-generate-keypair --privkey-path /keys/monk-mina-key
    echo "private key created"
fi

mina-validate-keypair --privkey-path /keys/monk-mina-key

# Check if libp2p key exists
if [ -f "/keys/monk-mina-libp2p-key" ]; then
    echo "libp2p key found"
else
    echo "creating libp2p key"
    mina libp2p generate-keypair --privkey-path /keys/monk-mina-libp2p-key
    echo "libp2p key created"
fi

# start mina daemon
mina daemon --peer-list-url $PEER_LIST_URL \
            --block-producer-key /keys/monk-mina-key \
            --libp2p-keypair /keys/monk-mina-libp2p-key \
            --log-level ${LOG_LEVEL} \
            --file-log-level ${FILE_LOG_LEVEL}
