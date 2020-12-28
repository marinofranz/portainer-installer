#!/bin/bash

function install_docker {
  if ! command -v docker &> /dev/null
  then
      echo "Docker is not installed"
      echo "Installing docker in 5 seconds.."
      echo "Exit out of this script to cancel"
      
      sleep 5

      sudo apt update

      echo "The following command will take a while, please wait"

      sudo apt upgrade

      echo "Removing & checking for older versions"
      sudo apt-get remove docker docker-engine docker.io containerd runc

      sudo apt-get update

      sudo apt-get install \
        apt-transport-https \
        ca-certificates \
        curl \
        gnupg-agent \
        software-properties-common

      curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

      echo "Adding repository"
      sudo add-apt-repository \
        "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
        $(lsb_release -cs) \
        stable"

      echo "Installing Docker engine"

      sudo apt-get update
      sudo apt-get install docker-ce docker-ce-cli containerd.io

      echo "Docker is now installed, installing Portainer.."
  fi
}

echo "Running the installer..."

sudo apt-get update

IP_ADDRESS=$(hostname -I | cut -f1 -d' ')

install_docker

docker volume create portainer_data

echo "What port would you like the Portainer GUI to run on?"
read PORTAINER_PORT

docker run -d -p 9000:9000 -p $PORTAINER_PORT:8000 --name portainer-ce --restart always -v /var/run/docker.sock:/var/run/docker.sock -v /home/docker/portainer:/data portainer/portainer

echo "Installed Portainer!"
echo "Starting Portainer!"

docker start portainer

echo "Started portainer!"
echo "-----"
echo "You can access the Portainer GUI at:"
echo "${IP_ADDRESS}:$[PORT}"
