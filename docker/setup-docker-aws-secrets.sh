#!/bin/bash

# Check if AWS CLI is installed
if ! command -v aws &> /dev/null; then
    echo "AWS CLI not found. Please install AWS CLI to proceed."
    exit 1
fi

# Configure AWS CLI if necessary
echo "Configuring AWS CLI..."
aws configure

# Define the secret name and AWS region
SECRET_NAME="exoplanets-analyzer-api-url-prod"
AWS_REGION="us-west-2"

# Retrieve the secret value
secrets=$(aws secretsmanager get-secret-value \
  --secret-id "$SECRET_NAME" \
  --region "$AWS_REGION" \
  --query SecretString \
  --output text)

BASE_URL=$(echo "$secrets" | grep -o '"BASE_URL":"[^"]*' | sed 's/"BASE_URL":"//')
PATH_SEGMENT=$(echo "$secrets" | grep -o '"PATH_SEGMENT":"[^"]*' | sed 's/"PATH_SEGMENT":"//')
ENDPOINT_EXOPLANETS=$(echo "$secrets" | grep -o '"ENDPOINT_EXOPLANETS":"[^"]*' | sed 's/"ENDPOINT_EXOPLANETS":"//')

# Verify that all variables were successfully retrieved
if [ -z "$BASE_URL" ] || [ -z "$PATH_SEGMENT" ] || [ -z "$ENDPOINT_EXOPLANETS" ]; then
    echo "Error retrieving one or more variables from the secret."
    exit 1
fi

# Run the Docker container with the environment variables
docker run -p 8080:8080 \
  -e BASE_URL="$BASE_URL" \
  -e PATH_SEGMENT="$PATH_SEGMENT" \
  -e ENDPOINT_EXOPLANETS="$ENDPOINT_EXOPLANETS" \
  rpairo/exoplanets-terminal:latest