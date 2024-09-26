# build

This directory is for Dockerfiles and other build-related files for Avail templates.

Currently, it only contains a Dockerfile for building the Avail DA image.  
It is used as part of Rollkit's Hello World example.
https://github.com/sonaric-network/kits/blob/main/rollkit/avail.yaml

```bash
docker build -t avail/da:latest -f avail-da.Dockerfile .
```