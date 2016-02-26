resource "aws_vpc" "coreos" {
  cidr_block = "10.0.0.0/16"
  enable_dns_hostnames = true

  tags {
      Name = "CoreOS VPC"
  }
}

resource "aws_subnet" "coreos" {
  vpc_id = "${aws_vpc.coreos.id}"
  cidr_block = "10.0.1.0/24"
  map_public_ip_on_launch = "true"

  tags {
      Name = "CoreOS Cluster"
  }
}

resource "aws_internet_gateway" "coreos_gw" {
    vpc_id = "${aws_vpc.coreos.id}"

    tags {
        Name = "CoreOS Internet Gateway"
    }
}

resource "aws_route" "internet_access" {
  route_table_id = "${aws_vpc.coreos.main_route_table_id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = "${aws_internet_gateway.coreos_gw.id}"
}

resource "aws_route_table_association" "a" {
    subnet_id = "${aws_subnet.coreos.id}"
    route_table_id = "${aws_vpc.coreos.main_route_table_id}"
}