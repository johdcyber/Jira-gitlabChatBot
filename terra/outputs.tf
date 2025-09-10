# Master VPC Outputs
output "master_vpc_id" {
  description = "ID of the master VPC"
  value       = aws_vpc.vpc_master.id
}

output "master_vpc_cidr" {
  description = "CIDR block of the master VPC"
  value       = aws_vpc.vpc_master.cidr_block
}

output "master_public_subnet_ids" {
  description = "IDs of the master public subnets"
  value       = aws_subnet.public_subnets_master[*].id
}

output "master_private_subnet_ids" {
  description = "IDs of the master private subnets"
  value       = aws_subnet.private_subnets_master[*].id
}

# Worker VPC Outputs
output "worker_vpc_id" {
  description = "ID of the worker VPC"
  value       = aws_vpc.vpc_worker.id
}

output "worker_vpc_cidr" {
  description = "CIDR block of the worker VPC"
  value       = aws_vpc.vpc_worker.cidr_block
}

output "worker_public_subnet_ids" {
  description = "IDs of the worker public subnets"
  value       = aws_subnet.public_subnets_worker[*].id
}

output "worker_private_subnet_ids" {
  description = "IDs of the worker private subnets"
  value       = aws_subnet.private_subnets_worker[*].id
}

# NAT Gateway Outputs
output "master_nat_gateway_ips" {
  description = "Elastic IPs of master NAT gateways"
  value       = aws_eip.nat_eip_master[*].public_ip
}

output "worker_nat_gateway_ips" {
  description = "Elastic IPs of worker NAT gateways"
  value       = aws_eip.nat_eip_worker[*].public_ip
}