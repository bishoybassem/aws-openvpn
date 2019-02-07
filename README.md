# AWS OpenVPN

Deploy an OpenVPN server to AWS using CloudFormation.

## Notes
* The CF template handles all the setup steps (cfn-init). Also, the EC2 instance would restart the OpenVPN service in case of updates to the keys/template (cfn-hup).
* The OpenVPN server is using the default communication protocol (UDP), and client certificates for authentication.

## Steps
First install/check that the following packages are present:
* openvpn (used version 2.4.0).
* openssl (used version 1.1.0).
* awscli (used version 1.16.96), and also that it's configured with your account's credentials.

Start by generating the CA, server and client keys and certificates:
```bash
   ./1_gen_ca.sh
   ./2_gen_certs.sh
```

Deploy the server, and provide the key pair name to be used with the instance:
```bash
   ./3_deploy_server.sh {KEY_PAIR_NAME_HERE}
```

Start the client:
```bash
   ./4_start_client.sh
```

To delete and free up all used resources:
```bash
   ./5_delete_server.sh
```