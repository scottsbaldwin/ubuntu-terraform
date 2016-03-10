resource "aws_vpc" "swarm" {
  cidr_block = "10.0.0.0/16"
  enable_dns_hostnames = true

  tags {
      Name = "Docker Swarm VPC"
  }
}

resource "aws_subnet" "swarm_010" {
  vpc_id = "${aws_vpc.swarm.id}"
  cidr_block = "10.0.10.0/24"
  map_public_ip_on_launch = "true"

  tags {
      Name = "Swarm Cluster Subnet 10"
  }
}

resource "aws_subnet" "swarm_011" {
  vpc_id = "${aws_vpc.swarm.id}"
  cidr_block = "10.0.11.0/24"
  map_public_ip_on_launch = "true"

  tags {
      Name = "Swarm Cluster Subnet 11"
  }
}

resource "aws_internet_gateway" "swarm_gw" {
    vpc_id = "${aws_vpc.swarm.id}"

    tags {
        Name = "Swarm Internet Gateway"
    }
}

resource "aws_route" "internet_access" {
  route_table_id = "${aws_vpc.swarm.main_route_table_id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = "${aws_internet_gateway.swarm_gw.id}"
}

resource "aws_route_table_association" "a" {
    subnet_id = "${aws_subnet.swarm_010.id}"
    route_table_id = "${aws_vpc.swarm.main_route_table_id}"
}

resource "aws_route_table_association" "b" {
    subnet_id = "${aws_subnet.swarm_011.id}"
    route_table_id = "${aws_vpc.swarm.main_route_table_id}"
}
