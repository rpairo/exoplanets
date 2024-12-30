#!/bin/bash

current_context=$(kubectl config current-context)

if [[ "$current_context" == "docker-desktop" ]]; then
  echo "Running on Docker Desktop. Creating secrets..."

  SECRET_NAME="exoplanets-local-secrets"

  kubectl delete secret $SECRET_NAME --ignore-not-found

  # Decode base64 values and create secret
  BASE_URL_DECODING=$(echo "aHR0cHM6Ly9naXN0LmdpdGh1YnVzZXJjb250ZW50LmNvbQ==" | base64 --decode)
  PATH_SEGMENT_DECODING=$(echo "L2pvZWxiaXJjaGxlci82NmNmODA0NWZjYmI2NTE1NTU3MzQ3YzA1ZDc4OWI0YS9yYXcvOWExOTYzODViNDRkNDI4ODQzMWVlZjc0ODk2YzA1MTJiYWQzZGVmZQ==" | base64 --decode)
  ENDPOINT_EXOPLANETS_DECODING=$(echo "L2V4b3BsYW5ldHM=" | base64 --decode)

  kubectl create secret generic $SECRET_NAME \
    --from-literal=BASE_URL="$BASE_URL_DECODING" \
    --from-literal=PATH_SEGMENT="$PATH_SEGMENT_DECODING" \
    --from-literal=ENDPOINT_EXOPLANETS="$ENDPOINT_EXOPLANETS_DECODING"
else
  echo "Not running on Docker Desktop. Skipping secret creation."
fi