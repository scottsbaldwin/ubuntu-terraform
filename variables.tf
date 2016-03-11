variable "aws_region" {
  default = "us-east-1"
}

variable "name" {}

variable "aws_amis" {
  default = {
    us-east-1 = "ami-fce3c696"
  }
}

variable "inbound_cidr" {
  default = "10.0.0.0/16"
}

variable "availability_zones" {
  default = "us-east-1b,us-east-1c,us-east-1d,us-east-1e"
}

variable "instance_type" {
  default = "t2.medium"
  description = "AWS instance type"
}

variable "key_name" {
  description = "SSH keypair name to use on instances"
}

provider "aws" {
  region = "${var.aws_region}"
}
