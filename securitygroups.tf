resource "aws_security_group" "cluster_sg" {
  name = "${var.name}-cluster"
  description = "allow ${var.name} cluster communication"
  vpc_id = "${aws_vpc.cluster.id}"

  # Nomad uses dynamic ports for services, because of this, we need to allow all traffic between cluster members
  ingress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    security_groups = ["${aws_security_group.cluster_sg.id}"]
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

resource "aws_security_group" "allow_http" {
  name = "${var.name}-allow-http"
  description = "allow incoming http"
  vpc_id = "${aws_vpc.cluster.id}"

  ingress {
    from_port = 80
    to_port = 80
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

resource "aws_security_group" "allow_consul_http" {
  name = "${var.name}-allow-consul-http"
  description = "allow incoming consul http"
  vpc_id = "${aws_vpc.cluster.id}"

  ingress {
    from_port = 8500
    to_port = 8500
    protocol = "tcp"
    cidr_blocks = ["${var.personal_home_ip}/32"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
