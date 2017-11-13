#!/bin/bash
################################################# 
# Bootstrap script for Amazon Linux.		#
# This server will automatically retrieve  	#
# all environment cloudformation templates and 	#
# ansible playbooks 				#
# Ufuk Dumlu - 9th Nov 17 			#
#################################################

yum update -y
yum install epel-release -y
yum-config-manager --enable epel
yum install gcc git python python-devel python-pip make -y
yum install python-mysqldb python-jinja2 python-paramiko PyYAML MySQL-python -y 

# install ansible for deployments
cd /usr/local/src
git clone git://github.com/ansible/ansible.git
cd ansible
git checkout -b stable-2.0 origin/stable-2.0
git submodule update --init --recursive
make install
export PATH=$PATH:/usr/local/bin
echo "export PATH=$PATH:/usr/local/bin" >> /root/.bashrc
source /root/.bashrc

#######################################################
# Type of automation: Ansible + CloudFormation Stacks #
#######################################################
# Run environment creation with Ansible Cloud Modules
# ansible-playbook 

# create aws environment
cd /usr/local/src
git clone https://github.com/oceanosis/awsProject
cd /usr/local/src/awsProject/automation
DATE=$(date "+%Y-%m-%d-%H-%M-%S")

ansible-playbook aws-automation.yml > /usr/local/src/ansible-$DATE.log
if [[ $? -ne 0 ]]; then
echo "Ansible playbook did not completed. Check process and errors in log" >> /usr/local/src/ansible-$DATE.log
exit 1
fi


