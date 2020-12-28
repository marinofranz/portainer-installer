#!/bin/bash

docker stop portainer-ce
docker rm portainer-ce
docker volume rm portainer_data

cd /home/docker

echo "Installation removed!"
echo "-----"
echo "If you would NOT like to delete Portainer data, please exit out of this script within 10 seconds"

sleep 10

sudo rm -r portainer

echo "Portainer and it's data has been uninstalled!"
