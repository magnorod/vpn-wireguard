#!/bin/bash
my_network="192.168.128.0/24"
wireguard_server="192.168.128.1/24"
dev_name="wg0"

ip link add dev "$dev_name" type wireguard
if [ $? -ne 0 ]
then
    exit 1
else
    echo "add dev "$dev_name" type wireguard"
fi
ip address add dev "$dev_name" "$wireguard_server"
if [ $? -ne 0 ]
then
    exit 1
else
    echo "add ip to dev wireguard"
fi
wg setconf "$dev_name" /etc/wireguard/serveur.conf
if [ $? -ne 0 ]
then
    exit 1
else
    echo "set serverconf to "$dev_name" "
fi
ip link set up dev "$dev_name"
if [ $? -ne 0 ]
then
    exit 1
else
    echo "up dev "$dev_name""
fi
ip route add "$my_network" dev "$dev_name"
if [ $? -ne 0 ]
then
    exit 1
else
    echo "add route to $my_network"
fi
exit 0
