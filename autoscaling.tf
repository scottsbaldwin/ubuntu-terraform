resource "aws_launch_configuration" "swarm_launch_config" {
    associate_public_ip_address = true
    image_id = "${lookup(var.aws_amis, var.aws_region)}"
    instance_type = "${var.instance_type}"
    key_name = "${var.key_name}"
    name = "swarm-example-lc"
    root_block_device = {
      volume_type = "gp2"
      volume_size = 50
    }
    security_groups = ["${aws_security_group.swarm_sg.id}", "${aws_security_group.allow_ssh.id}"]

    lifecycle {
      create_before_destroy = false
    }
}

resource "aws_autoscaling_group" "swarm_asg" {
  name = "swarm-example-asg"
  max_size = 5
  min_size = 1
  desired_capacity = 3
  force_delete = true
  launch_configuration = "${aws_launch_configuration.swarm_launch_config.name}"
  vpc_zone_identifier = ["${aws_subnet.swarm_010.id}", "${aws_subnet.swarm_011.id}"]

  lifecycle {
    create_before_destroy = false
  }

  tag {
    key = "Name"
    value = "swarm-asg"
    propagate_at_launch = "true"
  }
}
