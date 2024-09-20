# Sonaric Beacon-Kit Documentation

## Table of Contents
- [Overview](#overview)
- [System Requirements](#system-requirements)
- [Getting Started](#getting-started)
    - [Load Templates](#load-templates)
    - [Configuration](#configuration)
- [Running Node](#run-beacon-kit)
- [Logs](#logs)
- [Stop, remove and clean up](#stop-remove-and-clean-up)
- [Template Actions](#template-actions)
    - [Export jwt](#export-jwt)
- [Documentation and API References](#documentation-and-api-references)

## Overview
Beacon-Kit is a set of tools and services that allow you to run a beacon node on the Rollup network. Beacon-Kit is a part of the Rollup network and is used to run a beacon node. Beacon-Kit is a set of tools and services that allow you to run a beacon node on the Rollup network. Beacon-Kit is a part of the Rollup network and is used to run a beacon node. Beacon-Kit is a set of tools and services that allow you to run a beacon node on the Rollup network. Beacon-Kit is a part of the Rollup network and is used to run a beacon node. Beacon-Kit is a set of tools and services that allow you to run a beacon node on the Rollup network. Beacon-Kit is a part of the Rollup network and is used to run a beacon node. Beacon-Kit is a set of tools and services that allow you to run a beacon node on the Rollup network. Beacon-Kit is a part of the Rollup network and is used to run a beacon node. Beacon-Kit is a set of tools and services that allow you to run a beacon node on the Rollup network. Beacon-Kit is a part of the Rollup network and is used to run a beacon node. Beacon-Kit is a set of tools and services that allow you to run a beacon node on the Rollup network. Beacon-Kit is a part of the Rollup network and is used to run a beacon node. Beacon-Kit is a set of tools and services that allow you to run a beacon node on the Rollup network. Beacon-Kit is a part of the Rollup network and is used to run a beacon node. Beacon-Kit is a set of tools and services that allow you to run a beacon node on the Rollup network. Beacon-Kit is a part of the Rollup network and is used to run a beacon node.

## System Requirements
Hardware configuration required to set up an Beacon-Kit node:

| Component | Minimum | 
|-----------|---------|
| RAM       | 48GB    |
| CPU (amd64/x86 architecture)| 8 core  |
| Storage (SSD) | 1 TB    |


## Getting Started

### Load Templates
```bash
sonaric load beacon-kit
```

**Confirm templates are loaded:**
```bash
foo@bar:~$ sonaric list beacon-kit
```
```
✔ Got the list
Repository  Template              Version  Type      Tags
local       beacon-kit/geth       -        runnable  -
local       beacon-kit/rollkit    1.0.0    runnable  -
local       beacon-kit/testnet    -        group     -
```


### Configuration
Template variables can be set to customize the node's behavior. The following variables can be configured:

| Name         | Type   | Description | Default Value                                                                   |
|--------------|--------|-------------|---------------------------------------------------------------------------------|
| `jwt-secret` | string |             | `""`                                                                    |



### Run Beacon-Kit

Run a testnet using:
```bash
sonaric run templates/local/beacon-kit/testnet
```

```bash
✔ Started local/beacon-kit/testnet
🔩 templates/local/beacon-kit/testnet
 ├─🧊 Peer test-oleksii-1
 │  └─🔩 templates/local/beacon-kit/geth
 │     └─📦 300618bf8bf24c164a03b751beabdf7d-kit-geth-geth-container running
 │        ├─🧩 ethereum/client-go:latest
 │        ├─💾 /var/lib/monkd/volumes/geth -> /geth
 │        ├─🔌 open (public) 35.204.193.202:8551 -> 8551
 │        ├─🔌 open (public) 35.204.193.202:8545 -> 8545
 │        └─🔌 open (public) 35.204.193.202:30303 -> 30303
 └─🧊 Peer test-oleksii-3
    └─🔩 templates/local/beacon-kit/beacon-kit
       └─📦 73edc6f03da2e4eab540bfacd1d652da-t-beacon-kit-beacon-kit running
          ├─🧩 ghcr.io/berachain/beacon-kit:latest
          ├─💾 /var/lib/monkd/volumes/rollkit -> /geth/config
          ├─💾 /var/lib/monkd/volumes/rollkit -> /geth
          ├─🔌 open (public) 34.147.10.46:26656 -> 26656
          └─🔌 open (public) udp 34.147.10.46:26656 -> 26656
```

### logs
```bash
sonaric logs beacon-kit/testnet
```

```bash
3:30PM INF starting services module=beacon-kit num=6 service=service-registry
3:30PM INF starting service module=beacon-kit service=service-registry type=validator
3:30PM INF starting validator service 🛜  module=beacon-kit optimistic_payload_builds=true service=validator
3:30PM INF starting service module=beacon-kit service=service-registry type=blockchain
3:30PM INF starting service module=beacon-kit service=service-registry type=deposit-handler
3:30PM INF starting service module=beacon-kit service=service-registry type=engine-client
3:30PM INF waiting for execution client to start 🍺🕔 dial_url=http://geth.beacon-kit.rollkit.monk:8551 module=server service=engine.client
3:30PM INF connected to execution client 🔌 chain_id=80084 dial_url=http://geth.beacon-kit.rollkit.monk:8551 module=server required_chain_id=80084 service=engine.client
3:30PM INF exchanged capability capability=engine_forkchoiceUpdatedV1 module=server service=engine.client
3:30PM INF exchanged capability capability=engine_forkchoiceUpdatedV2 module=server service=engine.client
3:30PM INF exchanged capability capability=engine_forkchoiceUpdatedV3 module=server service=engine.client
3:30PM INF exchanged capability capability=engine_exchangeTransitionConfigurationV1 module=server service=engine.client
3:30PM INF exchanged capability capability=engine_getPayloadV1 module=server service=engine.client
3:30PM INF exchanged capability capability=engine_getPayloadV2 module=server service=engine.client
3:30PM INF exchanged capability capability=engine_getPayloadV3 module=server service=engine.client
3:30PM INF exchanged capability capability=engine_newPayloadV1 module=server service=engine.client
3:30PM INF exchanged capability capability=engine_newPayloadV2 module=server service=engine.client
3:30PM INF exchanged capability capability=engine_newPayloadV3 module=server service=engine.client
3:30PM INF exchanged capability capability=engine_getPayloadBodiesByHashV1 module=server service=engine.client
3:30PM INF exchanged capability capability=engine_getPayloadBodiesByRangeV1 module=server service=engine.client
3:30PM INF exchanged capability capability=engine_getClientVersionV1 module=server service=engine.client
3:30PM INF starting service module=beacon-kit service=service-registry type=reporting
3:30PM INF this node is running beacon-kit software module=beacon-kit version=
3:30PM INF starting service module=beacon-kit service=service-registry type=db-manager
3:30PM INF starting JWT refresh loop 🔄 module=server service=engine.client
3:30PM INF starting node with ABCI CometBFT in-process module=server
3:30PM INF State store key layout version  module=server version=vv1
3:30PM INF Blockstore version module=server version=v1
```

### Stop, remove and clean up
Stop:
```bash
sonaric stop beacon-kit/testnet
```
Purge:
```bash
sonaric purge beacon-kit/testnet
```

## Template Actions

### Export jwt
Export the JWT secret for the beacon-kit node.
```bash
sonaric do templates/local/beacon-kit/testnet/geth/export-jwt
```
Example output:
```
✔ Running action:
072e366d2036955f0a9466da2543e7c5a70b163f52aa112b9ecfd8c113f8688f
```


## Documentation and API References
Access detailed API documentation and examples:
- [Beacon-Kit Documentation](https://rollkit.dev/tutorials/beaconkit)
- [Beacon-Kit GitHub](https://github.com/rollkit/beacon-kit)
```
