#!/bin/bash

pubkey=$(
  echo "$PASSWORD" \
  | 0gchaind keys list 2>/dev/null \
  | awk -F 'pubkey: ' '/pubkey:/ {print $2}' \
  | sed "s/^'//;s/'\$//"
)
echo pubkey: $pubkey
echo $PASSWORD | 0gchaind tx staking create-validator --amount=${STAKING_AMOUNT}ua0gi --pubkey='{"@type":"/ethermint.crypto.v1.ethsecp256k1.PubKey","key":"A+zENlcxlv4tecDPs/pBAm4rMBn++KetVzN02dWhnytb"}' --moniker="$VALIDATOR_NAME" --chain-id="$CHAIN_ID" --details "$VALIDATOR_DESCRIPTION" --commission-rate="0.10" --commission-max-rate="0.20" --commission-max-change-rate="0.01" --min-self-delegation="1" --from=$KEY_NAME --gas=auto --gas-adjustment=1.4

0gchaind q staking validators -o json --limit=1000 | jq '.validators[] | select(.status=="BOND_STATUS_BONDED")' | jq -r '.tokens + " - " + .description.moniker' | sort -gr | nl

