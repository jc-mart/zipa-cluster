# Zipa Testbed Cluster
### This repo sets up the Raspberry Pi's used for the ZIPA testbed. Ansible configures system settings, downloads dependencies, and clones the testbed.

## Setup
### Requirements
- At least two Raspberry Pi's (3 or higher)
- At least two compatible USB microphones
- Separate computer capable of running Raspberry Pi Imager, nmap, and SSH
- Readily available WiFi or ethernet connection to the same LAN with internet access
- At least two SD cards (32GB or higher)
- Machine capable of running a NFS server

### Setting up
**1. Server-side**

**Server side Ansible scripts are underway**

**This currently assumes that you have setup an NFS server and have a computer on the network to distribute a server.py file**

**2. Client-side**
1. Using [Raspberry Pi Imager](https://www.raspberrypi.com/software/), flash the SD card with the latest version of PiOS lite. Customize the settings to create a username and password, configuring WLAN if no ethernet connection is used, and enable SSH.
2. Insert the SD card into a Raspberry Pi and hookup the device to a microphone and ethernet if not using WLAN. Then, plug the Pi to power.
3. Using the command line on that same machine on the same network as the Raspberry Pi's, type `ifconfig` to find the LAN address and associated netmask. For example, the LAN address is `192.168.8.15` with a netmask of `255.255.255.0`.
4. Still on the command line with LAN address and netmask in mind, type `nmap -v -sn 192.168.8.0/24` to find the Raspberry Pi's on the network, replacing the target IP address with the LAN address. Note the IP addresses returned with hostnames `raspberrypi.lan`.
5. SSH to the Raspberry Pi's using the username and password created from the image. Run the command `sudo apt install git -y` to install Git, and clone the ansible scripts repository using the command `git clone https://github.com/jc-mart/zipa-cluster`
6. Type `cd ~/zipa-cluster/client/` to reach the client ansible scripts. Give the bash script permission to execute using `chmod +x run.bash`.
7. Run the script by typing `./run.bash`. Ansible will download necessary dependencies for the testbed, configure the hostname, and clone the testbed repository. This process may take a while.
8. Once the Pi has rebooted, logon and type in `~/zipa-cluster-venv/bin/python3.11 ~/zipa-testbed/main.py`. This prompts the Pi to begin the testbed.