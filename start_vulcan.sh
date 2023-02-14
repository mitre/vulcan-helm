#!/bin/bash

# Generate vulcan secrets
./generate-vulcan-secrets.sh

# Install helm chart
helm install vulcan .
