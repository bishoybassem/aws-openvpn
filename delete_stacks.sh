#!/bin/bash -e

function delete_stack() {
    stack_name=$1
    echo "Deleting $stack_name stack..."
    aws cloudformation delete-stack --stack-name ${stack_name}
    echo "Waiting for action to complete..."
    aws cloudformation wait stack-delete-complete --stack-name ${stack_name}
}

delete_stack openvpn

delete_stack network
