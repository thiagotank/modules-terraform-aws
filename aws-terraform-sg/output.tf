output "security_group_id" {
  description = "The ID of the security group."
  value       = aws_security_group.this.id
}

output "security_group_ids" {
  value = aws_security_group.this.*.id
}
