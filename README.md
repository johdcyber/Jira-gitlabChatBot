# Multi-Project Repository

This repository contains several projects demonstrating different technologies and best practices for modern web development and infrastructure management.

## 🚀 Projects Overview

### 1. Document Metadata Extractor (`pythonProject/doc_meta_extractor/`)

A production-ready Flask web application that extracts comprehensive metadata from DOCX and PDF files with enterprise-grade security and user experience.

#### ✨ Key Features
- **Modern UI/UX**: Responsive Bootstrap interface with drag-and-drop file upload
- **Enhanced Security**: CSRF protection, file validation, secure uploads, and content verification
- **Comprehensive Metadata**: Extracts 20+ metadata properties including author, dates, document structure, and file integrity hashes
- **User Experience**: Loading states, progress indicators, copy-to-clipboard, print functionality, and JSON export
- **Production Ready**: Docker support, Nginx configuration, health checks, and comprehensive error handling

#### 🛠 Technical Stack
- **Backend**: Flask 3.0, Flask-WTF for CSRF protection
- **Frontend**: Bootstrap 5.3, Font Awesome 6.4, vanilla JavaScript
- **Document Processing**: python-docx, PyPDF2
- **Security**: File content validation, SHA-256 hashing, secure filename handling
- **Deployment**: Docker, Docker Compose, Nginx reverse proxy

#### 📋 Setup Instructions
```bash
cd pythonProject/doc_meta_extractor

# Development setup
python -m venv venv
source venv/bin/activate  # On Windows: venv\Scripts\activate
pip install -r requirements.txt
cp .env.example .env  # Configure your environment variables
python app.py

# Production deployment with Docker
docker-compose up -d
```

#### 🔒 Security Features
- CSRF token validation on all forms
- File content validation (not just extension checking)
- Secure filename handling with werkzeug
- File size limits and type restrictions
- SHA-256 file integrity hashing
- No file storage on server (processed in memory)
- Security headers via Nginx
- Rate limiting for uploads

---

### 2. Multi-Region AWS Infrastructure (`terra/`)

Enterprise-grade Terraform configuration for multi-region AWS VPC setup with Jenkins infrastructure, following AWS Well-Architected Framework principles.

#### 🏗 Architecture Features
- **Multi-Region Setup**: Master VPC (us-east-1) and Worker VPC (us-east-2)
- **High Availability**: Multi-AZ deployment with redundant NAT gateways
- **Security**: VPC Flow Logs, Security Groups, VPC Peering with proper routing
- **Best Practices**: Consistent tagging, state locking, modular structure
- **Monitoring**: CloudWatch integration, VPC Flow Logs with 30-day retention

#### 📁 File Structure
```
terra/
├── main.tf          # Main configuration and providers
├── vpc.tf           # VPC resources and subnets
├── routing.tf       # Route tables and NAT gateways
├── security.tf      # Security groups and VPC Flow Logs
├── peering.tf       # VPC peering configuration
├── variables.tf     # Input variables with validation
├── outputs.tf       # Output values
└── terraform.tfvars.example  # Example configuration
```

#### 🚀 Deployment
```bash
cd terra

# Initialize Terraform
terraform init

# Review planned changes
terraform plan

# Apply configuration
terraform apply

# Clean up resources
terraform destroy
```

#### 🔧 Configuration
- **State Management**: S3 backend with DynamoDB locking
- **Security Groups**: Least privilege access with specific port rules
- **Networking**: Public/private subnets with proper CIDR planning
- **Monitoring**: VPC Flow Logs for network traffic analysis
- **Tagging**: Comprehensive tagging strategy for resource management

---

### 3. VPC Demo (`terraform-vpc-demo/`)

Simplified, educational Terraform VPC configuration perfect for learning AWS networking concepts and rapid prototyping.

#### 📚 Learning Features
- **Simplified Structure**: Single-region VPC with clear, documented code
- **Configurable**: Easy-to-modify subnet counts and CIDR blocks
- **Well-Documented**: Comprehensive README with examples and best practices
- **Cost-Effective**: Optimized for development and learning environments

#### 🎯 Use Cases
- Learning AWS VPC concepts
- Rapid prototyping of network architectures
- Development environment setup
- Infrastructure as Code education

---

## 🌟 Key Improvements Implemented

### Flask Application Enhancements
- ✅ **Modern UI**: Responsive Bootstrap interface with drag-and-drop file upload
- ✅ **Better UX**: Loading states, progress indicators, and comprehensive user feedback
- ✅ **Enhanced Security**: File validation, secure uploads, CSRF protection, and content verification
- ✅ **New Features**: Copy to clipboard, print functionality, JSON export, and detailed metadata display
- ✅ **Code Quality**: Modular structure, proper error handling, and configuration management
- ✅ **Production Ready**: Docker containerization, Nginx reverse proxy, and health checks

### Terraform Infrastructure Improvements
- ✅ **Best Practices**: Proper resource organization, consistent tagging, and state locking
- ✅ **High Availability**: Multi-AZ deployment with redundant NAT gateways
- ✅ **Better Structure**: Separated concerns into logical files (vpc.tf, routing.tf, security.tf)
- ✅ **Documentation**: Comprehensive variable descriptions and outputs
- ✅ **Security**: Improved CIDR planning, VPC Flow Logs, and resource isolation
- ✅ **Monitoring**: CloudWatch integration and network traffic analysis

### General Project Improvements
- ✅ **Documentation**: Detailed README files with clear setup instructions
- ✅ **Code Organization**: Logical file structure and separation of concerns
- ✅ **Error Handling**: Comprehensive error handling throughout all components
- ✅ **Maintainability**: Modular design for easy extension and modification
- ✅ **Security**: Following security best practices across all projects
- ✅ **Scalability**: Designed for easy horizontal and vertical scaling

---

## 🚀 Getting Started

### Prerequisites
- **Python 3.9+** for Flask application
- **Terraform 1.0+** for infrastructure
- **Docker & Docker Compose** for containerized deployment
- **AWS CLI configured** for Terraform deployments

### Quick Start
1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd <repository-name>
   ```

2. **Choose your project**
   - For document processing: `cd pythonProject/doc_meta_extractor/`
   - For AWS infrastructure: `cd terra/`
   - For VPC learning: `cd terraform-vpc-demo/`

3. **Follow project-specific setup instructions** in each directory's README

---

## 🤝 Contributing

We welcome contributions! Please follow these guidelines:

- **Code Style**: Follow established patterns and formatting
- **Documentation**: Update README files for any changes
- **Testing**: Test thoroughly before submitting changes
- **Security**: Follow security best practices
- **Commit Messages**: Use clear, descriptive commit messages

---

## 📄 License

This project is for educational and demonstration purposes. See individual project directories for specific licensing information.

---

## 👨‍💻 Author

**John D. Cyber**
- Website: [https://johndcyber.com](https://johndcyber.com)
- Focus: Cybersecurity, Cloud Infrastructure, and Secure Web Development

---

## 🔗 Additional Resources

- [Flask Documentation](https://flask.palletsprojects.com/)
- [Terraform AWS Provider](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)
- [AWS Well-Architected Framework](https://aws.amazon.com/architecture/well-architected/)
- [Bootstrap Documentation](https://getbootstrap.com/docs/5.3/getting-started/introduction/)
- [Docker Best Practices](https://docs.docker.com/develop/dev-best-practices/)