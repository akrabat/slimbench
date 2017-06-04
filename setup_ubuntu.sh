#!/bin/bash

sudo apt-get update
sudo DEBIAN_FRONTEND=noninteractive apt-get -y upgrade

# Install Docker
sudo apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D
sudo apt-add-repository 'deb https://apt.dockerproject.org/repo ubuntu-xenial main'
sudo apt-get update
apt-cache policy docker-engine
sudo apt-get install -y docker-engine
sudo usermod -aG docker $(whoami)

# Install composer
sudo apt-get install -y php7.0-cli
sudo apt-get install -y php-zip
curl -o composer-setup.php  https://getcomposer.org/installer
php composer-setup.php  --filename=composer
sudo mv composer /usr/local/bin/
rm composer-setup.php

# Setup project
(cd v2-empty && composer update)
(cd v3-empty && composer update)
(cd v4-empty && composer update)


echo ""
echo "All done."
echo ""
echo "Now log out and log back in again so that docker works without sudo."
echo ""
