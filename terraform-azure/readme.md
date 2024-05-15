# Terraform scripts for Microsoft Azure

- Log into your Azure portal
- Load up cloud shell
- Run the shell command: wget https://github.com/boomyville/cloud-web-server/archive/refs/heads/main.zip
- This will download this repository
- Run the shell command: unzip main.sip
- Create a ssh key using the shell command: ssh-keygen -t rsa
- Change directory to terraform-azure (from the contents we just unzipped)
- Run terraform init
- Run terraform apply
- See your free Azure credits disappear!

# What does this do

- Creates a VM
- Creates a NSG with some ports open
  - 22 for SSH
  - 80 for HTTP
  - 443 for HTTPS
  - 9443 for portainer

# What's next?

- The world is your oyster
- The Ansible script installs Docker + Nginx stack + Portainer
