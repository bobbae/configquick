#!/bin/bash
# check the IP addresses of the devices connected in a network

# list information on all the network devices on the machine
echo Information on all the network devices on the machine:
ipconfig

# find the IPv4 of a device connected to the network
IP=`ipconfig | grep "IPv4" | awk '{ print $NF }' | cut -d "." -f 1-3`
echo -e '\n' Chosen Device\'s IPv4: `ipconfig | grep "IPv4" | awk '{ print $NF }'` '\n' List of IP addresses that responded on the network:

# find the IP range possible
#SUBNETMASK=`ipconfig | grep "Subnet Mask" | awk '{ print $NF }'`

# ping each IP address in the range
for NUM in $(seq 0 255) # subnet of 255.255.255.0
do
	# run all pings in background
	# wait only 5 seconds for a response (change for accuracy of total connected devices)
	echo $IP.$NUM
	ping $IP.$NUM -w 5 >/dev/null && echo "$IP.$NUM" & 
done

# prevent closing of terminal
read
