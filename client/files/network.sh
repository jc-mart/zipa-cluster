#!/bin/bash

# Refresh available list of connections
sudo nmcli c reload

# Bring down current connection
sudo nmcli con down preconfigured

# Bring up new connection
sudo nmcli con up network