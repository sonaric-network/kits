## Documentation and API References
Access detailed API documentation and examples:
- [Taiko Documentation](https://docs.taiko.xyz/start-here/getting-started)
- [Taiko Repository](https://github.com/taikoxyz)

## Load Template

```bash
cd taiko
sonaric load MANIFEST
```

### Confirm templates loaded

```bash
foo@bar:~$ sonaric list taiko
✔ Got the list
Repository  Template                           Version  Type      Tags        
local       taiko/client-driver                -        runnable  -
local       taiko/client-driver-with-prover    -        runnable  -
local       taiko/client-proposer              1.0.0    runnable  blockchain
local       taiko/client-prover-relayer        1.0.0    runnable  blockchain
local       taiko/execution-engine             1.0.0    runnable  blockchain
local       taiko/proccessor-group             -        group     -
local       taiko/proposer-group               -        group     -
local       taiko/prover-group                 -        group     -
local       taiko/prover-relayer-group         -        group     -
local       taiko/prover-with-processor-group  -        group     -
```

```bash
foo@bar:~$ sonaric list raiko
✔ Got the list
Repository  Template                   Version  Type      Tags        
local       raiko/full-group                 -        group     -
local       raiko/group-raiko                1.0.0    group     -
local       raiko/init-group                 -        group     -
local       raiko/init-self-register         -        runnable  -
local       raiko/init-self-register-group   -        group     -
local       raiko/pccs                       -        runnable  -
local       raiko/raiko                      -        runnable  -
local       raiko/raiko-group                -        group     -
local       raiko/raiko-init                 -        runnable  -
local       raiko/raiko-self-register        -        runnable  -
local       raiko/raiko-self-register-group  -        group     -
```

## variables the template

- [Mainnet addresses](https://docs.taiko.xyz/network-reference/mainnet-addresses)
- [Testnet addresses](https://docs.taiko.xyz/network-reference/testnet-addresses)

```bash
L1_RPC
L1_WS_RPC
L1_BEACON_API
TAIKO_L1_ADDRESS
TAIKO_L2_ADDRESS
P2P_SYNC_URL
TAIKO_TOKEN_L1_ADDRESS
L1_PROPOSER_PRIVATE_KEY
L2_SUGGESTED_FEE_RECIPIENT
```

