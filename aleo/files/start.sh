#!/bin/bash
# running the Aleo MAINNET snarkOS in a container

# check if environment variables are set
if [[ -z ${RUST_LOG+a} ]]; then
  RUST_LOG=debug
fi

# if no ip and port to bind were provided, bond to all on default port
if [[ -z ${SNARKOS_PORT+a} ]]; then
  SNARKOS_PORT="0.0.0.0:4130"
fi

# if no rest api port was provided
if [[ -z ${RPC_PORT+a} ]]; then
  RPC_PORT="0.0.0.0:3033"
fi

# if no log level was provided, use the default
if [[ -z ${LOGLEVEL+a} ]]; then
  LOGLEVEL="1"
fi

# if no function was provided
if [[ -z ${FUNC+a} ]]; then
  FUNC="client"
fi


# Setup key directory and file
KEY_DIR="/aleo/keys"
mkdir -p ${KEY_DIR}
KEY_FILE="${KEY_DIR}/aleo_keys.txt"

# First, check if a private key environment variable is provided
if [ ! -z "${ALEO_PRIVKEY}" ]; then
    echo "Using provided environment variable ALEO_PRIVKEY."
else
    # Generate or use existing keys if environment variable is not set
    if [ ! -f "${KEY_FILE}" ]; then
        echo "No key file found. Generating new key..."
        OUTPUT=$(/aleo/bin/snarkos account new)

        # Using 'sed' to extract keys to avoid complexities with 'awk'
        echo "PrivateKey: $(echo "${OUTPUT}" | grep 'Private Key' | sed -n 's/.*Private Key  //p')" > ${KEY_FILE}
        echo "ViewKey: $(echo "${OUTPUT}" | grep 'View Key' | sed -n 's/.*View Key  //p')" >> ${KEY_FILE}
        echo "Address: $(echo "${OUTPUT}" | grep 'Address' | sed -n 's/.*Address  //p')" >> ${KEY_FILE}
        chmod 600 ${KEY_FILE}
        ALEO_PRIVKEY=$(grep 'PrivateKey' ${KEY_FILE} | cut -d ' ' -f2)
        echo "Account key generated."
    else
        # Load keys from file
        echo "Using existing key from ${KEY_FILE}."
        ALEO_PRIVKEY=$(grep 'PrivateKey' ${KEY_FILE} | cut -d ' ' -f2)
    fi
fi


# if peers not were provided
if [[ -z ${PEERS+a} ]]; then
  COMMON_PARAMS=" --nocdn --nodisplay --logfile /dev/null --node ${SNARKOS_PORT} --rest ${RPC_PORT} --verbosity ${LOGLEVEL} --private-key ${ALEO_PRIVKEY}"
else
  COMMON_PARAMS=" --nocdn --nodisplay --logfile /dev/null --node ${SNARKOS_PORT} --rest ${RPC_PORT} --verbosity ${LOGLEVEL} --private-key ${ALEO_PRIVKEY} --peers ${PEERS}"
fi

case ${FUNC} in
  validator)
    /aleo/bin/snarkos start --bft ${BFT_PORT} --validators ${VALIDATORS} --validator ${COMMON_PARAMS}
    ;;

  prover)
    /aleo/bin/snarkos start --allow-external-peers --prover ${COMMON_PARAMS}
    ;;

  client)
    /aleo/bin/snarkos start --allow-external-peers --client ${COMMON_PARAMS}
    ;;

  *)
    /aleo/bin/snarkos start --allow-external-peers --client ${COMMON_PARAMS}
    ;;
esac