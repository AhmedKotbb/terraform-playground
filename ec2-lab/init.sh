#!/bin/bash
set -exu

export DEBIAN_FRONTEND=noninteractive

apt-get update -y
apt-get install -y nginx

systemctl start nginx
systemctl enable nginx

cat > /var/www/html/index.html <<'HTML'
<html>
  <head>
    <title>Terraform EC2 Lab!</title>
  </head>
  <body>
    <h1>Nginx deployed by Terraform!</h1>
    <p>User data loaded from init.sh script!</p>
  </body>
</html>
HTML