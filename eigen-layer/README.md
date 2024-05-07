# eigen-layer

eigen-layer basic template

## Prerequisites

- [Install Monk](https://docs.monk.io/docs/get-monk)
- [Register and Login Monk](https://docs.monk.io/docs/acc-and-auth)
- [Add Cloud Provider](https://docs.monk.io/docs/cloud-provider)
- [Add Instance](https://docs.monk.io/docs/multi-cloud)

### Make sure monkd is running

```bash
foo@bar:~$ monk status
daemon: ready
auth: logged in
not connected to cluster
```

## Clone Repository

```bash
git clone https://github.com/sonaric-network/kits
```

## Load Template

```bash
cd eigen-layer
monk load MANIFEST
```

## Stop, remove and clean up workloads and templates

```bash
monk purge eigen-layer/group
```