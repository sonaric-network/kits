#!/bin/sh
  beacond init $MONIKER_NAME --chain-id bartio-beacon-80084 --consensus-key-algo bls12_381 --home /bin/config/beacond;

  curl -o "/bin/config/beacond/config/genesis.json" "https://raw.githubusercontent.com/berachain/beacon-kit/main/testing/networks/80084/genesis.json";
  curl -o "/bin/config/beacond/kzg-trusted-setup.json" "https://raw.githubusercontent.com/berachain/beacon-kit/main/testing/networks/80084/kzg-trusted-setup.json";
  curl -o "/bin/config/beacond/config/app.toml" "https://raw.githubusercontent.com/berachain/beacon-kit/main/testing/networks/80084/app.toml";
  curl -o "/bin/config/beacond/config/config.toml" "https://raw.githubusercontent.com/berachain/beacon-kit/main/testing/networks/80084/config.toml";

  sed -i "s|^moniker = \".*\"|moniker = \"$MONIKER_NAME\"|" "/bin/config/beacond/config/config.toml"
  sed -i "s|^rpc-dial-url = \".*\"|rpc-dial-url = \"http://$GETH_HOST:$GETH_PORT\"|" "/bin/config/beacond/config/app.toml"

  sed -i "s|^jwt-secret-path = \".*\"|jwt-secret-path = \"/bin/config/beacond/jwt.hex\"|" "/bin/config/beacond/config/app.toml"
  sed -i "s|^trusted-setup-path = \".*\"|trusted-setup-path = \"/bin/config/beacond/kzg-trusted-setup.json\"|" "/bin/config/beacond/config/app.toml"

  seeds_url="https://raw.githubusercontent.com/berachain/beacon-kit/main/testing/networks/80084/cl-seeds.txt"
  seeds=$(curl -s "$seeds_url" | tail -n +2 | tr '\n' ',' | sed 's/,$//')
  sed -i "s/^seeds = \".*\"/seeds = \"$seeds\"/" "/bin/config/beacond/config/config.toml"

  sed -i "s/^persistent_peers = \".*\"/persistent_peers = \"$seeds\"/" "/bin/config/beacond/config/config.toml"

  beacond jwt generate -o /bin/config/beacond/jwt.hex;

  if [ "$DOWNLOAD_SNAPSHOTS" = true ]; then
    wget -O berachain_v2_testnet_4745496.tar.lz4 https://support.synergynodes.com/snapshots/berachain_v2_testnet/berachain_v2_testnet_4745496.tar.lz4
    mv berachain_v2_testnet_4745496.tar.lz4 ./snapshots/berachain_v2_testnet_4745496.tar.lz4

    lz4 -dc < ./snapshots/berachain_v2_testnet_4745496.tar.lz4 | tar xvf - -C ./snapshots/tmp/beacond
    lz4 -dc < ./snapshots/berachain_v2_testnet_4745496.tar.lz4 | tar xvf - -C ./snapshots/tmp/reth

    mv ./snapshots/tmp/beacond/data /bin/config/beacond/data
    mv ./snapshots/tmp/reth/blobstore /bin/config/reth/blobstore
    mv ./snapshots/tmp/reth/db /bin/config/reth/db
    mv ./snapshots/tmp/reth/static_files /bin/config/reth/static_files
  fi

  beacond start --minimum-gas-prices "0.01photino" --home /bin/config/beacond
