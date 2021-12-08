#!/bin/bash
sudo apt-get update && sudo apt-get install -y apache2 && cat <<EOF > /var/www/html/index.html
<html><body><h1>Welcome to website based on AWS platform.</h1><h2>Created with Terraform</h2></body></html>
EOF