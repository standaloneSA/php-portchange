#!/bin/bash

yum update  -y

cat << EOF > /tmp/ifcfg-eno16780032 
DEVICE=eno16780032
TYPE=Ethernet
BOOTPROTO=none
ONBOOT=yes
BRIDGE=br0
NM_CONTROLLED=no
EOF

cat << EOF > /tmp/ifcfg-br0
DEVICE=br0
TYPE=Bridge
BOOTPROTO=dhcp
ONBOOT=yes
DELAY=0
NM_CONTROLLED=no
EOF

cat << EOF > /tmp/ifcfg-veth0
DEVICE=veth0
TYPE=veth
BOOTPROTO=none
ONBOOT=yes
NM_CONTROLLED=no
EOF

cat << EOF > /tmp/ifcfg-veth1
BOOTPROTO=static
NAME=veth1
DEVICE=veth1
ONBOOT=yes
NM_CONTROLLED=no
IPADDR=10.254.10.20
NETMASK=255.255.0.0
EOF

echo 1 > /proc/sys/net/ipv4/ip_forward
ip link add veth0 type veth peer name veth1


