# Zipa Testbed Cluster

This repo sets up the Raspberry Pi's used for the ZIPA testbed. Ansible configures system settings, downloads dependencies, and runs the testbed.

## Setup

### Requirements

- At least two Raspberry Pi's (3 or higher)
- At least two compatible USB microphones
- Separate computer capable of running [Ansible](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html), [nmap](https://nmap.org/download.html), [Raspberry Pi Imager](https://www.raspberrypi.com/software/), and SSH
- Readily available WiFi or ethernet connection to the same LAN with internet access
- At least two SD cards (32GB or higher)
- Machine capable of running a NFS server

### Setting up

### 1. Server-side

Server side Ansible scripts are underway

This currently assumes that you have setup a NFS server and have a computer on the network to distribute a server.py file

### 2. Client-side

1. Using Raspberry Pi Imager on a machine, henceforth as the host machine, flash the SD card with the latest version of PiOS lite. Customize the settings to create a username and password, configuring WLAN if no ethernet connection is used, and enable SSH.
2. Insert the SD card into a Raspberry Pi and hookup the device to a microphone and ethernet if not using WLAN. Then, plug the Pi to power.
3. Using the command line on the host machine while on the same network as the Raspberry Pi's, use `ifconfig` to determine the networks LAN address. Plug the LAN address into nmap using the command `nmap -v -sn x.x.x.x/24`. This will reveal the Raspberry Pi's on the local network and are identifiable by their default hostname "**raspberrypi.lan**". Note these addresses.
4. `cd` into `zipa-cluster/client/` to modify the **inventory.ini** file and overwrite the existing IP addresses with the local IP addresses of each Raspberry Pi discovered. Keep the tailing information as it is needed for Ansible to run, and adding them if you need to put more addresses.
5. Once set and still in the same directory, type `make` on the command line to run the Ansible playbook. Ansible will then need user input, asking for the Raspbery Pi's password to login to SSH and once more to act as superuser. Ansible will then connect to the Raspberry Pi's through the local IP addresses supplied in the **inventory.ini** file. This process takes around 15 minutes with a good internet connection to setup all devices.
6. Once Ansible completes its playbook, run the **server.py** file on the host machine. This will mock the devices discovering and connecting to each other, and begin exchanging information to authenticate.
