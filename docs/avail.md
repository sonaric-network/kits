# Sonaric Avail Documentation

## Table of Contents
- [Overview](#overview)
- [System Requirements](#system-requirements)
- [Getting Started](#getting-started)
  - [Load Templates](#load-templates)
  - [Configuration](#configuration)
- [Running Nodes](#running-nodes)
  - [Light Client](#light-client)
  - [Full Node](#full-node)
  - [RPC Node](#rpc-node)
  - [Validator Node](#validator-node)
    - [Validator Node Operations](#validator-node-operations)
    - [Staking a Validator](#staking-a-validator)
      - [Rotating Session Keys](#rotating-session-keys)
- [Common Tasks and Troubleshooting](#common-tasks-and-troubleshooting)
  - [Stop Workloads](#stop-workloads)
  - [Custom configuration](#custom-configuration)
  - [Telemetry error in logs](#telemetry-error-in-logs)
  - [Check sync status](#check-sync-status)
  - [Failed RPC requests](#failed-rpc-requests)
- [Documentation and API References](#documentation-and-api-references)

## Overview
Avail: The Unification Layer for Web3.0. For more comprehensive information, refer to the [Avail Documentation](https://docs.availproject.org/docs/introduction-to-avail).

## System Requirements
Hardware configuration required to set up an Avail node:

| Component | Minimum | Recommended |
|-----------|---------|-------------|
| RAM       | 8GB     | 16GB        |
| CPU (amd64/x86 architecture) | 4 core | 8 core |
| Storage (SSD) | 20-40 GB | 200-300 GB |

### Avail Networks
There are currently two Avail networks available: Goldberg Testnet and Turing Testnet.
As of now, Turing is the only supported testnet on Avail. 
Goldberg is deprecated and will be decomissioned soon, 
even though Avail will keep some critical infra for Goldberg alive for the time being, 
so we can keep using it. 

More information on the networks can be found in the [Avail documentation]https://docs.availproject.org/docs/networks).

## Getting Started

### Load Templates
```bash
cd sonaric-avail
sonaric load MANIFEST
```

**Confirm templates are loaded:**
```bash
foo@bar:~$ sonaric list avail
```
```
✔ Got the list
Repository  Template                  Version  Type      Tags        
local       avail/avail             1.0      runnable  blockchain  
local       avail/avail-rpc         1.0      runnable  blockchain  
local       avail/avail-turing      1.0      runnable  blockchain  
local       avail/light             1.0      runnable  blockchain  
local       avail/light-client      1.0      runnable  blockchain  
local       avail/rpc-node          1.0      runnable  blockchain  
local       avail/validator         1.0      runnable  blockchain  
local       avail/validator-dev     1.0      runnable  blockchain  
local       avail/validator-turing  1.0      runnable  blockchain
```


### Configuration
Template variables can be set to customize the node's behavior. The following variables can be configured:

| Name      | Type   | Description                                                                | Default Value                                                                   |
|-----------|--------|----------------------------------------------------------------------------|---------------------------------------------------------------------------------|
| `chain`   | string | Determines the blockchain chain that the node will sync with. (goldberg, turing, dev)              | `"goldberg"`                                                                    |
| `version` | string | Specifies the version of the Avail node software to be used.               | `v1.10.0.0`  for golberg, `v2.2.0.0-rc1` for turing, `v1.7.10` for light client |
| `name`    | string | Sets a name for the node to help identify it in the network.         | `SonaricAvail<chain>Node` e.g. `SonaricAvailTuringNode`                         |

## Running Nodes

- **Light Clients**: Interact with the blockchain without downloading the entire transaction history.
- **Full Nodes**: Maintain the blockchain's current state without storing its entire history.
- **Validator Nodes**: Specialized full nodes that participate in block production and network governance.
- **RPC Nodes**: Expose an API for remote interactions, serving as a gateway for developers and external clients to engage with the Avail network.

More information on node types can be found in the [Avail documentation](https://docs.availproject.org/docs/operate-a-node/node-types).

### Light Client

Run a light client using:
```bash
sonaric run templates/local/avail/light-client
```

```bash
✔ Started local/avail/light-client
🔩 templates/local/avail/light-client
 └─🧊 Peer local
    └─🔩 templates/local/avail/light-client 
       └─📦 local-67f7321515f37a99e457e8d62f-ient-avail-light-client running
          ├─🧩 availj/avail-light:v1.7.10                                              
          ├─💾 /Users/foobar/.sonaric/volumes/avail-lc/config -> /home/avail/config
          ├─💾 /Users/foobar/.sonaric/volumes/avail-lc/identity -> /home/avail/identity
          ├─💾 /Users/foobar/.sonaric/volumes/avail-lc/data -> /home/avail/data
          ├─🔌 open (public) 104.28.131.166:7001 -> 7001                 
          └─🔌 open (public) 104.28.131.166:37000 -> 37000
```


**Check the light client is running**
```bash
curl "http://104.28.131.166:7001/v1/latest_block"
```
Response:
```json
{"latest_block":864733}
```

**Check sync status**
```bash
foo@bar:~$ curl "http://104.28.131.166:7001/v1/confidence/1"
```
Sample Response:
```json
{
"block": 1,
"confidence": 93.75,
"serialised_confidence": "5232467296"
}
```
If confidence is not computed, and specified block is before the latest processed block:
```json
"Not synced"
```  
If confidence is not computed, and specified block is after the latest processed block:
```json
"Not found"
```
#### LC API Reference
Full Light Client API reference can be found [here](https://docs.availproject.org/docs/operate-a-node/run-a-light-client/light-client-api-reference).

**PORT change**     
Please note that Sonaic Avail uses port 7001 instead of 7000 in the Light Client API reference.


### Full Node

avail/avail uses goldberg as the default chain which is deprecated and will be decomissioned soon.
To run a turin node, run the avail/avail-turing template instead.

Run a full node using:
```bash
sonaric run templates/local/avail/avail
```

```
✔ Started local/avail/avail
🔩 templates/local/avail/avail
 └─🧊 Peer local
    └─🔩 templates/local/avail/avail 
       └─📦 local-ac3e9340527c8241808a081fa4-local-avail-avail-node running
          ├─🧩 availj/avail:v1.11.0.0                                           
          ├─💾 /Users/foobar/.sonaric/volumes/avail-goldberg/state -> /da/state
          ├─🔌 open (public) 104.28.131.167:30333 -> 30333        
          ├─🔌 open (public) 104.28.131.167:9944 -> 9944          
          └─🔌 open (public) 104.28.131.167:9615 -> 9615
```

Confirm the full node is running:
```bash
sonaric logs -f avail/avail
```
Logs should look similar to:
```
2024-05-29 04:22:32 Avail Node    
2024-05-29 04:22:32 ✌️  version 1.11.0-38304bb5126    
2024-05-29 04:22:32 ❤️  by Anonymous, 2017-2024    
2024-05-29 04:22:32 📋 Chain specification: Avail Goldberg Testnet    
2024-05-29 04:22:32 🏷  Node name: SonaricAvailNode    
2024-05-29 04:22:32 👤 Role: FULL    
2024-05-29 04:22:32 💾 Database: RocksDb at /da/state/chains/avail_goldberg_testnet/db/full    
2024-05-29 04:22:52 🔨 Initializing Genesis block/state (state: 0x6bc7…ec83, header-hash: 0x6f09…a7ae)    
2024-05-29 04:22:52 👴 Loading GRANDPA authority set from genesis on what appears to be first startup.    
2024-05-29 04:23:04 👶 Creating empty BABE epoch changes on what appears to be first startup.    
2024-05-29 04:23:04 🏷  Local node identity is: 12D3KooWLQf2F42wFDuH61Py3VdnoJds3vkT29j6evZbJLDxMNzR    
2024-05-29 04:23:04 Prometheus metrics extended with avail metrics    
2024-05-29 04:23:04 💻 Operating system: linux    
2024-05-29 04:23:04 💻 CPU architecture: x86_64    
2024-05-29 04:23:04 💻 Target environment: gnu    
2024-05-29 04:23:04 💻 Memory: 7916MB    
2024-05-29 04:23:04 💻 Kernel: 6.8.4-200.fc39.aarch64    
2024-05-29 04:23:04 💻 Linux distribution: Debian GNU/Linux 12 (bookworm)    
2024-05-29 04:23:04 💻 Virtual machine: no    
2024-05-29 04:23:04 📦 Highest known block at #0    
2024-05-29 04:23:04 〽️ Prometheus exporter started at 127.0.0.1:9615    
2024-05-29 04:23:04 Running JSON-RPC server: addr=127.0.0.1:9944, allowed origins=["http://localhost:*", "http://127.0.0.1:*", "https://localhost:*", "https://127.0.0.1:*", "https://polkadot.js.org"]    
2024-05-29 04:23:04 🏁 CPU score: 26.22 MiBs    
2024-05-29 04:23:04 🏁 Memory score: 3.23 GiBs    
2024-05-29 04:23:04 🏁 Disk score (seq. writes): 1.23 GiBs    
2024-05-29 04:23:04 🏁 Disk score (rand. writes): 16.40 MiBs    
2024-05-29 04:23:09 💤 Idle (0 peers), best: #0 (0x6f09…a7ae), finalized #0 (0x6f09…a7ae), ⬇ 0 ⬆ 0    
2024-05-29 04:23:14 💤 Idle (0 peers), best: #0 (0x6f09…a7ae), finalized #0 (0x6f09…a7ae), ⬇ 0 ⬆ 0    
2024-05-29 04:23:19 💤 Idle (0 peers), best: #0 (0x6f09…a7ae), finalized #0 (0x6f09…a7ae), ⬇ 0 ⬆ 0    
2024-05-29 04:23:24 💤 Idle (0 peers), best: #0 (0x6f09…a7ae), finalized #0 (0x6f09…a7ae), ⬇ 0 ⬆ 0    
2024-05-29 04:23:24 ❌ Error while dialing /dns/telemetry.avail.tools/tcp/8001/x-parity-ws/%2Fsubmit: Custom { kind: Other, error: Timeout }    
2024-05-29 04:23:29 💤 Idle (0 peers), best: #0 (0x6f09…a7ae), finalized #0 (0x6f09…a7ae), ⬇ 0 ⬆ 0    
2024-05-29 04:23:34 💤 Idle (0 peers), best: #0 (0x6f09…a7ae), finalized #0 (0x6f09…a7ae), ⬇ 0 ⬆ 0    
2024-05-29 04:23:35 🔍 Discovered new external address for our node: /ip4/79.110.128.77/tcp/30333/ws/p2p/12D3KooWLQf2F42wFDuH61Py3VdnoJds3vkT29j6evZbJLDxMNzR    
2024-05-29 04:23:39 ⚙️  Syncing 19.9 bps, target=#865312 (4 peers), best: #100 (0x0a93…ccc2), finalized #0 (0x6f09…a7ae), ⬇ 211.3kiB/s ⬆ 3.1kiB/s    
2024-05-29 04:23:44 ⚙️  Syncing 35.5 bps, target=#865312 (4 peers), best: #278 (0x16eb…31d1), finalized #0 (0x6f09…a7ae), ⬇ 18.7kiB/s ⬆ 0.1kiB/s    
2024-05-29 04:23:49 ⚙️  Syncing 34.3 bps, target=#865313 (4 peers), best: #450 (0xe7a3…8f23), finalized #0 (0x6f09…a7ae), ⬇ 13.4kiB/s ⬆ 67 B/s ```
```

### RPC Node

Deploy an RPC node using:
```bash
sonaric run templates/local/avail/rpc-node
```

RPC Node is based on the Full Node template, but with an additional JSON-RPC server running on port 9944.  
This allows external clients to interact with the node using JSON-RPC requests.
You can see available RPC methods by making `rpc_methods` request to the node.
```bash
curl -H "Content-Type: application/json" -d '{"id":1, "jsonrpc":"2.0", "method": "rpc_methods"}' http://localhost:9944
```
Response:
```json
{"jsonrpc":"2.0","result":{"methods":["account_nextIndex","author_hasKey","author_hasSessionKeys","author_insertKey","author_pendingExtrinsics","author_removeExtrinsic","author_rotateKeys","author_submitAndWatchExtrinsic","author_submitExtrinsic","author_unwatchExtrinsic","babe_epochAuthorship","chainHead_unstable_body","chainHead_unstable_call","chainHead_unstable_follow","chainHead_unstable_genesisHash","chainHead_unstable_header","chainHead_unstable_stopBody","chainHead_unstable_stopCall","chainHead_unstable_stopStorage","chainHead_unstable_storage","chainHead_unstable_unfollow","chainHead_unstable_unpin","chainSpec_unstable_chainName","chainSpec_unstable_genesisHash","chainSpec_unstable_properties","chain_getBlock","chain_getBlockHash","chain_getFinalisedHead","chain_getFinalizedHead","chain_getHead","chain_getHeader","chain_getRuntimeVersion","chain_subscribeAllHeads","chain_subscribeFinalisedHeads","chain_subscribeFinalizedHeads","chain_subscribeNewHead","chain_subscribeNewHeads","chain_subscribeRuntimeVersion","chain_unsubscribeAllHeads","chain_unsubscribeFinalisedHeads","chain_unsubscribeFinalizedHeads","chain_unsubscribeNewHead","chain_unsubscribeNewHeads","chain_unsubscribeRuntimeVersion","childstate_getKeys","childstate_getKeysPaged","childstate_getKeysPagedAt","childstate_getStorage","childstate_getStorageEntries","childstate_getStorageHash","childstate_getStorageSize","grandpa_proveFinality","grandpa_roundState","grandpa_subscribeJustifications","grandpa_unsubscribeJustifications","mmr_generateProof","mmr_root","mmr_verifyProof","mmr_verifyProofStateless","offchain_localStorageGet","offchain_localStorageSet","payment_queryFeeDetails","payment_queryInfo","state_call","state_callAt","state_getChildReadProof","state_getKeys","state_getKeysPaged","state_getKeysPagedAt","state_getMetadata","state_getPairs","state_getReadProof","state_getRuntimeVersion","state_getStorage","state_getStorageAt","state_getStorageHash","state_getStorageHashAt","state_getStorageSize","state_getStorageSizeAt","state_queryStorage","state_queryStorageAt","state_subscribeRuntimeVersion","state_subscribeStorage","state_traceBlock","state_trieMigrationStatus","state_unsubscribeRuntimeVersion","state_unsubscribeStorage","subscribe_newHead","sync_state_genSyncSpec","system_accountNextIndex","system_addLogFilter","system_addReservedPeer","system_chain","system_chainType","system_dryRun","system_dryRunAt","system_health","system_localListenAddresses","system_localPeerId","system_name","system_nodeRoles","system_peers","system_properties","system_removeReservedPeer","system_reservedPeers","system_resetLogFilter","system_syncState","system_unstable_networkState","system_version","transaction_unstable_submitAndWatch","transaction_unstable_unwatch","unsubscribe_newHead"]},"id":1}
```

More about RPC methods can be found in the [Substrate framework documentation](https://docs.substrate.io/build/remote-procedure-calls/).  
Polkadot docs also might be useful, since Avail uses it's SDK: [Polkadot RPC](https://wiki.polkadot.network/docs/build-node-interaction#polkadot-rpc).


### Validator Node
Deploy a validator node using:
```bash
sonaric run templates/local/avail/validator
```
```
✔ Started local/avail/validator
🔩 templates/local/avail/validator
 └─🧊 Peer local
    └─🔩 templates/local/avail/validator 
       └─📦 local-c41b2828a3cbbdcc57a0917532-al-avail-validator-node running
          ├─🧩 availj/avail:v1.11.0.0                                                   
          ├─💾 /Users/foobar/.sonaric/volumes/avail-validator/node-data -> /da/node-data
          ├─🔌 open 104.28.131.166:9615 -> 9615                           
          ├─🔌 open (public) 104.28.131.166:9944 -> 9944                  
          └─🔌 open (public) TCP 104.28.131.166:30333 -> 30333
```

## Validator Node Operations

## Staking a Validator
Staking involves committing tokens to support network operations, providing security, and earning rewards. Validators
must stake a minimum amount to participate in consensus.


First you need to go to [Avail Explorer](https://explorer.avail.so/) and create a new account.  
Then you need to fund your account with some AVAIL tokens.  
More details on how to stake can be found [here](https://docs.availproject.org/docs/operate-a-node/become-a-validator/stake-your-validator).  
Sonaric implements session key rotation for validators. (Step 2 from the [doc](https://docs.availproject.org/docs/operate-a-node/become-a-validator/stake-your-validator#rotating-session-keys))


### Rotating Session Keys
Rotating session keys enhances security by updating the cryptographic keys used for validator operations.   
This prevents long-term exposure and potential key compromise.


> **Warning!**  
> Ensure your node is fully synchronized before rotating keys.   
> You can check the sync status by running sonaric [status action](#check-sync-status)

Generate new keys:
```bash
sonaric do templates/local/avail/validator/keys-rotate
```
example output:
```
✔ Running action: 
{"jsonrpc":"2.0","result":"0x2892f8248ae609aa5e608504104f69c7acbec803437534e7d9eaaeccb0c6d613c881fef5a202a652c03c35b1baaeebf0c2dc0597e45594744441fa28702fb3971e3b72533e11ea72221ed52d5c9a04aa1415e2a456e2ce6f00b29cfa13b6806ff60078d39145fbb98fd4acd37579821cc8c35c79fa0a4829dde3fb0c5817e417","id":1}
Restarting the service
```

Save the hex-encoded result. You don't need to restart the node, since sonaric actions took care of that.  
You must inform the network of your Session keys and register your validator. Please follow the link to official Avail doc for [full guide](https://docs.availproject.org/docs/operate-a-node/become-a-validator/stake-your-validator#submit-session-keys)

## Common Tasks and Troubleshooting

### Stop Workloads
To stop workloads, use the `sonaric stop` command:
```bash
sonaric stop avail/validator
```
```
foo@bar:~$ sonaric stop avail/validator
✔ Stopping templates/local/avail/validator... DONE
✔ Stopping container: local-c41b2828a3cbbdcc57a0917532-al-avail-validator-node DONE
✔ Stopping containers DONE
✔ templates/local/avail/validator stopped successfully
```
To purge workloads, use the `sonaric purge` command:
```bash
sonaric purge avail/validator
```
```
foo@bar:~$ sonaric purge avail/validator
WARNING! This will remove:
🔩 templates/local/avail/validator
 └─📦 local-c41b2828a3cbbdcc57a0917532-al-avail-validator-node
? Are you sure? Yes
✔ Deleting templates/local/avail/validator ... DONE
✔ templates/local/avail/validator deleted successfully
```
### Custom configuration

**Light Client template variables**

| Name      | Type   | Description                                                                         |
|-----------|--------|-------------------------------------------------------------------------------------|
| `port`   | string | LibP2P listener port (overrides port from config file).                             |
| `seed` | string | Seed string for libp2p keypair generation.                                          |
| `secret-key` | string | Ed25519 private key for libp2p keypair generation.                                  |
| `finality-sync-enable` | bool | Enable finality sync. (default: false)                                              |

**Full Node template variables**  

| Name      | Type   | Description                                                                         |
|-----------|--------|-------------------------------------------------------------------------------------|
| `chain`   | string | Determines the blockchain chain that the node will sync with. (goldberg, turing, dev)|
| `version` | string | Specifies the version of the Avail node software to be used.                        |
| `name`    | string | Sets a name for the node to help identify it in the network.                         |

### Telemetry error in logs
If encountering telemetry connection errors:
```bash
❌ Error while dialing /dns/telemetry.avail.tools/tcp/8001/x-parity-ws/%2Fsubmit: Custom { kind: Other, error: Timeout }
```
This error often resolves itself and does not impact node operations other than telemetry reporting.

### Check sync status
Sonaric Avail template has action to check if the node is synced.  
```bash
sonaric do templates/local/avail/avail/health
```
Example output:
```
✔ Running action: 
{"jsonrpc":"2.0","result":{"peers":7,"isSyncing":true,"shouldHavePeers":true},"id":1}
```

If node is still syncing, you will see `"isSyncing":true` in the output.  
You should wait until the node is fully synced before operations like staking or rotating keys.

### Failed RPC requests
If RPC requests fail, ensure the node is running and the correct port is used.  
Node may need a few minutes to start up and start to sync with the network.
Ensure you are running `avail-rpc` since the full node does not expose the RPC port by default!  
As example we use `author_rotateKeys` RPC method from docs:

```
curl -sS -H 'Content-Type: application/json' -d '{"id":1, "jsonrpc":"2.0", "method": "author_rotateKeys", "params":[]}' http://127.0.0.1:9944  
curl: (56) Recv failure: Connection reset by peer
```

You can, however, use the RPC methods for debugging purposes if you connect to container's shell and run the curl command from there.  
You can use `sonaric shell` to connect to the container's shell.

```bash
 monk shell templates/local/avail/validator-turing
 ```
```
# curl -H 'Content-Type: application/json' -d '{"id":1, "jsonrpc":"2.0", "method": "author_rotateKeys", "params":[]}' http://127.0.0.1:9944
{"jsonrpc":"2.0","result":"0xeca6c5e10cf9c3293401750cb6e3b847d2cdda6023dcb1f614e3f07f35259046d9730805d03beafc02279ceb22a4a48e34e5e951a9139b848dcdf1ed9d71039d1213b10543f09445b2eb57047029a300110c6f1e1129494142982757f1ecdd3498308230ede0642bc05ff55da4ad0df85184848e1868908c41300661b8e20e51","id":1}# 
# 

```

## Documentation and API References
Access detailed API documentation and examples:
- [Avail Documentation](https://docs.availproject.org/docs/introduction-to-avail)
- [Light Client API Reference](https://docs.availproject.org/docs/operate-a-node/run-a-light-client/light-client-api-reference)
