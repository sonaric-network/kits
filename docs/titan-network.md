# Sonaric Titan Network Documentation

## Table of Contents
- [Overview](#overview)
- [Load Template](#load-template)
    - [Confirm templates loaded](#confirm-templates-loaded)
- [Run Titan Network](#run-titan-network)
- [logs](#logs)
- [Template Actions](#template-actions)
    - [Export key](#export-key)
- [Documentation and API References](#documentation-and-api-references)

### Overview
Titan Network is a digital resource network designed to match idle community resources with global demand, enabling the aggregation or deployment of hardware resources to provide interchangeable digital resources such as computing, storage, and bandwidth. It features built-in economic incentives and network design to reward contributors while delivering high-quality results to end-users. The platform is open-source, has a low barrier to entry, and aims to facilitate the construction of the Internet of Value.

### Load Template

```bash
cd titan-network
sonaric load MANIFEST
```

#### Confirm templates loaded

```bash
foo@bar:~$ sonaric list titan-network
✔ Got the list
Repository  Template                     Version  Type      Tags
local       titan-network/l2-edge-node            runnable  blockchain
```

### Run Titan Network

Run a Titan Network node using:

```bash
sonaric run titan-network/l2-edge-node
```

Output:
```
🔩 templates/local/titan-network/l2-edge-node
 └─🧊 Peer test-oleksii
    └─🔩 templates/local/titan-network/l2-edge-node
       └─📦 a6a9db4e41d73486d725684837f017d2-twork-l2-edge-node-node running
          ├─🧩 nezha123/titan-edge:latest
          └─💾 /var/lib/monkd/volumes/titan-edge-storage -> /root/.titanedge
```

### Logs
```bash
sonaric logs titan-network/l2-edge-node
```
Output:
```
2025-01-20T18:48:49.975Z	INFO	repo	repo/fsrepo.go:248	Initializing repo at '/root/.titanedge'
2025/01/20 18:48:50 failed to sufficiently increase send buffer size (was: 208 kiB, wanted: 2048 kiB, got: 416 kiB). See https://github.com/quic-go/quic-go/wiki/UDP-Buffer-Sizes for details.
2025-01-20T18:48:50.618Z	INFO	main	titan-edge/main.go:178	Register new node
2025-01-20T18:48:51.484Z	INFO	main	titan-edge/daemon.go:143	Remote version 0.1.20+1227_1_main3+api1.0.0
2025-01-20T18:48:51.485Z	INFO	builder	node/builder_edge.go:48	start to config edge
2025-01-20T18:48:51.487Z	WARN	jwt	secret/secret.go:43	Generating new API secret
2025-01-20T18:48:51.715Z	INFO	main	titan-edge/daemon.go:224	New titan daemon
workerd/server/go.c++:360: warning: init runtime with empty report url, events will not be report
2025-01-20T18:48:51.720Z	INFO	main	titan-edge/main.go:425	Edge listen on tcp/udp 0.0.0.0:1234
2025-01-20T18:48:51.723Z	INFO	main	titan-edge/heartbeat.go:55	Making sure no local tasks are running
2025-01-20T18:48:52.346Z	INFO	main	titan-edge/heartbeat.go:72	Edge registered successfully, waiting for tasks
2025-01-20T18:48:54.983Z	WARN	main	titan-edge/daemon.go:286	Shutting down...
2025-01-20T18:48:54.983Z	WARN	main	titan-edge/heartbeat.go:76	heartbeat stopped
2025-01-20T18:48:54.983Z	WARN	main	titan-edge/main.go:406	http3 server graceful shutting down...
2025-01-20T18:48:54.983Z	WARN	main	titan-edge/main.go:429	http server graceful shutting down...
2025-01-20T18:48:54.983Z	WARN	main	titan-edge/main.go:437	http server start with error: http: Server closed
2025-01-20T18:48:54.983Z	WARN	main	titan-edge/main.go:414	http3 server start with error: http: Server closed
2025-01-20T18:48:54.983Z	WARN	main	titan-edge/daemon.go:296	Graceful shutdown successful
2025/01/20 18:48:59 failed to sufficiently increase send buffer size (was: 208 kiB, wanted: 2048 kiB, got: 416 kiB). See https://github.com/quic-go/quic-go/wiki/UDP-Buffer-Sizes for details.
2025-01-20T18:49:00.422Z	INFO	main	titan-edge/daemon.go:143	Remote version 0.1.20+1227_1_main3+api1.0.0
2025-01-20T18:49:00.422Z	INFO	builder	node/builder_edge.go:48	start to config edge
2025-01-20T18:49:00.481Z	INFO	main	titan-edge/daemon.go:224	New titan daemon
workerd/server/go.c++:360: warning: init runtime with empty report url, events will not be report
2025-01-20T18:49:00.484Z	INFO	main	titan-edge/main.go:425	Edge listen on tcp/udp 0.0.0.0:1234
2025-01-20T18:49:00.487Z	INFO	main	titan-edge/heartbeat.go:55	Making sure no local tasks are running
2025-01-20T18:49:00.703Z	INFO	main	titan-edge/heartbeat.go:72	Edge registered successfully, waiting for tasks
```

### Stop, remove and clean up
Stop:
```bash
sonaric stop titan-network/l2-edge-node
```
Purge:
```bash
sonaric purge titan-network/l2-edge-node
```

## Template Actions

### Import Key
Import a key to the node's key store.
```bash
sonaric do templates/local/titan-network/l2-edge-node/import-key privkey=
```

### Export Key
Export a key from the node's key store.
```bash
sonaric do templates/local/titan-network/l2-edge-node/export-key
```
Example output:
```
✔ Running action:
-----BEGIN RSA PRIVATE KEY-----
MIICXgIBAAKBgQC9wWhh57pFRFNPbAB8xHGqyxjnVWh0GyhsWly509gaKMk47c+Z
llDAKU3OSLdkyXm4nfKV3d+h1sPE2dmFz6ujzjoK9+dv8+IhcMiT/1qrOWDEv6G7
B0fbbGNYYe3Rtwosgos3p8fE1l2fBo0pp/z3A+8lxlywnoCAeRoh5b8OPwIDAQAB
AoGASzX1oZivg/To8HnmV42lYATQAiEgHaUGCKxoRF9rMDMqTp4zwrSJnSDB7hl0
V0ZkMICqPiyLDyKIxeVzCk6dwMc270AQrmPdzy1rMUXd2emVvVbxfpGUcDqdSq16
uBbeBA0kfKtfcsd543dccv6sfy4DANv5GMOe6CHBH8qgYIECQQD6zR7wu33SWHWY
xIdflUshemk0f+r3F3oMsO86ojVIagYWj3f+/9qJjg3J2MtLnzgw94+zp5zZKZNR
WQ4wcKqpAkEAwbBY1v/3mum/6q2SkPUTs3VjOU45rmUvyqGQtHK9m+ZKa+Y0+iVG
2G1GdjspR3Q8jWgvCWJ7o1ylFlFXtkAqpwJBAJ6T38Ja6l17rS9g5C+dmBmc6rRV
RV3irDsmDL1IHuSglSTipf7IC4f6F+HOgAxaqg7cGTKBAn2U+h7vbjdWpbECQQCI
4IDH37gxh8MSq3sKacd0aR6n3rownl15y1ehzfxk8gfh3JvPswwv4nmLECAJ2QD5
xYiID0rklZItBWsA5rO9AkEAnIwQ21eboS6pXynOC3PEgitA91No8tcSmoJ1nWMB
/R0a71RsMon7qZXsg5JeGmeWU0o93cvniUVDYw0XpCyHXw==
-----END RSA PRIVATE KEY-----
```

## Documentation and API References
Access detailed API documentation and examples:
- [Titan Network Documentation](https://titannet.gitbook.io/titan-network-en)
- [Titan Network Repository](https://github.com/Titannet-dao/titan-node)
- [Titan Network Discord Support](https://discord.com/invite/titannet)
