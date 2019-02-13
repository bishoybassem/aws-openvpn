#!/bin/bash -e

key_pair_name=$1

if [[ "$key_pair_name" == "" ]]; then
    echo "Please provide the key pair name to be used"
    exit 1
fi

ACTION=create-stack
EVENT=stack-create-complete
# If the stack already exists, then use the update action.
if aws cloudformation describe-stacks --stack-name openvpn &> /dev/null; then
    ACTION=update-stack
    EVENT=stack-update-complete
fi

# Create/update the cloudformation stack from template file.
aws cloudformation ${ACTION} --stack-name openvpn --template-body file://cf_template.yml --parameters \
    "ParameterKey=KeyName,ParameterValue=$key_pair_name" \
    "ParameterKey=ServerCertificate,ParameterValue=$(cat data/server.crt)" \
    "ParameterKey=CACertificate,ParameterValue=$(cat data/ca.crt)" \
    "ParameterKey=ServerPrivateKey,ParameterValue=$(cat data/server.pem)"

# Wait for the action to be complete.
aws cloudformation wait ${EVENT} --stack-name openvpn

echo "$ACTION action is complete"