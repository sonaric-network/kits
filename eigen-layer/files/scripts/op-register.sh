#!/bin/sh

config_file="/app/operator-config/operator.yaml"
password=$1

# if file doesn't exist, exit and ask user to create operator config
if [ ! -f "$config_file" ]; then
    echo "File not found. Please create the operator config file."
    exit 1
fi

echo $password | eigenlayer operator register $config_file