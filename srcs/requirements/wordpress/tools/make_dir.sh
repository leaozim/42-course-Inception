#!/bin/bash

sudo chmod 777 /etc/hosts
echo   "127.0.0.1 lade-lim.42.fr"  >> /etc/hosts

if [ ! -d "/home/${USER}/data" ]; then
        sudo mkdir ~/data
        sudo mkdir ~/data/mariadb
        sudo mkdir ~/data/wordpress
fi
 