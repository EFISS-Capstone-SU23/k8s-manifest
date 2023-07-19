# k8s-manifest

This use k8s with kustomization. Using ingress as the gateway.

Github Action will trigger kubectl command to deploy the application to k8s cluster.

The Docker Image will be built by the server and pushed to Google Container Registry (Google Artifact Registry). This make only the choosen service will be deployed, and other service will not be affected.

## Kubenetes Access

1. Install kubectl

Linux: https://kubernetes.io/docs/tasks/tools/install-kubectl-linux/

Windows: https://kubernetes.io/docs/tasks/tools/install-kubectl-windows/

2. Get the kubeconfig file from the server

```bash
mkdir -p ~/.kube
sudo cp -i ~/Downloads/config ~/.kube/config
sudo chown $(id -u):$(id -g) ~/.kube/config  # optional
```

3. Get all running pods (running containers)

```bash
kubectl -n development get pods
```

4. Get logs of a service

```bash
kubectl -n development logs -f --tail 10000 -l app=auth
kubectl -n development logs -f --tail 10000 -l app=product
```
