#!/bin/bash

if command -v aws &> /dev/null; then
    echo "AWS CLI found. Creating secrets from AWS..."
    ./docker/setup-docker-aws-secrets.sh
else
    echo "AWS CLI not found. Injecting credentials manually..."
    ./docker/setup-docker-manual.sh
fi