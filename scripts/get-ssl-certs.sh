#!/bin/bash
set -x
set -e

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

cat <<EOF > ./cloudflare-certbot.ini
# Cloudflare API credentials used by Certbot
# dns_cloudflare_api_token = abcxyz
EOF

if [ ! -f ./cloudflare-certbot.ini ]; then
    echo "Please create cloudflare-certbot.ini"
    exit
fi

# check if certbot is installed
if ! [ -x "$(command -v certbot)" ]; then
    echo "Certbot is not installed. Installing..."
    sudo apt install snapd -y
    sudo snap install core; sudo snap refresh core
    sudo snap install --classic certbot
    sudo ln -s /snap/bin/certbot /usr/bin/certbot
    sudo snap set certbot trust-plugin-with-root=ok
    sudo snap install certbot-dns-cloudflare
fi

sudo certbot certonly --dns-cloudflare --dns-cloudflare-credentials \
    ./cloudflare-certbot.ini -d '*.efiss.tech' -d 'efiss.tech'

mkdir -p certs/
sudo cp -L /etc/letsencrypt/live/efiss.tech/fullchain.pem certs/
sudo cp -L /etc/letsencrypt/live/efiss.tech/privkey.pem certs/

sudo chown -R $USER:$USER certs
sudo chmod -R 755 certs
