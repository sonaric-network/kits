# Sonaric Fuel Documentation

## Table of Contents
- [Overview](#overview)
- [System Requirements](#system-requirements)
- [Getting Started](#getting-started)
    - [Load Templates](#load-templates)
    - [Configuration](#configuration)
    - [Run fuel node](#run-fuel-node)
- [Fuel Template Actions](#fuel-template-actions)
    - [Export mnemonic phrase](#export-mnemonic-phrase)
    - [Export address](#export-address)
- [Documentation and API References](#documentation-and-api-references)

## Overview
Fuel is a modular execution layer designed to enhance scalability,
efficiency, and flexibility for blockchain-based applications.
Originally introduced as a scalable layer-2 solution for Ethereum,
Fuel has evolved into a general-purpose blockchain execution platform.
It is built to address the limitations of traditional blockchain architectures, such as high transaction costs,
limited throughput, and poor developer experience.

## System Requirements
Hardware configuration required to set up an Fuel node:

| Component                    | Minimum  | Recommended  |
|------------------------------|----------|--------------|
| RAM                          | 8GB      | 16GB         |
| CPU (amd64/x86 architecture) | 4 core   | 8 core       |
| Storage (SSD)                | 20-40 GB | 200-300 GB   |

## Getting Started

### Load Templates
```bash
cd fuel
sonaric load MANIFEST
```

**Confirm templates are loaded:**
```bash
foo@bar:~$ sonaric list fuel
```
```
✔ Got the list
Repository  Template               Version  Type      Tags        
local       fuel/mainnet           -        runnable  blockchain, protocol, rust
local       fuel/testnet           -        runnable  blockchain, protocol, rust
```

### Configuration
Template variables can be set to customize the node's behavior. The following variables can be configured:

| Name          | Type   | Description     | Default Value |
|---------------|--------|-----------------|---------------|
| `password`    | string | Password        | `""`          |     
| `private-key` | string | Set private key | ``            |

### Run Fuel node

- **Testnet**: Interact with the test blockchain network.
- **Mainnet**: Interact with the main blockchain network.

```bash
sonaric run -s password=<password> -s private-key=<private-key> fuel/mainnet
```

Output:
```bash
🔩 templates/local/fuel/mainnet
 └─🧊 Peer test-oleksii
    └─🔩 templates/local/fuel/mainnet
       └─📦 e9231580f8c43717655e97390fe8a2ac-local-fuel-mainnet-node running
          ├─🧩 sonaric.azurecr.io/public/fuel-core:latest
          ├─💾 /var/lib/monkd/volumes/fuel-data -> /var/lib/fuel
          ├─🔌 open (public) TCP 40.83.218.181:30303 -> 30303
          └─🔌 open (public) TCP 40.83.218.181:8545 -> 8545
```

## Fuel Template Actions

### Export mnemonic phrase
Export the mnemonic phrase of the wallet.

```bash
sonaric do templates/local/fuel/mainnet export-mnemonic-phrase
```

### Export address
Export the address of the account.

```bash
sonaric do templates/local/fuel/mainnet export-address
```


## Documentation and API References
Access detailed API documentation and examples:
- [Fuel Documentation](https://docs.fuel.network/docs/intro/what-is-fuel/)
- [GitHub Repository](https://github.com/FuelLabs/fuel-core)


