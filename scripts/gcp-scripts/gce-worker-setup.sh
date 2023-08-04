#!/bin/bash
# curl -s https://raw.githubusercontent.com/EFISS-Capstone-SU23/k8s-manifest/main/scripts/gcp-scripts/gce-worker-setup.sh | bash -s "token"
set -x

if command -v git &> /dev/null
then
    echo "GCE worker is installed successfully!"
    exit 0
fi

# Add SSH keys to the instance
cat <<EOF >> ~/.ssh/authorized_keys
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCC4dW+9GhTPZsNazMaTOE0SaLJGOxVm0HHMrx9h0YUUDhQgYsvrSN+sXJ5ZSxuFM/4Q7l06WYT4B/kabJlCwSxswRWq58El/epSgVVY7Z++sGBOjSnXUINFXLUv1K0wbE7xXRxyv3EPU6qvWaFZEAliNHNVR/jcKhfwUtHvEZf8ZVtj+uefBsMstJAuiNAEaVjThyvuly+huO6cN+CPML8zV9bP3tYORPLQalCvW7IM/b5MIRp4ilI2UeEbLwT2VQQ/ZsaEg6DSejsgmwCXnZ5rj3QMVRIn6iMAOcsi7inssS8RDI9O54xyG42LTxsJo4O8CJ2G4eBl3f5yQjxPBz7 thaiduongme
ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILxsm0F5HUfvpgUn0gZ/XvkEZbbz7rc+BZcrmyU54hT/ dinhanh300229@gmail.com
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC98tzsp/G5DOHLIYyyycyzhjlpncaRTAkj3hTETBgzvoTHx+jvviXfLFOEHRx0RncYZwKF8Cr2802K46ZR4SfNGPtxKqDntIrEQ9qRO+6I9xxouvZoTSNoT7SjRvTck1GybXKIfjvaOrd5oTYrGBv0Ixosd20Z9Ua4evh6Y6vohYbOJDobOPEHhDtRYjawM9hF8kjF64siR/6CRdwttBg80Mg+CBn8wwal3lq8NXccQPfcnkhcTZvrmDxe8ic1Q5+Z2WDjgvole2X/skcOsuZR9MCPKp54T8whDbybsXgPJ1lMk3XWwcTKg1+BTZwsfohBZjDBal9yo7HXdx4xaGGIaX/KgFtJeSY5+ziDWghOsFOezTrsRFMCM89TlYoNGRuZq0ReT6zufgRVYY47bWno6SVPaAaINFVq6SnWIBj3x1RS1X905rFQzB7vKdSN8cSk0jviZW2sJobT5ZlAWRiCzyiFexWweS0OaauzI4l/FcXFmzH3C4qzj6wUaRbistk= thaiminhpv@MinhDesktop
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDuKSshkLC1y2JM2EYtnfMLEtf7w6qXSvnsEq9mI5k0hiOysbhjZAf3jZU9umbHUQW+Ewqm/xe3JgTum1a6pz+PHtVAQ7/n6Pl3F3uUAjKwQhMBo5XMpzwVzo27XR4GRK4i0SESB4pql94Ul7A2aq7hBVquMobyfdFpU4k1/xjcHbR7Tkutgfuo55OKQkJ6JrtDLItlibFuWG8HY+fBjY1pu6kkXhx5drOInfV273UrlS5csp2NmOaZaMJx5UJG6P4auOz8INz/GI+Bj1MqGFts5wzgS0wqRxfeFcIT6aG1KitK0JKXhMfUw/15qweF/jMabbZJhVXxc3Pf6LewftrN8GSaiGlaxnauwpqf1qhEYhy0dkOhEX07Cq8TCfCeLFSkGwsOAbDThZJETyVsgxOQjU8tWzvp0mmX8CmRCm6vG7yLZfDft0AJjA1GLp2kF5L70e7D3TjM1NKMGjMvZlvw9DeO4faXrsQxIBx2YEy96EowU2UVKVWSXBu+bQ8JjHk= thaiminhpv@MinhLaptopUbuntu
ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAID/7ZdSoTsz6WX3uLT8dHlkBZ7uLOYTh4XbyUWr2Jwwg
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC3X9JhNBXDe+2LWLQbwb5dqVUVd8ZkNq+4LzyAYJGNhU0UESc46iD2sZab4/jMFURW1ZFwAulbj1BOUnFTbsdTm76hwC01EjP05EnOAtJUI56cdCfy1CYB6rT97jtm5fc9MS+mT8AqtX+SxQtc2vaH824qnz0h2WvGBhHgcFd5YYyDDpoWKkz6ipxV6maiMpU+N6hQBieZmsFniCV002rKCw6/Ce7pnoNSOW4uIYN9/lKfDbjGLbLJjGF+WpU4oc001szCoxNXLUMmLDwcXiT8lktPNAwUm729QsEznYFz47obmKdNlhrZ9pqTM9uIQZz+p2Ip/PDyzVoWvEf6TxRRrEBgl1qpA6HA3esNNGGF8vSHtnwsH+x8Tr1eOGHoPnKfMr96pa+UZSH8hLiDyyYW9mgJN597yY2L82aKBKc1RunqeckF1jdrSHE79HktV+TnNMQ/zrDmCP5H67Wwav3bWaj8WnJh5WcA2znA7zbdzVZLrDfz1R166Nj0QW79oF0= minhpvt@minhpvt-PC
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQC+DpMtp/fsuNMrPNicdxMBeN/Hi5Q0eUmRIVQpEi54qgpFCcn/KzaTPc2YSQIlwXdGDt2ZI4s9dbnyBCl9kFAkohC14PBz6okj2lhpfaGrBRn3XiqAVqQCkyTCPoyOFJQ794R2vHOZoWjnBBz3C7MEVbMYSyPz618Ngl33YpO4vwnbzippyElRc4nFHRexi9oTu9GIcgtMWBygnSq3YjGO/mSCFkcWiCd2VGlW7HrADq1jbYNyUPLq6NgyWwF6UGylM1tfKjY1YmxJuQzxLdZjNmny/tHu8hCZ1OQ37JiiOyq9mH1taVE7nIlzU2qIL+ZNLwOZEqPVcMAUiBC3bBS8nmaOdtunDYrZav+TV6mPE5YERvcUhxCWIRE0w8uY4p+NJajvJM5BwO2Q6qAsqfAH/nmghdzGyeZ4qkl/jpK3xC9Ftkcm0Jk4OguLDQZpFdYl9D9BOAq0YvRz6uQOCzTI9gwTQj58/hGEqMykFbOCvprzZqxwvs2mA7XOeKIqrQcRxYT2xVRz4Bmgnd1s0V+DJgiLwYpNDuEADycYNsgBJyeZFoTiYNgMYM9+jTnTBs3bmJSTkzTd6anJukJDxpqGU7GlXnjMiNAdwjmV6q/sM9nIEU/RVEUARwCLZTQoCAIkV1Wj0TWYOY7jRv4qta1FRSHsx3hMztxNnqLg79uYRQ== nguyendongducviet2001@gmail.com
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDAmWxz/haAaTizAx4idFuydK83CTejOvKJmW04CNW4GrkqPabWpk3KGGxHccREOU+TLAMnLtEcYhk0RU8Wh3aTEoJ9nH1p9NwRrJSudTtIZhCrMSoifa0cufRDigFewQPjKr6jVtSTZzc5tSAMM1HqupY11o9OIJ5C8xtRrqZKmZuKyVbzxCUwFeM997rXUeYQaPFwOPwcqkM4GFGTgbOjRX86yQzcHzM5SCw22mwqMGZcJrfr56VwKtp5/REQz/SfWPf1LQR+M9tdAMZbRMxJvjVvcjKxqCNdW4h3HPdWaPotT/AWTuZNJZZ4LGLqGgNXMh4DRcLaKjMjBABfC0PAXMnnqIggVlCMrWA7WdVH/umM9as5m21LBw+inChyHvSIyJ52Lgw6PqXLSoC/1eopT6hJtQSRCy2eV3WapOJxIdMFX2otmZv+zMtHW9CNc1BSGOJ5ZP+8D+ZIVi3xx+2BLd2MkWwSk3fQhWd8HIPwrIzAWfgjQ5zWAWsDAfuio6k= saplab@saplab-Z390-AORUS-PRO-WIFI
EOF

