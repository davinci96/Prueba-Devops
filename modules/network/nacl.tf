// create network acl for public subnets with ingress and egress rules
resource "aws_network_acl" "PublicSubnetNetworkAcl" {
  vpc_id = aws_vpc.app_vpc.id
  subnet_ids = [
    aws_subnet.SubnetWeb1.id,
    aws_subnet.SubnetWeb2.id
  ]

  ingress {
    protocol   = "tcp"
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 80
    to_port    = 80
  }

  ingress {
    protocol   = "tcp"
    rule_no    = 101
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 443
    to_port    = 443
  }

  ingress {
    protocol   = "6"
    rule_no    = 102
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 22
    to_port    = 22
  }
  
  ingress {
    rule_no    = 103
    action     = "allow"
    from_port  = 1025
    to_port    = 65535
    protocol   = "6"
    cidr_block = "0.0.0.0/0"
  }

  egress {
    protocol   = "-1"
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  tags = {
    Name        = "${var.app_name}-nacl-public"
    Environment = var.environment
  }
}

// create network acl for private subnets with ingress and egress rules
resource "aws_network_acl" "PrivateSubnetNetworkAcl" {
  vpc_id = aws_vpc.app_vpc.id
  subnet_ids = [
    aws_subnet.SubnetData1.id,
    aws_subnet.SubnetData2.id
  ]

  ingress {
    protocol   = "tcp"
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 80
    to_port    = 80
  }

  ingress {
    protocol   = "tcp"
    rule_no    = 101
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 443
    to_port    = 443
  }

  egress {
    protocol   = "-1"
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  tags = {
    Name        = "${var.app_name}-nacl-private"
    Environment = var.environment
  }
}