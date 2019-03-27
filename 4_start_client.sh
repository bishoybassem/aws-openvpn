#!/bin/bash -e

# Get the public ip of the deployed openvpn server.
server_ip=$(aws ec2 describe-instances --filter "Name=tag:aws:cloudformation:logical-id,Values=OpenVPNServer" --query "Reservations[*].Instances[*].PublicIpAddress" --output text)

cd data

# Start the vpn client
sudo openvpn --client --remote ${server_ip} --dev tun --ca ca.crt --key client.pem --cert client.crt --proto tcp-client