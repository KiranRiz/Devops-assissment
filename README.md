# DevOps Automation Assignment

## Project Overview
This project automates the deployment of a Docker container running a sample web application on AWS EC2 using Terraform, Ansible, and Docker.

## Tools Used
- **Terraform** - Infrastructure as Code (EC2 instance with security groups)
- **Ansible** - Configuration Management (Docker installation)
- **Docker** - Containerization (Sample web application)
- **AWS EC2** - Cloud infrastructure
- **Git/GitHub** - Version control


## Step-by-Step Deployment Guide

### Step 1: Create First EC2 Instance (Control Machine)
- Go to AWS Console
- Launch EC2 instance named "Terraform-aws"
- SSH into it:
ssh -i your-key.pem ubuntu@<control-machine-ip>


### Step 2: Install Terraform
- Go this website and execute one by one linux commands in your control machine: https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli

### Step 3: Install AWS CLI
- curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
- unzip awscliv2.zip
- sudo ./aws/install
- aws --version
- aws configure

### Step 4: Generate SSH Key
- ssh-keygen -t rsa -b 2048 -f ~/.ssh/id_rsa -N ""


### Step 5: Create Terraform Folder and main.tf
- mkdir ~/Tarraform
- cd ~/Tarraform
- vim main.tf  (Paste Terraform code in main.tf)

### Step 6: Run Terraform Commands
- cd ~/Tarraform
- terraform init
- terraform plan
- terraform apply

- Type 'yes' when prompted
- terraform output (Note down the IP address, e.g., 13.63.19.115)

### Step 7: Install Ansible
- sudo apt update
- sudo apt install ansible -y
- ansible --version
- mkdir ~/ansible
- cd ~/ansible

### Step 8: Create Ansible Files
- 1.Create inventory file:
  vim inventory
- Add this line in this file replece this IP address with your IP address:
  [ec2]
  13.63.19.115 ansible_user=ubuntu ansible_ssh_private_key_file=~/.ssh/id_rsa

- 2.Create install_docker.yml file:
  vim install_docker.yml (Paste Ansible playbook code from my install_docker.yml)


### Step 9: Run Ansible Playbook
- cd ~/ansible
- ansible-playbook -i inventory install_docker.yml

### Step 10: Test SSH Connection
- ssh -i ~/.ssh/id_rsa ubuntu@13.63.19.115 <- here replece this IP address with your IP address
- exit

### Step 11: Create Sample App on Second EC2
- ssh -i ~/.ssh/id_rsa ubuntu@13.63.19.115 <- use uyour IP address here
- mkdir mySample_App
- cd mySample_App
- vim Dockerfile (Paste Dockerfile code)
- vim index.html (Paste HTML code)

### Step 12: Build and Run Docker Container
- sudo docker build -t sample-app .
- sudo docker images
- sudo docker run -d -p 80:80 --name myapp-container sample-app
- sudo docker ps

### Step 13: Check in Browser
- Open browser and go to: Open user IP address in url with port 80 (example: http://13.63.19.115:80)
### Auto-Deployment - These keys enable GitHub Actions to securely connect to EC2, pull latest code, rebuild Docker image, and deploy updated container add these to your GitHib Actions:
### EC2_HOST - Contains the EC2 instance public IP address for target server connection

### EC2_SSH_KEY - Stores the private SSH key for secure authentication

### Pipeline Trigger - Automatically runs on every push to main branch
