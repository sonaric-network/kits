# Sonaric Quilibrium Documentation

## Table of Contents
- [Overview](#overview)
- [Load Template](#load-template)
    - [Confirm templates loaded](#confirm-templates-loaded)
- [Run Quilibrium](#run-quilibrium)
- [logs](#logs)
- [Template Actions](#template-actions)
    - [Export key](#export-key)
    - [Import key](#import-key)
- [Documentation and API References](#documentation-and-api-references)

### Overview

### Load Template

```bash
cd quilibrium
sonaric load MANIFEST
```

#### Confirm templates loaded

```bash
foo@bar:~$ sonaric list quilibrium
✔ Got the list
Repository  Template                     Version  Type      Tags
local       quilibrium/default-node               runnable  blockchain
```

### Run Quilibrium

Run a Quilibrium node using:

```bash
sonaric run quilibrium/default-node
```

Output:
```
templates/local/quilibrium/default-node
 └─🧊 Peer test-oleksii
    └─🔩 templates/local/quilibrium/default-node
       └─📦 47fa906a15d90525de913f71b474a4ed-brium-default-node-node running
          ├─🧩 avacalho/quilibrium:2.0.6.3
          ├─💾 /var/lib/monkd/volumes/config-data -> /ceremonyclient/node/.config
          ├─🔌 open (public) TCP 104.210.38.254:8337 -> 8337
          ├─🔌 open (public) TCP 104.210.38.254:8336 -> 8336
          ├─🔌 open (public) TCP 104.210.38.254:8338 -> 8338
          └─🔌 open (public) UDP 104.210.38.254:8336 -> 8336
```

### Logs
```bash
sonaric logs quilibrium/default-node
```
Output:
```
Signature check disabled, skipping...
████████████████████████████████████████████████████████████████████████████████
████████████████████████████████████████████████████████████████████████████████
██████████████████████████████                    ██████████████████████████████
█████████████████████████                              █████████████████████████
█████████████████████                                      █████████████████████
██████████████████                                            ██████████████████
████████████████                     ██████                     ████████████████
██████████████                ████████████████████                ██████████████
█████████████             ████████████████████████████              ████████████
███████████            ██████████████████████████████████            ███████████
██████████           ██████████████████████████████████████           ██████████
█████████          ██████████████████████████████████████████          █████████
████████          ████████████████████████████████████████████          ████████
███████          ████████████████████      ████████████████████          ███████
██████          ███████████████████          ███████████████████          ██████
█████          ███████████████████            ███████████████████          █████
█████         ████████████████████            ████████████████████         █████
████         █████████████████████            █████████████████████         ████
████         ██████████████████████          ██████████████████████         ████
████        █████████████████████████      █████████████████████████        ████
████        ████████████████████████████████████████████████████████        ████
████        ████████████████████████████████████████████████████████        ████
████        ████████████████████  ████████████  ████████████████████        ████
████        ██████████████████                   ███████████████████        ████
████         ████████████████                      ████████████████         ████
████         ██████████████            ██            ██████████████         ████
█████        ████████████            ██████            ████████████        █████
█████         █████████            ██████████            █████████         █████
██████         ███████           █████████████             ███████        ██████
██████          ████████       █████████████████            ████████      ██████
███████          █████████   █████████████████████            ████████   ███████
████████           █████████████████████████████████            ████████████████
█████████           ██████████████████████████████████            ██████████████
██████████            ██████████████████████████████████           █████████████
████████████             ████████████████████████████████            ███████████
█████████████               ███████████████████████████████            █████████
███████████████                 ████████████████    █████████            ███████
█████████████████                                     █████████            █████
████████████████████                                    █████████         ██████
███████████████████████                                  ██████████     ████████
███████████████████████████                          ███████████████  ██████████
█████████████████████████████████              █████████████████████████████████
████████████████████████████████████████████████████████████████████████████████
████████████████████████████████████████████████████████████████████████████████

                      Quilibrium Node - v2.0.6-p3 – Dusk

Creating config directory .config
Generating default config...
Generating random host key...
Generating keystore key...
Saving config...
Clearing test data...
Loading ceremony state and starting node...
Spawning 10 data workers...
Signature check disabled, skipping...
Signature check disabled, skipping...
Signature check disabled, skipping...
Signature check disabled, skipping...
{"level":"info","ts":1738176318.2423236,"caller":"rpc/data_worker_ipc_server.go:157","msg":"data worker listening","address":"/ip4/127.0.0.1/tcp/40001"}
Signature check disabled, skipping...
Signature check disabled, skipping...
Signature check disabled, skipping...
{"level":"info","ts":1738176318.2460296,"caller":"rpc/data_worker_ipc_server.go:157","msg":"data worker listening","address":"/ip4/127.0.0.1/tcp/40009"}
{"level":"info","ts":1738176318.24604,"caller":"rpc/data_worker_ipc_server.go:157","msg":"data worker listening","address":"/ip4/127.0.0.1/tcp/40007"}
{"level":"info","ts":1738176318.2460577,"caller":"rpc/data_worker_ipc_server.go:157","msg":"data worker listening","address":"/ip4/127.0.0.1/tcp/40002"}
{"level":"info","ts":1738176318.2465932,"caller":"rpc/data_worker_ipc_server.go:157","msg":"data worker listening","address":"/ip4/127.0.0.1/tcp/40003"}
{"level":"info","ts":1738176318.2472634,"caller":"rpc/data_worker_ipc_server.go:157","msg":"data worker listening","address":"/ip4/127.0.0.1/tcp/40005"}
{"level":"info","ts":1738176318.2484286,"caller":"rpc/data_worker_ipc_server.go:157","msg":"data worker listening","address":"/ip4/127.0.0.1/tcp/40000"}
Signature check disabled, skipping...
{"level":"info","ts":1738176318.24934,"caller":"rpc/data_worker_ipc_server.go:157","msg":"data worker listening","address":"/ip4/127.0.0.1/tcp/40008"}
Signature check disabled, skipping...
Signature check disabled, skipping...
{"level":"info","ts":1738176318.252806,"caller":"rpc/data_worker_ipc_server.go:157","msg":"data worker listening","address":"/ip4/127.0.0.1/tcp/40006"}
{"level":"info","ts":1738176318.2534554,"caller":"rpc/data_worker_ipc_server.go:157","msg":"data worker listening","address":"/ip4/127.0.0.1/tcp/40004"}
```

### Stop, remove and clean up
Stop:
```bash
sonaric stop quilibrium/default-node
```
Purge:
```bash
sonaric purge quilibrium/default-node
```

## Template Actions

### Import Key
Import a key to the node's key store.
```bash
sonaric do templates/local/quilibrium/default-node/import-key privkey=
```

### Import Config
Import a configuration file to the node.
```bash
sonaric do templates/local/quilibrium/default-node/import-config config=
```

### Export Key
Export a key from the node's key store.
```bash
sonaric do templates/local/quilibrium/default-node/export-key
```

### Export Config
Export a configuration file from the node.
```bash
sonaric do templates/local/quilibrium/default-node/export-config
```

## Documentation and API References
Access detailed API documentation and examples:
- [Quilibrium Documentation](https://quilibrium.guide/release-change-log)
- [Quilibrium Repository](https://github.com/QuilibriumNetwork/ceremonyclient)
- [Quilibrium Discord Support](https://discord.com/invite/quilibrium)