terraform {
  required_version = ">=1.1"
  required_providers {
    aws = ">= 4.66.1"
    template = "~> 2.2.0"
  }
}

locals {
  ami_version = "a1dc5c0f78915135f94f3ca03cce172f34c96bf5"  # see https://jenkins2.dev.lockhart.io/job/Bakery/job/cdo-connector-ami/
}

data "aws_ami" "sdc" {
  filter {
    name   = "name"
    values = ["cdo-connector-${local.ami_version}-*"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  owners = ["005087805285"]

  most_recent = true
}

resource "aws_security_group" "sdc" {
  vpc_id      = var.vpc_id
  name        = "${var.env}-${var.instance_name}-sdc-outbound-sg"
  description = "Security Group that allows all egress to the internet on TCP port 22 and 443"

  egress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge({
    Name = "${var.env}-${var.instance_name}-sec-sg"
  }, var.tags)

  lifecycle {
    create_before_destroy = true
  }
}

data "template_file" "bootstrap" {
  template = file("${path.module}/bootstrap_sdc.tpl")
  vars = {
    cdo_bootstrap_data = var.cdo_bootstrap_data
  }
}

resource "aws_instance" "sdc" {
  ami                  = data.aws_ami.sdc.id
  instance_type        = var.instance_size
  iam_instance_profile = aws_iam_instance_profile.sdc-ssm-instance-profile.name
  tags = merge({
    Name = "${var.env}-${var.instance_name}-sdc"
    AMI_Version = local.ami_version
  }, var.tags)
  subnet_id              = var.subnet_id
  vpc_security_group_ids = [aws_security_group.sdc.id]
  user_data              = data.template_file.bootstrap.rendered
}
