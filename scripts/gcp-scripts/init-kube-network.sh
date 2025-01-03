#!/bin/bash
# curl -s https://raw.githubusercontent.com/EFISS-Capstone-SU23/k8s-manifest/main/scripts/gcp-scripts/init-kube-network.sh | bash
set -x

sudo kubeadm init --control-plane-endpoint $(curl https://ipinfo.io/ip) --apiserver-advertise-address $(curl https://ipinfo.io/ip) \
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

# kubectl create -f https://raw.githubusercontent.com/projectcalico/calico/v3.26.1/manifests/tigera-operator.yaml
# curl https://raw.githubusercontent.com/projectcalico/calico/v3.26.1/manifests/custom-resources.yaml -O
# kubectl create -f custom-resources.yaml
# watch kubectl get pods -n calico-system


