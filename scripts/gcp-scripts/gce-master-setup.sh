#!/bin/bash

# curl -s https://raw.githubusercontent.com/EFISS-Capstone-SU23/k8s-manifest/main/scripts/gcp-scripts/gce-master-setup.sh | bash

if command -v tmux &> /dev/null
then
    echo "GCE master is installed successfully!"
    exit 0
fi

curl -s https://raw.githubusercontent.com/EFISS-Capstone-SU23/k8s-manifest/main/scripts/gcp-scripts/common.sh | bash

sudo apt install tmux htop -y

echo "Installing master node..."
curl -s https://raw.githubusercontent.com/EFISS-Capstone-SU23/k8s-manifest/main/scripts/gcp-scripts/install-master-kube-node.sh | bash -s $1
echo Done!