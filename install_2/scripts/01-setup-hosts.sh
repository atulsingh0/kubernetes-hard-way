#!/bin/bash
set -e
IFNAME=$1
ADDRESS="$(ip -4 addr show $IFNAME | grep "inet" | head -1 | awk '{print $2}' | cut -d/ -f1)"
sed -e "s/^.*${HOSTNAME}.*/${ADDRESS} ${HOSTNAME} ${HOSTNAME}.local/" -i /etc/hosts

# remove ubuntu-bionic entry
sed -e '/^.*ubuntu-bionic.*/d' -i /etc/hosts

# Update /etc/hosts about other hosts
cat >>/etc/hosts <<EOF
192.168.56.11  k8s-control01
192.168.56.12  k8s-control02
192.168.56.12  k8s-control03
192.168.56.21  k8s-worker01
192.168.56.22  k8s-worker02
192.168.56.23  k8s-worker03
192.168.56.30  lb
EOF
