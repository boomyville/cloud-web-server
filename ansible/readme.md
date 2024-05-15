## Ansible script

Run the setup.yaml after terraform has established the underlying infrastructure

Make sure to change the following values:
- hosts.ini (host ip address and username)
- anisble variables (for our docker installation)

Use the following command
- ansible-playbook -i hosts.ini --e 'host_key_checking=False ansible_ssh_private_key_file=ssh.key' --limit webservers setup.yaml

The ansible script will perform the following tasks:
- Ping an IP (just to test it works)
- Install docker
- Install SWAG stack (nginx webserver)
- Install MariaDB
- Install portainer (for managing docker with GUI)

To-do:
- Add a shell command to add the mysql_user to have privileges to the database (mysql - u root - p)
- Add wget command to pull a github repository (website) to the www folder
