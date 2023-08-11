#!/bin/bash
set -x

sudo kubeadm init --control-plane-endpoint 10.66.66.1 --apiserver-advertise-address 10.66.66.1 \
    --cri-socket=unix:///var/run/crio/crio.sock --pod-network-cidr 192.168.0.0/16

mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

# helm upgrade --install ingress-nginx ingress-nginx \
#   --repo https://kubernetes.github.io/ingress-nginx \
#   --namespace ingress-nginx --create-namespace

# master as worker
# kubectl taint nodes efiss node-role.kubernetes.io/master-
# kubectl taint node efiss node-role.kubernetes.io/master:NoSchedule-
# kubectl taint node efiss node-role.kubernetes.io/control-plane:NoSchedule-

# debug taint
# kubectl get nodes -o json | jq '.items[].spec'


# kubeadm token create --print-join-command