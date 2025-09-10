# Terraform VPC Demo

This Terraform configuration creates a complete VPC setup with public and private subnets, NAT gateways, and proper routing.

## Architecture

- **VPC**: Main virtual private cloud with configurable CIDR block
- **Public Subnets**: Subnets with direct internet access via Internet Gateway
- **Private Subnets**: Subnets with internet access via NAT Gateways
- **NAT Gateways**: One per private subnet for high availability
- **Route Tables**: Separate routing for public and private subnets

## Usage

1. **Initialize Terraform**:
   ```bash
   terraform init
   ```

2. **Plan the deployment**:
   ```bash
   terraform plan
   ```

3. **Apply the configuration**:
   ```bash
   terraform apply
   ```

4. **Destroy resources** (when no longer needed):
   ```bash
   terraform destroy
   ```

## Configuration

### Variables

- `aws_region`: AWS region for deployment (default: us-east-1)
- `environment`: Environment name for resource tagging (default: dev)
- `main_vpc_cidr`: CIDR block for the VPC (default: 10.0.0.0/16)
- `public_subnets`: List of public subnet CIDR blocks
- `private_subnets`: List of private subnet CIDR blocks

### Customization

Create a `terraform.tfvars` file to customize variables:

```hcl
aws_region = "us-west-2"
environment = "production"
main_vpc_cidr = "10.1.0.0/16"
public_subnets = ["10.1.1.0/24", "10.1.2.0/24", "10.1.3.0/24"]
private_subnets = ["10.1.10.0/24", "10.1.20.0/24", "10.1.30.0/24"]
```

## Outputs

- `vpc_id`: The ID of the created VPC
- `public_subnet_ids`: List of public subnet IDs
- `private_subnet_ids`: List of private subnet IDs
- `nat_gateway_ips`: List of NAT Gateway public IPs

## Best Practices

- Resources are tagged consistently for better management
- High availability with subnets across multiple AZs
- Separate NAT gateways for each private subnet
- Proper security group and NACL configurations can be added as needed

## Cost Considerations

- NAT Gateways incur hourly charges and data processing fees
- Consider using a single NAT Gateway for development environments
- Elastic IPs are free when attached to running instances