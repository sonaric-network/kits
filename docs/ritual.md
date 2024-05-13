
## Load Template

```bash
cd ritual
sonaric load MANIFEST
```

### Confirm templates loaded

```bash
foo@bar:~$ sonaric list ritual
✔ Got the list
Type      Template             Repository  Version  Tags
runnable    ritual/fluent-bit   local      0.2.0      blockchain
runnable    ritual/fluentbit    local      0.2.0      blockchain
group       ritual/group        local      -          -
runnable    ritual/node         local      -          -
runnable    ritual/redis        local      -          -
runnable    ritual/ritual-node  local      -          -
```

### Run ritual ritual-node

```bash
sonaric run ritual/ritual-node
```
Output:
```bash
✔ Started local/ritual/ritual-node
🔩 templates/local/ritual/ritual-node
 └─🧊 Peer local
    └─🔩 templates/local/ritual/ritual-node
       └─📦 local-379ad959e288cd1494436edd52-ritual-ritual-node-node running
          ├─🧩 ritualnetwork/infernet-node:latest
          ├─💾 nil -> /var/run/docker.sock
          ├─💾 /Users/alexnelepa/.monk/volumes/node-logs -> /logs
          └─🔌 open 188.146.114.165:4000 -> 4000
```

## Stop, remove and clean up workloads and templates

```bash
sonaric purge ritual/ritual-node
```