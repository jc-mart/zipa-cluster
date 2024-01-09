#!/bin/bash

sudo apt --fix-broken install -y
sudo apt update
sudo apt upgrade -y
sudo apt autoremove --purge -y
sudo apt --fix-broken install -y

ls /bin > defaultSoftware.txt

sudo apt install software-properties-common -y
sudo add-apt-repository --yes --update ppa:ansible/ansible
sudo apt install ansible -y
sudo apt --fix-broken install -y

sudo apt install python3-pip -y

python3.11 -m venv zipa-cluster-venv

./zipa-cluster-venv/bin/pip install -r requirements.txt

./zipa-cluster-venv/bin/poetry update

ansible-playbook -i inventory.ini playbook.yaml

source ~/.bashrc

sudo reboot