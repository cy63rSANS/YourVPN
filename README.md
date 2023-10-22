# NOT YET COMPLETE!!!
YourVPN based on Headscale, Wireguard and tailscale client

# SANS @night | MANCHESTER
#### Simon Vernon, SANS 2023

### Prerequisites
1. An Azure account
2. A basic knowlege of terraform and shell in Linux
2. A web broswer

If you need to register a new Azure account, you can create a Pay-As-You-Go Azure subscription from [here:](https://azure.microsoft.com/en-gb/pricing/purchase-options/pay-as-you-go/?srcurl=https%3A%2F%2Fazure.microsoft.com%2Ffree)  
#### A valid email address and credit card are required to subscribe to Microsoft Azure.

You are liable for any expenses associated with hosting objects and services within your azure account. Use the Budget systems! 
A full teardown script is provided

### Getting started

1. Log into Azure and open a cloud shell
2. clone this repository using:
    `git clone https://github.com/cy63rSANS/YourVPN`
3. Navigate to the 'terraform' directory and Execute terraform init and terraform apply:
    `cd YourVPN/terraform`
    `terraform init`
    `terraform apply`
4. Check out the new assets in the resource group "YourVPN", click on the virtual machine called 'VPNhost' and finds its public IP address. 
5. You can now SSH to the server to continue the deployment. 

----------

ADD USERS AND REGISTER
docker exec headscale headscale users create <myfirstuser>
docker exec headscale headscale --user myfirstuser nodes register --key <YOU_+MACHINE_KEY>

INSTALL TAILSCALE CLIENT AND THEN RUN:
tailscale up --login-server https://YOUR.DOMIANNAME.COM --advertise-exit-node(IF REQUIRED)

To Advertise exit node: 
docker exec headscale headscale nodes list
docker exec headscale headscale routes enable -r (number)

#### Contact Simon Vernon
#### @Xzer0f
#### https://www.linkedin.com/in/simon-vernon