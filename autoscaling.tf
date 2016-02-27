resource "aws_launch_configuration" "coreos_launch_config" {
    associate_public_ip_address = true
    name = "coreos-example-lc"
    image_id = "${lookup(var.aws_amis, var.aws_region)}"
    instance_type = "${var.instance_type}"
    key_name = "${var.key_name}"
    security_groups = ["${aws_security_group.coreos_sg.id}", "${aws_security_group.allow_ssh.id}"]
    user_data = <<EOF
#cloud-config

coreos:
  etcd2:
    discovery: ${var.token}
    advertise-client-urls: http://$private_ipv4:2379
    initial-advertise-peer-urls: http://$private_ipv4:2380
    listen-client-urls: http://0.0.0.0:2379,http://0.0.0.0:4001
    listen-peer-urls: http://$private_ipv4:2380
  flannel:
    etcd_prefix: "/coreos.com/network2"
  units:
  - name: etcd2.service
    command: start
  - name: fleet.service
    command: start
EOF

    lifecycle {
      create_before_destroy = false
    }
}

resource "aws_autoscaling_group" "coreos_asg" {
  name = "coreos-example-asg"
  max_size = 5
  min_size = 1
  desired_capacity = 3
  force_delete = true
  launch_configuration = "${aws_launch_configuration.coreos_launch_config.name}"
  vpc_zone_identifier = ["${aws_subnet.coreos.id}"]

  lifecycle {
    create_before_destroy = false
  }

  tag {
    key = "Name"
    value = "coreos-asg"
    propagate_at_launch = "true"
  }
}
