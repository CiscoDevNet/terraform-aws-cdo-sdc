variable "instance_size" {
  description = "Size of the EC2 instance used to run the SDC). Allowed values: \"r5a.xlarge\", \"r5a.2xlarge\", \"r5a.4xlarge\", \"r5a.8xlarge\", \"r5a.12xlarge\". We recommend using r5a.xlarge (the default)."
  type        = string
  default     = "t2.medium"
}

variable "env" {
  description = "A user-defined string to indicate the environment."
  type        = string
  default     = "prod"
}

variable "instance_name" {
  description = "The name to give the SDC instance (the instance created will be prefixed with `env`, and suffixed with `sdc`)."
  type        = string
}

variable "vpc_id" {
  description = "The ID of the VPC to deploy the SDC instance in."
  type        = string
}

variable "tags" {
  description = "The tags to add to all of the resources created by this Terraform module."
  default = {
    ApplicationName = "Cisco Defense Orchestrator"
    ServiceName     = "SDC"
  }
  type = map(string)
}

variable "cdo_bootstrap_data" {
  description = "Base64-encoded CDO Bootstrap Data. You can generate this using [CDO](https://edge.us.cdo.cisco.com/content/docs/index.html#!t_install-a-cdo-connector-to-support-an-on-premises-sec-using-your-vm-image1.html) (see Step 19)."
  type        = string
}

variable "subnet_id" {
  description = "The subnet to deploy the SDC instance in. The subnet must be in the VPC specified in `vpc_id`. We recommend deploying the SDC in a private subnet."
  type        = string
}