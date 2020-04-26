# AWS OpenVPN

Sets up a VPN solution using OpenVPN, AWS and CloudFormation. Moreover, a CLI is provided to simplify the operations for the end user.

## Implementation
The implementation features the following:
* A network CF stack (`cf_network.yml`) that sets up a VPC with an IPv4 block (10.1.0.0/16), and an internet facing pubic subnet.
* Another CF stack (`cf_openvpn.yml`) that handles the OpenVPN server's setup (using cfn-init), and cross references the network stack.
* The OpenVPN server uses UDP as communication protocol, and TLS certificates for authentication.
* In case of stack updates to the server's keys/metadata, the instance would automatically restart the OpenVPN service (using cfn-hup).

## Requirements
Before using the CLI, the following needs to be present/installed on your machine:
* OpenVPN (used version 2.4.7, [guide](https://openvpn.net/community-resources/installing-openvpn/))
* OpenSSL (used version 1.1.1d)
* AWS CLI (used version 1.18.39, [guide](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-install.html)) 
and configured with your IAM user's access keys. ([guide](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-configure.html))
* EC2 key pair for SSH access. ([guide](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-key-pairs.html))

## Usage
1. Clone the repository, and navigate to the clone directory.
2. Configure the AWS region to use (e.g. ca-central-1):
   ```bash
   ./vpncli use-region ca-central-1
   ```
3. Generate keys and certificates for the CA, server and client:
   ```bash
   ./vpncli gen-ca
   ./vpncli gen-certs
   ```
4. Run the deployment command, and provide the name of the key pair that you created earlier:
   ```bash
   ./vpncli deploy {KEY_PAIR_NAME_HERE}
   ```
   For each CF stack, the script would first show the change set, ask for your confirmation, deploy the change set, and finally display the stack's outputs.
5. To start the OpenVPN client:
   ```bash
   ./vpncli connect
   ```
6. To disconnect from the VPN:
   ```bash
   ./vpncli disconnect
   ```
7. To delete the stacks and free up all used AWS resources:
   ```bash
   ./vpncli undeploy
   ```