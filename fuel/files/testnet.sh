#!/usr/bin/env bash
  set -euo pipefail

  apt update
  DEBIAN_FRONTEND=noninteractive apt-get install -y tzdata git curl jq tmux expect
  curl https://install.fuel.network | sh

  export PATH="${HOME}/.fuelup/bin:${PATH}"
  P2P_PRIVATE_KEY=$(fuel-core-keygen new --key-type peering | jq -r '.secret')

  if [ -z "$PRIVATE_KEY" ]; then
    echo "PRIVATE_KEY is empty. Creating new wallet and account..."
    WALLET_OUTPUT_FILE="forc_wallet_output.txt"
    ACCOUNT_OUTPUT_FILE="forc_wallet_account.txt"

    tmux new-session -d -s wallet_account_session
   tmux send-keys -t wallet_account_session "/root/.fuelup/bin/forc-wallet new" Enter
   sleep 1
   tmux send-keys -t wallet_account_session "$PASSWORD" Enter
   sleep 1
   tmux send-keys -t wallet_account_session "$PASSWORD" Enter
   sleep 2

   WALLET_OUTPUT=$(tmux capture-pane -t wallet_account_session -p)
   echo "$WALLET_OUTPUT" > "$WALLET_OUTPUT_FILE"
   tmux kill-session -t wallet_account_session
   echo "Wallet creation output saved to $WALLET_OUTPUT_FILE"

   ACCOUNT_OUTPUT=$(/root/forc_wallet_account.exp $PASSWORD)

   echo "$ACCOUNT_OUTPUT" > "$ACCOUNT_OUTPUT_FILE"

   echo "Account creation output saved to $ACCOUNT_OUTPUT"
  fi

  ulimit -S -n 32768

  fuel-core run \
  --service-name=fuel-sepolia-testnet-node \
  --keypair $P2P_PRIVATE_KEY \
  --relayer $ETHEREUM_RPC_ENDPOINT \
  --ip=0.0.0.0 --port=4000 --peering-port=30333 \
  --db-path=~/.fuel-sepolia-testnet \
  --utxo-validation --poa-instant false --enable-p2p \
  --reserved-nodes /dns4/p2p-testnet.fuel.network/tcp/30333/p2p/16Uiu2HAmDxoChB7AheKNvCVpD4PHJwuDGn8rifMBEHmEynGHvHrf \
  --sync-header-batch-size 100 \
  --enable-relayer \
  --relayer-v2-listening-contracts=0x01855B78C1f8868DE70e84507ec735983bf262dA \
  --relayer-da-deploy-height=5827607 \
  --relayer-log-page-size=500 \
  --sync-block-stream-buffer-size 30