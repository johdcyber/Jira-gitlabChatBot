# Route Tables - Master Region
resource "aws_route_table" "public_rt_master" {
  provider = aws.region-master
  vpc_id   = aws_vpc.vpc_master.id
  
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw_master.id
  }
  
  tags = merge(local.common_tags, {
    Name = "master-public-rt"
  })
}

resource "aws_route_table" "private_rt_master" {
  count    = 2
  provider = aws.region-master
  vpc_id   = aws_vpc.vpc_master.id
  
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_master[count.index].id
  }
  
  tags = merge(local.common_tags, {
    Name = "master-private-rt-${count.index + 1}"
  })
}

# Route Tables - Worker Region
resource "aws_route_table" "public_rt_worker" {
  provider = aws.region-worker
  vpc_id   = aws_vpc.vpc_worker.id
  
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw_worker.id
  }
  
  tags = merge(local.common_tags, {
    Name = "worker-public-rt"
  })
}

resource "aws_route_table" "private_rt_worker" {
  count    = 2
  provider = aws.region-worker
  vpc_id   = aws_vpc.vpc_worker.id
  
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_worker[count.index].id
  }
  
  tags = merge(local.common_tags, {
    Name = "worker-private-rt-${count.index + 1}"
  })
}

# Route Table Associations - Master Region
resource "aws_route_table_association" "public_rta_master" {
  count          = 2
  provider       = aws.region-master
  subnet_id      = aws_subnet.public_subnets_master[count.index].id
  route_table_id = aws_route_table.public_rt_master.id
}

resource "aws_route_table_association" "private_rta_master" {
  count          = 2
  provider       = aws.region-master
  subnet_id      = aws_subnet.private_subnets_master[count.index].id
  route_table_id = aws_route_table.private_rt_master[count.index].id
}

# Route Table Associations - Worker Region
resource "aws_route_table_association" "public_rta_worker" {
  count          = 2
  provider       = aws.region-worker
  subnet_id      = aws_subnet.public_subnets_worker[count.index].id
  route_table_id = aws_route_table.public_rt_worker.id
}

resource "aws_route_table_association" "private_rta_worker" {
  count          = 2
  provider       = aws.region-worker
  subnet_id      = aws_subnet.private_subnets_worker[count.index].id
  route_table_id = aws_route_table.private_rt_worker[count.index].id
}

# NAT Gateways - Master Region
resource "aws_eip" "nat_eip_master" {
  count    = 2
  provider = aws.region-master
  domain   = "vpc"
  
  tags = merge(local.common_tags, {
    Name = "master-nat-eip-${count.index + 1}"
  })
  
  depends_on = [aws_internet_gateway.igw_master]
}

resource "aws_nat_gateway" "nat_master" {
  count         = 2
  provider      = aws.region-master
  allocation_id = aws_eip.nat_eip_master[count.index].id
  subnet_id     = aws_subnet.public_subnets_master[count.index].id
  
  tags = merge(local.common_tags, {
    Name = "master-nat-gateway-${count.index + 1}"
  })
  
  depends_on = [aws_internet_gateway.igw_master]
}

# NAT Gateways - Worker Region
resource "aws_eip" "nat_eip_worker" {
  count    = 2
  provider = aws.region-worker
  domain   = "vpc"
  
  tags = merge(local.common_tags, {
    Name = "worker-nat-eip-${count.index + 1}"
  })
  
  depends_on = [aws_internet_gateway.igw_worker]
}

resource "aws_nat_gateway" "nat_worker" {
  count         = 2
  provider      = aws.region-worker
  allocation_id = aws_eip.nat_eip_worker[count.index].id
  subnet_id     = aws_subnet.public_subnets_worker[count.index].id
  
  tags = merge(local.common_tags, {
    Name = "worker-nat-gateway-${count.index + 1}"
  })
  
  depends_on = [aws_internet_gateway.igw_worker]
}