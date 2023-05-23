## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | 1.3.9 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 4.66.1 |
| <a name="requirement_template"></a> [template](#requirement\_template) | ~> 2.2.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 4.66.1 |
| <a name="provider_template"></a> [template](#provider\_template) | ~> 2.2.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_iam_instance_profile.sdc-ssm-instance-profile](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_instance_profile) | resource |
| [aws_iam_role.sdc-ssm-role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.sdc-ssm-role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_instance.sdc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance) | resource |
| [aws_security_group.sdc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_ami.sdc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ami) | data source |
| [aws_iam_policy.AmazonSSMManagedInstanceCore](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy) | data source |
| [aws_iam_policy_document.assume_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_partition.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/partition) | data source |
| [template_file.bootstrap](https://registry.terraform.io/providers/hashicorp/template/latest/docs/data-sources/file) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cdo_bootstrap_data"></a> [cdo\_bootstrap\_data](#input\_cdo\_bootstrap\_data) | Base64-encoded CDO Bootstrap Data. You can generate this using [CDO](https://edge.us.cdo.cisco.com/content/docs/index.html#!t_install-a-cdo-connector-to-support-an-on-premises-sec-using-your-vm-image1.html) (see Step 19). | `string` | n/a | yes |
| <a name="input_env"></a> [env](#input\_env) | A user-defined string to indicate the environment. | `string` | `"prod"` | no |
| <a name="input_instance_name"></a> [instance\_name](#input\_instance\_name) | The name to give the SDC instance (the instance created will be prefixed with `env`, and suffixed with `sdc`). | `string` | n/a | yes |
| <a name="input_instance_size"></a> [instance\_size](#input\_instance\_size) | Size of the EC2 instance used to run the SDC). Allowed values: "r5a.xlarge", "r5a.2xlarge", "r5a.4xlarge", "r5a.8xlarge", "r5a.12xlarge". We recommend using r5a.xlarge (the default). | `string` | `"r5a.xlarge"` | no |
| <a name="input_subnet_id"></a> [subnet\_id](#input\_subnet\_id) | The subnet to deploy the SDC instance in. The subnet must be in the VPC specified in `vpc_id`. We recommend deploying the SDC in a private subnet. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | The tags to add to all of the resources created by this Terraform module. | `map(string)` | <pre>{<br>  "ApplicationName": "Cisco Defense Orchestrator",<br>  "ServiceName": "SDC"<br>}</pre> | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | The ID of the VPC to deploy the SDC instance in. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_instance_id"></a> [instance\_id](#output\_instance\_id) | The ID of the SDC instance. |
