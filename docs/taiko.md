# Sonaric Taiko Documentation

## Table of Contents
- [Overview](#overview)
- [Load Template](#load-template)
    - [Confirm templates loaded](#confirm-templates-loaded)
    - [Configuration](#configuration)
- [Run taiko](#run-taiko)
    - [Logs](#logs)
    - [Stop, remove and clean up](#stop-remove-and-clean-up)
- [Troubleshooting](#troubleshooting)
- [Documentation and API References](#documentation-and-api-references)

## Overview
Taiko is a decentralized and permissionless zero-knowledge rollup (zk-rollup) built on Ethereum. It aims to scale Ethereum by increasing transaction throughput while maintaining security and decentralization.

## Load Template

```bash
cd taiko
sonaric load MANIFEST
```

### Confirm templates loaded

```bash
foo@bar:~$ sonaric list taiko
✔ Got the list
Repository  Template                           Version  Type      Tags        
local       taiko/client-driver                -        runnable  -
local       taiko/client-driver-with-prover    -        runnable  -
local       taiko/client-proposer              1.0.0    runnable  blockchain
local       taiko/client-prover-relayer        1.0.0    runnable  blockchain
local       taiko/execution-engine             1.0.0    runnable  blockchain
local       taiko/proccessor-group             -        group     -
local       taiko/proposer-group               -        group     -
local       taiko/prover-group                 -        group     -
local       taiko/prover-relayer-group         -        group     -
local       taiko/prover-with-processor-group  -        group     -
```

## Configuration

- [Mainnet addresses](https://docs.taiko.xyz/network-reference/mainnet-addresses)
- [Testnet addresses](https://docs.taiko.xyz/network-reference/testnet-addresses)

Template variables can be set to customize the node's behavior. The following variables can be configured:
| Name                         | Type   | Description                                         | Default Value                                           |
|------------------------------|--------|-----------------------------------------------------|---------------------------------------------------------|
| `l1_rpc`                     | string | RPC endpoint for Layer 1                            | `""`                                                    |
| `l1_ws_rpc`                  | string | WebSocket RPC endpoint for Layer 1                  | `""`                                                    |
| `l1_beacon_api`              | string | Beacon API endpoint for Layer 1                     | `""`                                                    |
| `taiko_l1_address`           | string | Contract address for Taiko on Layer 1               | `"0x06a9Ab27c7e2255df1815E6CC0168d7755Feb19a"`          |
| `taiko_l2_address`           | string | Contract address for Taiko on Layer 2               | `"0x1670000000000000000000000000000000010001"`          |
| `p2p_sync_url`               | string | URL for peer-to-peer synchronization                | `"https://rpc.mainnet.taiko.xyz"`                       |
| `taiko_token_l1_address`     | string | Token contract address for Taiko on Layer 1         | `"0x10dea67478c5F8C5E2D90e5E9B26dBe60c54d800"`          |
| `l1_proposer_private_key`    | string | Private key for the Layer 1 proposer                | `""`                                                    |
| `l2_suggested_fee_recipient` | string | Suggested fee recipient address for Layer 2         | `""`                                                    |

## Run taiko

While running template, operator MUST provide own l1_proposer_private_key and l2_suggested_fee_recipient.

```bash
sonaric run -s l1_rpc=<rpc> -s l1_ws_rpc=<ws_rpc> -s l1_rpc=<rpc> -s l1_beacon_api=<beacon_api> -s l2_suggested_fee_recipient=<suggested_fee_recipient> taiko/prover-group
```

Output:
```bash
🔩 templates/local/taiko/prover-group
 └─🧊 Peer local
    ├─🔩 templates/local/taiko/client-driver
    │  └─📦 07a158af06dbb364e155eb63d1515b04-nt-driver-client-driver running
    │     ├─🧩 us-docker.pkg.dev/evmchain/images/taiko-client:taiko-client-v0.29.0
    │     └─💾 /Users/alexnelepa/.monk/volumes/taiko -> /data/taiko-geth
    └─🔩 templates/local/taiko/execution-engine
       └─📦 66f8e5c0de7264089b1a4a5267ff04f3-engine-execution-engine running
          ├─🧩 us-docker.pkg.dev/evmchain/images/taiko-geth:v1.5.0
          ├─💾 /Users/alexnelepa/.monk/volumes/taiko -> /data/taiko-geth
          ├─🔌 open (public) 188.146.32.63:8551 -> 8551
          ├─🔌 open (public) 188.146.32.63:6060 -> 6060
          ├─🔌 open (public) 188.146.32.63:30306 -> 30306
          ├─🔌 open (public) 188.146.32.63:8546 -> 8546
          ├─🔌 open (public) 188.146.32.63:8545 -> 8545
          ├─🔌 open (public) 188.146.32.63:5052 -> 5052
          ├─🔌 open (public) 188.146.32.63:8551 -> 8551
          └─🔌 open (public) UDP 188.146.32.63:30306 -> 30306
```

### Logs

```bash
  sonaric logs taiko/prover-group
```

```bash
INFO [09-04|11:26:39.061] Enabling metrics collection
INFO [09-04|11:26:39.062] Enabling stand-alone metrics HTTP endpoint address=0.0.0.0:6060
INFO [09-04|11:26:39.063] Starting metrics server                  addr=http://0.0.0.0:6060/debug/metrics
INFO [09-04|11:26:39.093] Maximum peer count                       ETH=50 total=50
INFO [09-04|11:26:39.101] Smartcard socket not found, disabling    err="stat /run/pcscd/pcscd.comm: no such file or directory"
WARN [09-04|11:26:39.130] Sanitizing cache to Go's GC limits       provided=1024 updated=650
INFO [09-04|11:26:39.131] Enabling recording of key preimages since archive mode is used
WARN [09-04|11:26:39.132] Disabled transaction unindexing for archive node
INFO [09-04|11:26:39.133] Set global gas cap                       cap=50,000,000
INFO [09-04|11:26:39.161] Initializing the KZG library             backend=gokzg
INFO [09-04|11:26:39.409] Allocated trie memory caches             clean=194.00MiB dirty=0.00B
INFO [09-04|11:26:39.417] Defaulting to pebble as the backing database
INFO [09-04|11:26:39.418] Allocated cache and file handles         database=/data/taiko-geth/geth/chaindata cache=325.00MiB handles=262,144
INFO [09-04|11:26:39.498] Opened ancient database                  database=/data/taiko-geth/geth/chaindata/ancient/chain readonly=false
INFO [09-04|11:26:39.502] State scheme set by user                 scheme=path
INFO [09-04|11:26:39.504] Initialising Ethereum protocol           network=167,000 dbversion=<nil>
ERROR[09-04|11:26:39.514] Zero trie root hash!
INFO [09-04|11:26:39.526] Opened ancient database                  database=/data/taiko-geth/geth/chaindata/ancient/state readonly=false
WARN [09-04|11:26:39.527] Path-based state scheme is an experimental feature
INFO [09-04|11:26:39.527] Writing custom genesis block
INFO [09-04|11:26:39.696]
INFO [09-04|11:26:39.696] ---------------------------------------------------------------------------------------------------------------------------------------------------------
INFO [09-04|11:26:39.697] Chain ID:  167000 (Taiko)
INFO [09-04|11:26:39.697] Consensus: Taiko
INFO [09-04|11:26:39.697]
INFO [09-04|11:26:39.697] Pre-Merge hard forks (block based):
INFO [09-04|11:26:39.697]  - Homestead:                   #0        (https://github.com/ethereum/execution-specs/blob/master/network-upgrades/mainnet-upgrades/homestead.md)
INFO [09-04|11:26:39.697]  - Tangerine Whistle (EIP 150): #0        (https://github.com/ethereum/execution-specs/blob/master/network-upgrades/mainnet-upgrades/tangerine-whistle.md)
INFO [09-04|11:26:39.697]  - Spurious Dragon/1 (EIP 155): #0        (https://github.com/ethereum/execution-specs/blob/master/network-upgrades/mainnet-upgrades/spurious-dragon.md)
INFO [09-04|11:26:39.697]  - Spurious Dragon/2 (EIP 158): #0        (https://github.com/ethereum/execution-specs/blob/master/network-upgrades/mainnet-upgrades/spurious-dragon.md)
INFO [09-04|11:26:39.697]  - Byzantium:                   #0        (https://github.com/ethereum/execution-specs/blob/master/network-upgrades/mainnet-upgrades/byzantium.md)
INFO [09-04|11:26:39.697]  - Constantinople:              #0        (https://github.com/ethereum/execution-specs/blob/master/network-upgrades/mainnet-upgrades/constantinople.md)
INFO [09-04|11:26:39.697]  - Petersburg:                  #0        (https://github.com/ethereum/execution-specs/blob/master/network-upgrades/mainnet-upgrades/petersburg.md)
INFO [09-04|11:26:39.697]  - Istanbul:                    #0        (https://github.com/ethereum/execution-specs/blob/master/network-upgrades/mainnet-upgrades/istanbul.md)
INFO [09-04|11:26:39.697]  - Berlin:                      #0        (https://github.com/ethereum/execution-specs/blob/master/network-upgrades/mainnet-upgrades/berlin.md)
INFO [09-04|11:26:39.697]  - London:                      #0        (https://github.com/ethereum/execution-specs/blob/master/network-upgrades/mainnet-upgrades/london.md)
INFO [09-04|11:26:39.697]
INFO [09-04|11:26:39.697] Merge configured:
INFO [09-04|11:26:39.697]  - Hard-fork specification:    https://github.com/ethereum/execution-specs/blob/master/network-upgrades/mainnet-upgrades/paris.md
INFO [09-04|11:26:39.697]  - Network known to be merged: true
INFO [09-04|11:26:39.697]  - Total terminal difficulty:  0
INFO [09-04|11:26:39.697]
INFO [09-04|11:26:39.697] Post-Merge hard forks (timestamp based):
INFO [09-04|11:26:39.697]  - Shanghai:                    @0          (https://github.com/ethereum/execution-specs/blob/master/network-upgrades/mainnet-upgrades/shanghai.md)
INFO [09-04|11:26:39.697]
INFO [09-04|11:26:39.697] ---------------------------------------------------------------------------------------------------------------------------------------------------------
INFO [09-04|11:26:39.697]
INFO [09-04|11:26:39.703] Loaded most recent local block           number=0 hash=90bc60..e489b9 td=0 age=55y5mo2w
WARN [09-04|11:26:39.706] Failed to load snapshot                  err="missing or corrupted snapshot"
INFO [09-04|11:26:39.709] Rebuilding state snapshot
INFO [09-04|11:26:39.711] Resuming state snapshot generation       root=6db0b8..11921b accounts=0 slots=0 storage=0.00B dangling=0 elapsed=1.648ms
INFO [09-04|11:26:39.711] Initialized transaction indexer          range="entire chain"
INFO [09-04|11:26:39.727] Generated state snapshot                 accounts=22 slots=61 storage=6.76KiB dangling=0 elapsed=17.699ms
INFO [09-04|11:26:39.788] Chain post-merge, sync via beacon client
INFO [09-04|11:26:39.791] Gasprice oracle is ignoring threshold set threshold=2
WARN [09-04|11:26:39.802] Engine API enabled                       protocol=eth
INFO [09-04|11:26:39.803] Starting peer-to-peer node               instance=Geth/v1.13.15-stable-4954004f/linux-amd64/go1.21.12
INFO [09-04|11:26:39.850] New local node record                    seq=1,725,449,199,824 id=85d79ce09196079b ip=127.0.0.1 udp=30306 tcp=30306
INFO [09-04|11:26:39.858] Started P2P networking                   self=enode://18260125791d3161674d75e68483d250eacd5a44e6a413b3dd3271fc9504426eff89fc5ad81ccd81e5fc3103cf9d6ecb6f2248d0c577020fd25f57c40ac9f5e8@127.0.0.1:30306
INFO [09-04|11:26:39.870] IPC endpoint opened                      url=/data/taiko-geth/geth.ipc
INFO [09-04|11:26:39.875] Generated JWT secret                     path=data/taiko-geth/geth/jwtsecret
INFO [09-04|11:26:39.879] HTTP server started                      endpoint=[::]:8545 auth=false prefix= cors= vhosts=*
INFO [09-04|11:26:39.879] WebSocket enabled                        url=ws://[::]:8546
INFO [09-04|11:26:39.879] WebSocket enabled                        url=ws://[::]:8551
INFO [09-04|11:26:39.879] HTTP server started                      endpoint=[::]:8551 auth=true  prefix= cors=localhost vhosts=*
```
### Stop, remove and clean up
Stop:
```bash
sonaric stop taiko/prover-group
```
Purge:
```bash
sonaric purge taiko/prover-group
```
## Troubleshooting
If you encounter any issues, please refer to the [Taiko Troubleshooting Guide](https://docs.taiko.xyz/guides/node-operators/node-troubleshooting/).
## Documentation and API References
Access detailed API documentation and examples:
- [Taiko Documentation](https://docs.taiko.xyz/start-here/getting-started)
- [Taiko Repository](https://github.com/taikoxyz)