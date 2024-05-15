# Oracle Cloud Free Tier Website
A collection of terraform and ansible scripts to deploy an NGINX web server running in a docker container on Oracle Cloud (or Microsoft Azure) using the free tier service


## Using Terraform and Ansible to automate the process

Included in this repository is a collection of Terraform scripts for Oracle Cloud and Microsoft Azure

Do note that Microsoft Azure is not free. 

Both terraform scripts will create a virtual machine with a configured network security group

Terraform scripts should be uploaded to the cloud shell and the terraform command should be run via cloud shell

The ansible script is run after the virtual machine is initialised and is run from the user's local computer (not off the cloud or via SSH)

## Creating a portfolio website for free using the portal (using the graphical interface)

* Why free?
    * Free is good. For a lot of people, commitment of money is a barrier to entry. Sure hosting your own website might cost less than a coffee a month but who wants to give up that coffee once a month? 
    * Working with limitations is good. In the workplace, we may have limitations on what we can do; it might be manpower or time or money. Working with what you've got shows adaptability and awareness of the situation. 
    * And we are working with the cloud which whilst very powerful can also be very expensive. I'm sure you've heard of horror stories where cloud costs go through the roof for very basic resources such as:
        * [https://www.reddit.com/r/aws/comments/1cg7ce8/how_an_empty_private_s3_bucket_can_make_your_bill/](https://www.reddit.com/r/aws/comments/1cg7ce8/how_an_empty_private_s3_bucket_can_make_your_bill/)
* Why a website
    * Websites are easily accessible to anyone including potential employers and recruiters. As we all know, jobs in IT are scarce in supply and the demand for entry-level jobs is through the roof so we as cloud spartans need to:
        * Stand out
        * Make the biggest impact with the tiny window of attention recruiters give us
    * Websites are also a great tool to learn; everything nowadays has a website and most businesses use websites; either as an app or for e-commerce or to provide support to customers. Having knowledge of how to deploy a website will be important skill for any budding cloud developer
* Why Oracle
    * Oracle provide a free tier which includes:
        * Crappy compute instance (for unlimited hours)
        * Some storage for our crappy compute service (20GB I think)
        * Free bandwidth of 10TB a month
    * Oracle is useless otherwise…
* Some things to be wary of
    * Be careful how much personal information you put on the web; you need to be comfortable with what you are exposing yourself too. You could put your entire resume and contact details on the web; but now you have increased the attack surface for identity theft and targeted cybersecurity attacks against you
    * Oracle is a big evil mega corporation and they can pull the rug on your little free cloud computing lands. [https://docs.oracle.com/en-us/iaas/Content/FreeTier/freetier_topic-Always_Free_Resources.htm](https://docs.oracle.com/en-us/iaas/Content/FreeTier/freetier_topic-Always_Free_Resources.htm)
* Requirements
    * SSH client
    * Credit card
    * Sanity / Time
* Step 1 - Account creation
    * Create an Oracle Cloud account
    * Yes you will need a credit card
    * Yes you will be 'charged' $1.50 
    * No they won't actually be taking your money
    * I used a debit card so they can't take all my money away
* Step 2 - Setting up our compute instance
    * Type 'instance' in the search bar
    * Create a new compute instance
    * Pick 'free' option
    * Don't worry about the $3 cost for boot volume; it's actually free
    * Pick Canonical Ubuntu 22.4 as the image (or some other linux if your heart desires but keep it Linux folks)
    * You get $400 credit anyway but the goal is to have $400 after a month to demonstrate to yourself that running this service is 'free'
    * Make sure to download the SSH key otherwise we won't be logging into anything
* Step 3 - SSH into our computer
    * ssh -i ssh-key-2024-05-01.key ubuntu@some_ip_address
    * Replace IP address with the public IP address of your compute instance
    * Make sure you run this command in the same folder as the ssh key that you downloaded from Oracle Cloud
* Step 4 - Install stuff
    * In this example I am going to install SWAG on a docker container
    * So I am going to install docker 
    * [https://docs.docker.com/engine/install/ubuntu/](https://docs.docker.com/engine/install/ubuntu/)
    * Then I'm going to install portainer CE because I don't like command line
    * [https://docs.portainer.io/start/install-ce/server/docker/linux](https://docs.portainer.io/start/install-ce/server/docker/linux)
    * Then I'm going to open port 9443 so I can access portainer
        * We can do this with a network security group
        * Select the (only) virtual network that exists and you should already see some pre-built rules (mainly the SSH one that allows SSH traffic to our virtual network)
        * Create an ingress rule to allow all traffic to be accessible via port 9443 on any private IP address
    * I am also going to open port 80 and port 443 so we can access our website
* Step 5 - Configure portainer
    * [https://ip-address:9443](https://ip-address:9443)
    * Accept the security certificate warning (its a self-signed certificate)
    * Create an account
* Step 7 - Docker compose
    * Create a new stack
    * Copy the docker compose code from SWAG repository
    * [https://docs.linuxserver.io/general/swag/#docker-cli](https://docs.linuxserver.io/general/swag/#docker-cli)
    * Configure the docker compose file to suit your needs (for example timezone)
    * Also add duckdns
    * [https://docs.linuxserver.io/images/docker-duckdns/#docker-cli](https://docs.linuxserver.io/images/docker-duckdns/#docker-cli)
* Step 7 - Sign up to duckdns
    * We are going to use a dynamic DNS service to get ourselves a free domain
    * Duckdns is free
    * Its actual purpose is to translate a server's IP address to 'duckdns.org'
    * Useful for dynamic IPs
    * Once you make an account, create a domain (whatever.duckdns.org) and copy the tokenId. Also set the IP address of the domain to your public IP of your virtual machine
* Step 8 - Configure duckdns and SWAG stacks on portainer
    * Add your subdomain and token to the duckdns stack
    * Map a volume for the config folder for both the swag and duckdns docker images
    * For SWAG, add your duckdns domain name as the URL, set validation to DNS and dnsplugin as duckdns
    * Also you need to edit duckdns.ini in the config folder for swag and add your tokenId into the ini file
* Step 9 - Deploy the docker containers
* Step 10 - Install [MariaDB](https://mariadb.com/resources/blog/get-started-with-mariadb-using-docker-in-3-steps/)
    * Make sure to tweak various settings on your MariaDB instance to [enable connection outside of the container](https://mariadb.com/kb/en/installing-and-using-mariadb-via-docker/)
    * You will also need to give your user [privileges](https://dev.mysql.com/doc/refman/8.0/en/grant.html) to create/modify the database that you created 

To do list
* ~~Add terraform to create the VM / virtual network / NSG~~
* ~~Automate sudo apt upgrade / docker installation commands (using shell module with Ansible or I dunno something)~~
* Link the www folder to a GitHub repository (just wget... probably incorporate this with Ansible)
