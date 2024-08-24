#!/bin/sh

# Default values for holesky configuration
holesky_eth_rpc_url="https://endpoints.omniatech.io/v1/eth/holesky/public"
holesky_el_delegation_manager_address="0xA44151489861Fe9e3055d95adC98FbD462B948e7"
holesky_chain_id=17000
# Default values for mainnet configuration
mainnet_eth_rpc_url="https://endpoints.omniatech.io/v1/eth/mainnet/public"
mainnet_el_delegation_manager_address="0x39053D51B77DC0d36036Fc1fCc8Cb819df8Ef37A"
mainnet_chain_id=1
# Default to mainnet configuration
chain=$1
metadata_url=$2
eth_rpc_url=$mainnet_eth_rpc_url # TODO: consider case when it's own ethereum node (local)
el_delegation_manager_address=$mainnet_el_delegation_manager_address
chain_id=$mainnet_chain_id


# Select the appropriate configuration based on the chain argument
if [ "$chain" = "mainnet" ]; then
  # Use mainnet configuration (this is already the default, so no changes needed here)
  :
elif [ "$chain" = "testnet" ]; then
    eth_rpc_url=$holesky_eth_rpc_url
    el_delegation_manager_address=$holesky_el_delegation_manager_address
    chain_id=$holesky_chain_id
else
    echo "Unknown chain: $chain"
    exit 1
fi

# Other configurations
signer_type="local_keystore"
key_file="/keys/ecdsa_key.json"
operator_address=$(jq -r '.address' "$key_file")
config_file="/app/operator-config/operator.yaml"

if [ -f $config_file ]; then
    file_exists=true
fi

# Generate the operator.yaml file
cat <<EOF > $config_file
operator:
    address: 0x$operator_address
    delegation_approver_address: "0x0000000000000000000000000000000000000000"
    staker_opt_out_window_blocks: 0
    metadata_url: "$metadata_url"
el_delegation_manager_address: ${el_delegation_manager_address}
eth_rpc_url: ${eth_rpc_url}
chain_id: ${chain_id}
private_key_store_path: $key_file
signer_type: ${signer_type}
fireblocks:
    api_key: ""
    secret_key: ""
    base_url: ""
    vault_account_name: ""
    secret_storage_type: ""
    aws_region: ""
    timeout: 0
web3:
    url: ""
EOF

if [ "$file_exists" = true ]; then
    echo "Operator config has been updated for $chain."
else
    echo "Operator config has been generated for $chain."
fi


