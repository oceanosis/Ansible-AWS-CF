#!/bin/bash

#cd /usr/local/src/awsProject

yum install httpd php php-mysql php-pear

cd /var/www/html/
wget https://resources.mybb.com/downloads/mybb_1813.zip
unzip mybb_1813.zip
service httpd start
chkconfig httpd on
mv ./inc/config.default.php ./inc/config.php
chmod 666 ./inc/settings.php ./inc/config.php   
chmod -R 777 ./cache/ ./cache/themes/ ./uploads/ ./uploads/avatars/ ./admin/backups/ 

# 1. Connect with LoadBalancer DNS on Web to configure mybb

# 2. next next next - Connect system to RDS (mysql) 

rm -rf install/

# Connect system with Admin only...



