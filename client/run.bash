#!/bin/bash

sudo apt install software-properties-common -y
sudo add-apt-repository --yes --update ppa:ansible/ansible
sudo apt install ansible -y

ansible-playbook -i inventory.ini playbook.yaml

source ~/.bashrc