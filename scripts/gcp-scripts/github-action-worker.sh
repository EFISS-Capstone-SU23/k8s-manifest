#!/bin/bash
set -x

# check if token is provided
if [ -z "$1" ]
then
    read -sp 'Github Action token: ' token
else
    token=$1
fi

CURRENT_USER_DIR=/home/thaiminhpv
CURRENT_USER=thaiminhpv

mkdir -p $CURRENT_USER_DIR/devops/actions-runner/k8s-manifest && cd $CURRENT_USER_DIR/devops/actions-runner/k8s-manifest
curl -o actions-runner-linux-x64-2.307.1.tar.gz -L https://github.com/actions/runner/releases/download/v2.307.1/actions-runner-linux-x64-2.307.1.tar.gz
echo "038c9e98b3912c5fd6d0b277f2e4266b2a10accc1ff8ff981b9971a8e76b5441  actions-runner-linux-x64-2.307.1.tar.gz" | shasum -a 256 -c
tar xzf ./actions-runner-linux-x64-2.307.1.tar.gz

/bin/su -c "$CURRENT_USER_DIR/devops/actions-runner/k8s-manifest/config.sh --url https://github.com/EFISS-Capstone-SU23/k8s-manifest --token $token --unattended" - $CURRENT_USER

sudo ./svc.sh install && sudo ./svc.sh start
