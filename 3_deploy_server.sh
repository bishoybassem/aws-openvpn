#!/bin/bash -e

KEY_PAIR_NAME=$1

if [[ "$KEY_PAIR_NAME" == "" ]]; then
    echo "Please provide the key pair name to be used"
    exit 1
fi

# Create the cloudformation stack from template file.
aws cloudformation create-stack --stack-name openvpn --template-body file://cf_template.yml --parameters \
    "ParameterKey=KeyName,ParameterValue=$KEY_PAIR_NAME" \
    "ParameterKey=ServerCertificate,ParameterValue=$(cat data/server.crt)" \
    "ParameterKey=CACertificate,ParameterValue=$(cat data/ca.crt)"

# Wait for the action to be complete.
aws cloudformation wait stack-create-complete --stack-name openvpn

echo "create-stack action is complete"