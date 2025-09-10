# Master VPC in us-east-1
resource "aws_vpc" "vpc_master" {
  provider             = aws.region-master
  cidr_block           = "10.30.0.0/20"
  enable_dns_support   = true
  enable_dns_hostnames = true
  
  tags = merge(local.common_tags, {
    Name = "master-vpc-jenkins"
    Region = var.region-master
  })
}

# Worker VPC in us-east-2
resource "aws_vpc" "vpc_worker" {
  provider             = aws.region-worker
  cidr_block           = "10.40.0.0/20"
  enable_dns_support   = true
  enable_dns_hostnames = true
  
  tags = merge(local.common_tags, {
    Name = "worker-vpc-jenkins"
    Region = var.region-worker
  })
}

# Internet Gateways
resource "aws_internet_gateway" "igw_master" {
  provider = aws.region-master
  vpc_id   = aws_vpc.vpc_master.id
  
  tags = merge(local.common_tags, {
    Name = "master-igw"
  })
}

resource "aws_internet_gateway" "igw_worker" {
  provider = aws.region-worker
  vpc_id   = aws_vpc.vpc_worker.id
  
  tags = merge(local.common_tags, {
    Name = "worker-igw"
  })
}

# Public Subnets - Master Region
resource "aws_subnet" "public_subnets_master" {
  count                   = 2
  provider                = aws.region-master
  vpc_id                  = aws_vpc.vpc_master.id
  cidr_block              = "10.30.${count.index}.0/24"
  availability_zone       = data.aws_availability_zones.master_azs.names[count.index]
  map_public_ip_on_launch = true
  
  tags = merge(local.common_tags, {
    Name = "master-public-subnet-${count.index + 1}"
    Type = "public"
  })
}

# Private Subnets - Master Region
resource "aws_subnet" "private_subnets_master" {
  count             = 2
  provider          = aws.region-master
  vpc_id            = aws_vpc.vpc_master.id
  cidr_block        = "10.30.${count.index + 10}.0/24"
  availability_zone = data.aws_availability_zones.master_azs.names[count.index]
  
  tags = merge(local.common_tags, {
    Name = "master-private-subnet-${count.index + 1}"
    Type = "private"
  })
}

# Public Subnets - Worker Region
resource "aws_subnet" "public_subnets_worker" {
  count                   = 2
  provider                = aws.region-worker
  vpc_id                  = aws_vpc.vpc_worker.id
  cidr_block              = "10.40.${count.index}.0/24"
  availability_zone       = data.aws_availability_zones.worker_azs.names[count.index]
  map_public_ip_on_launch = true
  
  tags = merge(local.common_tags, {
    Name = "worker-public-subnet-${count.index + 1}"
    Type = "public"
  })
}

# Private Subnets - Worker Region
resource "aws_subnet" "private_subnets_worker" {
  count             = 2
  provider          = aws.region-worker
  vpc_id            = aws_vpc.vpc_worker.id
  cidr_block        = "10.40.${count.index + 10}.0/24"
  availability_zone = data.aws_availability_zones.worker_azs.names[count.index]
  
  tags = merge(local.common_tags, {
    Name = "worker-private-subnet-${count.index + 1}"
    Type = "private"
  })
}