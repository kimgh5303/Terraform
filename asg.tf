data "aws_ami" "myamazonlinux2" {
  most_recent = var.my_amazonlinux2.most_recent
  filter {
    name   = var.my_amazonlinux2.fil_1_name
    values = var.my_amazonlinux2.fil_1_values
  }

  filter {
    name   = var.my_amazonlinux2.fil_2_name
    values = var.my_amazonlinux2.fil_2_values
  }

  owners = var.my_amazonlinux2.owners
}

resource "aws_launch_configuration" "mylaunchconfig" {
  name_prefix     = var.my_launchconfig.name_prefix
  image_id        = data.aws_ami.myamazonlinux2.id
  instance_type   = var.my_launchconfig.instance_type
  security_groups = [aws_security_group.mysg.id]
  associate_public_ip_address = var.my_launchconfig.associate_public_ip_address

   user_data = <<-EOF
              #!/bin/bash
              wget https://busybox.net/downloads/binaries/1.31.0-defconfig-multiarch-musl/busybox-x86_64
              mv busybox-x86_64 busybox
              chmod +x busybox
              RZAZ=$(curl http://169.254.169.254/latest/meta-data/placement/availability-zone-id)
              IID=$(curl 169.254.169.254/latest/meta-data/instance-id)
              LIP=$(curl 169.254.169.254/latest/meta-data/local-ipv4)
              echo "<h1>RegionAz($RZAZ) : Instance ID($IID) : Private IP($LIP) : Web Server</h1>" > index.html
              nohup ./busybox httpd -f -p 80 &
              EOF

  # Required when using a launch configuration with an auto scaling group.
  lifecycle {
    create_before_destroy = true
    #create_before_destroy = var.mylaunchconfig.create_before_destroy
  }
}

resource "aws_autoscaling_group" "myasg" {
  name                 = var.my_asg.name
  launch_configuration = aws_launch_configuration.mylaunchconfig.name
  vpc_zone_identifier  = [aws_subnet.mysubnet1.id, aws_subnet.mysubnet2.id]
  min_size = var.my_asg.min_size
  max_size = var.my_asg.max_size
  health_check_type = var.my_asg.health_check_type
  target_group_arns = [aws_lb_target_group.myalbtg.arn]

  tag {
    key                 = var.my_asg.key
    value               = var.my_asg.value
    propagate_at_launch = var.my_asg.propagate_at_launch
  }
}
