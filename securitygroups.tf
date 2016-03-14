resource "aws_security_group" "cluster_sg" {
  name = "${var.name}-cluster"
  description = "allow ${var.name} cluster communication"
  vpc_id = "${aws_vpc.cluster.id}"

  ingress {
    from_port = 4647
    to_port = 4647
    protocol = "tcp"
    cidr_blocks = ["${var.inbound_cidr}"]
  }

  ingress {
    from_port = 4648
    to_port = 4648
    protocol = "tcp"
    cidr_blocks = ["${var.inbound_cidr}"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}

resource "aws_security_group" "allow_ssh" {
  name = "${var.name}-allow-ssh"
  description = "allow incoming ssh"
  vpc_id = "${aws_vpc.cluster.id}"

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
