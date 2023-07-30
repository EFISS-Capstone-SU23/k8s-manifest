#!/bin/bash

# curl -s https://raw.githubusercontent.com/EFISS-Capstone-SU23/k8s-manifest/main/gcp-scripts/install-gce-builder.sh | bash

if ! command -v make &> /dev/null
then
    echo "Cannot find make, installing..."
    sudo apt-get update
    sudo apt-get install make -y
fi

if ! command -v docker &> /dev/null
then
    echo "Cannot find docker, installing..."

    if grep -q Debian /etc/os-release; then
        sudo apt-get update
        sudo apt-get install \
            ca-certificates \
            curl \
            gnupg -y
        sudo install -m 0755 -d /etc/apt/keyrings
        curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
        sudo chmod a+r /etc/apt/keyrings/docker.gpg
        echo \
        "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian \
        "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
        sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
        sudo apt-get update

        sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y

        sudo groupadd docker
        sudo usermod -aG docker $USER
        newgrp docker
    elif grep -q Ubuntu /etc/os-release; then
        sudo apt-get update
        sudo apt-get install ca-certificates curl gnupg -y
        sudo install -m 0755 -d /etc/apt/keyrings
        curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
        sudo chmod a+r /etc/apt/keyrings/docker.gpg
        echo \
        "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
        "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
        sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
        sudo apt-get update
        sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
        sudo groupadd docker
        sudo usermod -aG docker $USER
        newgrp docker
    else
        echo "Unsupported OS, please install docker manually"
        exit 1
    fi
fi

exit 0