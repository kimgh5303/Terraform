# VPC---------------------------------

variable "region" {
  type    = string
}

variable "vpc" {
  type = object({
    vpc_name= string,
    cidr = string,
    eds = bool,
    edh = bool
  })
}

variable "my_subnet_1" {
  type = object({
    subnet_name= string,
    cidr = string,
    az = string
  })
}

variable "my_subnet_2" {
  type = object({
    subnet_name= string,
    cidr = string,
    az = string
  })
}

variable "igw" {
  type = string
}

variable "rt" {
  type = string
}

# SG---------------------------------

variable "mysg" {
  type = object({
    name    = string
    description = string
  })
}

variable "mysginbound" {
  type = object({
    type    = string
    from_port = number
    to_port = number
    protocol = string
    cidr_blocks = list(string)
  })
}

variable "mysgoutbound" {
  type = object({
    type    = string
    from_port = number
    to_port = number
    protocol = string
    cidr_blocks = list(string)
  })
}

# ASG---------------------------------
variable "my_amazonlinux2" {
  type = object({
    most_recent = bool,
    fil_1_name = string,
    fil_1_values = list(string),
    fil_2_name = string,
    fil_2_values = list(string),
    owners = list(string)
  })
}

variable "my_launchconfig" {
  type = object({
    name_prefix = string,
    instance_type = string,
    associate_public_ip_address = bool,
    create_before_destroy = bool
  })
}
variable "my_asg" {
  type = object({
    name = string,
    min_size = number,
    max_size = number,
    health_check_type = string,
    key = string,
    value = string,
    propagate_at_launch = bool
  })
}

# ALB---------------------------------

variable "my_alb" {
  type = object({
    name = string,
    lbtype = string
  })
}

variable "my_http" {
  type = object({
    port = number,
    protocol = string,
    da_type = string,
    fr_ct_type = string,
    fr_ct_mb = string,
    fr_ct_sc = number
  })
}

variable "my_alb_tg" {
  type = object({
    name = string,
    port = number,
    protocol = string,
    hc_path = string,
    hc_protocol = string,
    hc_matcher = string,
    hc_interval = number,
    hc_timeout = number,
    hc_ht = number,
    hc_ut = number
  })
}

variable "my_alb_rule" {
  type = object({
    priority = number,
    con_pp_values = list(string),
    act_type = string
  })
}
