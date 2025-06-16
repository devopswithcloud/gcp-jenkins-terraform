variable "project" {
    description = "The ID of the Google Cloud project to use."
    type        = string
}

variable "region" {
    description = "The region in which to create resources."
    type        = string
    #default     = "us-central1"
}


# Varible defined for vpc module
variable "vpc_name" {
  type        = string
  description = "The name of the VPC network to create."
}

# Variable defined for subnet module
variable "subnet_name" {
  type        = string
  description = "The name of the subnet to create."
}
variable "subnet_cidr" {
  type        = string
  description = "The CIDR block for the subnet."
}

# Variable defined for GCE module
variable "vm_name" {
  type        = string
  description = "The name of the GCE instance to create."
}
variable "zone" {
  type        = string
  description = "The zone in which to create the GCE instance."
}
variable "machine_type" {
  type        = string
  description = "The machine type for the GCE instance."
}
