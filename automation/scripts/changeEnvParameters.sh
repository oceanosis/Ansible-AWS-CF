#!/bin/bash

# Variables
if [ -z "$1" ]; then
echo "REGION parameter is missing"
exit 1
fi

REGION=$1

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

PUBLICIP=$(aws ec2 describe-instances --region="$REGION" --filter Name=tag:Name,Values=TempWeb --query "Reservations[*].Instances[*].PublicIpAddress"  --output=text)

#sed -i 's/.*TempWeb":.*/"TempWeb": "'$PUBLICIP'",/g'  $DIR/../group_vars/inventory
mkdir -p /etc/ansible/
touch /etc/ansible/hosts
chmod -R 777 /etc/ansible/

echo "[webservers]" > /etc/ansible/hosts
echo $PUBLICIP >> /etc/ansible/hosts

export ANSIBLE_HOST_KEY_CHECKING=False

# Copy Automation-Test.pem and use ssh agent forwarding
#aws s3 cp s3://automation-test-dumlu/Automation-Test.pem /tmp/
chmod 400 /tmp/Automation-Test.pem
eval $(ssh-agent)
ssh-add -k /tmp/Automation-Test.pem
