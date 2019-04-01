#!/bin/bash -e

key_pair_name=$1

if [[ "$key_pair_name" == "" ]]; then
    echo "Please provide the key pair name to be used"
    exit 1
fi

function review_and_deploy() {
    stack_name=$1
    template_file=cf_${stack_name}.yml

    echo "Evaluating change set for $stack_name stack..."
    change_set_cmd=$(aws cloudformation deploy --stack-name ${stack_name} --template-file ${template_file} \
                --parameter-overrides "${@:2}" --no-fail-on-empty-changeset \
                --no-execute-changeset | grep describe-change-set || true)

    if [ -z "$change_set_cmd" ]; then
        echo "No changes found!"
        return 0
    fi

    echo "Change set preview:"
    eval ${change_set_cmd}

    read -p "Please enter 'y' to proceed or 'n' to abort: " choice
    if [ "$choice" != "y" ]; then
        echo "Aborted!"
        return 0
    fi

    echo "Deploying $stack_name stack..."
    aws cloudformation deploy --stack-name ${stack_name} --template-file ${template_file} \
                --parameter-overrides "${@:2}" --no-fail-on-empty-changeset

    echo "Stack outputs:"
    aws cloudformation describe-stacks --stack-name ${stack_name} --query 'Stacks[*].Outputs'
}

review_and_deploy network "none=none"

review_and_deploy openvpn "KeyName=$key_pair_name" \
    "ServerCertificate=$(cat data/server.crt)" \
    "CACertificate=$(cat data/ca.crt)" \
    "ServerPrivateKey=$(cat data/server.pem)"