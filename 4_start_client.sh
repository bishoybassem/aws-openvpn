#!/bin/bash -e

# Get the public ip of the deployed openvpn server.
SERVER_IP=$(aws ec2 describe-instances --filter "Name=tag:aws:cloudformation:logical-id,Values=OpenVPNServer" --query "Reservations[*].Instances[*].PublicIpAddress" --output text)

cd data

# Start the vpn client
sudo openvpn --client --remote ${SERVER_IP} --dev tun --ca ca.crt --key client.pem --cert client.crt