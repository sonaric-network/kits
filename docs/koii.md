# Sonaric Koii Documentation

## Table of Contents
- [Overview](#overview)
- [Load Template](#load-template)
    - [Confirm templates loaded](#confirm-templates-loaded)
    - [Configuration](#configuration)
- [Run koii](#run-koii)
- [Template Actions](#template-actions)
    - [Export key](#export-key)
    - [Address](#address)
    - [Balance](#balance)
- [Troubleshooting](#troubleshooting)
- [Documentation and API References](#documentation-and-api-references)

## Overview
Koii is a decentralized content network built on the Solana blockchain. It aims to provide an open and decentralized platform for content creators to monetize their work.

## Load Template

```bash
cd koii
sonaric load MANIFEST
```

### Confirm templates loaded

```bash
foo@bar:~$ sonaric list koii
✔ Got the list
Repository  Template                Version  Type      Tags        
local       koii/task_node          1.0.0    runnable  blockchain
```

### Configuration

If you already have an account, you can simply provide the private-key.
If you don't have an account, it is mandatory to input the seed-phrase to create a new account.

```bash

| Name          | Type   | Description                     | Required | Default Value |
|---------------|--------|---------------------------------|----------|---------------|
| `private-key` | string | Private key of the account      | true     | `""`          |
| `seed-phrase` | string | Seed phrase of the account      | true     | `""`          |
| `tasks`       | string | Tasks to be executed            | true     | `""`          |
| `stakes`      | string | Stakes to be used               | true     | `""`          |
```

## Run koii

Starting the node may take approximately 3-5 minutes, so please be patient during the initialization process.

```bash
sonaric run -s seed-phrase=<seed-phrase> -s tasks=<task1,task2,task3> -s stakes=<stake1,stake2,stake3> koii/task_node
```

Output:
```
🔩 templates/local/koii/task_node
 └─🧊 Peer local
    └─🔩 templates/local/koii/task_node
       └─📦 6ba3a2ba5d0f908046fb708b9ba574e9-oii-task_node-task_node running
          ├─🧩 public.ecr.aws/koii-network/task_node:latest
          ├─💾 /Users/alexnelepa/.monk/volumes/koii/namespace -> /app/namespace
          ├─💾 /Users/alexnelepa/.monk/volumes/koii/data -> /app/data
          ├─💾 /Users/alexnelepa/.monk/volumes/koii/config -> /app/config
          ├─💾 /Users/alexnelepa/.monk/volumes/koii/dist -> /app/executables
          └─🔌 open 188.146.32.63:30017 -> 30017
```
### logs
```bash
sonaric logs koii/task_node
```

```bash
WARNING: apt does not have a stable CLI interface. Use with caution in scripts.

Reading package lists...
Building dependency tree...
Reading state information...
The following additional packages will be installed:
  ca-certificates krb5-locales libbrotli1 libcurl4 libgssapi-krb5-2
  libk5crypto3 libkeyutils1 libkrb5-3 libkrb5support0 libldap-2.5-0
  libldap-common libnghttp2-14 libpsl5 librtmp1 libsasl2-2 libsasl2-modules
  libsasl2-modules-db libssh2-1 libssl3 libtcl8.6 openssl publicsuffix
  tcl-expect tcl8.6
Suggested packages:
  tk8.6 krb5-doc krb5-user libsasl2-modules-gssapi-mit
  | libsasl2-modules-gssapi-heimdal libsasl2-modules-ldap libsasl2-modules-otp
  libsasl2-modules-sql tcl-tclreadline
The following NEW packages will be installed:
  ca-certificates curl expect krb5-locales libbrotli1 libcurl4
  libgssapi-krb5-2 libk5crypto3 libkeyutils1 libkrb5-3 libkrb5support0
  libldap-2.5-0 libldap-common libnghttp2-14 libpsl5 librtmp1 libsasl2-2
  libsasl2-modules libsasl2-modules-db libssh2-1 libssl3 libtcl8.6 openssl
  publicsuffix tcl-expect tcl8.6
0 upgraded, 26 newly installed, 0 to remove and 0 not upgraded.
Need to get 7531 kB of archives.
After this operation, 20.8 MB of additional disk space will be used.
Ign:1 http://deb.debian.org/debian bookworm/main amd64 libssl3 amd64 3.0.11-1~deb12u2
Ign:2 http://deb.debian.org/debian bookworm/main amd64 openssl amd64 3.0.11-1~deb12u2
Get:3 http://deb.debian.org/debian bookworm/main amd64 ca-certificates all 20230311 [153 kB]
Get:4 http://deb.debian.org/debian bookworm/main amd64 krb5-locales all 1.20.1-2+deb12u1 [62.7 kB]
Get:5 http://deb.debian.org/debian bookworm/main amd64 libbrotli1 amd64 1.0.9-2+b6 [275 kB]
Get:6 http://deb.debian.org/debian bookworm/main amd64 libkrb5support0 amd64 1.20.1-2+deb12u1 [32.4 kB]
Get:7 http://deb.debian.org/debian bookworm/main amd64 libk5crypto3 amd64 1.20.1-2+deb12u1 [78.9 kB]
Get:8 http://deb.debian.org/debian bookworm/main amd64 libkeyutils1 amd64 1.6.3-2 [8808 B]
Get:9 http://deb.debian.org/debian bookworm/main amd64 libkrb5-3 amd64 1.20.1-2+deb12u1 [332 kB]
Get:10 http://deb.debian.org/debian bookworm/main amd64 libgssapi-krb5-2 amd64 1.20.1-2+deb12u1 [134 kB]
Get:11 http://deb.debian.org/debian bookworm/main amd64 libsasl2-modules-db amd64 2.1.28+dfsg-10 [20.3 kB]
Get:12 http://deb.debian.org/debian bookworm/main amd64 libsasl2-2 amd64 2.1.28+dfsg-10 [59.7 kB]
Get:13 http://deb.debian.org/debian bookworm/main amd64 libldap-2.5-0 amd64 2.5.13+dfsg-5 [183 kB]
Get:14 http://deb.debian.org/debian bookworm/main amd64 libnghttp2-14 amd64 1.52.0-1+deb12u1 [72.4 kB]
Get:15 http://deb.debian.org/debian bookworm/main amd64 libpsl5 amd64 0.21.2-1 [58.7 kB]
Get:16 http://deb.debian.org/debian bookworm/main amd64 librtmp1 amd64 2.4+20151223.gitfa8646d.1-2+b2 [60.8 kB]
Get:17 http://deb.debian.org/debian bookworm/main amd64 libssh2-1 amd64 1.10.0-3+b1 [179 kB]
Ign:18 http://deb.debian.org/debian bookworm/main amd64 libcurl4 amd64 7.88.1-10+deb12u5
Ign:19 http://deb.debian.org/debian bookworm/main amd64 curl amd64 7.88.1-10+deb12u5
Get:20 http://deb.debian.org/debian bookworm/main amd64 libtcl8.6 amd64 8.6.13+dfsg-2 [1035 kB]
Get:21 http://deb.debian.org/debian bookworm/main amd64 tcl8.6 amd64 8.6.13+dfsg-2 [120 kB]
Get:22 http://deb.debian.org/debian bookworm/main amd64 tcl-expect amd64 5.45.4-2+b1 [133 kB]
Get:23 http://deb.debian.org/debian bookworm/main amd64 expect amd64 5.45.4-2+b1 [166 kB]
Get:24 http://deb.debian.org/debian bookworm/main amd64 libldap-common all 2.5.13+dfsg-5 [29.3 kB]
Get:25 http://deb.debian.org/debian bookworm/main amd64 libsasl2-modules amd64 2.1.28+dfsg-10 [66.6 kB]
Get:26 http://deb.debian.org/debian bookworm/main amd64 publicsuffix all 20230209.2326-1 [126 kB]
Get:1 http://deb.debian.org/debian bookworm/main amd64 libssl3 amd64 3.0.11-1~deb12u2 [2019 kB]
Get:2 http://deb.debian.org/debian bookworm/main amd64 openssl amd64 3.0.11-1~deb12u2 [1419 kB]
Get:18 http://deb.debian.org/debian bookworm/main amd64 libcurl4 amd64 7.88.1-10+deb12u5 [390 kB]
debconf: delaying package configuration, since apt-utils is not installed
Get:19 http://deb.debian.org/debian bookworm/main amd64 curl amd64 7.88.1-10+deb12u5 [315 kB]
Fetched 7531 kB in 0s (27.4 MB/s)
Selecting previously unselected package libssl3:amd64.
(Reading database ... 6090 files and directories currently installed.)
Preparing to unpack .../00-libssl3_3.0.11-1~deb12u2_amd64.deb ...
Unpacking libssl3:amd64 (3.0.11-1~deb12u2) ...
Selecting previously unselected package openssl.
Preparing to unpack .../01-openssl_3.0.11-1~deb12u2_amd64.deb ...
Unpacking openssl (3.0.11-1~deb12u2) ...
Selecting previously unselected package ca-certificates.
Preparing to unpack .../02-ca-certificates_20230311_all.deb ...
Unpacking ca-certificates (20230311) ...
Selecting previously unselected package krb5-locales.
Preparing to unpack .../03-krb5-locales_1.20.1-2+deb12u1_all.deb ...
Unpacking krb5-locales (1.20.1-2+deb12u1) ...
Selecting previously unselected package libbrotli1:amd64.
Preparing to unpack .../04-libbrotli1_1.0.9-2+b6_amd64.deb ...
Unpacking libbrotli1:amd64 (1.0.9-2+b6) ...
Selecting previously unselected package libkrb5support0:amd64.
Preparing to unpack .../05-libkrb5support0_1.20.1-2+deb12u1_amd64.deb ...
Unpacking libkrb5support0:amd64 (1.20.1-2+deb12u1) ...
Selecting previously unselected package libk5crypto3:amd64.
Preparing to unpack .../06-libk5crypto3_1.20.1-2+deb12u1_amd64.deb ...
Unpacking libk5crypto3:amd64 (1.20.1-2+deb12u1) ...
Selecting previously unselected package libkeyutils1:amd64.
Preparing to unpack .../07-libkeyutils1_1.6.3-2_amd64.deb ...
Unpacking libkeyutils1:amd64 (1.6.3-2) ...
Selecting previously unselected package libkrb5-3:amd64.
Preparing to unpack .../08-libkrb5-3_1.20.1-2+deb12u1_amd64.deb ...
Unpacking libkrb5-3:amd64 (1.20.1-2+deb12u1) ...
Selecting previously unselected package libgssapi-krb5-2:amd64.
Preparing to unpack .../09-libgssapi-krb5-2_1.20.1-2+deb12u1_amd64.deb ...
Unpacking libgssapi-krb5-2:amd64 (1.20.1-2+deb12u1) ...
Selecting previously unselected package libsasl2-modules-db:amd64.
Preparing to unpack .../10-libsasl2-modules-db_2.1.28+dfsg-10_amd64.deb ...
Unpacking libsasl2-modules-db:amd64 (2.1.28+dfsg-10) ...
Selecting previously unselected package libsasl2-2:amd64.
Preparing to unpack .../11-libsasl2-2_2.1.28+dfsg-10_amd64.deb ...
Unpacking libsasl2-2:amd64 (2.1.28+dfsg-10) ...
Selecting previously unselected package libldap-2.5-0:amd64.
Preparing to unpack .../12-libldap-2.5-0_2.5.13+dfsg-5_amd64.deb ...
Unpacking libldap-2.5-0:amd64 (2.5.13+dfsg-5) ...
Selecting previously unselected package libnghttp2-14:amd64.
Preparing to unpack .../13-libnghttp2-14_1.52.0-1+deb12u1_amd64.deb ...
Unpacking libnghttp2-14:amd64 (1.52.0-1+deb12u1) ...
Selecting previously unselected package libpsl5:amd64.
Preparing to unpack .../14-libpsl5_0.21.2-1_amd64.deb ...
Unpacking libpsl5:amd64 (0.21.2-1) ...
Selecting previously unselected package librtmp1:amd64.
Preparing to unpack .../15-librtmp1_2.4+20151223.gitfa8646d.1-2+b2_amd64.deb ...
Unpacking librtmp1:amd64 (2.4+20151223.gitfa8646d.1-2+b2) ...
Selecting previously unselected package libssh2-1:amd64.
Preparing to unpack .../16-libssh2-1_1.10.0-3+b1_amd64.deb ...
Unpacking libssh2-1:amd64 (1.10.0-3+b1) ...
Selecting previously unselected package libcurl4:amd64.
Preparing to unpack .../17-libcurl4_7.88.1-10+deb12u5_amd64.deb ...
Unpacking libcurl4:amd64 (7.88.1-10+deb12u5) ...
Selecting previously unselected package curl.
Preparing to unpack .../18-curl_7.88.1-10+deb12u5_amd64.deb ...
Unpacking curl (7.88.1-10+deb12u5) ...
Selecting previously unselected package libtcl8.6:amd64.
Preparing to unpack .../19-libtcl8.6_8.6.13+dfsg-2_amd64.deb ...
Unpacking libtcl8.6:amd64 (8.6.13+dfsg-2) ...
Selecting previously unselected package tcl8.6.
Preparing to unpack .../20-tcl8.6_8.6.13+dfsg-2_amd64.deb ...
Unpacking tcl8.6 (8.6.13+dfsg-2) ...
Selecting previously unselected package tcl-expect:amd64.
Preparing to unpack .../21-tcl-expect_5.45.4-2+b1_amd64.deb ...
Unpacking tcl-expect:amd64 (5.45.4-2+b1) ...
Selecting previously unselected package expect.
Preparing to unpack .../22-expect_5.45.4-2+b1_amd64.deb ...
Unpacking expect (5.45.4-2+b1) ...
Selecting previously unselected package libldap-common.
Preparing to unpack .../23-libldap-common_2.5.13+dfsg-5_all.deb ...
Unpacking libldap-common (2.5.13+dfsg-5) ...
Selecting previously unselected package libsasl2-modules:amd64.
Preparing to unpack .../24-libsasl2-modules_2.1.28+dfsg-10_amd64.deb ...
Unpacking libsasl2-modules:amd64 (2.1.28+dfsg-10) ...
Selecting previously unselected package publicsuffix.
Preparing to unpack .../25-publicsuffix_20230209.2326-1_all.deb ...
Unpacking publicsuffix (20230209.2326-1) ...
Setting up libkeyutils1:amd64 (1.6.3-2) ...
Setting up libpsl5:amd64 (0.21.2-1) ...
Setting up libbrotli1:amd64 (1.0.9-2+b6) ...
Setting up libssl3:amd64 (3.0.11-1~deb12u2) ...
Setting up libnghttp2-14:amd64 (1.52.0-1+deb12u1) ...
Setting up krb5-locales (1.20.1-2+deb12u1) ...
Setting up libldap-common (2.5.13+dfsg-5) ...
Setting up libkrb5support0:amd64 (1.20.1-2+deb12u1) ...
Setting up libsasl2-modules-db:amd64 (2.1.28+dfsg-10) ...
Setting up librtmp1:amd64 (2.4+20151223.gitfa8646d.1-2+b2) ...
Setting up libtcl8.6:amd64 (8.6.13+dfsg-2) ...
Setting up libk5crypto3:amd64 (1.20.1-2+deb12u1) ...
Setting up libsasl2-2:amd64 (2.1.28+dfsg-10) ...
Setting up libssh2-1:amd64 (1.10.0-3+b1) ...
Setting up libkrb5-3:amd64 (1.20.1-2+deb12u1) ...
Setting up openssl (3.0.11-1~deb12u2) ...
Setting up publicsuffix (20230209.2326-1) ...
Setting up tcl8.6 (8.6.13+dfsg-2) ...
Setting up libsasl2-modules:amd64 (2.1.28+dfsg-10) ...
Setting up tcl-expect:amd64 (5.45.4-2+b1) ...
Setting up libldap-2.5-0:amd64 (2.5.13+dfsg-5) ...
Setting up ca-certificates (20230311) ...
debconf: unable to initialize frontend: Dialog
debconf: (No usable dialog-like program is installed, so the dialog based frontend cannot be used. at /usr/share/perl5/Debconf/FrontEnd/Dialog.pm line 78.)
debconf: falling back to frontend: Readline
debconf: unable to initialize frontend: Readline
debconf: (Can't locate Term/ReadLine.pm in @INC (you may need to install the Term::ReadLine module) (@INC contains: /etc/perl /usr/local/lib/x86_64-linux-gnu/perl/5.36.0 /usr/local/share/perl/5.36.0 /usr/lib/x86_64-linux-gnu/perl5/5.36 /usr/share/perl5 /usr/lib/x86_64-linux-gnu/perl-base /usr/lib/x86_64-linux-gnu/perl/5.36 /usr/share/perl/5.36 /usr/local/lib/site_perl) at /usr/share/perl5/Debconf/FrontEnd/Readline.pm line 7.)
debconf: falling back to frontend: Teletype
Updating certificates in /etc/ssl/certs...
140 added, 0 removed; done.
Setting up libgssapi-krb5-2:amd64 (1.20.1-2+deb12u1) ...
Setting up libcurl4:amd64 (7.88.1-10+deb12u5) ...
Setting up curl (7.88.1-10+deb12u5) ...
Setting up expect (5.45.4-2+b1) ...
Processing triggers for libc-bin (2.36-9+deb12u7) ...
Processing triggers for ca-certificates (20230311) ...
Updating certificates in /etc/ssl/certs...
0 added, 0 removed; done.
Running hooks in /etc/ca-certificates/update.d...
downloading v1.16.2 installer
done.
  1.16.2 initialized
Adding
export PATH="/root/.local/share/koii/install/active_release/bin:$PATH" to /root/.profile

Close and reopen your terminal to apply the PATH changes or run the following in your existing shell:

export PATH="/root/.local/share/koii/install/active_release/bin:$PATH"

Config File: /root/.config/koii/cli/config.yml
RPC URL: https://testnet.koii.network
WebSocket URL: wss://testnet.koii.network/ (computed)
Keypair Path: /app/config/id.json
Commitment: confirmed
spawn koii-keygen recover --force -o /app/config/id.json
[recover] seed phrase:
send: spawn id exp3 not open
    while executing
Error: Can't get mnemonic from seed phrases
"send "\r""
    (file "/home/keygen.sh" line 10)
yarn run v1.22.19
$ npm run autostake && npm run start

> @koii-network/task-node@1.11.19 preautostake
> npm run build


> @koii-network/task-node@1.11.19 prebuild
> npm run lint


> @koii-network/task-node@1.11.19 lint
> eslint . --quiet --ext .ts,.tsx


> @koii-network/task-node@1.11.19 build
> tsc -p tsconfig.release.json


> @koii-network/task-node@1.11.19 postbuild
> cpy '../webasm_bincode_deserializer/**/*' ../build/webasm_bincode_deserializer --cwd=src/ --parents


> @koii-network/task-node@1.11.19 autostake
> node build/src/cli/auto-stake.js
```


### Stop, remove and clean up
Stop:
```bash
sonaric stop koii/task_node
```
Purge:
```bash
sonaric purge koii/task_node
```

## Template Actions

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

## Troubleshooting
If you encounter any issues, please refer to the [Koii Network Discord Support](https://discord.com/invite/koii-network).

## Documentation and API References
Access detailed API documentation and examples:
- [Koii Documentation](https://www.koii.network/docs/run-a-node/introduction/types-of-nodes)
- [Koii Repository](https://github.com/koii-network/VPS-task)
- [Koii Network Discord Support](https://discord.com/invite/koii-network)
