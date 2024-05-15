# Oracle Cloud Terraform setup

Some things to do prior to running this script
- Create the ssh key by using ssh-keygen in the Oracle cloud shell
- This will then create a pub file in user/.ssh/ folder (you will need this key for the ansible stuff)
- Copy that link and add that path to ssh_public_key variable in terraform.tfvars

Open a cloud shell instance

Upload the .tf files into root

Shell command: terraform init

Shell command: terraform apply

The following items will be created:
- Virtual machine
- Network security group with some ports opened
