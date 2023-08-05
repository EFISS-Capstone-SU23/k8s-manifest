#!/bin/bash
set -x

sudo kubeadm init --control-plane-endpoint efiss.tech \
    --cri-socket=unix:///var/run/crio/crio.sock

mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

helm upgrade --install ingress-nginx ingress-nginx \
  --repo https://kubernetes.github.io/ingress-nginx \
  --namespace ingress-nginx --create-namespace

# master as worker
# kubectl taint nodes efiss node-role.kubernetes.io/master-
# kubectl taint node efiss node-role.kubernetes.io/master:NoSchedule-
# kubectl taint node efiss node-role.kubernetes.io/control-plane:NoSchedule-

# debug taint
# kubectl get nodes -o json | jq '.items[].spec'


# kubeadm token create --print-join-command