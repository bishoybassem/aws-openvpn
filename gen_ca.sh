#!/bin/bash -e

mkdir -p data
cd data

# Generate CA's private key and a self signed certificate to act as the root certificate.
openssl req -newkey rsa:4096 -nodes -keyout ca.pem -x509 -days 10000 -subj "/CN=openvpn_ca" -out ca.crt