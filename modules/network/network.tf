resource "aws_vpc" "app_vpc" {
  cidr_block           = "${var.ip_address_prefix}.0/16"
  enable_dns_hostnames = true
  tags = {
    Name        = "${var.app_name}-vpc"
    Environment = var.environment
  }
}

resource "aws_subnet" "SubnetWeb1" {
  vpc_id            = aws_vpc.app_vpc.id
  cidr_block        = "${var.ip_address_prefix}.0/26"
  availability_zone = "${var.region}a"

  tags = {
    Name        = "${var.app_name}-web1"
    Environment = var.environment
  }
}

resource "aws_subnet" "SubnetWeb2" {
  vpc_id            = aws_vpc.app_vpc.id
  cidr_block        = "${var.ip_address_prefix}.64/26"
  availability_zone = "${var.region}b"

  tags = {
    Name        = "${var.app_name}-web2"
    Environment = var.environment
  }
}

resource "aws_subnet" "SubnetData1" {
  vpc_id            = aws_vpc.app_vpc.id
  cidr_block        = "${var.ip_address_prefix}.128/26"
  availability_zone = "${var.region}a"

  tags = {
    Name        = "${var.app_name}-data1"
    Environment = var.environment
  }
}

resource "aws_subnet" "SubnetData2" {
  vpc_id            = aws_vpc.app_vpc.id
  cidr_block        = "${var.ip_address_prefix}.192/26"
  availability_zone = "${var.region}b"

  tags = {
    Name        = "${var.app_name}-data2"
    Environment = var.environment
  }
}

resource "aws_internet_gateway" "InternetGateway" {
  vpc_id = aws_vpc.app_vpc.id
  tags = {
    Name        = "${var.app_name}-igw"
    Environment = var.environment
  }
}

resource "aws_route_table" "RouteTablePublic" {
  vpc_id = aws_vpc.app_vpc.id

  tags = {
    Name        = "${var.app_name}-rt-public"
    Environment = var.environment
  }
}

resource "aws_route" "PublicRoute1" {
  route_table_id         = aws_route_table.RouteTablePublic.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.InternetGateway.id
}

resource "aws_route_table_association" "SubnetWeb2RouteTablePublicAssociation" {
  subnet_id      = aws_subnet.SubnetWeb1.id
  route_table_id = aws_route_table.RouteTablePublic.id
}

resource "aws_route_table" "RouteTablePrivate" {
  vpc_id = aws_vpc.app_vpc.id

  tags = {
    Name        = "${var.app_name}-rt-private-1"
    Environment = var.environment
  }
}

resource "aws_route_table_association" "SubnetData1RouteTablePrivateAssociation" {
  subnet_id      = aws_subnet.SubnetData1.id
  route_table_id = aws_route_table.RouteTablePrivate.id
}

resource "aws_route_table_association" "SubnetData2RouteTablePrivateAssociation" {
  subnet_id      = aws_subnet.SubnetData2.id
  route_table_id = aws_route_table.RouteTablePrivate.id
}
