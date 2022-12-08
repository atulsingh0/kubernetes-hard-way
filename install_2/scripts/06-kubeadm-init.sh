#!/bin/bash

sudo kubeadm init --pod-network-cidr 10.244.0.0/16 \
  --apiserver-advertise-address=192.168.56.11 \
  --kubernetes-version 1.24.0

mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

echo "" >/vagrant/k8s-join-script.sh
echo '#!/bin/bash' >>/vagrant/k8s-join-script.sh
sudo kubeadm token create --print-join-command >>/vagrant/k8s-join-script.sh
