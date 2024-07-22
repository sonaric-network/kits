## System Requirements
- Single Core
- 500 MB RAM
- 100 GB SSD disk space
- 56 Kbps Internet Connection

More details can be found [here](https://docs.celestia.org/nodes/overview)

## Load Template

```bash
cd celestia
sonaric load MANIFEST
```

### Confirm templates loaded

```bash
foo@bar:~$ sonaric list celestia
✔ Got the list
Repository  Template                Version  Type      Tags        
local       celestia/light          -        runnable  blockchain  
local       celestia/light-arabica  -        runnable  blockchain  
local       celestia/light-mainnet  -        runnable  blockchain  
local       celestia/light-mocha    -        runnable  blockchain  
```
### Managing Celestia keys

#### Light node

Keys are generated (or imported) on the first run.  
Located in `/home/celestia/.celestia-light/keys` directory.   
You can see the initial info about the keys in the runnable logs  
```bash
foo@bar:~$ sonaric logs -f celestia/light
```
Example output:
```bash
2024-05-07T19:15:10.124Z        INFO    node    nodebuilder/init.go:31  Initializing Light Node Store over '/home/celestia/.celestia-light'
2024-05-07T19:15:10.126Z        INFO    node    nodebuilder/init.go:64  Saved config    {"path": "/home/celestia/.celestia-light/config.toml"}
2024-05-07T19:15:10.126Z        INFO    node    nodebuilder/init.go:66  Accessing keyring...
2024-05-07T19:15:10.130Z        WARN    node    nodebuilder/init.go:196 Detected plaintext keyring backend. For elevated security properties, consider using the `file` keyring backend.
2024-05-07T19:15:10.131Z        INFO    node    nodebuilder/init.go:211 NO KEY FOUND IN STORE, GENERATING NEW KEY...    {"path": "/home/celestia/.celestia-light/keys"}
2024-05-07T19:15:10.149Z        INFO    node    nodebuilder/init.go:216 NEW KEY GENERATED...

NAME: my_celes_key
ADDRESS: celestia12h24m8efen8jvkulm4s09c4uw65q88s03ape40
MNEMONIC (save this somewhere safe!!!): 
priority pet follow increase express narrow night panda love hint under actor brand elite excess diesel that swim super anchor retire tunnel taxi news

```

#### Managing keys
You can manage keys using `cel-key` utility.  
Connect to the container using `sonaric shell celestia/light` and run `cel-key --help` to see available commands.

```bash
foo@bar:~$ sonaric shell celestia/light
```
```bash
~ $ cel-key --help
Keyring management commands. These keys may be in any format supported by the
Tendermint crypto library and can be used by light-clients, full nodes, or any other application
that needs to sign with a private key.

The keyring supports the following backends:

    os          Uses the operating system\'s default credentials store.
...
...
Use "keys [command] --help" for more information about a command.
```

More info about `cel-key` utility can be found [here](https://docs.celestia.org/developers/celestia-node-key#using-the-cel-key-utility).

#### Create own key
https://docs.celestia.org/developers/node-tutorial#keys-and-wallets


### Get Auth Token
```bash
sonaric do templates/local/celestia/light-mocha/get-auth-token
```
```bash
✔ Get templates/local/celestia/light-mocha actions list success
✔ Got action parameters
✔ Parse parameters success
✔ Running the action... DONE
✔ Running action: 
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJBbGxvdyI6WyJwdWJsaWMiLCJyZWFkIiwid3JpdGUiLCJhZG1pbiJdfQ.i-R99xPL9zG1jwxsOoHARBNdQ3cMyxAuwK5BplCX2LA
✨ Took: 0s
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

### List-keys
Imports a private key.
```bash
sonaric do local/celestia/light-arabica/list-keys
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

### Core endpoints
Connecting to a core endpoint with --core.ip string provides the light node with access to state queries (reading balances, submitting transactions, and other state-related queries).  
Core endpoints are set via variable ${rpc-url} in the runnable template.  
You can change the core endpoint by editing the template and running it again.

### List of available core endpoints:  
| Network | Default Core Endpoint | List of Core Endpoints in Docs |
| --- | --- | --- |
| Mainnet Beta | consensus.lunaroasis.net | [Mainnet Beta](https://docs.celestia.org/nodes/mainnet#consensus-rpc-endpoints) |
| Mocha | rpc-mocha.pops.one | [Mocha](https://docs.celestia.org/nodes/mocha-testnet#rpc-endpoints) |
| Arabica | validator-1.celestia-arabica-11.com | [Arabica](https://docs.celestia.org/nodes/arabica-devnet#rpc-endpoints) |

Look for the `Direct endpoints with open ports` section in the table.