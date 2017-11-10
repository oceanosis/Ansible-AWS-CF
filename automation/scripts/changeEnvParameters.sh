#!/bin/bash

REGION=$1

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

PUBLICIP=$(aws ec2 describe-instances --region="$REGION" --filter Name=tag:Name,Values=TempWeb --query "Reservations[*].Instances[*].PublicIpAddress"  --output=text)
echo "[webservers]" > $DIR/../hosts
echo $PUBLICIP >> $DIR/../hosts

export ANSIBLE_HOST_KEY_CHECKING=False

# Copy Automation-Test.pem and use ssh agent forwarding
#aws s3 cp s3://automation-test-dumlu/Automation-Test.pem /tmp/
chmod 400 /tmp/Automation-Test.pem
eval $(ssh-agent)
ssh-add -k /tmp/Automation-Test.pem
