#!/bin/bash

sudo apt-get update
sudo DEBIAN_FRONTEND=noninteractive apt-get -y upgrade

# Install Docker
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository \
   "deb https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
sudo apt-get update
sudo apt-get install -y docker-ce
sudo usermod -aG docker $(whoami)

# Docker Compose
sudo curl -o /usr/local/bin/docker-compose -L https://github.com/docker/compose/releases/download/1.13.0/docker-compose-`uname -s`-`uname -m`
sudo chmod a+x /usr/local/bin/docker-compose

# Install composer
sudo apt-get install -y php7.0-cli
sudo apt-get install -y php-zip
curl -o composer-setup.php  https://getcomposer.org/installer
php composer-setup.php  --filename=composer
sudo mv composer /usr/local/bin/
rm composer-setup.php

# Setup project
(cd v2-empty && composer update -a --no-dev)
(cd v3-empty && composer update -a --no-dev)
(cd v4-empty && composer update -a --no-dev)


echo ""
echo "All done."
echo ""
echo "Now log out and log back in again so that docker works without sudo."
echo ""
