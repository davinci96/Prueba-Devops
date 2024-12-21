output "vpc_id" {
  value = aws_vpc.app_vpc.id
}

output "public_subnet_id" {
  value = aws_subnet.SubnetWeb1.id
}

output "private_subnet_id" {
  value = aws_subnet.SubnetData1.id
}

output "security_group_id" {
  value = aws_security_group.web.id
}