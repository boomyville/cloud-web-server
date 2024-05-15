# main.tf

resource "oci_core_virtual_network" "vcn" {
  compartment_id = var.compartment_ocid
  cidr_block     = var.cidr
  dns_label      = var.dns_label
  display_name   = var.dns_label
}

resource "oci_core_internet_gateway" "gateway" {
  compartment_id = var.compartment_ocid
  display_name   = "${var.dns_label}_gateway"
  vcn_id         = oci_core_virtual_network.vcn.id
}

resource "oci_core_route_table" "route_table" {
  compartment_id = var.compartment_ocid
  display_name   = "${var.dns_label}_route"
  vcn_id         = oci_core_virtual_network.vcn.id

  route_rules {
    destination       = "0.0.0.0/0"  # Send all traffic to the internet gateway
    network_entity_id = oci_core_internet_gateway.gateway.id
  }
}


resource "oci_core_subnet" "subnet" {
  availability_domain = var.ad
  compartment_id      = var.compartment_ocid
  vcn_id              = oci_core_virtual_network.vcn.id
  cidr_block          = cidrsubnet(var.cidr, 8, 1) # A terraform function that converts 10.0.0.0/16 to 10.0.0.0/24 (10.0.1.X)
  display_name        = var.dns_label
  dns_label           = var.dns_label
  route_table_id      = oci_core_route_table.route_table.id
  security_list_ids   = [oci_core_security_list.securitylist.id] # Yes you can reference a variable that is declared later in the file
}

resource "oci_core_security_list" "securitylist" {
  display_name   = "Public_security"
  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_virtual_network.vcn.id

  egress_security_rules {
    protocol    = "all"
    destination = "0.0.0.0/0" #Allow all traffic out to anyone on the internet
  }

  ingress_security_rules {
    protocol = "6" #6 is TCP, 17 is UDP and "all" is all
    source   = "0.0.0.0/0"

    tcp_options {
      min = 80 #HTTP
      max = 80
    }
  }

  ingress_security_rules {
    protocol = "6" #6 is TCP, 17 is UDP and "all" is all
    source   = "0.0.0.0/0"

    tcp_options {
      min = 443 #HTTPS
      max = 443
    }
  }

  ingress_security_rules {
    protocol = "6" #6 is TCP, 17 is UDP and "all" is all
    source   = "0.0.0.0/0"

    tcp_options {
      min = 22 #SSH
      max = 22
    }
  }
}


resource "oci_core_instance" "web-server" {
  availability_domain = var.ad
  compartment_id      = var.compartment_ocid
  display_name        = "Webserver"
  shape               = var.compute_shape

  create_vnic_details {
    subnet_id     = oci_core_subnet.subnet.id
    display_name  = "web-server-01"
  }

  source_details {
    source_type            = "image"
    source_id              = var.os_image
    boot_volume_size_in_gbs = "50"
  }

  metadata = {
    ssh_authorized_keys = chomp(file(var.ssh_public_key))
  }
}
