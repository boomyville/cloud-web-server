# Variables file 

variable "tenancy_ocid" {}
variable "compartment_ocid" {}
variable "ssh_public_key" {}

# Availability domain (1 for free tier)
# Get by running this command in the cloud shell: oci iam availability-domain list 
variable "ad" {
    default = "ZNyW:AP-MELBOURNE-1-AD-1"
}

# Virtual network variables
variable "cidr" {
    default = "10.0.0.0/16"
}

variable "vcn_label" {
    description = "Virtual Cloud Network (VCN) name"
    default = "VCN-boomyville"
}

variable "dns_label" {
    description = "Network DNS label for Virtual Cloud Network (VCN)"
    default = "boomyville"
}

# Operating system
# https://docs.oracle.com/en-us/iaas/images/ubuntu-2204/
# Pick non arch64 image
variable "os_image" {
    default = "ocid1.image.oc1.ap-melbourne-1.aaaaaaaaewofgx5xbpxb6na7zoklo3ov3vgjcd6ese6dsxldatd6nq5t5gga"
}


# Virtual machine (compute) details

variable "compute_shape" {
    description = "The 'shape' or the SKU of the virtual machine"
    default = "VM.Standard.E2.1.Micro"
}

# Load balancer details
/*
variable "balancer_min" {
    description = "Load balancer minimum bandwidth"
    default = "10"
}
variable "balancer_max" {
    description = "Load balancer maximum bandwidth"
    default = "10"
}
*/
