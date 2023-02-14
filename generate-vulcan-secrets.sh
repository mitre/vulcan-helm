#!/bin/bash

echo "Checking if vulcan-secrets.yaml file exist ..."

if [ -f env/vulcan-secrets.yaml ]; then
	echo "vulcan-secrets.yaml already exists, if you would like to regenerate your secrets, please delete this file and re-run the script."
else
	echo "vulcan-secrets.yaml does not exist, creating..."
	(umask 066; touch env/vulcan-secrets.yaml)
fi

if ! grep -qF "POSTGRES_PASSWORD" env/vulcan-secrets.yaml; then
	echo "vulcan-secrets.yaml does not contain POSTGRES_PASSWORD, generating secret..."
	echo -e "POSTGRES_PASSWORD: $(openssl rand -hex 33)" >> env/vulcan-secrets.yaml
else
  echo "vulcan-secrets.yaml already contains POSTGRES_PASSWORD, no need to regenerate :)"
fi

if ! grep -qF "SECRET_KEY_BASE" env/vulcan-secrets.yaml; then
	echo "vulcan-secrets.yaml does not contain SECRET_KEY_BASE, generating secret..."
	echo -e "SECRET_KEY_BASE: $(openssl rand -hex 64)" >> env/vulcan-secrets.yaml
else
  echo "vulcan-secrets.yaml already contains SECRET_KEY_BASE, no need to regenerate :)"
fi

if ! grep -qF "CIPHER_PASSWORD" env/vulcan-secrets.yaml; then
	echo "vulcan-secrets.yaml does not contain CIPHER_PASSWORD, generating secret..."
	echo -e "CIPHER_PASSWORD: $(openssl rand -hex 64)" >> env/vulcan-secrets.yaml
else
  echo "vulcan-secrets.yaml already contains CIPHER_PASSWORD, no need to regenerate :)"
fi

if ! grep -qF "CIPHER_SALT" env/vulcan-secrets.yaml; then
	echo "vulcan-secrets.yaml does not contain CIPHER_SALT, generating secret..."
	echo -e "CIPHER_SALT: $(openssl rand -hex 32)" >> env/vulcan-secrets.yaml
else
  echo "vulcan-secrets.yaml already contains CIPHER_SALT, no need to regenerate :)"
fi

echo "Done"
