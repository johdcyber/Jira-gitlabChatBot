#Creat VPC in us-east-1
resource "aws_vpc" "vpc_master" {
  provider             = aws.region-master
  cidr_block           = "10.30.0.0/20"
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "master-vpc-jenkins"
  }
}
#Creat VPC in us-east-2
resource "aws_vpc" "vpc_worker" {
  provider             = aws.region-worker
  cidr_block           = "10.40.0.0/20"
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "worker-vpc-jenkins"
  }
}

#Create IGW in us-east-1

resource "aws_internet_gateway" "igw-us-east-1_master" {
  provider = aws.region-master
  vpc_id   = aws_vpc.vpc_master.id
}

#Create IGW in us-east-2

resource "aws_internet_gateway" "igw-us-east-2_worker" {
  provider = aws.region-worker
  vpc_id   = aws_vpc.vpc_worker.id
}

# Get all available AZ's in VPC for master region
data "aws_availability_zones" "azs" {
  provider = aws.region-master
  state    = "available"
}
# Create Subnet #1 in us-east-1
resource "aws_subnet" "subnet_1_master" {
  provider          = aws.region-master
  availability_zone = "${var.zones-master[count.index]}"
  vpc_id            = aws_vpc.vpc_master.id
  cidr_block        = "10.30.0.0/24"
}

# Create Subnet #1 in us-east-1
resource "aws_subnet" "subnet_2_master" {
  provider          = aws.region-master
  availability_zone = "${var.zones-master[count.index]}"
  vpc_id            = aws_vpc.vpc_master.id
  cidr_block        = "10.30.1.0/24"
}

# Create Subnet #2 in us-east-2
resource "aws_subnet" "subnet_1_worker" {
  provider          = aws.region-worker
  availability_zone = "${var.zones-worker[count.index]}"
  vpc_id            = aws_vpc.vpc_master.id
  cidr_block        = "10.40.0.0/24"
}

# Create Subnet #2 in us-east-2
resource "aws_subnet" "subnet_2_worker" {
  provider          = aws.region-worker
  availability_zone = "${var.zones-worker[count.index]}"
  vpc_id            = aws_vpc.vpc_master.id
  cidr_block        = "10.40.1.0/24"
}
