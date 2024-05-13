
## Load Template

```bash
cd eigen-layer
sonaric load MANIFEST
```

### Let's take a look at the themes I have installed

```bash
foo@bar:~$ sonaric list eigen-layer
✔ Got the list
Type      Template              Repository  Version  Tags
runnable    eigen-layer/da-node  local      1.0        web, api
group       eigen-layer/group    local      -          -
runnable    eigen-layer/nginx    local      1.0        load balancing, dynamic content serving, security, reverse proxy, high performance, ssl/tls encryption...
```

### Run mina sandbox

```bash
sonaric run gnosis/mainnet
```
Output:
```bash
✔ Started local/eigen-layer/group
🔩 templates/local/eigen-layer/group
 └─🧊 Peer local
    ├─🔩 templates/local/eigen-layer/nginx
    │  └─📦 local-02324acfae656c4fab73d5fd6a-inx-nginx-reverse-proxy running
    │     ├─🧩 docker.io/bitnami/nginx:latest
    │     └─🔌 open TCP 188.146.114.165:80 -> 80
    └─🔩 templates/local/eigen-layer/da-node
       └─📦 local-be734a2ce4875c89511d575232-igen-layer-da-node-node running
          ├─🧩 ghcr.io/layr-labs/eigenda/opr-node:release-0.6.2
          ├─💾 /home/ubuntu/eigenda-operator-setup/resources/g2.point.powerof2 -> /app/g2.point.powerOf2
          ├─💾 /home/ubuntu/.eigenlayer/eigenda/holesky/logs -> /app/logs
          ├─💾 /home/ubuntu/eigenda-operator-setup/resources/cache -> /app/cache
          ├─💾 /home/ubuntu/.eigenlayer/operator_keys/opr.bls.key.json -> /app/operator_keys/bls_key.json
          ├─💾 /home/ubuntu/.eigenlayer/eigenda/holesky/db -> /data/operator/db
          ├─💾 /home/ubuntu/.eigenlayer/operator_keys/opr.ecdsa.key.json -> /app/operator_keys/ecdsa_key.json
          ├─💾 /home/ubuntu/eigenda-operator-setup/resources/g1.point -> /app/g1.point
          ├─🔌 open 188.146.114.165:9092 -> 9092
          └─🔌 open 188.146.114.165:32005 -> 32005
```

## Stop, remove and clean up workloads and templates

```bash
sonaric purge eigen-layer/group
```