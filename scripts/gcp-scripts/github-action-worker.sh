#!/bin/bash
set -x

# check if token is provided
if [ -z "$1" ]
then
    read -sp 'Github Action token: ' token
else
    token=$1
fi

mkdir -p ~/devops/actions-runner/k8s-manifest && cd ~/devops/actions-runner/k8s-manifest
curl -o actions-runner-linux-x64-2.306.0.tar.gz -L https://github.com/actions/runner/releases/download/v2.306.0/actions-runner-linux-x64-2.306.0.tar.gz
echo "b0a090336f0d0a439dac7505475a1fb822f61bbb36420c7b3b3fe6b1bdc4dbaa  actions-runner-linux-x64-2.306.0.tar.gz" | shasum -a 256 -c
tar xzf ./actions-runner-linux-x64-2.306.0.tar.gz

./config.sh --url https://github.com/EFISS-Capstone-SU23/k8s-manifest --token "$token" --unattended

sudo ./svc.sh install && sudo ./svc.sh start
