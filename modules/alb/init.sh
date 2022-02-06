#!/bin/bash
  sudo su - root
  mkfs.ext4 /dev/sdf
  mount -t ext4 /dev/sdf /var/log
  
  apt-get update
  apt-get -y install nginx
   service nginx start
   echo "<center><h1>Yes!</h1><br><h2>Demo2 Terraform<h2><br>$HOSTNAME" > /var/www/html/index.html