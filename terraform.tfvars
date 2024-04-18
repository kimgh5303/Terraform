# VPC----------------------------------------

region = "ap-northeast-2"

vpc = {
  "vpc_name": "mzcloud",
  "cidr": "10.10.0.0/16",
  "eds": "true",
  "edh": "true"
}

my_subnet_1 = {
  "subnet_name": "mzc-subnet1",
  "cidr": "10.10.1.0/24",
  "az": "ap-northeast-2a"
}

my_subnet_2 = {
  "subnet_name": "mzc-subnet2",
  "cidr": "10.10.2.0/24",
  "az": "ap-northeast-2c"
}

igw = "mzc-igw"

rt = "mzc-rt"

# SG----------------------------------------

mysg = {
  "name": "MZC SG"
  "description": "MZC-101 SG"
}

mysginbound = {
  "type": "ingress"
  "from_port": 0
  "to_port": 80
  "protocol": "tcp"
  "cidr_blocks": ["0.0.0.0/0"]
}

mysgoutbound = {
  "type": "egress"
  "from_port": 0
  "to_port": 0
  "protocol": "-1"
  "cidr_blocks": ["0.0.0.0/0"]
}

# ASG---------------------------------
my_amazonlinux2 = {
    "most_recent" : true
    "fil_1_name" : "owner-alias"
    "fil_1_values" : ["amazon"]
    "fil_2_name" : "name"
    "fil_2_values" : ["amzn2-ami-hvm-*-x86_64-ebs"]
    "owners" : ["amazon"]
}
my_launchconfig = {
  "name_prefix" : "mzc-cloud-"
  "instance_type" : "t2.micro"
  "associate_public_ip_address" : true
  "create_before_destroy" : true
}
my_asg = {
  "name" : "myasg"
  "min_size" : 3
  "max_size" : 10
  "health_check_type" : "ELB"
  "key" : "Name"
  "value" : "terraform-asg"
  "propagate_at_launch" : true
}

# ALB---------------------------------

my_alb = {
  "name": "mzc-alb"
  "lbtype": "application"
}

my_http = {
  "port": 80
  "protocol": "HTTP"
  "da_type": "fixed-response"
  "fr_ct_type": "text/plain"
  "fr_ct_mb": "404: page not found - BABO"
  "fr_ct_sc": 404
}

my_alb_tg = {
  "name": "mzc-alb-tg"
  "port": 80
  "protocol": "HTTP"
  "hc_path": "/"
  "hc_protocol": "HTTP"
  "hc_matcher": "200-299"
  "hc_interval": 5
  "hc_timeout": 3
  "hc_ht": 2
  "hc_ut": 2
}

my_alb_rule = {
    "priority": 100
    "con_pp_values": ["*"]
    "act_type": "forward"
}