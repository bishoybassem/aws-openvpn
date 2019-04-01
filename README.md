# AWS OpenVPN

Deploy an OpenVPN server to AWS using CloudFormation.

## Features
The setup features the following:
* A network CF stack (`cf_network.yml`) that sets up a VPC with an IPv4 block (10.1.0.0/16), and an internet facing pubic subnet.
* Another CF stack (`cf_openvpn.yml`) that handles the OpenVPN server's setup (using cfn-init), and cross references the network stack.
* The OpenVPN server uses TCP as communication protocol, and client certificates for authentication.
* In case of stack updates to the server's keys/metadata, the instance would automatically restart the OpenVPN service (using cfn-hup).

## Requirements
The setup requires the following to be present/installed:
* OpenVPN (used version 2.4.0, [guide](https://openvpn.net/community-resources/installing-openvpn/))
* OpenSSL (used version 1.1.0)
* AWS CLI (used version 1.16.96, [guide](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-install.html)) 
and configured with your IAM user's access keys. ([guide](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-configure.html))
* EC2 key pair for SSH access. ([guide](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-key-pairs.html))

## Steps
1. Clone the repository, and navigate to the clone directory.
2. Generate keys and certificates for the CA, server and client:
   ```bash
   ./gen_ca.sh
   ./gen_certs.sh
   ```
3. Run the stacks deployment script, and provide the name of the key pair that you created earlier:
   ```bash
   ./deploy_stacks.sh {KEY_PAIR_NAME_HERE}
   ```
   For each stack, the script would first show the change set, ask for your confirmation, deploy the change set, and finally display the stack's outputs.
4. Start the client:
   ```bash
   ./start_client.sh
   ```
5. To delete and free up all used resources:
   ```bash
   ./delete_stacks.sh
   ```