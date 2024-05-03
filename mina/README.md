# sonaric-mina

Mina basic templates


## Prerequisites

- [Install Monk](https://docs.monk.io/docs/get-monk)
- [Register and Login Monk](https://docs.monk.io/docs/acc-and-auth)
- [Add Cloud Provider](https://docs.monk.io/docs/cloud-provider)
- [Add Instance](https://docs.monk.io/docs/multi-cloud)

### Make sure monkd is running

```bash
foo@bar:~$ monk status
daemon: ready
auth: logged in
not connected to cluster
```


### Generate Mina keypair

[Generate Mina keypair](https://docs.minaprotocol.com/node-operators/generating-a-keypair)



### Run mina sandbox

```bash
monk run mina/sandbox
```
Output:
```bash
✔ Started local/mina/sandbox
🔩 templates/local/mina/sandbox
 └─🧊 Peer minatest2
    └─🔩 templates/local/mina/sandbox 
       └─📦 e37d5647c78d56b5c3f396943a286d21-local-mina-sandbox-mina running
          ├─🧩 minaprotocol/mina-daemon:1.3.0-9b0369c-bullseye-devnet
          └─🔌 open (public) 34.88.82.185:3085 -> 3085

```

After few minutes graphql endpoint will be available at http://34.88.82.185:3085/graphql
(Replace with your IP from the output)

[GraphQL API](https://docs.minaprotocol.com/node-developers/graphql-api)

### Run mina devnet/mainnet

You need to set your `private-key-password` variable in runnable template. 
We will generate a new private key before mina daemon start.

Also, you need to set `libp2p-password` variable in a template. (optional for `mainnet`)
We will generate a new libp2p key before mina daemon start.

The keys will be generated only on the first run. 


### Actions:
#### Node status:
````bash
monk do templates/local/mina/devnet/status
````
Example output:
```bash
Mina daemon status
-----------------------------------

Global number of accounts:                     11553
Block height:                                  303627
Max observed block height:                     303887
Max observed unvalidated block height:         0
Local uptime:                                  10m58s
...
```

#### Get public key:
```bash
monk do templates/local/mina/devnet/get-public-key
```
```bash
monk do templates/local/mina/mainnet/get-public-key
```
Example output:
```bash
✔ Running action: 
B62qk1TxzXVyp736wQ333dJdUx2Rwsb4ygknR7vfeBSZp9hnn8vn9Xj
```
#### Get encrypted private key:
```
monk do templates/local/mina/devnet/get-private-key
```
```bash
monk do templates/local/mina/mainnet/get-private-key
```
Example output:
```bash
{"box_primitive":"xsalsa20poly1305","pw_primitive":"argon2i","nonce":"75vSdB7xzoTfZF6iX5jkMRvKcGfP6pRRsJxvxFC","pwsalt":"A9sD4Kmw9JNHvhgyDVLa5vBkD6RG","pwdiff":[134217728,6],"ciphertext":"CTiNYK6SeKwSgCd2iSf2gmzqUhEU9Wu1bK8H9wNU5E2bR4kUTJrLJ1RAmk9zi2vhyHN7ngeWA"}
```
### Get libp2p peer id:
```bash
monk do templates/local/mina/devnet/get-peer-id
```
```bash
monk do templates/local/mina/mainnet/get-peer-id
```



