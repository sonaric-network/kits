## Documentation and API References
Access detailed API documentation and examples:
- [Koii Documentation](https://www.koii.network/docs/run-a-node/introduction/types-of-nodes)
- [Koii Repository](https://github.com/koii-network/VPS-task)

## Load Template

```bash
cd koii
sonaric load MANIFEST
```

### Confirm templates loaded

```bash
foo@bar:~$ sonaric list celestia
✔ Got the list
Repository  Template                Version  Type      Tags        
local       koii/task_node          1.0.0    runnable  blockchain
```

## Koii actions

### Export Key
Export a key from the node's key store.
```bash
sonaric do templates/local/koii/task_node/export-key
```
Example output:
```
✔ Running action: 
[12,75,213,69,921,179,47,81,130,207,119,10,249,95,153,34,122,221,236,70,21,210,149,185,16,44,137,77,70,113,1,186,233,52,187,87,70,167,153,160,131,152,35,221,25,139,202,146,5,185,97,122,47,47,142,165,119,45,9,251,147,255,186,14]
```

### Address
Get the address of the node.
```bash
sonaric do templates/local/koii/task_node/address
```

Example output:
```
✔ Running action:
GhLdXpJLagFnyi3B11jLJaYYAvmQg1FNGZEWv3p3sR2d
```

### Balance
Get the balance of the node.
```bash
sonaric do templates/local/koii/task_node/balance
```

Example output:
```
✔ Running action:
4 KOII
```