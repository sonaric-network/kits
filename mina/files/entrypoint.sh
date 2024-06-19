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
if [ -f "/keys/sonaric-mina-key" ]; then
    echo "private key exists"
else
    echo "creating private key"
    mina-generate-keypair --privkey-path /keys/sonaric-mina-key
    echo "private key created"
    chmod 600 /keys/sonaric-mina-key
fi

# Check if libp2p key exists
if [ -f "/keys/sonaric-mina-libp2p-key" ]; then
    echo "libp2p key found"
else
    echo "creating libp2p key"
    mina libp2p generate-keypair --privkey-path /keys/sonaric-mina-libp2p-key
    echo "libp2p key created"
    chmod 600 /keys/sonaric-mina-libp2p-key
fi


check_existing_accounts() {
    local accounts
    accounts=$(mina accounts list 2>&1)
    if [[ "$accounts" == *"You have no tracked accounts!"* ]]; then
        echo "no"
    else
        echo "yes"
    fi
}

# Check if there are existing accounts
existing_accounts=$(check_existing_accounts)
if [ "$existing_accounts" == "no" ]; then
    echo "No existing accounts found. Importing default key."
    mina accounts import --privkey-path /keys/sonaric-mina-key
    echo "Default key imported."
else
    echo "Existing accounts found. No need to import the default key."
fi

# start mina daemon

# print mina daemon start command
exec mina daemon --peer-list-url $PEER_LIST_URL \
            --libp2p-keypair /keys/sonaric-mina-libp2p-key \
            --log-level ${LOG_LEVEL} \
            --file-log-level ${FILE_LOG_LEVEL} ${EXTRA_FLAGS}