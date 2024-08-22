#!/bin/sh


# load environment variables
set -a
source .env
set +a
# copy resources
mkdir -p /app/resources
cp /sonaric/files/resources/srssha256sums.txt /app/resources/srssha256sums.txt

/sonaric/scripts/check-generate-keys.sh # generate keys if they don't exist
/sonaric/scripts/srs-setup.sh           # download srs resources

node