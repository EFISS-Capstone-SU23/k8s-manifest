# k8s-manifest

This use k8s with kustomization. Using ingress as the gateway.

Github Action will trigger kubectl command to deploy the application to k8s cluster.

The Docker Image will be built **by developer** and pushed to Google Container Registry (Google Artifact Registry). This make only the choosen service will be deployed, and other service will not be affected.

In the future, if we want to build docker on the server, we must write a bash script which triggered by Github Action. This script will get the git commit diff, infer the changed service, and only build and deploy only the changed service docker image.
