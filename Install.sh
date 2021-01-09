#!/bin/bash

if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 
   exit 1
fi

echo "[+] Install ansible."
apt update >> log.txt 2>&1
apt-get -y install software-properties-common >> log.txt 2>&1
apt-add-repository --yes --update ppa:ansible/ansible >> log.txt 2>&1
apt-get -y install ansible sshpass >> log.txt 2>&1

echo "[+] Clone repo to the /opt folder."

cd /opt
if [ ! -d "/opt/RTvsBT" ] ; then
    git clone --recurse-submodules https://github.com/RTvsBT/RTvsBT.git >> log.txt 2>&1
fi
cd /opt/RTvsBT
git submodule update >> log.txt 2>&1
git submodule foreach git checkout main >> log.txt 2>&1
git submodule foreach git pull origin main >> log.txt 2>&1

echo "[+] Clone repo to the /opt folder."

cp /opt/RTvsBT/AnsiblePlaybooks/hosts.ini /etc/ansible/hosts
cp /opt/RTvsBT/AnsiblePlaybooks/assets/ansible.cfg /etc/ansible/ansible.cfg

echo "[+] Finished installing ansible."
