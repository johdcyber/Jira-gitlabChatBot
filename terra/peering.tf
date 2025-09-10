# VPC Peering Connection
resource "aws_vpc_peering_connection" "master_worker_peering" {
  provider    = aws.region-master
  vpc_id      = aws_vpc.vpc_master.id
  peer_vpc_id = aws_vpc.vpc_worker.id
  peer_region = var.region-worker
  auto_accept = false

  tags = merge(local.common_tags, {
    Name = "master-worker-peering"
    Side = "Requester"
  })
}

# Accept the peering connection in the worker region
resource "aws_vpc_peering_connection_accepter" "worker_accept_peering" {
  provider                  = aws.region-worker
  vpc_peering_connection_id = aws_vpc_peering_connection.master_worker_peering.id
  auto_accept               = true

  tags = merge(local.common_tags, {
    Name = "master-worker-peering"
    Side = "Accepter"
  })
}

# Add routes for peering connection - Master VPC
resource "aws_route" "master_to_worker_public" {
  provider                  = aws.region-master
  route_table_id            = aws_route_table.public_rt_master.id
  destination_cidr_block    = aws_vpc.vpc_worker.cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.master_worker_peering.id

  depends_on = [aws_vpc_peering_connection_accepter.worker_accept_peering]
}

resource "aws_route" "master_to_worker_private" {
  count                     = 2
  provider                  = aws.region-master
  route_table_id            = aws_route_table.private_rt_master[count.index].id
  destination_cidr_block    = aws_vpc.vpc_worker.cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.master_worker_peering.id

  depends_on = [aws_vpc_peering_connection_accepter.worker_accept_peering]
}

# Add routes for peering connection - Worker VPC
resource "aws_route" "worker_to_master_public" {
  provider                  = aws.region-worker
  route_table_id            = aws_route_table.public_rt_worker.id
  destination_cidr_block    = aws_vpc.vpc_master.cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.master_worker_peering.id

  depends_on = [aws_vpc_peering_connection_accepter.worker_accept_peering]
}

resource "aws_route" "worker_to_master_private" {
  count                     = 2
  provider                  = aws.region-worker
  route_table_id            = aws_route_table.private_rt_worker[count.index].id
  destination_cidr_block    = aws_vpc.vpc_master.cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.master_worker_peering.id

  depends_on = [aws_vpc_peering_connection_accepter.worker_accept_peering]
}