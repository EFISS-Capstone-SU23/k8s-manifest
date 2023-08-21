#!/bin/bash
set -x

# curl -s https://raw.githubusercontent.com/EFISS-Capstone-SU23/k8s-manifest/main/scripts/k8s-expose-ingress.sh | bash

cat <<'EOF' > /home/thaiminhpv/expose-ingress.sh
sudo -E kubectl port-forward --namespace=ingress-nginx service/ingress-nginx-controller 80:80 --address='0.0.0.0' &
sudo -E kubectl port-forward --namespace=ingress-nginx service/ingress-nginx-controller 443:443 --address='0.0.0.0'
EOF

chmod +x /home/thaiminhpv/expose-ingress.sh

while :; do
sudo -E bash /home/thaiminhpv/expose-ingress.sh
done