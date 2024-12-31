#!/bin/bash

echo "Creating secrets with AWS..."

echo "Configuring AWS CLI (if needed)..."
aws configure

K8S_SECRET_NAME="exoplanets-local-secrets"
SECRET_NAME="exoplanets-analyzer-api-url-prod"
AWS_REGION="us-west-2"

secrets=$(aws secretsmanager get-secret-value \
  --secret-id "$SECRET_NAME" \
  --region "$AWS_REGION" \
  --query SecretString \
  --output text)

BASE_URL=$(echo "$secrets" | grep -o '"BASE_URL":"[^"]*' | sed 's/"BASE_URL":"//')
PATH_SEGMENT=$(echo "$secrets" | grep -o '"PATH_SEGMENT":"[^"]*' | sed 's/"PATH_SEGMENT":"//')
ENDPOINT_EXOPLANETS=$(echo "$secrets" | grep -o '"ENDPOINT_EXOPLANETS":"[^"]*' | sed 's/"ENDPOINT_EXOPLANETS":"//')

kubectl create secret generic "$K8S_SECRET_NAME" \
  --from-literal=BASE_URL="$BASE_URL" \
  --from-literal=PATH_SEGMENT="$PATH_SEGMENT" \
  --from-literal=ENDPOINT_EXOPLANETS="$ENDPOINT_EXOPLANETS"

echo "Kubernetes secret '$K8S_SECRET_NAME' created successfully."