# AWS OpenVPN

Deploy an OpenVPN server to AWS using CloudFormation.

## Features
* A CF template that handles the server's setup (using cfn-init). Also, the instance would restart the OpenVPN service in case of updates to the keys/template (using cfn-hup).
* The server is using TCP as communication protocol, and client certificates for authentication.

## Requirements
The setup requires the following to be present/installed:
* OpenVPN (used version 2.4.0).
* OpenSSL (used version 1.1.0).
* AWS CLI (used version 1.16.96), and configured with your user's access keys.

## Steps
1. Clone the repository, and navigate to the clone directory.
2. Generate the CA, server and client keys and certificates:
   ```bash
   ./gen_ca.sh
   ./gen_certs.sh
   ```
3. Deploy the server, and provide the key pair name to be used with the instance:
   ```bash
   ./deploy_server.sh {KEY_PAIR_NAME_HERE}
   ```
4. Start the client:
   ```bash
   ./start_client.sh
   ```
5. To delete and free up all used resources:
   ```bash
   ./delete_server.sh
   ```