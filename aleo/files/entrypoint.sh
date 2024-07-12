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
  RPC_PORT="0.0.0.0:3030"
fi

# if no log level was provided, use the default
if [[ -z ${LOGLEVEL+a} ]]; then
  LOGLEVEL="1"
fi

# if no function was provided
if [[ -z ${FUNC+a} ]]; then
  FUNC="client"
fi

# if no Aleo address was provided
if [[ -z ${ALEO_PRIVKEY+a} ]]; then
  ALEO_PRIVKEY="$(/aleo/bin/snarkos account new | grep APrivateKey1 | awk '{ print $3; }')"
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
