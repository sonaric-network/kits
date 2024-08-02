#!/bin/bash

{
  echo $PASSPHRASE
  echo $PASSPHRASE
  echo $PASSPHRASE
} | livepeer -network mainnet -orchestrator -transcoder -maxSessions 16 -orchSecret asdf -ethUrl https://eth.public-rpc.com -pricePerUnit 800 -serviceAddr $NODE_IP:8935
sleep 90000000