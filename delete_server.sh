#!/bin/bash -e

# Delete the cloudformation stack.
aws cloudformation delete-stack --stack-name openvpn

# Wait for the action to be complete.
aws cloudformation wait stack-delete-complete --stack-name openvpn

echo "delete-stack action is complete"

