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
git clone --recurse-submodules https://github.com/RTvsBT/RTvsBT.git

echo "[+] Finished installing ansible."
