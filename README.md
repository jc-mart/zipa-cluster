# ZIPA Testbed Cluster

This repository sets up Raspberry Pi's used for the [ZIPA testbed](https://github.com/isaac-ahlgren/zipa-testbed/tree/main) project. Ansible configures system settings, downloads dependencies, and runs the testbed.

## Overview

### Requirements

- Readily available Wi-Fi or ethernet connection to the same LAN with internet access
- At minimum two Raspberry Pi's (Models 3 B+ or later)
- SD cards for flashing PiOS (Preferrably 32GB or higher)
- Compatible sensors to hookup (a USB microphone for each Pi, for example)
- A computer capable of running [Ansible](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html), [nmap](https://nmap.org/download.html), [Raspberry Pi Imager](https://www.raspberrypi.com/software/), SSH, and running an NFS server (NFS server can be run on a separate machine)

### Setup

### 1. Client side

1. Flash PiOS lite onto the SD card using Raspberry Pi Imager.
    - When prompted, customize OS settings from the Imager such as:
      - Setting an easily identifiable hostname for finding the Pi on the LAN network.
      - Set a default username and password, to be the same on all imaged Pi's.
      - Specify WLAN SSID and password if using Wi-Fi.
      - Enable both SSH and SSH password authentication.

2. Insert SD card with PiOS into the Raspberry Pi, hookup sensors, insert ethernet cable if not using Wi-Fi, and plug into power.
    - Our setup on one of our various deployed Pi's comprised of:
      - One microphone attached through a USB audio card
      - Humidity, light, and temperature sensors daisy chained using I2C on pins `5` and `7` using 5V power
      - VoltKey interfaces through serial on pins `8` and `10`
      - PIR sensor interfaces on pin `32` using 3V3 power

3. Once Pi's have booted up, use **nmap** on the command line to search for the devices on the local network and note their IP addresses.
    - For example:
      - Using `ifconfig` reveals the computer's **wlan0** address as **192.168.1.100**; note the three octets, **192.168.1**
      - Use the command `nmap -sn your.three.octets.0/24` to find all discoverable devices on the network
      - Once the network scan is completed, note all IP addresses that have the Raspberry Pi's identifiable hostname
4. Still on the computer, navigate to this project's client directory and edit the **inventory.ini** file.
    - Using your favorite text editor and following the file's schema:
      - Add/replace existing addresses with the addresses with your noted addresses
      - Keep the `ansible_connection` and `ansible_user` fields the same
      - Once completed, save the file
5. Run the Ansible install script.
    - Still in the client directory on the command line, type `make install` to run the script
      - The script prompts for the password so that it can make changes to the Pi
6. Run a protocol.
    - Using the **server.py** file on your computer from the ZIPA testbed repository (linked above), modify fields such as `IP_ADDR` with your computers LAN IP address, `TARGET_IP_ADDRESS` with one of the Pi's LAN IP address (to act as the host), and `bytestream` with one of the available protocols
    - Once modified, run the file using `python3 server.py` to send the protocol to the host Pi, to begin the testbed on all participating Pi's

### 2. Server Side

1. Run the Ansible install script.
   - On the command line for the machine intended to hold the NFS, navigate to the server directory and modify the **inventory.ini** file and include the machine's IP address (can be done through `ifconfig` or `nmap`), as well as a valid superuser
   - Navigate to the tasks directory, and modify the **filesystem.yaml** file to change the IP addresses to an expected subnet address so that multiple clients from that subnet can mount to the NFS
   - Return to the server directory and type `make install` to run the script
   - The script prompts for the password so that it can make changes to the machine
