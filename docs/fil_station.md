# Sonaric Filecoin Station Core Documentation

## Table of Contents
- [Overview](#overview)
- [Load Template](#load-template)
    - [Confirm templates loaded](#confirm-templates-loaded)
    - [Configuration](#configuration)
- [Run Filecoin Station Core](#run-filecoin-station-core)
    - [Logs](#logs)
    - [Address](#address)
    - [Balance](#balance)
- [Troubleshooting](#troubleshooting)
- [Documentation and API References](#documentation-and-api-references)

## Overview
Filecoin Station Core is a headless version of Filecoin Station that connects your computer's idle resources to the Filecoin network and rewards you with FIL. It is suitable for running on all kinds of servers.

## Load Template

```bash
cd filstation
sonaric load filstation.yaml
```
Confirm templates loaded:
```bash
foo@bar:~$ sonaric list filstation
✔ Got the list
Repository  Template                Version  Type      Tags        
local       filstation/headless-node          1.0.0    runnable  blockchain
```

## Configuration
If you already have an account, you can simply provide the private-key. If you don't have an account, it is mandatory to input the seed-phrase to create a new account.  
Setting **your own** wallet address is needed to **earn rewards**. You can also set a passphrase to secure the node.

| Name             | Type   | Description                                     | Required | Default Value                                             |
|------------------|--------|-------------------------------------------------|----------|-----------------------------------------------------------|
| `passphrase`     | string | The passphrase for securing the node.           | false    | -                                                         |

# Run Filecoin Station Core
    
```bash
sonaric run -s passphrase=<passphrase> filstation/headless-node
```
Output:
```bash
✔ Starting the run job: local/filstation/headless-node... DONE
✔ Preparing nodes DONE
✔ Checking/pulling images DONE
✔ Starting containers DONE
✔ Host ports have been added to container local-80f37e6c8d389fc56e32290e3f-tion-headless-node-node DONE
✔ Runnable templates/local/filstation/headless-node connections graph updating DONE
✔ Runnable templates/local/filstation/headless-node connections graph has been updated DONE
✔ Runnable templates/local/filstation/headless-node services initialization DONE
✔ Runnable templates/local/filstation/headless-node services have been initialized DONE
✔ New container local-80f37e6c8d389fc56e32290e3f-tion-headless-node-node created DONE
✔ Container local-80f37e6c8d389fc56e32290e3f-tion-headless-node-node has been started DONE
✔ Started local/filstation/headless-node
🔩 templates/local/filstation/headless-node
 └─🧊 Peer local
    └─🔩 templates/local/filstation/headless-node 
       └─📦 local-80f37e6c8d389fc56e32290e3f-tion-headless-node-node running
          ├─🧩 ghcr.io/filecoin-station/core:latest                                                            
          ├─💾 /Users/username/.monk/volumes/filstation/state -> /home/node/.local/state/filecoin-station-core
          └─💾 /Users/username/.monk/volumes/filstation/cache -> /home/node/.cache/filecoin-station-core
```
## Logs
To see the logs of the running node:
```bash
sonaric logs filstation/headless-node
```
```bash
(node:1) ExperimentalWarning: The Ed25519 Web Crypto API algorithm is an experimental feature and might change at any time
(Use `node --trace-warnings ...` to show where the warning was created)
Generated a new Station ID: 302a300506032b6570032100c4085e093f76c3b6f32064a1334f530ecd73320f94bfcd4abd5e29ca75465a29
[1/23/2025, 10:55:22 PM] INFO  Updating source code for Zinnia modules...
[spark]  ⇣ downloading source files via https://bafkreiavbi3i2o67itafv75swfqfz6tq253zcbyyidiwvibsjm6njh5qu4.ipfs.w3s.link?format=car
[spark]  ✓ /home/node/.cache/filecoin-station-core/sources/spark
[1/23/2025, 10:55:23 PM] INFO  Zinnia module source code up to date
[2025-01-23T22:55:23Z INFO  zinniad] Starting zinniad with config CliArgs { wallet_address: "0xE8cF08A71395FB5c80c4395865732712A9618763", station_id: "302a300506032b6570032100c4085e093f76c3b6f32064a1334f530ecd73320f94bfcd4abd5e29ca75465a29", state_root: "/home/node/.local/state/filecoin-station-core/modules/zinnia", cache_root: "/home/node/.cache/filecoin-station-core/modules/zinnia", files: ["spark/main.js"] }
[2025-01-23T22:55:23Z INFO  lassie] Starting Lassie Daemon
[2025-01-23T22:55:24Z INFO  lassie] Lassie Daemon is listening on port 35927
[1/23/2025, 10:55:24 PM] INFO  Spark started
{
  "totalJobsCompleted": 0,
  "rewardsScheduledForAddress": "0.0"
}
[2025-01-23T22:55:24Z INFO  zinniad] Starting module file:///home/node/.cache/filecoin-station-core/sources/spark/main.js
[1/23/2025, 10:55:24 PM] INFO  SPARK started reporting retrievals
[2025-01-23T22:55:24Z INFO  module:spark/main] Checking the current SPARK round...
[2025-01-23T22:55:24Z INFO  module:spark/main] Fetching round details at location /rounds/meridian/0x8460766edc62b525fc1fa4d628fc79229dc73031/24108
[2025-01-23T22:55:24Z INFO  module:spark/main] Current SPARK round: { roundId: "29532", startEpoch: "4645546" }
[2025-01-23T22:55:24Z INFO  module:spark/main]   10 max tasks per round
[2025-01-23T22:55:24Z INFO  module:spark/main]   666 retrieval tasks
```


## Address
To get the wallet address:
```bash
  sonaric do local/filstation/headless-node/address
```

```bash
✔ Get templates/local/filstation/headless-node actions list success
✔ Got action parameters
✔ Parse parameters success
✔ Running the action... DONE
✔ Running action: 
0x4966f571aeb27da14b767970143c4c8bfe37466d
```

## Balance
To check the amount of scheduled rewards for the wallet address:
```bash
sonaric do local/filstation/headless-node/balance
```

```bash
✔ Get templates/local/filstation/headless-node actions list success
✔ Got action parameters
✔ Parse parameters success
✔ Running the action... DONE
✔ Running action: 
0.000158027581917348
✨ Took: 1s
```

# Troubleshooting


# Documentation and API References
- [Filecoin Documentation](https://docs.filecoin.io/)
- [Station Core GitHub Repository](https://github.com/filecoin-station/core)