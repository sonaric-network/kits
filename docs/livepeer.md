# Sonaric Livepeer Documentation

## Table of Contents
- [Overview](#overview)
- [System Requirements](#system-requirements)
- [Load Template](#load-template)
    - [Confirm templates loaded](#confirm-templates-loaded)
    - [Configuration](#configuration)
- [Run Livepeer](#run-livepeer)
    - [Logs](#logs)
    - [Stop, remove and clean up](#stop-remove-and-clean-up)
- [Template Actions](#template-actions)
    - [Export key](#export-key)
    - [Import key](#import-key)
    - [List keys](#list-keys)
- [Troubleshooting](#troubleshooting)
- [Documentation and API References](#documentation-and-api-references)

## Overview
Livepeer is a decentralized video streaming network built on the Ethereum blockchain. It aims to provide an open and decentralized platform for live video broadcasting and transcoding.


## System Requirements
 - Quad-core processor
 - 8 GB
 - Dedicated GPU such as NVIDIA GTX 1050 Ti or equivalent
 - 256 GB SSD

## Load Template

```bash
cd livepeer
sonaric load MANIFEST
```

### Confirm templates loaded

```bash
foo@bar:~$ sonaric list livepeer
✔ Got the list
Repository  Template           Version  Type      Tags
local       livepeer/mainnet   1.0.1    runnable  blockchain
```

### Configuration

Template variables can be set to customize the node's behavior. The following variables can be configured:
| Name                         | Type   | Description                                         | Default Value                                           |
|------------------------------|--------|-----------------------------------------------------|---------------------------------------------------------|
| `passphrase`                 | string | passphrase of the account                           | `""`                                                    |


## Run livepeer

```bash
sonaric run -s passphrase=<passphrase> templates/local/livepeer/mainnet
```

Output:
```bash
🔩 templates/local/livepeer/mainnet
 └─🧊 Peer local
    └─🔩 templates/local/livepeer/mainnet
       └─📦 443db6b9f6c3b8ceeb07fe1e7290e90f-vepeer-mainnet-livepeer running
          ├─🧩 livepeer/go-livepeer:latest
          ├─💾 /Users/alexnelepa/.monk/volumes/livepeer/keystore -> /root/.lpData/mainnet/keystore
          ├─💾 /Users/alexnelepa/.monk/volumes/livepeer/state -> /da/state
          ├─🔌 open 188.146.32.63:1935 -> 1935
          ├─🔌 open (public) 188.146.32.63:8935 -> 8935
          ├─🔌 open 188.146.32.63:7935 -> 7935
          └─🔌 open (public) UDP 188.146.32.63:8935 -> 8935
```

### logs

```bash
*--------------*----------------------------*
| Network      | mainnet                    |
| ServiceAddr  | 188.146.32.63:8935         |
| Orchestrator | true                       |
| Transcoder   | true                       |
| OrchSecret   | asdf                       |
| MaxSessions  | 16                         |
| EthUrl       | https://eth.public-rpc.com |
*--------------*----------------------------*
I0904 12:30:46.468416       5 starter.go:405] ***Livepeer is running on the mainnet network: 0xf96d54e490317c557a967abfa5d6e33006be69b3***
I0904 12:30:47.228980       5 accountmanager.go:51] No Ethereum account found. Creating a new account
I0904 12:30:47.229261       5 accountmanager.go:52] This process will create a new Ethereum account for this Livepeer node
I0904 12:30:47.229389       5 accountmanager.go:55] Please enter a passphrase to encrypt the Private Keystore file for the Ethereum account.
I0904 12:30:47.229440       5 accountmanager.go:56] This process will ask for this passphrase every time it is launched
!! Unsupported terminal, password will be echoed.
Passphrase:
Repeat passphrase:
I0904 12:30:47.229473       5 accountmanager.go:57] (no characters will appear in Terminal when the passphrase is entered)
I0904 12:30:54.052589       5 accountmanager.go:80] Using Ethereum account: 0xa55fA88e73F05706002eEDc7C0634f6f6da731DE
I0904 12:30:57.133079       5 accountmanager.go:114] Unlocked ETH account: 0xa55fA88e73F05706002eEDc7C0634f6f6da731DE
I0904 12:30:58.319810       5 starter.go:783] Price: 800.000 wei per pixel

I0904 12:30:58.747219       5 starter.go:1450] Orchestrator 0xa55fA88e73F05706002eEDc7C0634f6f6da731DE is inactive
I0904 12:30:59.148347       5 starter.go:1012] Backfilling block events (this can take a while)...
I0904 12:30:59.230089       5 starter.go:1017] Done backfilling block events
I0904 12:30:59.237865       5 starter.go:1287] ***Livepeer Running in Orchestrator Mode***
I0904 12:30:59.238403       5 starter.go:1297] Livepeer Node version: 0.7.5-16246943
I0904 12:30:59.251090       5 cert.go:83] Private key and cert not found. Generating
I0904 12:30:59.252745       5 webserver.go:20] CLI server listening on 127.0.0.1:7935
I0904 12:30:59.264669       5 cert.go:22] Generating cert for 188.146.32.63
I0904 12:30:59.277131       5 rpc.go:207] Listening for RPC on :8935
```

### Stop, remove and clean up
Stop:
```bash
sonaric stop livepeer/mainnet
```
Purge:
```bash
sonaric purge livepeer/mainnet
```

## Template actions

### Import Key
Create a new key from a private key and import it into the node's key store.  
Key could be in hex or json format. If key is empty, a new key will be generated.
```bash
sonaric do templates/local/livepeer/mainnet/import-key password=test
```
Example output:
```
✔ Running action: 
{"address":"7ce17814a929693c3fee3d3953657631250ca649","mnemonic":"glance salute fever asset knee top response void tennis crisp toilet drama second village wide ceiling craft army half rotate pond judge offer annual"}
```

### Export Key
Export a key from the node's key store.
```bash
sonaric do templates/local/livepeer/mainnet/export-key address=7ce17814a929693c3fee3d3953657631250ca649 password=test
```
Example output:
```
✔ Running action: 
{"address":"7ce17814a929693c3fee3d3953657631250ca649","crypto":{"cipher":"aes-128-ctr","ciphertext":"5a91d7405ab57c5006dd54d4bbc915568dd6176638d368a9d152e39588c0c230","cipherparams":{"iv":"17a14fdbf97b87643a345dc8921f6e87"},"kdf":"scrypt","kdfparams":{"dklen":32,"n":262144,"p":1,"r":8,"salt":"13fae9c4ad777ba1265b0f60002b780e0833e41d32ed39b435c631afa4b5d0b3"},"mac":"56cfaac25e60d81e8d680cb57ccb688dabd9f2558e95783a12260edccc09295c"},"id":"81dbb40c-02bf-4e2f-9ff0-c1f8686b8915","version":3}
```

### List Keys
List addresses of all keys in the node's key store.
```bash
sonaric do templates/local/livepeer/mainnet/list-keys
```

Example output:
```
✔ Running action: 
UTC--2024-08-02T11-40-40.884271824Z--2c7bd35ed5427513c5deee37f401de234af003ed
```

## Troubleshooting
If you encounter any issues, please refer to the [Livepeer Troubleshooting Guide](https://docs.livepeer.org/orchestrators/guides/troubleshoot).



## Documentation and API References
Access detailed API documentation and examples:
- [livepeer Documentation](https://docs.livepeer.org/developers/introduction)
- [livepeer Repository](https://github.com/livepeer)
