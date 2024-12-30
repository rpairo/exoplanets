#!/bin/bash

./k8s/scripts/create-secrets-docker-desktop.sh

echo "Deploying Kubernetes resources..."

kubectl apply -f k8s/base/exoplanets-terminal.yaml

echo "Deployment completed successfully."
