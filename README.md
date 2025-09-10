# Multi-Project Repository

This repository contains several projects demonstrating different technologies and best practices.

## Projects

### 1. Document Metadata Extractor (`pythonProject/doc_meta_extractor/`)

A Flask web application that extracts metadata from DOCX and PDF files.

**Features:**
- Drag-and-drop file upload interface
- Support for .docx and .pdf files
- Comprehensive metadata extraction
- Modern, responsive UI with Bootstrap
- Error handling and file validation
- Copy to clipboard and print functionality

**Setup:**
```bash
cd pythonProject/doc_meta_extractor
pip install -r requirements.txt
python app.py
```

### 2. Terraform Infrastructure (`terra/`)

Multi-region AWS VPC setup with Jenkins infrastructure.

**Features:**
- Master and worker VPCs in different regions
- Public and private subnets with proper routing
- NAT gateways for high availability
- Comprehensive tagging strategy
- State management with S3 backend

**Setup:**
```bash
cd terra
terraform init
terraform plan
terraform apply
```

### 3. VPC Demo (`terraform-vpc-demo/`)

Simplified Terraform VPC configuration for learning and testing.

**Features:**
- Single-region VPC with public/private subnets
- Configurable subnet counts and CIDR blocks
- NAT gateways for private subnet internet access
- Well-documented variables and outputs

**Setup:**
```bash
cd terraform-vpc-demo
terraform init
terraform plan
terraform apply
```

## Key Improvements Made

### Flask Application
- **Enhanced UI/UX**: Modern Bootstrap interface with drag-and-drop functionality
- **Better Error Handling**: Comprehensive error handling with user-friendly messages
- **Security**: File validation, secure filename handling, and CSRF protection
- **Code Organization**: Modular structure with configuration management
- **Features**: Copy to clipboard, print functionality, and detailed metadata display

### Terraform Infrastructure
- **Best Practices**: Proper resource organization, consistent tagging, and state management
- **High Availability**: Multiple AZs, redundant NAT gateways
- **Documentation**: Clear variable descriptions and comprehensive outputs
- **Security**: VPC flow logs, proper CIDR planning
- **Maintainability**: Modular file structure and reusable configurations

### General Improvements
- **Documentation**: Comprehensive README files with setup instructions
- **Code Quality**: Consistent formatting, proper commenting, and error handling
- **Security**: Following security best practices for both web applications and infrastructure
- **Scalability**: Designed for easy extension and modification

## Getting Started

1. Clone the repository
2. Navigate to the specific project directory
3. Follow the setup instructions in each project's section
4. Refer to individual README files for detailed documentation

## Contributing

When contributing to this repository:
- Follow the established code style and structure
- Update documentation for any changes
- Test thoroughly before submitting changes
- Use meaningful commit messages

## License

This project is for educational and demonstration purposes.