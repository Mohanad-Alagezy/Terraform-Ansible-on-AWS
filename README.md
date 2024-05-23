# Deploying High Available AWS Infrastructure with Terraform and Ansible
![Screenshot 2024-05-23 003055](https://github.com/Mohanad-Alagezy/Terraform-Ansible-on-AWS/assets/161209920/0fb3129c-1333-4b78-af10-461ef325e62b)

## Project Overview

This project leverages AWS, Terraform, and Ansible to provision and configure an infrastructure that includes two EC2 instances across two Availability Zones, an RDS instance, a VPC, and an Application Load Balancer (ALB). Terraform is used for provisioning the AWS resources, while Ansible is used to configure the EC2 instances to run Apache server and MariaDB agent.

## Prerequisites

Before you begin, ensure you have the following installed on your local machine:

- [Terraform](https://www.terraform.io/downloads.html) (v0.12 or later)
- [Ansible](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html) (v2.9 or later)
- [AWS CLI](https://aws.amazon.com/cli/) (v2 or later)
- An AWS account with necessary permissions to create the required resources

## Project Components

### 1. Terraform

#### Purpose

Terraform is used to provision the following AWS services:

- **VPC**: A virtual private cloud to host the infrastructure.
- **EC2 Instances**: Two instances across two different Availability Zones.
- **RDS Instance**: A managed relational database instance using MySQL engine.
- **Application Load Balancer**: Distributes incoming application traffic across the EC2 instances.

#### Configuration

1. **VPC and Subnets**: Define a VPC with subnets in different Availability Zones.
2. **Security Groups**: Create security groups for EC2 instances and RDS with appropriate inbound and outbound rules.
3. **EC2 Instances**: Launch two EC2 instances with the necessary configurations.
4. **RDS Instance**: Create an RDS instance with MySQL as the database engine.
5. **Application Load Balancer**: Set up an ALB to balance the load across the EC2 instances.



### 2. Ansible

#### Purpose

Ansible is used to configure the EC2 instances by installing Apache server and MariaDB agent. The Apache server will serve the default Apache page when accessed via the ALB, and the MariaDB agent will facilitate connections to the RDS instance.

#### Configuration

##### Playbook: `install_services.yml`

This Ansible playbook performs the following tasks:

- Installs Apache server.
- Installs MariaDB agent.
- Configures the services to start on boot.

## Installation and Setup

1. Clone the repository:

    ```bash
    git clone <repository_url>
    cd <repository_directory>
    ```

2. Initialize Terraform:

    ```bash
    terraform init
    ```

3. Apply the Terraform configuration to create the infrastructure:

    ```bash
    terraform apply
    ```


## Usage

- Access the Application Load Balancer's DNS name in your web browser to view the Apache server's default page.
- The MariaDB agent on the EC2 instances will connect to the RDS instance using the configuration specified during the setup.
