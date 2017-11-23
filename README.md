# Ansible-AWS-CloudFormation 

Project Description
Demonstration of a cloud automation scenario is being held by using Ansible and 
AWS CloudFormation on a AWS Environment. The main purpose is to create the architecture
and design and develop enviroment in squence without any manual interruption.

***
## Getting Started

These instructions will give you a brief explanation about the project and will explain 
how an up-and-running cloud-based envrionment on AWS Environment for development and 
testing purposes can be prepared.

***
## Prerequisites, Constraints & Assumptions

The scripts should assume an empty AWS account to start with and all necessary resources
need to be provisioned via the cloud formation scripts.
Security, Monitoring, High Availability and Scailability have to be considered.
Database servers have to be RDS.
A Management System, web app on AWS EC2 Server, has to be working with DynamoDB in order to store config data.
Solution has to be configurable (Parametric).

***
## Installations & Deployments

Beside using a local host to automate whole process, an ansible (automation) server will
be created with necessary configurations;
 - Import KeyPair
 - Create IAM User / Role /Policy
 - Create a FreeTier AmazonLinux EC2 instance with IAM Role and KeyPair in Codes.
 - Use Ansible-Bootstrap.sh script in UserData before launch.

All installations and Deployments will be done via ansible playbook script when automation server is launching.
Ansible will be installed and necessary codes will be retrieved from github repository.
Ansible will trigger all cloudformation scripts so that there will be no other operation.
Ansible logs will be under /usr/local/src/ in order to check cloudformation outputs such as web links or any other information.
KeyPair Pem file is under Codes in order to connect Bastion Server by using SSH Agent forwarding.

***
## Running the tests

MyBB WebServers may be browsed via Load Balancer DNS URL. (Check Ansible/CloudFormation Output as described above)
Monitoring App (with missing parts) may be browsed via EIP or DNS URL. (Check Ansible/CloudFormation Output)
Management App (with missing parts) may be browsed via EIP or DNS URL. (Check Ansible/CloudFormation Output)


