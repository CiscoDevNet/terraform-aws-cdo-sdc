output "instance_id" {
  description = "The ID of the SDC instance. Use this ID to connect to your SEC instance for debugging purposes using AWS SSM (See [the AWS docs](https://docs.aws.amazon.com/systems-manager/latest/userguide/session-manager-working-with.html) for details on how to connect using AWS SSM)."
  value       = aws_instance.sdc.id
}