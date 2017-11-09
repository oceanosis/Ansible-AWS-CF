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
yum install python-jinja2 python-paramiko PyYAML MySQL-python -y 

# install ansible for deployments
cd /usr/local/src
git clone git://github.com/ansible/ansible.git
cd ansible
git checkout -b stable-2.0 origin/stable-2.0
git submodule update --init --recursive
make install
export PATH=$PATH:/usr/local/bin
echo "export PATH=$PATH:/usr/local/bin" >> /root/.bash_profile

# create aws environment
cd /usr/local/src
git clone https://github.com/oceanosis/awsProject

##############################################################
# Type of automation: Bootscript + Ansible + CloudFormation  #
##############################################################
# VARIABLES

DIR=/usr/local/src/awsProject
REGION="us-east-1"
DATE=$(date "+%Y-%m-%d-%H-%M-%S")

# Change parameters accordingly in templates
sed -i 's/.*region:.*/region: '$REGION'/g' $DIR/ansible/roles/env/vars/main.yml

export AWS_ACCESS_KEY_ID='AAAAAAAAAA'
export AWS_SECRET_ACCESS_KEY='BBBBBBBBBB'

ansible-playbook aws-automation.yml > /usr/local/src/ansible-$DATE.log
if [[ $? -ne 0 ]]; then
echo "Ansible playbook did not completed. Check process and errors in log"
exit 1
fi
# Environment Creation is over, deployment will be done 
