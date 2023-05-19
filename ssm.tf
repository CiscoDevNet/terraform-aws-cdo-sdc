data "aws_partition" "current" {}

data "aws_iam_policy" "AmazonSSMManagedInstanceCore" {
  arn = "arn:${data.aws_partition.current.partition}:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "sdc-ssm-role" {
  name        = "${var.env}-${var.instance_name}-sdc-ssm-role"
  path        = "/"
  description = "AWS IAM Role required for SSM managed access to the SEC"
  tags = merge(var.tags, {
    Name : "${var.env}-sdc-ssm-role"
  })

  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

resource "aws_iam_role_policy_attachment" "sdc-ssm-role" {
  role       = aws_iam_role.sdc-ssm-role.name
  policy_arn = data.aws_iam_policy.AmazonSSMManagedInstanceCore.arn
}

resource "aws_iam_instance_profile" "sdc-ssm-instance-profile" {
  name = "${var.env}-${var.instance_name}-sdc-ssm-instance-profile"
  role = aws_iam_role.sdc-ssm-role.name
}
