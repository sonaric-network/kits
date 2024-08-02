## System Requirements
 - Quad-core processor
 - 8 GB
 - Dedicated GPU such as NVIDIA GTX 1050 Ti or equivalent
 - 256 GB SSD

## Load Template

```bash
cd livepeer
sonaric load MANIFEST
```

### Confirm templates loaded

```bash
foo@bar:~$ sonaric list livepeer
✔ Got the list
Repository  Template           Version  Type      Tags
local       livepeer/mainnet   1.0.1    runnable  blockchain
```


## Livepeer actions

### Import Key
Create a new key from a private key and import it into the node's key store.  
Key could be in hex or json format. If key is empty, a new key will be generated.
```bash
sonaric do templates/local/livepeer/mainnet/import-key password=test
```
Example output:
```
✔ Running action: 
{"address":"7ce17814a929693c3fee3d3953657631250ca649","mnemonic":"glance salute fever asset knee top response void tennis crisp toilet drama second village wide ceiling craft army half rotate pond judge offer annual"}
```

### Export Key
Export a key from the node's key store.
```bash
sonaric do templates/local/livepeer/mainnet/export-key address=7ce17814a929693c3fee3d3953657631250ca649 password=test
```
Example output:
```
✔ Running action: 
{"address":"7ce17814a929693c3fee3d3953657631250ca649","crypto":{"cipher":"aes-128-ctr","ciphertext":"5a91d7405ab57c5006dd54d4bbc915568dd6176638d368a9d152e39588c0c230","cipherparams":{"iv":"17a14fdbf97b87643a345dc8921f6e87"},"kdf":"scrypt","kdfparams":{"dklen":32,"n":262144,"p":1,"r":8,"salt":"13fae9c4ad777ba1265b0f60002b780e0833e41d32ed39b435c631afa4b5d0b3"},"mac":"56cfaac25e60d81e8d680cb57ccb688dabd9f2558e95783a12260edccc09295c"},"id":"81dbb40c-02bf-4e2f-9ff0-c1f8686b8915","version":3}
```

### List Keys
List addresses of all keys in the node's key store.
```bash
sonaric do templates/local/livepeer/mainnet/list-keys
```

Example output:
```
✔ Running action: 
UTC--2024-08-02T11-40-40.884271824Z--2c7bd35ed5427513c5deee37f401de234af003ed
```

## Documentation and API References
Access detailed API documentation and examples:
- [livepeer Documentation](https://docs.livepeer.org/developers/introduction)
- [livepeer Repository](https://github.com/livepeer)
