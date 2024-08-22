#!/bin/sh
# Path: srs_setup.sh

DOWNLOADED_FILE=false
echo "Downloading srs resources"
if ! [ -f /app/resources/g1.point ]; then
  echo "g1.point does not exist."
  echo "Downloading g1 point. This could take upto 5 minutes..."
  wget -q https://srs-mainnet.s3.amazonaws.com/kzg/g1.point --output-document=/app/resources/g1.point
  echo "Downloaded g1 point."

  DOWNLOADED_FILE=true
else
  echo "g1.point already exists."
fi

if ! [ -f /app/resources/g2.point.powerOf2 ]; then
  echo "g2.point.powerOf2 does not exist."
  echo "Downloading g2 point powerOf2. This will take few seconds"
  wget -q https://srs-mainnet.s3.amazonaws.com/kzg/g2.point.powerOf2 --output-document=/app/resources/g2.point.powerOf2
  DOWNLOADED_FILE=true
else
  echo "g2.point.powerOf2 already exists."
fi

# Any time we download the file, validate hashes
if [ "$DOWNLOADED_FILE" = true ]; then
  echo "validating hashes of g1 and g2 points This could take upto 5 minutes"
  if (cd /app/resources && sha256sum -c srssha256sums.txt); then
    echo "Checksums match. Verification successful."
  else
    echo "Error: Checksums do not match. Exiting."
    exit 1
  fi
fi