
## Load Template

```bash
sonaric load solana.yaml
```

### Confirm templates loaded

```bash
foo@bar:~$ sonaric list solana
✔ Got the list
Repository  Template       Version  Type      Tags
local       solana/beta    beta     runnable  blockchain
local       solana/edge    edge     runnable  blockchain
local       solana/stable  stable   runnable  blockchain
```

### Export keys
Prints both public and private keys.  
Requires `password` as input.

```bash
sonaric do local/celestia/light-arabica/export-key password=12345678
```
Example output:
```bash
✔ Get templates/local/celestia/light-arabica actions list success
✔ Got action parameters
✔ Parse parameters success
✔ Running the action... DONE
✔ Running action:
-----BEGIN TENDERMINT PRIVATE KEY-----
kdf: bcrypt
salt: 4A63D516BCD93CC17DD40B4B1539E13D
type: secp256k1

cbhTWBpkgME13w71HOmV1bV2Ii/hn5nVeHuxFI+gDUuLkSz7DhYxk6W/VFyuIyD/
KoJHGAOHjc711Kl/gjeY2gLdxPhYGf/fXN4wfpQ=
=o594
-----END TENDERMINT PRIVATE KEY-----
✨ Took: 1s
```

### Import key
Imports a private key.  
Requires `password` and `privkey` as input.
```bash
sonaric do local/celestia/light-arabica/import-key password=12345678 privkey=$SOME_VARIABLE
```
Example output:
```bash
✔ Get templates/local/celestia/light-arabica actions list success
✔ Got action parameters
✔ Parse parameters success
✔ Running the action... DONE
✔ Running action:
✨ Took: 1s
```

### Get address
Prints the address of the private key.
```bash
sonaric do local/celestia/light-arabica/get-address
```
Example output:
```bash
✔ Get templates/local/solana/beta actions list success
✔ Got action parameters
✔ Parse parameters success
✔ Running the action... DONE
✔ Running action:
G5ksHZUUURzYRUxnLD89nJ578NE4NW8NDBysifAVMnJH
✨ Took: 1s
```

### Get balance
Prints the balance of the address.
```bash
sonaric do local/solana/beta/get-balance
```
Example output:
```bash
✔ Get templates/local/solana/beta actions list success
✔ Got action parameters
✔ Parse parameters success
✔ Running the action... DONE
✔ Running action:
0 SOL
✨ Took: 1s
```

## Documentation and API References
Access detailed API documentation and examples:
- [Solana Documentation](https://docs.solanalabs.com/)
- [Solana Repository](https://github.com/solana-labs/solana)
