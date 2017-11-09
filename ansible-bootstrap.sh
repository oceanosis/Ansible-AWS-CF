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
source /root/.bash_profile

