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
- SSH into it: ssh -i your-key.pem ubuntu@<control-machine-ip>

### Step 2: Install Terraform
- install Terraform using by following commands in the this website: https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli
- Verify installation using this command: terraform --help

### Step 3: Install AWS CLI

### Step 5: Create Terraform Folder and main.tfmkdir ~/Tarraform
- cd ~/Tarraform
- vim main.tf (Paste Terraform code in main.tf)

### Step 6: Run Terraform Commands to Create Second EC2
- cd ~/Tarraform
- terraform init
- terraform plan
- terraform apply 
- (Type Yes when prompted)
- (Note down the IP address in output, e.g., 13.63.19.115 and refresh your aws console newly craeted EC2 instance will appear)

### Step 7: Install Ansible
- sudo apt update
- sudo apt install ansible -y
- ansible --version

### Make directory for ansible
- mkdir ~/ansible
- cd ~/ansible

### Step 8: Create Ansible Files
- 1- Create inventory file: 
   vim inventory 
- 2- Create install_docker.yml file:
   vim install_docker.yml
### Step 9: Run Ansible Playbook to Install Docker
- cd ~/ansible
- ansible-playbook -i inventory install_docker.yml

### Step 10: Test SSH Connection to Second EC2
- ssh -i ~/.ssh/id_rsa ubuntu@13.63.19.115


### Step 11: Create Sample App on Second EC2
- For connection with second EC2 instance use this command with your IP address: ssh -i ~/.ssh/id_rsa ubuntu@13.63.19.115
- Make a directory for Application: mkdir mySample_App
- cd mySample_App
- Create a docker file in this directory: 
- vim Dockerfile  -(Paste Dockerfile code here)
- vim index.html  -(Paste HTML code)

### Step 12: Build and Run Docker Container

- sudo docker build -t sample-app .
- sudo docker images
- sudo docker run -d -p 80:80 --name myapp-container sample-app
- sudo docker ps


### Step 13: Check in Browser
- Open browser and go to url and paste your instance's IP adress which you created through terraform with port 80:


## Important Notes
- Replace IP addresses with your actual EC2 IP
- Free tier resources used (t3.micro)


---

## Author
Kiran Bibi
Feb-2026













