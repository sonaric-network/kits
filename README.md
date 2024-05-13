### Docs
[Docs](https://github.com/sonaric-network/kits/tree/main/docs)

## Templates

- [Mina](https://github.com/sonaric-network/kits/tree/main/docs/mina.md)
- [Ritual](https://github.com/sonaric-network/kits/tree/main/docs/ritual.md)
- [Avail](https://github.com/sonaric-network/kits/tree/main/docs/avail.md)
- [Eigen Layer](https://github.com/sonaric-network/kits/tree/main/docs/eigen-layer.md)


## Load Template

```bash
sonaric load MANIFEST
```
Output:
```bash
Loaded 28 runnables, 0 process groups, 0 services, 0 entities and 5 entity instances from 6 files
✨ Loaded:
 ├─🔩 Runnables:
 │  ├─🧩 avail/full-node
 │  ├─🧩 avail/light-client
 │  ├─🧩 avail/validator
 │  ├─🧩 avail/rpc-node
 │  ├─🧩 avail/turing
 │  ├─🧩 mina/mainnet
 │  ├─🧩 mina/devnet
 │  ├─🧩 mina/sandbox
 │  ├─🧩 ethereum/sepolia-pruned
 │  ├─🧩 ethereum/mainnet
 │  ├─🧩 ethereum/holesky-pruned
 │  ├─🧩 ethereum/goerli
 │  ├─🧩 ethereum/holesky
 │  ├─🧩 ethereum/sepolia
 │  ├─🧩 ethereum/goerli-pruned
 │  ├─🧩 ethereum/mainnet-pruned
 │  ├─🧩 ethereum/base
 │  ├─🧩 gnosis/mainnet
 │  ├─🧩 gnosis/chiado-pruned
 │  ├─🧩 gnosis/mainnet-pruned
 │  ├─🧩 gnosis/chiado
 │  ├─🧩 polygon/mumbai
 │  ├─🧩 polygon/mainnet-pruned
 │  ├─🧩 polygon/mumbai-pruned
 │  ├─🧩 polygon/mainnet
 │  ├─🧩 solana/beta
 │  ├─🧩 solana/edge
 │  └─🧩 solana/stable
 └─⚙️ Entity instances:
    ├─🧩 avail/light-client/requirements
    ├─🧩 avail/avail-common/requirements
    ├─🧩 mina/base/requirements
    ├─🧩 ethereum/base/requirements
    └─🧩 solana/common/requirements
✔ All templates loaded successfully
```

### Run gnosis mainnet

```bash
sonaric run gnosis/mainnet
```
Output:
```bash
✔ Started local/gnosis/mainnet
🔩 templates/local/gnosis/mainnet
 └─🧊 Peer local
    └─🔩 templates/local/gnosis/mainnet
       └─📦 local-f2bcba1ec616d5457ce3bdc89f-l-gnosis-mainnet-erigon running
          ├─🧩 thorax/erigon:v2.58.2
          ├─🔌 open (public) UDP 188.146.114.165:4000 -> 4000
          ├─🔌 open TCP 188.146.114.165:42069 -> 42069
          ├─🔌 open (public) UDP 188.146.114.165:30304 -> 30304
          ├─🔌 open (public) UDP 188.146.114.165:30303 -> 30303
          ├─🔌 open UDP 188.146.114.165:42069 -> 42069
          ├─🔌 open (public) TCP 188.146.114.165:4001 -> 4001
          ├─🔌 open (public) TCP 188.146.114.165:30303 -> 30303
          ├─🔌 open (public) TCP 188.146.114.165:8545 -> 8545
          └─🔌 open (public) TCP 188.146.114.165:30304 -> 30304
```

## Stop, remove and clean up workloads and templates

```bash
sonaric purge gnosis/mainnet
```