#### DATASOURCE ####
data "aws_availability_zones" "available" {}


#### VPC ####
resource "aws_vpc" "this" {
  cidr_block           = var.vpc_cidr_block
  instance_tenancy     = "default"
  enable_dns_hostnames = "true"
  enable_dns_support   = "true"

  tags = merge(var.additional_tags, {
    Name = "vpc-${var.environment}-${var.organization}"
    }
  )
}


#### SUBNET PUBLIC ####
resource "aws_subnet" "public" {
  count                   = 3
  vpc_id                  = aws_vpc.this.id
  cidr_block              = element(var.cidr_subnet_public, count.index)
  availability_zone       = element(data.aws_availability_zones.available.names, count.index)
  map_public_ip_on_launch = true

  tags = merge(var.additional_tags, {
    Name = "public-${var.environment}-${element(data.aws_availability_zones.available.names, count.index)}"
    Tier = "Public"
    }
  )
}

#### SUBNET PRIVATE ####
resource "aws_subnet" "private" {
  count             = 3
  vpc_id            = aws_vpc.this.id
  cidr_block        = element(var.cidr_subnet_private, count.index)
  availability_zone = element(data.aws_availability_zones.available.names, count.index)

  tags = merge(var.additional_tags, {
    Name = "private-${var.environment}-${element(data.aws_availability_zones.available.names, count.index)}"
    Tier = "Private"
    }
  )
}


#### INTERNET GETEWAY ####
resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id

  tags = merge(var.additional_tags, {
    Name = "igtw-${var.environment}"
    }
  )
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.this.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.this.id
  }

  tags = merge(var.additional_tags, {
    Name = "igtw-routes-${var.environment}"
    }
  )
}

resource "aws_route_table_association" "public" {
  count          = 3
  subnet_id      = element(aws_subnet.public[*].id, count.index)
  route_table_id = aws_route_table.public.id
}


#### NAT GATEWAY ####
resource "aws_eip" "this" {
  count = 3
  vpc   = true

  tags = merge(var.additional_tags, {
    Name = "nat-eip-${var.environment}-${count.index}"
    }
  )
}

resource "aws_nat_gateway" "this" {
  count         = 3
  allocation_id = element(aws_eip.this[*].id, count.index)
  subnet_id     = element(aws_subnet.public[*].id, count.index)

  tags = merge(var.additional_tags, {
    Name = "nat-${var.environment}-${element(data.aws_availability_zones.available.names, count.index)}-nat-gateway"
    }
  )

  depends_on = [aws_internet_gateway.this]
}

resource "aws_route_table" "private" {
  count  = 3
  vpc_id = aws_vpc.this.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = element(aws_nat_gateway.this[*].id, count.index)
  }


  tags = merge(var.additional_tags, {
    Name = "${var.environment}-${element(data.aws_availability_zones.available.names, count.index)}-nat-gateway-routes"
    }
  )
}

resource "aws_route_table_association" "private" {
  count          = 3
  subnet_id      = element(aws_subnet.private[*].id, count.index)
  route_table_id = element(aws_route_table.private[*].id, count.index)
}
