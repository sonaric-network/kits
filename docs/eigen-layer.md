# Sonaric Eigen Layer Documentation

## Table of Contents
- [Overview](#overview)
- [Load Template](#load-template)
  - [Confirm templates loaded](#confirm-templates-loaded)
  - [Configuration](#configuration)
- [Run eigen-layer](#run-eigen-layer)
- [Template Actions](#template-actions)
  - [Export key](#export-key)
  - [Import key](#import-key)
    - [BLS](#bls)
    - [ECDSA](#ecdsa)
  - [List keys](#list-keys)
  - [Operator actions](#operator-actions)
    - [Init operator](#init-operator)
    - [Register operator](#register-operator)
    - [Update operator](#update-operator)
    - [Operator status](#operator-status)
- [Troubleshooting](#troubleshooting)
- [Documentation and API References](#documentation-and-api-references)

## Overview
EigenDA is a secure, high-throughput, and decentralized data availability (DA) service built on top of Ethereum using the EigenLayer restaking primitives.


## Load Template
```bash
cd eigen-layer
sonaric load MANIFEST
```
### Confirm templates loaded
```bash

foo@bar:~$ sonaric list eigen-layer
✔ Got the list
Repository  Template             Version  Type      Tags             
local       eigen-layer/mainnet  1.0      runnable  blockchain, evm  
local       eigen-layer/testnet  1.0      runnable  blockchain, evm 

```
## Configuration
Template variables can be set to customize the node's behavior. The following variables can be configured:

| Name                 | Type   | Description                                                                                     | Default Value |
|----------------------|--------|-------------------------------------------------------------------------------------------------|---------------|
| `enable-node-api`    | string | whether enable node API access                                                                  | `true`        |
| `enable-metrics`     | string | whether enable eth API access                                                                   | `true`        |
| `metrics-port`       | string | port for metrics                                                                                | `9092`        |
| `api-port`           | string | port for node API                                                                               | `9091`        |
| `bls-key-password`   | string | BLS private key password                                                                        | `""`          |
| `ecdsa-key-password` | string | ECDSA private key password                                                                      | `""`          |
| `test-mode`          | string | whether to run as test mode                                                                     | `false`       |
| `num-workers`        | int    | Number of workers to run                                                                        | `1`           |
| `verbose`            | bool   | Enable to see verbose output for encoding/decoding                                              | `false`       |
| `log-level`          | string | The lowest log level that will be output. Accepted options are 'debug', 'info', 'warn', 'error' | `info`        |

## Run eigen-layer

All the examples here and below are based on the `eigen-layer/testnet` template. You can replace `eigen-layer/testnet` with `eigen-layer/mainnet` if you want to run the mainnet template.

While running `eigen-layer/testnet` template, operator MUST provide own bls and ecdsa passwords for keys generation. The keys are stored in the `~/.eigenlayer/operator_keys` directory. 
You can replace generated keys with your own using [import key action](#import-key) and export the keys using [export key action](#export-key). 

```bash
sonaric run -s bls-key-password=<bls-password> -s ecdsa-key-password=<ecdsa-password> eigen-layer/testnet
```

Output:

```bash
🔩 templates/local/eigen-layer/testnet
 └─🧊 Peer local
    └─🔩 templates/local/eigen-layer/testnet 
       └─📦 local-e40f3528d8cc4bf6f81d6017b5-igen-layer-testnet-node running
          ├─🧩 eigenda-cli-node:latest                                                                            
          ├─💾 /Users/vladislavkrapivin/.monk/volumes/eigen-layer/testnet/keys -> /keys                  
          ├─💾 /Users/vladislavkrapivin/.monk/volumes/eigen-layer/testnet/operator-keys -> /root/.eigenlayer/operator_keys
          ├─💾 /Users/vladislavkrapivin/.monk/volumes/eigen-layer/testnet/resources -> /app/resources    
          ├─💾 /Users/vladislavkrapivin/.monk/volumes/eigen-layer/testnet/data -> /data                  
          ├─💾 /Users/vladislavkrapivin/.monk/volumes/eigen-layer/testnet/operator-config -> /app/operator-config
          ├─💾 /Users/vladislavkrapivin/.monk/volumes/eigen-layer/testnet/logs -> /app/logs              
          ├─🔌 open 79.110.128.98:3030 -> 3030                                                      
          ├─🔌 open 79.110.128.98:32005 -> 32005                                                    
          ├─🔌 open 79.110.128.98:9092 -> 9092                                                      
          ├─🔌 open 79.110.128.98:9091 -> 9091                                                      
          └─🔌 open 79.110.128.98:32004 -> 32004
```

### Logs
First, eigen-layer will download required resources (usually takes 5-10 minutes). It happens once.
Then it'll generate bls and ecdsa keys (if not exist).
After that, it'll start the eigen-layer node.

```bash
  sonaric logs eigen-layer/testnet -f --last 100
```

```bash
ecdsa key already exists at /keys/ecdsa_key.json
bls key already exists at /keys/bls_key.json
Key setup complete.
Downloading srs resources
g1.point already exists.
2024/08/23 19:22:33 Initializing Node
g2.point.powerOf2 already exists.
Aug 23 19:22:48.436 DBG eth/tx.go:833 Addresses component=Transactor blsOperatorStateRetrieverAddr=0xB4baAfee917fb4449f5ec64804217bccE9f46C67 eigenDAServiceManagerAddr=0xD4A7E1Bd8015057293f0D0A557088c286942e84b registryCoordinatorAddr=0x53012C69A189cfA2D9d29eb6F19B32e0A2EA3490 blsPubkeyRegistryAddr=0x066cF95c1bf0927124DFB8B02B401bc23A79730D
2024/08/23 19:22:48     Reading G1 points (4194304 bytes) takes 10.054471ms
2024/08/23 19:22:57     Parsing takes 8.86186305s
numthread 4
Aug 23 19:22:58.157 INF node/node.go:158 Creating node component=Node chainID=17000 operatorID=d4e59df1f8bd7341ae0137b8df61943036c53eef7649d734f6338902ac843346 dispersalPort=32005 retrievalPort=32004 churnerUrl=churner-holesky.eigenda.xyz:443 quorumIDs=[0] registerNodeAtStart=false pubIPCheckInterval=10s eigenDAServiceManagerAddr=0xD4A7E1Bd8015057293f0D0A557088c286942e84b blockStaleMeasure=300 storeDurationBlocks=100800
Aug 23 19:22:58.162 INF metrics/eigenmetrics.go:81 Starting metrics server at port :9092 component=EigenMetrics
Aug 23 19:22:58.163 INF node/node.go:184 Enabled metrics component=Node socket=:9092
Aug 23 19:22:58.163 INF nodeapi/nodeapi.go:104 Starting node api server at address :9091 component=NodeApi
Aug 23 19:22:58.175 INF node/node.go:188 Enabled node api component=Node port=9091
Aug 23 19:22:58.177 INF nodeapi/nodeapi.go:227 node api server running component=NodeApi addr=:9091
Aug 23 19:22:58.177 INF node/node.go:253 Start expireLoop goroutine in background to periodically remove expired batches on the node component=Node
Aug 23 19:22:58.177 INF node/node.go:224 The node has successfully started. Note: if it\'s not opted in on https://holesky.eigenlayer.xyz/avs/eigenda, then please follow the EigenDA operator guide section in docs.eigenlayer.xyz to register component=Node
Aug 23 19:22:58.181 INF node/node.go:455 Start checkCurrentNodeIp goroutine in background to detect the current public IP of the operator node component=Node
Aug 23 19:22:58.180 INF node/node.go:432 Start checkRegisteredNodeIpOnChain goroutine in background to subscribe the operator socket change events onchain component=Node
Aug 23 19:22:58.184 INF node/node.go:499 Start nodeReachabilityCheck goroutine in background to check the reachability of the operator node component=Node
Aug 23 19:22:58.190 INF grpc/server.go:100 port 32005=address [::]:32005="GRPC Listening"
Aug 23 19:22:58.190 INF grpc/server.go:125 port 32004=address [::]:32004="GRPC Listening"
Aug 23 19:23:58.188 DBG node/node.go:506 Calling reachability check component=Node url="https://dataapi-holesky.eigenda.xyz/api/v1/operators-info/port-check?operator_id=d4e59df1f8bd7341ae0137b8df61943036c53eef7649d734f6338902ac843346"
```

### Stop, remove and clean up
Stop:
```bash
sonaric stop eigen-layer/testnet
```
Purge:
```bash
sonaric purge eigen-layer/testnet
```
## Template Actions

### Export key
Prints EigenLayer ECDSA or BLS private key (type is passed as flag `key-type`).
```bash
sonaric do templates/local/eigen-layer/testnet/export-key key-type=ecdsa
```
Example output:
```bash
{"address":"cfd2ff52bbdef53bec23fe9a21a2c70d7037c405","crypto":{"cipher":"aes-128-ctr","ciphertext":"c0b93952d860b40057cdc41881ffe3c615df09f39ab1836ac5deffbf0834d418","cipherparams":{"iv":"b9675dfd8f1023da5ecaaa940dbed58d"},"kdf":"scrypt","kdfparams":{"dklen":32,"n":262144,"p":1,"r":8,"salt":"9f460e72a58a3b6001c44c66a4d20232f4c0570403af934b6b59d378a7fd7303"},"mac":"8e68a637039117b821c7d651bea2f1cbad43ec83ce4bc98c0916d3c7163af9ad"},"id":"20ade5aa-bb27-4665-b8f9-599b2bec6c84","version":3}
```

### Import key
Imports EigenLayer ECDSA or BLS private key (Arguments: `key-type` and `key`).

#### BLS
```bash
sonaric do templates/local/eigen-layer/testnet/import-key key-type=bls key=14353266338836816574789324050779154273339609213724651308056530165157325064316
```
Output:
```bash
Key imported successfully.
Public Key: E([10421304940478394117022611691529343162918714827558758100471533096501564335187,8592820887220863033324633702429607062466146678185870769761990956276757948248])
Private Key (Hex): 1435326633883681657478932405077915427333960921372465130805653016
```

#### ECDSA
```bash
sonaric do templates/local/eigen-layer/testnet/import-key key-type=ecdsa key=14353266338836816574789324050779154273339609213724651308056530165157325064316
```
Output:
```bash
Key imported successfully.
Public Key hex: 0x04d4e59df1f8bd7341ae0137b8df61943036c53eef7649d734f6338902ac843346
Ethereum Address: 0xcfd2ff52bbdef53bec23fe9a21a2c70d7037c405
Private Key (Hex): 1435326633883681657478932405077915427333960921372465130805653016
```

### List keys
Lists all keys stored (currently only one BLS and one ECDSA key are supported).
```bash
sonaric do templates/local/eigen-layer/testnet/list-keys
```

Output:
```
Key Name: bls_wallet
Key Type: BLS
Public Key: E([10421304940478394117022611691529343162918714827558758100471533096501564335187,8592820887220863033324633702429607062466146678185870769761990956276757948248])
Operator Id: 0xe618fa521f7f84c1006d26d143816bb07bb5a3ddc6173ba363c7d66dbbc6a503
Key location: /root/.eigenlayer/operator_keys/bls_wallet.bls.key.json
====================================================================================

Key Name: ecdsa_wallet
Key Type: ECDSA
Address: 0xcfd2ff52bbdef53bec23fe9a21a2c70d7037c405
Key location: /root/.eigenlayer/operator_keys/ecdsa_wallet.ecdsa.key.json
====================================================================================
```

### Operator actions
More about operator actions can be found in the [EigenLayer Operator Guide](https://docs.eigenlayer.xyz/eigenlayer/operator-guides/operator-installation#operator-configuration-and-registration).

Important! Before registering the operator, send at least 1 ETH to your “address”. 
This ETH will be used to cover the gas cost for operator registration.

For testnet, you can get test ETH from the Google faucet: https://cloud.google.com/application/web3/faucet/ethereum/holesky

Additionally, you need to provide metadata URL for the operator. You can use the following template:
https://raw.githubusercontent.com/Layr-Labs/eigenlayer-cli/master/pkg/operator/config/metadata-example.json  
Upload the logo of the operator to a publicly accessible location and set the url in your metadata.json file.   
Operator registration only supports .png images for now and must be less than 1MB in size.

The name and description should comply with the regex `^[a-zA-Z0-9 +.,;:?!'’"“”\-_/()\[\]~&#$—%]+$`. You can use services like https://regex101.com/ to validate your fields.

The metadata.json must be less than 4KB in size. Upload the file to a publicly accessible location and set that url in operator.yaml. Please note that a publicly accessible metadata url is required for successful registration.

For Mainnet Operators - the metadata.json and operator logo .png files MUST be hosted via github.com repositories specifically. Caveat: gist.github.com hosted files are not permitted. These requirements do not apply to Testnet Operators.  

When using Github for hosting please ensure you link to the raw file (example), rather than the github repo URL (example).


#### Init operator
Creates config for the operator (or updates the existing one).
```bash
sonaric do templates/local/eigen-layer/testnet/operator-init metadata-url=https://raw.githubusercontent.com/Layr-Labs/eigenlayer-cli/master/pkg/operator/config/metadata-example.json
```

```bash
Operator config has been generated for testnet.
```

#### Register operator
You need to have at least 1 ETH on your operator address to cover the gas cost for registration.
```bash
sonaric do templates/local/eigen-layer/testnet/operator-register
```

Example output:

```bash
Aug 23 19:24:15.124 INF ✅ Operator configuration file read successfully 0xcfd2ff52bbdef53bec23fe9a21a2c70d7037c405
Aug 23 19:24:15.127 INF %s validating operator config:  %s ⏳=0xcfd2ff52bbdef53bec23fe9a21a2c70d7037c405
Aug 23 19:24:15.765 INF ✅ Operator configuration file validated successfully 0xcfd2ff52bbdef53bec23fe9a21a2c70d7037c405

✅ Operator is registered on EigenLayer

--------------------------- Operator Details ---------------------------
Address: 0xcfd2ff52bbdef53bec23fe9a21a2c70d7037c405
Delegation Approver Address: 0x0000000000000000000000000000000000000000
Staker Opt Out Window Blocks: 0
------------------------------------------------------------------------


----------------------------------------------------------------------------------------------------
🔗 Chain ID: 17000
🌐 Operator Web App Link: https://holesky.eigenlayer.xyz/operator/0xcFd2fF52BbDeF53BeC23fE9a21A2c70d7037c405
----------------------------------------------------------------------------------------------------
```

#### Update operator
Update the operator if you have made changes to the operator config.
```bash
sonaric do templates/local/eigen-layer/testnet/operator-update
```
Example output:
```bash
Aug 23 20:27:01.989 INF ✅ Operator configuration file read successfully 0xcfd2ff52bbdef53bec23fe9a21a2c70d7037c405
Aug 23 20:27:01.991 INF ⏳ Validating operator config: 0xcfd2ff52bbdef53bec23fe9a21a2c70d7037c405
Aug 23 20:27:02.621 INF ✅ Operator configuration file validated successfully 0xcfd2ff52bbdef53bec23fe9a21a2c70d7037c405
Aug 23 20:27:03.024 INF updating operator details of operator 0xcfd2ff52bbdef53bec23fe9a21a2c70d7037c405 to EigenLayer component=elcontracts/writer
```

#### Operator status
Get the status of the operator.
```bash
sonaric do templates/local/eigen-layer/testnet/operator-status
```

Example output:
```bash
Aug 23 20:28:13.014 INF ✅ Operator configuration file read successfully 0xcfd2ff52bbdef53bec23fe9a21a2c70d7037c405
Aug 23 20:28:13.017 INF %s validating operator config:  %s ⏳=0xcfd2ff52bbdef53bec23fe9a21a2c70d7037c405
```

## Troubleshooting
If you encounter any issues, please refer to the [EigenLayer Troubleshooting Guide](https://docs.eigenlayer.xyz/eigenlayer/operator-guides/troubleshooting).


## Documentation and API References
- [EigenLayer Documentation](https://docs.eigenlayer.xyz/)
- [Eigenlayer guide for Node Operators](https://docs.eigenlayer.xyz/eigenlayer/operator-guides/operator-installation)
- [GitHub Repository](https://github.com/Layr-Labs/eigenda)
- [Public API](https://github.com/Layr-Labs/eigenda/tree/master/api/docs)
- [Metadata Example](https://raw.githubusercontent.com/Layr-Labs/eigenlayer-cli/master/pkg/operator/config/metadata-example.json)
- [Eiglayer CLI](https://github.com/Layr-Labs/eigenlayer-cli)