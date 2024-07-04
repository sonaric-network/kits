# Sonaric Mina Documentation

## Table of Contents
- [Overview](#overview)
- [System Requirements](#system-requirements)
- [Getting Started](#getting-started)
  - [Load Templates](#load-templates)
  - [Configuration](#configuration)
  - [Run mina daemon](#run-mina-daemon)
    - [Mina logs](#mina-logs)
    - [Access GraphQL API](#access-graphql-api)
- [Mina Template Actions](#mina-template-actions)
  - [Get libp2p peer id](#get-libp2p-peer-id)
  - [Get sync status](#get-sync-status)
  - [Get node status](#get-node-status)
  - [List keys](#list-keys)
  - [Export keys](#export-keys)
  - [Import key](#import-key)
  - [Get balance](#get-balance)
  - [Get address](#get-address)
- [Documentation and API References](#documentation-and-api-references)

## Overview
Mina Protocol is a minimal “succinct blockchain” built to curtail computational requirements in order to run DApps more efficiently.   
Mina has been described as the world’s lightest blockchain since its size is designed to remain constant despite growth in usage.   
Furthermore, it remains balanced in terms of security and decentralization.

## System Requirements
- 8 core processor with BMI2 and AVX CPU instruction set
- 32 GB RAM
- 64 GB disk space
- 1 Mbps Internet Connection

More details can be found [here](https://docs.minaprotocol.com/node-operators/requirements)

## Getting Started

### Load Templates

```bash
cd mina
sonaric load MANIFEST
```

Output:
```bash
Loaded 2 runnables, 0 process groups, 0 services, 0 entities and 0 entity instances
✨ Loaded:
 └─🔩 Runnables: 
    ├─🧩 mina/devnet
    └─🧩 mina/mainnet
✔ All templates loaded successfully
```

**Confirm templates are loaded:**
```bash
foo@bar:~$ sonaric list mina
```
```
✔ Got the list
Repository  Template      Version  Type      Tags        
local       mina/devnet   1.0.1    runnable  blockchain  
local       mina/mainnet  1.0.1    runnable  blockchain  
```

### Configuration

The base image currently used for Mina is `mina-daemon`.   
Currently, the following versions are available:
- `3.0.0-93e0279-bullseye-mainnet` for mainnet
- `3.0.0-dc6bf78-focal-devnet` for devnet

Template variables can be set to customize the node's behavior. The following variables can be configured:

| Name                   | Type   | Description                                                   | Default Value                                                                                                                            |
|------------------------|--------|---------------------------------------------------------------|------------------------------------------------------------------------------------------------------------------------------------------|
| `private-key-password` | string | Password for the private key.                                 | `"My_V3ry_S3cure_Privat3K3yPassw0rd"`                                                                                                    |
| `libp2p-password`      | string | Password for the libp2p key.                                  | `""`                                                                                                                                     |
| `version`              | string | Version of the Mina daemon to deploy.                         | `3.0.0-93e0279-bullseye-mainnet` for mainnet  <br/> `3.0.0-dc6bf78-focal-devnet` for devnet   <br/>(in `1.0.1` version of mina template) |
| `peer-list-url`        | string | URL to fetch the peer list from.                              | `https://bootnodes.minaprotocol.com/networks/[network].txt` (network devnet/mainnet)                                                     |
| `extra-flags`          | string | Extra flags to pass to the Mina daemon. (like `--external-ip` | `""`                                                                                                                                     |     
| `log-level`            | string | Log level for the Mina daemon.                                | `Info`                                                                                                                                   |
| `file-log-level`       | string | File log level for the Mina daemon.                           | `Debug`                                                                                                                                  |

### Run mina daemon

You need to set your `private-key-password` variable in runnable template.
Sonaric will generate a new private key before mina daemon start.

Also, you need to set `libp2p-password` variable in a template.
Sonaric will generate a new libp2p key before mina daemon start.

The keys will be generated only on the first run.

We will use `local/mina/mainnet` template in this example.  
Development network is also available as `local/mina/devnet`.

```bash
sonaric run local/mina/mainnet
```
Output:
```bash
✔ Started local/mina/mainnet
🔩 templates/local/mina/mainnet
 └─🧊 Peer minatest2
    └─🔩 templates/local/mina/sandbox 
       └─📦 03158cdf6dbd9490e6568126807ecae7-local-mina-mainnet-mina running
          ├─🧩 minaprotocol/mina-daemon:3.0.0-93e0279-bullseye-mainnet
          ├─💾 /var/lib/sonaricd/volumes/mina/.mina-config -> /root/.mina-config
          ├─💾 /var/lib/sonaricd/volumes/mina/keys -> /keys    
          ├─🔌 open (public) 34.118.58.199:3085 -> 3085
          └─🔌 open (public) 34.118.58.199:8302 -> 8302

```
#### Mina logs:
```bash
sonaric logs local/mina/mainnet -f
```
Output:
```bash
2024-06-17 18:19:33 UTC [Info] Mina daemon is booting up; built with commit "93e02797f72abe2cbf8dfca6f2328e9c8cd76546" on branch "berkeley"
2024-06-17 18:19:33 UTC [Info] Booting may take several seconds, please wait
Using libp2p keypair private-key password from environment variable MINA_LIBP2P_PASS
2024-06-17 18:19:33 UTC [Info] Reading configuration files $config_files
        config_files: [ "/var/lib/coda/config_93e02797.json", "/root/.mina-config/daemon.json" ]
2024-06-17 18:19:33 UTC [Warn] Could not read configuration from "/root/.mina-config/daemon.json"
2024-06-17 18:19:33 UTC [Info] Initializing with runtime configuration. Ledger name: null
2024-06-17 18:19:33 UTC [Info] Using the constraint constants from the configuration file
2024-06-17 18:19:35 UTC [Info] Loaded genesis ledger from $ledger_file
        ledger_file: "/var/lib/coda/genesis_ledger_5605a5a45c8ef6aac8fa88d5228640c00c16247a93cbeb55e2c95fd4782e88d2.tar.gz"
Using block producer keypair private-key password from environment variable MINA_PRIVKEY_PASS
2024-06-17 18:22:17 UTC [Info] Daemon will use chain id a7351abc7ddf2ea92d1b38cc8e636c271c1dfd2c081c637f62ebc2af34eb7cc1
2024-06-17 18:22:17 UTC [Info] Daemon running protocol version 3.0.0
2024-06-17 18:22:17 UTC [Info] Starting a new prover process
2024-06-17 18:24:00 UTC [Info] Daemon started process of kind "Prover" with pid 106
2024-06-17 18:24:00 UTC [Info] Starting a new verifier process
2024-06-17 18:25:35 UTC [Info] Daemon started process of kind "Verifier" with pid 122
2024-06-17 18:25:35 UTC [Info] Starting a new vrf-evaluator process
2024-06-17 18:25:36 UTC [Info] Daemon started process of kind "Vrf_evaluator" with pid 139
2024-06-17 18:25:36 UTC [Info] Custom child process "libp2p_helper" started with pid 146
2024-06-17 18:25:36 UTC [Info] libp2p peer ID this session is $peer_id
        peer_id: "12D3KooWGfQ6ezgDa5TBwaGsWJhtnpzq6eT9qkWTPCr9RwcidVTP"
2024-06-17 18:25:36 UTC [Error] libp2p_helper: failed to set log level debug for routing/record: error: No such logger
2024-06-17 18:25:36 UTC [Info] Network not instantiated when node status requested
2024-06-17 18:25:36 UTC [Info] Starting transition router
2024-06-17 18:25:36 UTC [Info] Initializing transition router
2024-06-17 18:25:36 UTC [Warn] GCLOUD_KEYFILE environment variable not set. Must be set to use upload_blocks_to_gcloud
2024-06-17 18:25:36 UTC [Info] Mina daemon is connecting
2024-06-17 18:25:36 UTC [Info] Initializing plugins
2024-06-17 18:25:36 UTC [Info] Pausing block production while bootstrapping
2024-06-17 18:25:36 UTC [Info] Not running uptime service, no URL given
2024-06-17 18:25:36 UTC [Info] Stopping daemon after 10620 mins and when there are no blocks to be produced
2024-06-17 18:25:36 UTC [Info] Attempted to turn on snark worker, but snark worker key is set to none
2024-06-17 18:25:36 UTC [Info] Daemon ready. Clients can now connect
2024-06-17 18:25:36 UTC [Info] Created GraphQL server at: http://localhost:3085/graphql
2024-06-17 18:25:37 UTC [Info] Mina daemon is listening
2024-06-17 18:25:37 UTC [Info] Already connected to enough peers, start initialization
2024-06-17 18:26:24 UTC [Info] Persistent_frontier.Instsance.check_database took 46.011s
2024-06-17 18:26:25 UTC [Info] Fast forward successful
2024-06-17 18:26:27 UTC [Info] Mina daemon is bootstrapping
2024-06-17 18:26:29 UTC [Info] Requesting peers for their best tip to do initialization
```

#### Access GraphQL API

After few minutes graphql endpoint will be available at http://34.88.82.185:3085/graphql
(Replace with your IP from the output)

[GraphQL API](https://docs.minaprotocol.com/node-developers/graphql-api)

## Mina Template Actions

Some actions might not work immediately after the node start. 
Mina daemon needs some time to start API services.


### Get libp2p peer id

```bash
sonaric do templates/local/mina/mainnet/get-peer-id
```
```bash
✔ Running action: 
12D3KooWGfQ6ezgDa5TBwaGsWJhtnpzq6eT9qkWTPCr9RwcidVTP
✨ Took: 1s
```

### Get sync status
```bash
sonaric do templates/local/mina/mainnet/sync-status
```
Example output:
```json
{"data":{"daemonStatus":{"syncStatus":"SYNCED","blockchainLength":363117,"highestBlockLengthReceived":363118}}}
```


### Get node status
More details about the node status compared to the sync-status action.
````bash
sonaric do templates/local/mina/mainnet/status
````
Example output:
```bash
Mina daemon status
-----------------------------------

Global number of accounts:                     229252
Block height:                                  363118
Max observed block height:                     363118
Max observed unvalidated block height:         0
Local uptime:                                  12m6s
Ledger Merkle root:                            jwU9Mk6vPAa9X26s4YSYuDQsC23BANMVC132JnMnXZmTaLkkmh8
Protocol state hash:                           3NKhEL4z914Kp65PHA9rA2mXzCWMN9fzLJHCceoCDAYvhfV7TUT7
Chain id:                                      a7351abc7ddf2ea92d1b38cc8e636c271c1dfd2c081c637f62ebc2af34eb7cc1
Git SHA-1:                                     93e02797f72abe2cbf8dfca6f2328e9c8cd76546
Configuration directory:                       /root/.mina-config
Peers:                                         45
User_commands sent:                            0
SNARK worker:                                  None
SNARK work fee:                                100000000
Sync status:                                   Synced
Catchup status:                                
        To build breadcrumb:           0
        To initial validate:           0
        Finished:                      5
        To download:                   0
        Waiting for parent to finish:  0
        To verify:                     0

Block producers running:                       1 (B62qoApvCpFSKDraj8LsWL9BdpF66cGm3c5grMDQbsd1C4cMfnLRomJ)
Coinbase receiver:                             Block producer
Best tip consensus time:                       epoch=0, slot=6128
Best tip global slot (across all hard-forks):  570608
Next block will be produced in:                None this epoch… checking at in 2.103d (Generated from consensus at slot: 6124 slot-since-genesis: 570604)
Consensus time now:                            epoch=0, slot=6130
Consensus mechanism:                           proof_of_stake
Consensus configuration:                       
        Delta:                     0
        k:                         290
        Slots per epoch:           7140
        Slot duration:             3m
        Epoch duration:            14d21h
        Chain start timestamp:     2024-06-05 00:00:00.000000Z
        Acceptable network delay:  3m

Addresses and ports:                           
        External IP:    34.118.58.199
        Bind IP:        0.0.0.0
        Libp2p PeerID:  12D3KooWGfQ6ezgDa5TBwaGsWJhtnpzq6eT9qkWTPCr9RwcidVTP
        Libp2p port:    8302
        Client port:    8301

Metrics:                                       
        block_production_delay:             7 (0 0 0 0 0 0 0)
        transaction_pool_diff_received:     20
        transaction_pool_diff_broadcasted:  0
        transactions_added_to_pool:         0
        transaction_pool_size:              0
        snark_pool_diff_received:           23
        snark_pool_diff_broadcasted:        0
        pending_snark_work:                 0
        snark_pool_size:                    2
✨ Took: 3s
```

### List keys
Prints Mina daemon keys.  
We're generating and importing new keypair on first run if none exists.
```bash
sonaric do templates/local/mina/mainnet/list-keys
```

Example output:
```bash
✔ Running action: 
Warning: Could not connect to a running daemon.
Listing from local directory /root/.mina-config
Account .1:
  Public key: B62qkR9p3vKuWKZaxhmtQNSansrsEQAMcDWQ7XcNk1a8Rr9n7HhhdeT
✨ Took: 1s
```


### Export keys
Prints both public and private keys.  
Requires `pubkey` as input.  
It's possible to see public keys with `list-keys` [action](#list-keys).   

```bash
sonaric do templates/local/mina/mainnet/export-key pubkey=B62qmJh5sJB4jcrFzCbKK9j8ayp1U2toiEQANLaGeW7a4mq4SpUrozr
```
Example output:
```bash
✔ Running action: 
Account exported successfully.
Private key:
{"box_primitive":"xsalsa20poly1305","pw_primitive":"argon2i","nonce":"7NjR6gENJ4PvFUJZPaodomKXzePNQZ2LGWr8P6v","pwsalt":"AgAyjqJvEZZ22UpWq4YEd9YanM74","pwdiff":[134217728,6],"ciphertext":"CCzoQjxVMG9ia1B4SU8xEjQJyJ3nZHvNhdUTeLbfAYKboNkRXWBZisKkrQLYeHZZMg3XtvXQf"}
Public key:
B62qmJh5sJB4jcrFzCbKK9j8ayp1U2toiEQANLaGeW7a4mq4SpUrozr
✨ Took: 2s
```

### Import key
Imports a private key.  
Requires `privkey` as input. (JSON format)  
```bash
sonaric do templates/local/mina/mainnet/import-key privkey='{"box_primitive":"xsalsa20poly1305","pw_primitive":"argon2i","nonce":"8dEbSrQLicNgPMtw1aruCaZrXgcbt3MEYpvk5vt","pwsalt":"98sNnePSNVkSbZJSG8x42jPUAQa8","pwdiff":[134217728,6],"ciphertext":"BsdaWJv96W5DpDHbkfLqwjMDjLusWQZtPH4e8s4De2CY5D23xdgAM7HXjwj2Sq33BSJLEAC4i"}'
```
Example output:
```bash
✔ Running action:
😄 Imported account!
Public key: B62qkUyePK48iNndRnKqzrwy4RDn4buYdh3HfrL6RWSTRaF5B3FNW3C
✨ Took: 2s
```

Confirm the key is imported:
```bash
sonaric do templates/local/mina/mainnet/list-keys
```
```bash
Account .1:
Public key: B62qkUyePK48iNndRnKqzrwy4RDn4buYdh3HfrL6RWSTRaF5B3FNW3C
Balance: 0
Locked: false
Account .2:
Public key: B62qkUyePK48iNndRnKqzrwy4RDn4buYdh3HfrL6RWSTRaF5B3FNW3C
Balance: 0
Locked: true
```

### Get balance
Requires `pubkey` as input.  
```bash
sonaric do templates/local/mina/mainnet/get-balance pubkey=B62qkUyePK48iNndRnKqzrwy4RDn4buYdh3HfrL6RWSTRaF5B3FNW3C
```

Example output:
```bash
✔ Running action:
There are no funds in this account
✨ Took: 1s
```

### Get address
Returns address (mina public key) in json format.
```bash
sonaric do templates/local/mina/mainnet/get-address
```

Example output:
```bash
✔ Running action:
{"address":"B62qkUyePK48iNndRnKqzrwy4RDn4buYdh3HfrL6RWSTRaF5B3FNW3C"}
✨ Took: 1s
```

If you see warning like this before output:
```bash
Warning: Could not connect to a running daemon.
Listing from local directory /root/.mina-config
{"address":"B62qkUyePK48iNndRnKqzrwy4RDn4buYdh3HfrL6RWSTRaF5B3FNW3C"}
```
just wait a few minutes and try again.  
That means the daemon is not ready yet. And that is normal behavior.

### Get balance
Requires `pubkey` as input.  
```bash
sonaric do templates/local/mina/mainnet/get-balance pubkey=B62qkUyePK48iNndRnKqzrwy4RDn4buYdh3HfrL6RWSTRaF5B3FNW3C
```

Example output:
```bash
✔ Running action:
{"amount": 299}
✨ Took: 1s
```

## Documentation and API References
Access detailed API documentation and examples:
- [Mina Protocol Documentation](https://docs.minaprotocol.com/)
- [Mina Protocol GraphQL API](https://docs.minaprotocol.com/node-developers/graphql-api)
- [Mina Repository](https://github.com/minaprotocol/mina)