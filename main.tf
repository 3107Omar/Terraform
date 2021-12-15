# Configure the OpenStack Provider
terraform {
  required_providers {
    openstack = {
      source = "terraform-provider-openstack/openstack"
    }
  }
}
provider "openstack" {
  cloud  = "osp_admin" # cloud defined in cloud.yml file
}

# Variables
variable "keypair" {
  type    = string
  default = "admin"   # name of keypair created
}

variable "network" {
  type    = string
  default = "test" # default network to be used
}

variable "security_groups" {
  type    = list(string)
  default = ["default"]  # Name of default security group
}

# Data sources
## Get Image ID
data "openstack_images_image_v2" "image" {
  name        = "cirros" # Name of image to be used
  most_recent = true
}

## Get flavor id
data "openstack_compute_flavor_v2" "flavor" {
  name = "cirros" # flavor to be used
}

# Create an instance
resource "openstack_compute_instance_v2" "telco" {
  name            = "telco"  #Instance name
  image_id        = data.openstack_images_image_v2.image.id
  flavor_id       = data.openstack_compute_flavor_v2.flavor.id
  key_pair        = var.keypair
  security_groups = var.security_groups

  network {
    name = var.network
  }
}

# Output VM IP Address
output "serverip" {
 value = openstack_compute_instance_v2.telco.access_ip_v4
}
