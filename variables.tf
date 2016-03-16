variable "aws_region" {
  default = "us-east-1"
}

variable "name" {}

# Defaults to something unrouteable
variable "personal_home_ip" {
  default = "10.0.0.0"
}

variable "aws_amis" {
  default = {
    us-east-1 = "ami-ff427095"
  }
}

variable "inbound_cidr" {
  default = "10.0.0.0/16"
}

variable "availability_zones" {
  default = "us-east-1b,us-east-1c,us-east-1d,us-east-1e"
}

variable "control_instance_type" {
  default = "m3.medium"
  description = "AWS instance type"
}

variable "data_instance_type" {
  default = "m4.large"
  description = "AWS instance type"
}

variable "key_name" {
  description = "SSH keypair name to use on instances"
}

provider "aws" {
  region = "${var.aws_region}"
}
