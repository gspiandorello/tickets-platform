# AWS Infrastructure and CI/CD Pipelines with Terraform and GitHub Actions

This project was developed to deepen my understanding and knowledge in cloud infrastructure and CI/CD pipelines. I created a simple CRUD application and the main goal was to create and manage a complete AWS environment using Terraform and automate deployment processes with GitHub Actions.

## Project Highlights

### Infrastructure Setup with Terraform:

- Configured a Virtual Private Cloud (VPC) with subnets, internet gateways, and security groups.
- Deployed a MySQL RDS instance for database management.
- Provisioned an EC2 instance to host the application.

### CI/CD Pipelines with GitHub Actions:

#### Deploy EC2 Pipeline:
- Objective: Create the entire infrastructure on AWS and deploy the Docker image to the EC2 instance.
- Steps:
  - Checkout the code from the repository.
  - Log in to Docker Hub and build the Docker image.
  - Push the Docker image to Docker Hub.
  - Configure AWS credentials.
  - Set up Terraform and apply the infrastructure configuration.
  - Deploy the Docker image to the EC2 instance using Docker Compose.

#### Destroy Infrastructure Pipeline:
- Objective: Destroy the infrastructure created on AWS using Terraform.
- Steps:
  - Checkout the code from the repository.
  - Configure AWS credentials.
  - Set up Terraform and destroy the infrastructure configuration.
