#!/bin/bash

if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 
   exit 1
fi

echo "[+] Install ansible."
apt update
apt install software-properties-common
apt-add-repository --yes --update ppa:ansible/ansible
apt install ansible

echo "[+] Clone repo to the /opt folder."

cd /opt
if [ ! -d "/opt/RTvsBT" ] ; then
    git clone --recurse-submodules https://github.com/RTvsBT/RTvsBT.git
fi
cd /opt/RTvsBT
git submodule update
git submodule foreach git checkout main
git submodule foreach git pull origin main

echo "[+] Clone repo to the /opt folder."
cp /opt/RTvsBT/AnsiblePlaybooks/hosts.ini /etc/ansible/hosts

echo "[+] Finished installing ansible."
