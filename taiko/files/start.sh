#!/bin/sh

source /home/config.toml

#echo $NODE_IP


#geth --taiko --networkid "$CHAIN_ID" --gcmode archive --datadir /data/taiko-geth --metrics --metrics.addr "0.0.0.0" --bootnodes $BOOT_NODES --authrpc.addr "0.0.0.0" --http.port 8551 --authrpc.vhosts "*" --http --http.api debug,eth,net,web3,txpool,taiko --http.addr "0.0.0.0" --http.vhosts "*" --ws --ws.api debug,eth,net,web3,txpool,taiko --ws.addr "0.0.0.0" --ws.origins "*" --gpo.defaultprice "10000000" --port $PORT_L2_EXECUTION_ENGINE_P2P --discovery.port $PORT_L2_EXECUTION_ENGINE_P2P --maxpeers $MAXPEERS 50 --maxpendpeers $MAXPENDPEERS 0 $GETH_ADDITIONAL_ARGS

geth \
  --taiko \
  --networkid "$CHAIN_ID" \
  --gcmode archive \
  --datadir ./data/taiko-geth \
  --metrics \
  --metrics.expensive \
  --metrics.addr "0.0.0.0" \
  --bootnodes $BOOT_NODES \
  --authrpc.addr "0.0.0.0" \
  --authrpc.port 8551 \
  --authrpc.vhosts "*" \
  --authrpc.jwtsecret ./data/taiko-geth/geth/jwtsecret \
  --http \
  --http.api admin,debug,eth,net,web3,txpool,miner,taiko \
  --http.addr "0.0.0.0" \
  --http.port 8545 \
  --http.vhosts "*" \
  --ws \
  --ws.api admin,debug,eth,net,web3,txpool,miner,taiko \
  --ws.addr "0.0.0.0" \
  --ws.port 8546 \
  --ws.origins "*" \
  --gpo.defaultprice "10000000" \
  --port $PORT_L2_EXECUTION_ENGINE_P2P \
  --syncmode full \
  --state.scheme=path
