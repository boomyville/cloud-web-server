# Terraform has a 'resource' that creates a random 'pet name' 
# These pet names are mainly used to create unique resource names
resource "random_pet" "ssh_key_name" {
  prefix    = "ssh"
  separator = ""
}

#  azapi_resource_action runs actions in azure via an API
# In this example we are using the sshPublicKeys API
resource "azapi_resource_action" "ssh_public_key_gen" {
  type        = "Microsoft.Compute/sshPublicKeys@2024-03-01"
  resource_id = azapi_resource.ssh_public_key.id
  action      = "generateKeyPair"
  method      = "POST"

  response_export_values = ["publicKey", "privateKey"]
}

# 2024-03-01 is the API version
# To keep up to date: Google Azure Ssh Public Keys
# The azapi_resource service allows us to modify or delete existing resources
# In this case we are setting a location and parent id and name for our ssh key
# Note that azurerm_resource_group will be created in a different script
resource "azapi_resource" "ssh_public_key" {
  type      = "Microsoft.Compute/sshPublicKeys@2024-03-01"
  name      = random_pet.ssh_key_name.id
  location  = azurerm_resource_group.rg.location
  parent_id = azurerm_resource_group.rg.id
}

# Spits out public key data of the ssh key
# We can access this data in terraform 
output "key_data" {
  value = file("~/.ssh/id_rsa.pub")
}