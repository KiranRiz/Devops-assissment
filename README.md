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
- SSH into it:ssh -i your-key.pem ubuntu@<control-machine-ip>


### Step 2: Install Terraform
- Go this website and execute one by one linux commands in your control machine: https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli
- Verify Terraform installation by typing this command in your terminal: terminal --help

### Step 3: Install AWS CLI
follow 
- curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
- unzip awscliv2.zip
- sudo ./aws/install
- aws --version (Verify installation)
- Configure AWS credentials
- aws configure
- Enter your Access Key, Secret Key, region (eu-north-1)

### Step 4: Generate SSH Key
- This creates public and private key for secure connections
- ssh-keygen -t rsa -b 2048 -f ~/.ssh/id_rsa -N ""


### Step 5: Create Terraform Folder and main.tf
- mkdir ~/Tarraform
- cd ~/Tarraform
- vim main.tf  (Create main.tf file & Paste your Terraform code here (EC2, security groups, key pair))

### Step 6: Run Terraform Commands
- cd ~/Tarraform
- terraform init (Initialize Terraform)
- terraform plan (See what will be created)
- terraform apply (Create the infrastructure Type 'yes' when prompted)
- terraform output (Note down the IP address of remote server e.g: 13.63.19.115) 

### Step 7: Install Ansible
- sudo apt update
- sudo apt install ansible -y
- ansible --version (Verify installation)
- mkdir ~/ansible (Create Ansible folder)
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
- This will automatically install Docker on the target server

### Step 10: Test SSH Connection
Test connection to target server:
- ssh -i ~/.ssh/id_rsa ubuntu@13.63.19.115 <- here replece this IP address with your actual IP address
If successful, type 'exit' to go back  
- exit

### Step 11: Create Sample App on Second EC2
- ssh -i ~/.ssh/id_rsa ubuntu@13.63.19.115 <- use uyour IP address here
- mkdir mySample_App (Make folder)
- cd mySample_App
- vim Dockerfile (Write Dockerfile code)
- vim index.html (Write HTML code here)

### Step 12: Build and Run Docker Container
Make sure you're on the target server Build Docker image
- sudo docker build -t sample-app .
Check if image was created:  
- sudo docker images
Run container:
- sudo docker run -d -p 80:80 --name myapp-container sample-app
Check if container is running:
- sudo docker ps

### Step 13: Check in Browser
- Open browser and go to: Open user IP address in url with port 80 (example: http://13.63.19.115:80)
  
### Step 14: Setup GitHub Repository
Create Repository in your GitHub
- git init
- git add .
- git commit -m "initial commit"

### Step 15: Configure GitHub Secrets
1. Go to your GitHub repository
2. Click on Settings → Secrets and variables → Actions
3. Add these two secrets:

   Secret 1:
   Name: HOST_IP
   Value: 13.63.19.115 (your EC2 IP)
   
   Secret 2:
   Name: HOST_KEY
   Value: (copy your entire private key)
   Run this command to copy: cat ~/.ssh/id_rsa
   Copy everything including BEGIN and END lines
   
### Step 16: Create GitHub Actions Workflow
In your repository, create this folder structure
- mkdir -p .github/workflows
- cd .github/workflows
- vim deploy.yml (Write your github actions workflow here)

### Step 17: Test the CI/CD Pipeline
- ~/mySample_App
- vim index.html (Make change in this file, & commit & Push changes)
- git add .
- git commit -m "updated website content"
- git push

### Step 18: Go to -> Actions Tab
- check running pipeline workflow
  
# Step 19: Final Verification
Open browser & enter IP address also ssh into remote server to check Docker Container is running
- ssh -i ~/.ssh/id_rsa ubuntu@13.63.19.115 
- sudo docker ps
- exit
