# Sonaric Aleo Documentation

## Table of Contents
- [Overview](#overview)
- [System Requirements](#system-requirements)
- [Getting Started](#getting-started)
  - [Load Templates](#load-templates)
  - [Configuration](#configuration)
  - [Run aleo node](#run-aleo-node)
    - [Aleo logs](#aleo-logs)
    - [Access REST API](#access-rest-api)
- [Aleo Template Actions](#aleo-template-actions)
  - [Export keys](#export-keys)
  - [Import key](#import-key)
  - [Get address](#get-address)
- [Documentation and API References](#documentation-and-api-references)

## Overview
Aleo's purpose-built zero-knowledge architecture allows developers 
to leverage the power of zero-knowledge in their applications 
without dealing with the tedious and time-consuming complexities of cryptography.



## System Requirements
Requirements can be found [here](https://github.com/AleoNet/snarkOS?tab=readme-ov-file#21-requirements)

## Getting Started

### Load Templates

```bash
cd aleo
sonaric load MANIFEST
```

Output:
```bash
Loaded 2 runnables, 0 process groups, 0 services, 0 entities and 0 entity instances
✨ Loaded:
 └─🔩 Runnables: 
    ├─🧩 aleo/client
    ├─🧩 aleo/validator
    └─🧩 aleo/prover
✔ All templates loaded successfully
```

**Confirm templates are loaded:**
```bash
foo@bar:~$ sonaric list aleo
```
```
✔ Got the list
Repository  Template      Version  Type      Tags        
local       aleo/client     1.0.0    runnable  blockchain  
local       aleo/prover     1.0.0    runnable  blockchain  
local       aleo/validator  1.0.0    runnable  blockchain
```

### Configuration

The base image currently used for Aleo is `aleohq/snarkos`.   

Template variables can be set to customize the node's behavior. The following variables can be configured:

| Name          | Type   | Description                           | Default Value |
|---------------|--------|---------------------------------------|---------------|
| `verbosity`   | string | Log level                             | 3             |
| `extra-args`  | string | Extra flags to pass to the Aleo node. | `""`          |     
| `private-key` | string | Set private key                       | ``            |

### Run aleo node

Sonaric will generate a new private key before aleo node start if none was set.

We will use `local/aleo/client` template in this example.  
Development network is also available as `local/aleo/devnet`.

```bash
sonaric run local/aleo/client
```
Output:
```bash
✔ Started local/aleo/client
🔩 templates/local/aleo/client
 └─🧊 Peer local
    └─🔩 templates/local/aleo/client 
       └─📦 local-acce50e6bee669d7ae2bf022d3-local-aleo-client-node running
          ├─🧩 aleohq/snarkos:latest                                  
          ├─💾 /Users/vladislavkrapivin/.sonaric/volumes/aleo-/data -> /aleo/data
          ├─🔌 open (public) 104.28.131.166:3033 -> 3033
          └─🔌 open (public) 104.28.131.166:4130 -> 4130


```
#### Aleo logs:
```bash
sonaric logs local/aleo/client -f --last 100
```
Output:
```bash



         ╦╬╬╬╬╬╦
        ╬╬╬╬╬╬╬╬╬                    ▄▄▄▄        ▄▄▄
       ╬╬╬╬╬╬╬╬╬╬╬                  ▐▓▓▓▓▌       ▓▓▓
      ╬╬╬╬╬╬╬╬╬╬╬╬╬                ▐▓▓▓▓▓▓▌      ▓▓▓     ▄▄▄▄▄▄       ▄▄▄▄▄▄
     ╬╬╬╬╬╬╬╬╬╬╬╬╬╬╬              ▐▓▓▓  ▓▓▓▌     ▓▓▓   ▄▓▓▀▀▀▀▓▓▄   ▐▓▓▓▓▓▓▓▓▌
    ╬╬╬╬╬╬╬╜ ╙╬╬╬╬╬╬╬            ▐▓▓▓▌  ▐▓▓▓▌    ▓▓▓  ▐▓▓▓▄▄▄▄▓▓▓▌ ▐▓▓▓    ▓▓▓▌
   ╬╬╬╬╬╬╣     ╠╬╬╬╬╬╬           ▓▓▓▓▓▓▓▓▓▓▓▓    ▓▓▓  ▐▓▓▀▀▀▀▀▀▀▀▘ ▐▓▓▓    ▓▓▓▌
  ╬╬╬╬╬╬╣       ╠╬╬╬╬╬╬         ▓▓▓▓▌    ▐▓▓▓▓   ▓▓▓   ▀▓▓▄▄▄▄▓▓▀   ▐▓▓▓▓▓▓▓▓▌
 ╬╬╬╬╬╬╣         ╠╬╬╬╬╬╬       ▝▀▀▀▀      ▀▀▀▀▘  ▀▀▀     ▀▀▀▀▀▀       ▀▀▀▀▀▀
╚╬╬╬╬╬╩           ╩╬╬╬╬╩


👋 Welcome to Aleo! We thank you for running a node and supporting privacy.

👛 Your Aleo address is aleo1a03ntj2lq8gy5qtqyc38hkzrgcws0vjqzpwayv9ha257tpa97u8swwvwkt.

🧭 Starting a client node on Aleo Mainnet (v0) at 0.0.0.0:4130.

2024-07-28T12:35:03.779777Z  INFO snarkvm_ledger: Loading the ledger from storage...
2024-07-28T12:35:04.994908Z TRACE snarkvm_ledger::advance: Updating the current epoch hash at block 0 to 'ab1qqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq5g436j'
2024-07-28T12:35:05.007560Z DEBUG snarkos_node_rest: REST rate limit per IP - 10 RPS
2024-07-28T12:35:05.091901Z DEBUG snarkos_node_router::heartbeat: No connected peers
2024-07-28T12:35:10.103607Z TRACE snarkos_node_sync::block_sync: Updating is_block_synced: greatest_peer_height = 0, canon_height = 0
2024-07-28T12:35:10.108119Z TRACE snarkos_node_sync::block_sync: Prepared 0 block requests
2024-07-28T12:35:15.115793Z TRACE snarkos_node_sync::block_sync: Updating is_block_synced: greatest_peer_height = 0, canon_height = 0
```

#### Access REST API

Rest API is available at `http://localhost:3033`.

## Aleo Template Actions

Some actions might not work immediately after the node start. 


### Export keys
Prints Aleo private key.

```bash
sonaric do templates/local/aleo/client/export-key
```
Example output:
```bash
✔ Running action: 
APrivateKey1zkpJUhuSXVjPYrkbDHGv2xi29HmMV7SB5S2y9drnZMZC7R6
✨ Took: 0s
```

### Import key
Imports a private key.  
Requires `privkey` as input. (JSON format)  
```bash
sonaric do templates/local/aleo/client/import-key privkey=APrivateKey1zkpHPYxAwnkAV34EzNdFur6bQnEFAAvr4J57BpUePjEnawN
```
New key will be set as default key and node will be restarted (need to wait a minute or so).
Confirm the key is imported:
```bash
sonaric do templates/local/aleo/client/export-key
```
```bash
✔ Running action: 
APrivateKey1zkpHPYxAwnkAV34EzNdFur6bQnEFAAvr4J57BpUePjEnawN
✨ Took: 0s
```

### Get address
Returns address (aleo public key).  
NOT IMPLEMENTED


## Documentation and API References
Access detailed API documentation and examples:
- [SnarkOS](https://github.com/AleoNet/snarkOS)
- [Aleo Developer Docs](https://developer.aleo.org/getting_started/)