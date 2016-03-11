resource "aws_vpc" "cluster" {
  cidr_block = "10.0.0.0/16"
  enable_dns_hostnames = true

  tags {
      Name = "${var.name} VPC"
  }
}

resource "aws_subnet" "cluster_010" {
  vpc_id = "${aws_vpc.cluster.id}"
  cidr_block = "10.0.10.0/24"
  map_public_ip_on_launch = "true"

  tags {
      Name = "${var.name} Cluster Subnet 10"
  }
}

resource "aws_subnet" "cluster_011" {
  vpc_id = "${aws_vpc.cluster.id}"
  cidr_block = "10.0.11.0/24"
  map_public_ip_on_launch = "true"

  tags {
      Name = "${var.name} Cluster Subnet 11"
  }
}

resource "aws_internet_gateway" "cluster_gw" {
    vpc_id = "${aws_vpc.cluster.id}"

    tags {
        Name = "${var.name} Internet Gateway"
    }
}

resource "aws_route" "internet_access" {
  route_table_id = "${aws_vpc.cluster.main_route_table_id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = "${aws_internet_gateway.cluster_gw.id}"
}

resource "aws_route_table_association" "a" {
    subnet_id = "${aws_subnet.cluster_010.id}"
    route_table_id = "${aws_vpc.cluster.main_route_table_id}"
}

resource "aws_route_table_association" "b" {
    subnet_id = "${aws_subnet.cluster_011.id}"
    route_table_id = "${aws_vpc.cluster.main_route_table_id}"
}
