#!/bin/bash
# curl -s https://raw.githubusercontent.com/EFISS-Capstone-SU23/k8s-manifest/main/scripts/gcp-scripts/gce-builder-setup.sh | bash -s "Github Runner Token"
set -x

CURRENT_USER_DIR=/home/thaiminhpv
CURRENT_USER=thaiminhpv

if [ -d /home/thaiminhpv/devops/actions-runner/EFISS-Backend ]
then
    echo "GCE builder is installed successfully!"
    exit 0
fi

curl -s https://raw.githubusercontent.com/EFISS-Capstone-SU23/k8s-manifest/main/scripts/gcp-scripts/common.sh | bash

curl -s https://raw.githubusercontent.com/EFISS-Capstone-SU23/k8s-manifest/main/scripts/gcp-scripts/install-gce-builder.sh | bash

mkdir -p $CURRENT_USER_DIR/devops/actions-runner/EFISS-Backend && cd $CURRENT_USER_DIR/devops/actions-runner/EFISS-Backend
curl -o actions-runner-linux-x64-2.307.1.tar.gz -L https://github.com/actions/runner/releases/download/v2.307.1/actions-runner-linux-x64-2.307.1.tar.gz
echo "038c9e98b3912c5fd6d0b277f2e4266b2a10accc1ff8ff981b9971a8e76b5441  actions-runner-linux-x64-2.307.1.tar.gz" | shasum -a 256 -c
tar xzf ./actions-runner-linux-x64-2.307.1.tar.gz

if [ -z "$1" ]
then
    read -sp 'Github Action token: ' token
else
    token=$1
fi

/bin/su -c "$CURRENT_USER_DIR/devops/actions-runner/EFISS-Backend/config.sh --url https://github.com/EFISS-Capstone-SU23/EFISS-Backend --token $token --unattended" - $CURRENT_USER

sudo ./svc.sh install && sudo ./svc.sh start

sudo reboot