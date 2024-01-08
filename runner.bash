#!/bin/bash

sudo apt update
sudo apt upgrade -y
sudo apt dist-upgrade -y

sudo apt install git -y
# Ensure version 1:2.39.2-1.1

sudo apt install avahi-daemon -y
# Ensure version 0.8-10 

sudo apt install vim -y
# Ensure version 9.0.1378-2 

sudo apt install python3-defaults -y
# Ensure version 3.11.2-1+b1

sudo apt install python3-pyaudio -y
# Ensure version 0.2.13-1+b1

sudo apt install python3-pip -y
# Ensure version 23.0.1+dfsg-1+rpt1

python3.11 -m venv zipa-cluster-venv

./zipa-cluster-venv/bin/pip install poetry
# Ensure version 1.7.1

./zipa-cluster-venv/bin/poetry update

