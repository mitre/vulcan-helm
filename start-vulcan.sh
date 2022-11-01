# ENV Secrets
POSTGRES_PASSWORD=$(openssl rand -hex 33)
SECRET_KEY_BASE=$(openssl rand -hex 64)
CIPHER_PASSWORD=$(openssl rand -hex 64)
CIPHER_SALT=$(openssl rand -hex 32)

# Install vulcan
helm install --set POSTGRES_PASSWORD=$POSTGRES_PASSWORD --set SECRET_KEY_BASE=$SECRET_KEY_BASE --set CIPHER_PASSWORD=$CIPHER_PASSWORD --set CIPHER_SALT=$CIPHER_SALT --debug vulcan-helm .
