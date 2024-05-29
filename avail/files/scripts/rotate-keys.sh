#!/bin/bash
curl -sS -H 'Content-Type: application/json' -d '{"id":1, "jsonrpc":"2.0", "method": "author_rotateKeys", "params":[]}' http://127.0.0.1:9944
# Call the restart script
echo -e "\nRestarting the service"
/usr/local/bin/restart.sh