cat <<EOF >> ~/.bashrc
# avoid duplicates..
export HISTCONTROL=ignoredups:erasedups

# append history entries..
shopt -s histappend

# After each command, save and reload history
export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"
EOF

sudo apt update
sudo apt install git curl -y

cd ~/
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
cd ~/.fzf/
bash install --all
source ~/.bashrc
cd ~/

# Install kubectl 
sudo apt-get update
sudo apt-get install -y ca-certificates curl
sudo apt-get install -y apt-transport-https
sudo mkdir -p /etc/apt/keyrings/
curl -fsSL https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-archive-keyring.gpg
echo "deb [signed-by=/etc/apt/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list
sudo apt-get update
sudo apt-get install -y kubectl

cat <<EOF | sudo tee /etc/modules-load.d/k8s.conf
overlay
br_netfilter
EOF

sudo modprobe overlay
sudo modprobe br_netfilter

# sysctl params required by setup, params persist across reboots
cat <<EOF | sudo tee /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-iptables  = 1
net.bridge.bridge-nf-call-ip6tables = 1
net.ipv4.ip_forward                 = 1
EOF

# Apply sysctl params without reboot
sudo sysctl --system

cat <<EOF | sudo tee /etc/modules-load.d/crio.conf
overlay
br_netfilter
EOF

# Set up required sysctl params, these persist across reboots.
cat <<EOF | sudo tee /etc/sysctl.d/99-kubernetes-cri.conf
net.bridge.bridge-nf-call-iptables  = 1
net.ipv4.ip_forward                 = 1
net.bridge.bridge-nf-call-ip6tables = 1
EOF


OS=Debian_11
CRIO_VERSION=1.23
echo "deb https://download.opensuse.org/repositories/devel:/kubic:/libcontainers:/stable/$OS/ /"|sudo tee /etc/apt/sources.list.d/devel:kubic:libcontainers:stable.list
echo "deb http://download.opensuse.org/repositories/devel:/kubic:/libcontainers:/stable:/cri-o:/$CRIO_VERSION/$OS/ /"|sudo tee /etc/apt/sources.list.d/devel:kubic:libcontainers:stable:cri-o:$CRIO_VERSION.list
curl -L https://download.opensuse.org/repositories/devel:kubic:libcontainers:stable:cri-o:$CRIO_VERSION/$OS/Release.key | sudo apt-key add -
curl -L https://download.opensuse.org/repositories/devel:/kubic:/libcontainers:/stable/$OS/Release.key | sudo apt-key add -
sudo apt update
sudo apt install cri-o cri-o-runc -y
sudo systemctl start crio.service
sudo systemctl enable crio.service

sudo apt-get update
sudo apt-get install -y kubelet kubeadm kubectl
sudo apt-mark hold kubelet kubeadm kubectl

sudo kubeadm join efiss.tech:6443 --token "$token" \
        --discovery-token-ca-cert-hash sha256:8c6a2132710c3ce85842c7cb5811a1fddec99c405a956e9bc94fcb5183e989a7 \