
## Load Template

```bash
cd sonaric-avail
sonaric load MANIFEST
```

### Confirm templates loaded

```bash
foo@bar:~$ sonaric list avail
✔ Got the list
Type      Template             Repository  Version  Tags
runnable  avail/full-node      local       1.0        blockchain
runnable  avail/rpc-node       local       1.0        blockchain
runnable  avail/light-client   local       -          blockchain

```
## avail/full-node usage example:
### locally:
```bash
curl -H "Content-Type: application/json" -d '{"id":1, "jsonrpc":"2.0", "method": "rpc_methods"}' http://localhost:9944/
```
response:
```json
{"jsonrpc":"2.0","result":{"methods":["account_nextIndex", "...", "system_version","transaction_unstable_submitAndWatch","transaction_unstable_unwatch","unsubscribe_newHead"]},"id":1}
```

### cloud deployment:
```bash
foo@bar:~$ sonaric describe avail/full-node
✔ Got avail/full-node
✨ Success!
🔩 templates/local/avail/full-node
 └─🧊 Peer <PEER_NAME>
    └─🔩 templates/local/avail/full-node 
       └─📦 c015916b26b9550596f04c591c4f137c-ic-avail-full-node-node running
          ├─🧩 availj/avail:v1.10.0.0                           
          ├─💾 /var/lib/monkd/volumes/avail-full-node/state -> /da/state
          ├─🔌 open (public) 34.68.212.246:9944 -> 9944 # <- CLOUD NODE IP
          ├─🔌 open (public) 34.68.212.246:9615 -> 9615 
          └─🔌 open (public) 34.68.212.246:30333 -> 30333

```
`curl -H "Content-Type: application/json" -d '{"id":1, "jsonrpc":"2.0", "method": "rpc_methods"}' <CLOUD_NODE_IP>:9944/`

## sonaric-avail/light-client usage example:
`curl "http://localhost:7000/v1/confidence/1"`

## Stop, remove and clean up workloads and templates

```bash
sonaric purge sonaric-avail/full-node
sonaric purge sonaric-avail/light-client
```


## Configuration
### Full Node Variables

| Name          | Type   | Description                                                                 | Default Value                                    |
|---------------|--------|-----------------------------------------------------------------------------|--------------------------------------------------|
| `version`     | string | Specifies the version of the Avail node software to be used.                | `"v1.10.0.0"`                                    |
| `chain`       | string | Determines the blockchain chain that the node will sync with.               | `"goldberg"`                                     |
| `name`        | string | Sets a unique name for the node to help identify it in the network.         | `"MonkAvailNode"`                                |

### RPC Node Variables

| Name         | Type   | Description                                          | Default Value  |
|--------------|--------|------------------------------------------------------|----------------|
| `rpc-port`   | int    | Defines the port on which the RPC server will listen.| `9944`         |
| `rpc-cors`   | string | Sets the CORS policy for the RPC server.             | `"all"`        |


## Light Client
More information about the light client can be found [here](https://github.com/availproject/avail-light?tab=readme-ov-file)

### Light Client Variables

| Name         | Type   | Description                                               | Default Value |
|--------------|--------|-----------------------------------------------------------|---------|
| `network`    | string | Network where the node is syncing. (e.g. goldberg, local) | `""` |
| `config-path`| string | Path to the configuration file.                            | `"/home/avail/config.toml"` |
| `identity-path`| string | Path to the identity file.                                | `"/home/avail/identity.toml"` |
| `port`       | string | LibP2P listener port (overrides port from config file).   |  |
| `avail-passphrase`| string | Avail secret seed phrase password.                        |  |
| `seed`      | string | Seed string for libp2p keypair generation.                | |
| `secret-key `| string | Ed25519 private key for libp2p keypair generation.        |  |


NOTE Flags and options take precedence to the configuration file if both are set (i.e. --port option overwrites the port parameter from the config file).

#### config.toml
Configuration reference for the light client.

https://github.com/availproject/avail-light?tab=readme-ov-file#configuration-reference

#### identity.toml
In the Avail network, a light client's identity can be configured using the identity.toml file. If not specified, a secret seed phrase will be generated and stored in the identity file when the light client starts. To use an existing seed phrase, set the avail_secret_seed_phrase entry in the identity.toml file. Seed phrase will be used to derive Sr25519 key pair for signing. Location of the identity file can be specified using --identity option.
WARNING: This file contains a private key. Please ensure only authorized access and prefer using encrypted storage.

### Use light client API

API reference: [usage] https://github.com/availproject/avail-light?tab=readme-ov-file#usage-and-examples


example (light client deployed on instance with IP 35.222.191.87)
it might take a few minutes for the API to be available
````
curl "http://35.222.191.87:7000/v1/latest_block"
{"latest_block":714729}%

curl "http://35.222.191.87:7000/v1/status"      
{"block_num":714738,"confidence":87.5,"app_id":0}
````

## Validator node

Run the following command to deploy a validator node
```bash
sonaric load MANIFEST && sonaric run templates/local/avail/validator
```

| Name          | Type   | Description                                                                 | Default Value                                    |
|---------------|--------|-----------------------------------------------------------------------------|--------------------------------------------------|
| `version`     | string | Specifies the version of the Avail node software to be used.                | `"v1.8.0.7"`                                    |
| `chain`       | string | Determines the blockchain chain that the node will sync with.               | `"goldberg"`                                     |
| `name`        | string | Sets a unique name for the node to help identify it in the network.         | `"MonkAvailValidator"`                                |

### Rotate session keys

More about session keys can be found [here](https://docs.availproject.org/docs/operate-a-node/become-a-validator/0030-session-keys/)

Our template provides a helper action to generate session keys for a validator node. 
Run the following command:
```bash
sonaric do templates/local/avail/validator/generate-session-keys
```
example output:
```
✔ Get templates/local/avail/validator actions list success
✔ Got action parameters
✔ Parse parameters success
✔ Running the action... DONE
✔ Running action: 
{"jsonrpc":"2.0","result":"0x98d5767f35312f96b6c6e4073524e6aab8581fd1ee42301149fbfc86e90d4c1136d5489ff9b85fbffcb82942a3c75a53527da34aa49d1a267ab96bab7d6d853006d600623c53f28a0e16caf51b56a3e98e14b3eec17c95e3f3571cb1365d52750c22d67d13579b33e74f37a072852c6894855a1b85caef1523a1e8a16488ad7d","id":1}
✨ Took: 2s
```

The result is the concatenation of the four public keys. **Save** the hex-encoded result for the next step and **restart** your node.
```bash
monk restart templates/local/avail/validator
```

### Stake a validator

More about staking can be found [here](https://docs.availproject.org/docs/operate-a-node/become-a-validator/0020-staking/)

