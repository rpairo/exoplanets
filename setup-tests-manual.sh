#!/bin/bash

echo "Setting up ENV VARs..."

export BASE_URL=$(echo "aHR0cHM6Ly9naXN0LmdpdGh1YnVzZXJjb250ZW50LmNvbQ==" | base64 --decode)
export PATH_SEGMENT=$(echo "L2pvZWxiaXJjaGxlci82NmNmODA0NWZjYmI2NTE1NTU3MzQ3YzA1ZDc4OWI0YS9yYXcvOWExOTYzODViNDRkNDI4ODQzMWVlZjc0ODk2YzA1MTJiYWQzZGVmZQ==" | base64 --decode)
export ENDPOINT_EXOPLANETS=$(echo "L2V4b3BsYW5ldHM=" | base64 --decode)

if [ -z "$BASE_URL" ] || [ -z "$PATH_SEGMENT" ] || [ -z "$ENDPOINT_EXOPLANETS" ]; then
    echo "Error retrieving one or more variables from the secret."
    exit 1
fi

echo "Running Swift Tests..."
swift test
