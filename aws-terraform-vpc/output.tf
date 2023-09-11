output "aws_vpc_id" {
  value = aws_vpc.this.id
}

output "aws_subnet_public_id" {
  value = aws_subnet.public[*].id
}

output "aws_subnet_private_id" {
  value = aws_subnet.private[*].id
}

