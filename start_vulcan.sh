#!/bin/bash

# Generate vulcan secrets
./generate-vulcan-secrets.sh

# Check if vulcan has already been released:
if [ "$(helm ls -n vulcan -q)" = vulcan ]
  then
    echo "vulcan has already been installed."
    echo ""
    echo "Upgrading the release to a new version ..."
    echo ""
    # Upgrade chart if already installed
    helm -n vulcan upgrade vulcan .
  else
    # Install helm chart
    helm install -n vulcan --create-namespace vulcan .
fi
