# YourVPN based on Headscale, Wireguard and tailscale client

# SANS @night | MANCHESTER
#### Simon Vernon, SANS 2023

### Prerequisites
1. An Azure account
2. A basic knowlege of terraform and shell in Linux
3. A domain name you onw and control
4. A web broswer

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
4. Check out the new assets in the resource group "MyVPN", click on the virtual machine called 'VPNhost' and finds its public IP address. 
5. You can now SSH to the server to continue the deployment. 

----------

PiHole:
It's worth noting that you can free up port 53 by simply uncommenting DNSStubListener and setting it to no in /etc/systemd/resolved.conf. The other steps are for enabling a DNS server - without it, your system will not be able to resolve any domain names, so you won't be able to visit websites in web browser, etc.

1. Edit /etc/systemd/resolved.conf
DNSStubListener=no

sudo ln -sf /run/systemd/resolve/resolv.conf /etc/resolv.conf
reboot

IN CONTAINERS/PIHOLE: docker-compose up -d

-----------

To install tailscale on the Headscale server and configure as a gateway:

sudo curl -fsSL https://pkgs.tailscale.com/stable/ubuntu/jammy.noarmor.gpg | sudo tee /usr/share/keyrings/tailscale-archive-keyring.gpg >/dev/null
sudo curl -fsSL https://pkgs.tailscale.com/stable/ubuntu/jammy.tailscale-keyring.list | sudo tee /etc/apt/sources.list.d/tailscale.list
sudo apt update
sudo apt install tailscale -y

tailscale up --login-server https://YOUR.DOMIANNAME.COM --advertise-exit-node

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