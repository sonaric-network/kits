# Sonaric Ethereum Documentation

## Table of Contents
- [Overview](#overview)
- [System Requirements](#system-requirements)
- [Getting Started](#getting-started)
  * [Load Templates](#load-templates)
  * [Configuration](#configuration)
- [Running Nodes](#running-nodes)
- [Ethereum actions](#ethereum-actions)
  * [Import Key](#import-key)
  * [Export Key](#export-key)
  * [List Keys](#list-keys)
  * [Sync Status](#sync-status)
- [Common Tasks and Troubleshooting](#common-tasks-and-troubleshooting)
- [Documentation and API References](#documentation-and-api-references)


## Overview
Ethereum is a decentralized platform that enables developers to build and deploy smart contracts and decentralized applications (dApps). The platform is powered by the Ethereum blockchain, which is a distributed ledger that records transactions across a network of computers. Ethereum's native cryptocurrency, Ether (ETH), is used to pay for transaction fees and computational services on the network.

Ethereum official docs: [Ethereum Documentation](https://ethereum.org/en/developers/docs/)

Sonaric provides Ethereum templates to deploy and manage Ethereum nodes.     
The templates are based on the Erigon client, which is a fast and efficient Ethereum client written in Go.   

Currently, Sonaric provides templates for full(or pruned) and archive nodes for mainnet, goerli, sepolia and holesky networks.  
Also we have gnosis (mainnet and chiado networks) and polygon (mainnet and mumbai networks) templates based on ethereum.

## System Requirements

Erigon hardware requirements (source: [Erigon GitHub](https://erigon.gitbook.io/erigon/basic-usage/getting-started#hardware-requirements))

Requirements for Ethereum networks:

| Node            | Components | Recommended                                                                          |
|-----------------|------------|--------------------------------------------------------------------------------------|
| Mainnet archive | Storage    | SSD 3.5TB+                                                                           |
| Mainnet full    | Storage    | SSD 1.5TiB+                                                                          |
| Goerli full     | Storage    | SSD 200 GB                                                                           |
| Gnosis archive  | Storage    | SSD 1.7TiB                                                                           |
| Gnosis full     | Storage    | SSD 530GiB                                                                           |
| Polygon archive | Storage    | SSD 8.5TiB                                                                           |
| Polygon full    | Storage    | SSD 5.1TiB                                                                           |
| -               | CPU        | 64-bit architecture <br/> (core and threads number doesn't really matter for Erigon) |
| -               | RAM        | ≥ 16GB                                                                               |




## Getting Started

### Load Templates
```bash
cd ethereum
sonaric load MANIFEST
```

**Confirm templates are loaded:**
```bash
foo@bar:~$ sonaric list ethereum
```
```
✔ Got the list
local       ethereum/goerli          1.0.0    runnable  blockchain, evm  
local       ethereum/goerli-pruned   1.0.0    runnable  blockchain, evm  
local       ethereum/holesky         1.0.0    runnable  blockchain, evm  
local       ethereum/holesky-pruned  1.0.0    runnable  blockchain, evm  
local       ethereum/mainnet         1.0.0    runnable  blockchain, evm  
local       ethereum/mainnet-pruned  1.0.0    runnable  blockchain, evm  
local       ethereum/sepolia         1.0.0    runnable  blockchain, evm  
local       ethereum/sepolia-pruned  1.0.0    runnable  blockchain, evm 
```


### Configuration
Template variables can be set to customize the node's behavior. The following variables can be configured:

| Name      | Type   | Description                                | Default Value                                |
|-----------|--------|--------------------------------------------|----------------------------------------------|
| `version` | string | Specifies the version of the Erigon client | `v2.60.0`                                    |
| `options` | string | additional paramets for the node           | `--prune=hrtc` for pruned, empty for archive |


## Running Nodes

More information on nodes and clients can be found in [Ethereum documentation](https://ethereum.org/en/developers/docs/nodes-and-clients).

Run a full node using:
```bash
sonaric run templates/local/ethereum/mainnet-pruned
```

```
✔ Started templates/local/ethereum/mainnet-pruned
🔩 templates/local/ethereum/mainnet-pruned
 └─🧊 Peer test-gcp2-1
    └─🔩 templates/local/ethereum/mainnet-pruned 
       └─📦 f4c02cdde053c34d8f8107bd1b92aa92-m-mainnet-pruned-erigon running
          ├─🧩 thorax/erigon:v2.60.0                                                        
          ├─💾 /var/lib/sonaricd/volumes/ethereum -> /home/erigon/.local/share/erigon 
          ├─🔌 open (public) TCP 34.118.93.118:4001 -> 4001          
          ├─🔌 open (public) UDP 34.118.93.118:30304 -> 30304        
          ├─🔌 open (public) TCP 34.118.93.118:8545 -> 8545          
          ├─🔌 open (public) TCP 34.118.93.118:30304 -> 30304        
          ├─🔌 open (public) UDP 34.118.93.118:30303 -> 30303        
          ├─🔌 open UDP 34.118.93.118:42069 -> 42069                 
          ├─🔌 open TCP 34.118.93.118:42069 -> 42069                 
          ├─🔌 open (public) UDP 34.118.93.118:4000 -> 4000          
          └─🔌 open (public) TCP 34.118.93.118:30303 -> 30303
```

Confirm the full node is running:
```bash
sonaric logs -f ethereum/mainnet-pruned
```
Logs should look similar to:
```
[INFO] [06-12|18:39:59.952] logging to file system                   log dir=/home/erigon/.local/share/erigon/logs file prefix=erigon log level=info json=false
[INFO] [06-12|18:39:59.952] Build info                               git_branch=heads/v2.60.0 git_tag=v2.60.0-dirty git_commit=7883a4e3c99a22ccc826906f7ecdab61afee74f8
[INFO] [06-12|18:39:59.952] Starting Erigon on Ethereum mainnet... 
[INFO] [06-12|18:39:59.953] Maximum peer count                       ETH=100 total=100
[INFO] [06-12|18:39:59.953] starting HTTP APIs                       port=8545 APIs=eth,web3,net,debug,trace,txpool
[INFO] [06-12|18:39:59.954] torrent verbosity                        level=WRN
[INFO] [06-12|18:40:02.058] Set global gas cap                       cap=50000000
[INFO] [06-12|18:40:02.108] [Downloader] Running with                ipv6-enabled=true ipv4-enabled=true download.rate=512mb upload.rate=4mb
[INFO] [06-12|18:40:02.128] Opening Database                         label=chaindata path=/home/erigon/.local/share/erigon/chaindata
[INFO] [06-12|18:40:02.134] [db] open                                label=chaindata sizeLimit=12TB pageSize=8192
[WARN] [06-12|18:40:02.135] Sanitizing invalid bor miner gas price   provided=1000000000 updated=30000000000
[INFO] [06-12|18:40:02.135] Initialised chain configuration          config="{ChainID: 1, Homestead: 1150000, DAO: 1920000, Tangerine Whistle: 2463000, Spurious Dragon: 2675000, Byzantium: 4370000, Constantinople: 7280000, Petersburg: 7280000, Istanbul: 9069000, Muir Glacier: 9200000, Berlin: 12244000, London: 12965000, Arrow Glacier: 13773000, Gray Glacier: 15050000, Terminal Total Difficulty: 58750000000000000000000, Merge Netsplit: <nil>, Shanghai: 1681338455, Cancun: 1710338135, Prague: <nil>, Osaka: <nil>, Engine: ethash, NoPruneContracts: map[0x00000000219ab540356cBB839Cbe05303d7705Fa:true]}" genesis=0xd4e56740f876aef8c010b86a40d5f56745a118d0906a34e69aec8c0db1cb8fa3
[INFO] [06-12|18:40:44.010] [snapshots] Adding .torrent files        progress=54/156
[INFO] [06-12|18:41:03.407] [snapshots] Adding .torrent files        progress=75/156
[INFO] [06-12|18:41:22.274] [snapshots] Adding .torrent files        progress=91/156
[INFO] [06-12|18:41:44.475] [snapshots] Adding .torrent files        progress=106/156
[INFO] [06-12|18:42:02.751] [snapshots] Adding .torrent files        progress=117/156
[INFO] [06-12|18:42:22.606] [snapshots] Adding .torrent files        progress=127/156
[INFO] [06-12|18:42:43.304] [snapshots] Adding .torrent files        progress=139/156
[INFO] [06-12|18:43:03.135] [snapshots] Adding .torrent files        progress=151/156
```




## Ethereum actions

### Import Key
Create a new key from a private key and import it into the node's key store.  
Key could be in hex or json format. If key is empty, a new key will be generated.
```bash
sonaric do templates/local/ethereum/mainnet-pruned/import-key password=test
```
Example output:
```
✔ Running action: 
{"address":"7ce17814a929693c3fee3d3953657631250ca649","mnemonic":"glance salute fever asset knee top response void tennis crisp toilet drama second village wide ceiling craft army half rotate pond judge offer annual"}
```

### Export Key
Export a key from the node's key store.  
```bash
sonaric do templates/local/ethereum/mainnet-pruned/export-key address=7ce17814a929693c3fee3d3953657631250ca649 password=test
```
Example output:
```
✔ Running action: 
{"address":"7ce17814a929693c3fee3d3953657631250ca649","crypto":{"cipher":"aes-128-ctr","ciphertext":"5a91d7405ab57c5006dd54d4bbc915568dd6176638d368a9d152e39588c0c230","cipherparams":{"iv":"17a14fdbf97b87643a345dc8921f6e87"},"kdf":"scrypt","kdfparams":{"dklen":32,"n":262144,"p":1,"r":8,"salt":"13fae9c4ad777ba1265b0f60002b780e0833e41d32ed39b435c631afa4b5d0b3"},"mac":"56cfaac25e60d81e8d680cb57ccb688dabd9f2558e95783a12260edccc09295c"},"id":"81dbb40c-02bf-4e2f-9ff0-c1f8686b8915","version":3}
```

### List Keys
List addresses of all keys in the node's key store.  
```bash
sonaric do templates/local/ethereum/mainnet-pruned/list-keys
```

Example output:
```
✔ Running action: 
ad0433c825f00298b7a2646b093a010aeb75efc6
d936278cb36ac41563c369bd7c665e10ca416220
7ce17814a929693c3fee3d3953657631250ca649
```

### Sync Status
Get the current sync status of the node.  
```bash
sonaric do templates/local/ethereum/mainnet-pruned/sync-status
```
Example output:
```
✔ Running action: 
{"jsonrpc":"2.0","id":1,"result":{"currentBlock":"0x0","highestBlock":"0x0","stages":[{"stage_name":"Snapshots","block_number":"0x0"},{"stage_name":"Headers","block_number":"0x0"},{"stage_name":"BorHeimdall","block_number":"0x0"},{"stage_name":"BlockHashes","block_number":"0x0"},{"stage_name":"Bodies","block_number":"0x0"},{"stage_name":"Senders","block_number":"0x0"},{"stage_name":"Execution","block_number":"0x0"},{"stage_name":"Translation","block_number":"0x0"},{"stage_name":"HashState","block_number":"0x0"},{"stage_name":"IntermediateHashes","block_number":"0x0"},{"stage_name":"AccountHistoryIndex","block_number":"0x0"},{"stage_name":"StorageHistoryIndex","block_number":"0x0"},{"stage_name":"LogIndex","block_number":"0x0"},{"stage_name":"CallTraces","block_number":"0x0"},{"stage_name":"TxLookup","block_number":"0x0"},{"stage_name":"Finish","block_number":"0x0"}]}}
```



## Common Tasks and Troubleshooting

### Stop Workloads
To stop workloads, use the `sonaric stop` command:
```bash
sonaric stop ethereum/mainnet-pruned
```
```
foo@bar:~$ sonaric stop ethereum/mainnet-pruned
✔ Stopping templates/local/ethereum/mainnet-pruned... DONE
✔ Stopping container: f4c02cdde053c34d8f8107bd1b92aa92-m-mainnet-pruned-erigon DONE
✔ Stopping containers DONE
✔ templates/local/ethereum/mainnet-pruned stopped successfully
```
To purge workloads, use the `sonaric purge` command:
```bash
sonaric purge ethereum/mainnet-pruned
```
```
foo@bar:~$ sonaric purge ethereum/mainnet-pruned
WARNING! This will remove:
🔩 templates/local/ethereum/mainnet-pruned
 └─📦 f4c02cdde053c34d8f8107bd1b92aa92-m-mainnet-pruned-erigon
? Are you sure? Yes
✔ Deleting templates/local/ethereum/mainnet-pruned ... DONE
✔ templates/local/ethereum/mainnet-pruned deleted successfully
```


## Documentation and API References
Access detailed API documentation and examples:
- [Ethereum Documentation](https://ethereum.org/en/developers/docs/)
- [Erigon Documentation](https://erigon.gitbook.io/erigon/)