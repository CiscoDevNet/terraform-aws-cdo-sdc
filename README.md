# Secure Device Connector Terraform module

Secure Device Connector (SDC) is a proxy for communications between the devices and CDO. When onboarding a device to CDO using device credentials, CDO considers it a best practice to download and deploy a Secure Device Connector (SDC) in your network to proxy communications between the devices and CDO. Adaptive Security Appliances (ASAs), FDM-managed devices, Firepower Management Centers (FMCs), Secure Firewall Cloud Native devices, and SSH and IOS devices, can all be onboarded to CDO using an SDC.

Use this Terraform module if you wish to deploy the SDC in your AWS VPC.

## Learn more
The [CDO documentation](https://docs.defenseorchestrator.com/#!c-secure-device-connector-sdc.html?highlight=SDC) has more details on SDC.

# Pre-requisities
- An AWS account
- An AWS VPC with one subnet.
- An AWS Route53 Hosted Zone
- Terraform knowledge


# Supported Regions

| Region       |
| ------------ |
| us-east-1    |
| us-west-1    |
| eu-west-1    |
| eu-west-2    |
| eu-central-1 |

# Architecture
This terraform module will spin up the following:
- An EC2 instance that runs the SDC AMI.
  - An EC2 security group that allows all outbound traffic on TCP port 443.
    - No inbound access required because the SDC talks to the backend via sqs queue.
  - An IAM role that allows starting an SSM sessions to the EC2.

# Usage
Please see [the usage documentation](USAGE.md) and the example below.

## Example
```
module "example-sdc" {
  source             = "git::https://github.com/cisco-lockhart/terraform-aws-cdo-sdc.git?ref=v0.0.1"
  env                = "example-env-ci"
  instance_name      = "example-instance-name"
  instance_size      = "r5a.xlarge"
  cdo_bootstrap_data = "<replace-with-cdo-bootstrap-data>" # see https://docs.defenseorchestrator.com/#!t_deploy-a-sdc-using-cdos-vm-image.html
  vpc_id             = <replace-with-vpc-id>
  subnet_id          = <replace-with-private-subnet-id>
}
```

## Connecting to your SEC instance

Once this terraform module is applied, the SDC should be up and running. However, you may find that you may need to log in to your instance's shell to perform troubleshooting. For security reasons, we do not expose SSH on the SDC that we deploy. You can use AWS SSM Session Manager to connect. To learn more about how to use SSM to connect to your AWS instance, see [the AWS documentation](https://docs.aws.amazon.com/systems-manager/latest/userguide/session-manager-working-with.html). The instance ID is required to connect, and you can get that from the `instance_id` output of this Terraform module.

# Development
- Tags are automatically generated on push to master.
- `USAGE.md` is generated using [terraform-docs](https://github.com/terraform-docs/terraform-docs).