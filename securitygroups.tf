resource "aws_security_group" "swarm_sg" {
  name = "swarm_sg"
  description = "swarm SecurityGroup"
  vpc_id = "${aws_vpc.swarm.id}"

  ingress {
    from_port = 80
    to_port = 80
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
  name = "allow-ssh"
  description = "allow incoming ssh"
  vpc_id = "${aws_vpc.swarm.id}"

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
