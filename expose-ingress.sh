sudo -E kubectl port-forward --namespace=ingress-nginx service/ingress-nginx-controller 80:80 --address='0.0.0.0' &
sudo -E kubectl port-forward --namespace=ingress-nginx service/ingress-nginx-controller 443:443 --address='0.0.0.0'
