#!/bin/bash -e

cd data

# Generate servers's private key and a certificate signing request.
openssl req -newkey rsa:2046 -nodes -keyout server.pem -new -subj "/CN=openvpn_server" -out server.csr

# Sign the server's certificate request.
openssl x509 -req -CA ca.crt -CAkey ca.pem -CAcreateserial -in server.csr -days 1000 -out server.crt

# Generate clients's private key and a certificate signing request.
openssl req -newkey rsa:2046 -nodes -keyout client.pem -new -subj "/CN=openvpn_client" -out client.csr

# Sign the client's certificate request.
openssl x509 -req -CA ca.crt -CAkey ca.pem -CAcreateserial -in client.csr -days 1000 -out client.crt
