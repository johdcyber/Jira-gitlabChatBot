# Security Groups
resource "aws_security_group" "jenkins_master_sg" {
  provider    = aws.region-master
  name        = "jenkins-master-sg"
  description = "Security group for Jenkins master"
  vpc_id      = aws_vpc.vpc_master.id

  # SSH access
  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Restrict this in production
  }

  # Jenkins web interface
  ingress {
    description = "Jenkins Web"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Jenkins agent communication
  ingress {
    description = "Jenkins Agent"
    from_port   = 50000
    to_port     = 50000
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.vpc_worker.cidr_block]
  }

  # All outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(local.common_tags, {
    Name = "jenkins-master-sg"
  })
}

resource "aws_security_group" "jenkins_worker_sg" {
  provider    = aws.region-worker
  name        = "jenkins-worker-sg"
  description = "Security group for Jenkins workers"
  vpc_id      = aws_vpc.vpc_worker.id

  # SSH access
  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.vpc_master.cidr_block]
  }

  # Jenkins agent communication
  ingress {
    description = "Jenkins Agent Communication"
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.vpc_master.cidr_block]
  }

  # All outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(local.common_tags, {
    Name = "jenkins-worker-sg"
  })
}

# VPC Flow Logs
resource "aws_flow_log" "master_vpc_flow_log" {
  provider        = aws.region-master
  iam_role_arn    = aws_iam_role.flow_log_role.arn
  log_destination = aws_cloudwatch_log_group.master_vpc_log_group.arn
  traffic_type    = "ALL"
  vpc_id          = aws_vpc.vpc_master.id

  tags = merge(local.common_tags, {
    Name = "master-vpc-flow-log"
  })
}

resource "aws_flow_log" "worker_vpc_flow_log" {
  provider        = aws.region-worker
  iam_role_arn    = aws_iam_role.flow_log_role.arn
  log_destination = aws_cloudwatch_log_group.worker_vpc_log_group.arn
  traffic_type    = "ALL"
  vpc_id          = aws_vpc.vpc_worker.id

  tags = merge(local.common_tags, {
    Name = "worker-vpc-flow-log"
  })
}

# CloudWatch Log Groups
resource "aws_cloudwatch_log_group" "master_vpc_log_group" {
  provider          = aws.region-master
  name              = "/aws/vpc/flowlogs/master"
  retention_in_days = 30

  tags = merge(local.common_tags, {
    Name = "master-vpc-log-group"
  })
}

resource "aws_cloudwatch_log_group" "worker_vpc_log_group" {
  provider          = aws.region-worker
  name              = "/aws/vpc/flowlogs/worker"
  retention_in_days = 30

  tags = merge(local.common_tags, {
    Name = "worker-vpc-log-group"
  })
}

# IAM Role for VPC Flow Logs
resource "aws_iam_role" "flow_log_role" {
  provider = aws.region-master
  name     = "flow-log-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "vpc-flow-logs.amazonaws.com"
        }
      }
    ]
  })

  tags = merge(local.common_tags, {
    Name = "flow-log-role"
  })
}

resource "aws_iam_role_policy" "flow_log_policy" {
  provider = aws.region-master
  name     = "flow-log-policy"
  role     = aws_iam_role.flow_log_role.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents",
          "logs:DescribeLogGroups",
          "logs:DescribeLogStreams"
        ]
        Effect   = "Allow"
        Resource = "*"
      }
    ]
  })
}