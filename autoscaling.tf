resource "aws_launch_configuration" "control_plane_launch_config_001" {
    associate_public_ip_address = true
    image_id = "${lookup(var.aws_amis, var.aws_region)}"
    instance_type = "${var.control_instance_type}"
    key_name = "${var.key_name}"
    name = "${var.name}-control-lc-001"
    root_block_device = {
      volume_type = "gp2"
      volume_size = 16
    }
    security_groups = ["${aws_security_group.cluster_sg.id}", "${aws_security_group.allow_ssh.id}", "${aws_security_group.allow_consul_http.id}"]

    lifecycle {
      create_before_destroy = false
    }
}

resource "aws_autoscaling_group" "control_plane_asg" {
  name = "${var.name}-control-asg"
  max_size = 5
  min_size = 1
  desired_capacity = 3
  force_delete = true
  launch_configuration = "${aws_launch_configuration.control_plane_launch_config_001.name}"
  vpc_zone_identifier = ["${aws_subnet.cluster_010.id}", "${aws_subnet.cluster_011.id}"]

  lifecycle {
    create_before_destroy = false
  }

  tag {
    key = "Name"
    value = "${var.name}"
    propagate_at_launch = "true"
  }
  tag {
    key = "Role"
    value = "control-plane"
    propagate_at_launch = "true"
  }
}

resource "aws_launch_configuration" "data_plane_launch_config" {
    associate_public_ip_address = true
    image_id = "${lookup(var.aws_amis, var.aws_region)}"
    instance_type = "${var.data_instance_type}"
    key_name = "${var.key_name}"
    name = "${var.name}-data-lc"
    root_block_device = {
      volume_type = "gp2"
      volume_size = 50
    }
    security_groups = ["${aws_security_group.cluster_sg.id}", "${aws_security_group.allow_ssh.id}", "${aws_security_group.allow_http.id}"]

    lifecycle {
      create_before_destroy = false
    }
}

resource "aws_autoscaling_group" "data_plane_asg" {
  name = "${var.name}-data-asg"
  max_size = 5
  min_size = 1
  desired_capacity = 3
  force_delete = true
  launch_configuration = "${aws_launch_configuration.data_plane_launch_config.name}"
  vpc_zone_identifier = ["${aws_subnet.cluster_010.id}", "${aws_subnet.cluster_011.id}"]

  lifecycle {
    create_before_destroy = false
  }

  tag {
    key = "Name"
    value = "${var.name}"
    propagate_at_launch = "true"
  }
  tag {
    key = "Role"
    value = "data-plane"
    propagate_at_launch = "true"
  }
}
