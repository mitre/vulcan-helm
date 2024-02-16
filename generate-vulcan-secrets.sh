#!/bin/bash

RED="\033[0;31m"
GREEN="\033[0;32m"
NC="\033[0m"
UNICORN="\U1F984\n"

# Function to generate secrets
generate_secrets () {
	if ! grep -qF "POSTGRES_PASSWORD" vulcan/env/vulcan-secrets.yaml; then
		echo -e "${RED}vulcan-secrets.yaml does not contain POSTGRES_PASSWORD, generating secret...${NC}"
		PASSWORD=$(openssl rand -hex 33)
		echo -e "POSTGRES_PASSWORD: $PASSWORD" >> vulcan/env/vulcan-secrets.yaml
		echo -e "DATABASE_URL: postgres://vulcanpostgres:$PASSWORD@postgres/vulcan_psql_production" >> vulcan/env/vulcan-secrets.yaml
	else
		echo -e "${GREEN}vulcan-secrets.yaml already contains POSTGRES_PASSWORD, no need to regenerate${NC} ${UNICORN}"
	fi

	if ! grep -qF "SECRET_KEY_BASE" vulcan/env/vulcan-secrets.yaml; then
		echo  -e "${RED}vulcan-secrets.yaml does not contain SECRET_KEY_BASE, generating secret...${NC}"
		echo -e "SECRET_KEY_BASE: $(openssl rand -hex 64)" >> vulcan/env/vulcan-secrets.yaml
	else
		echo -e "${GREEN}vulcan-secrets.yaml already contains SECRET_KEY_BASE, no need to regenerate${NC} ${UNICORN}"
	fi

	if ! grep -qF "CIPHER_PASSWORD" vulcan/env/vulcan-secrets.yaml; then
		echo -e "${RED}vulcan-secrets.yaml does not contain CIPHER_PASSWORD, generating secret...${NC}"
		echo -e "CIPHER_PASSWORD: $(openssl rand -hex 64)" >> vulcan/env/vulcan-secrets.yaml
	else
		echo -e "${GREEN}vulcan-secrets.yaml already contains CIPHER_PASSWORD, no need to regenerate${NC} ${UNICORN}"
	fi

	if ! grep -qF "CIPHER_SALT" vulcan/env/vulcan-secrets.yaml; then
		echo -e "${RED}vulcan-secrets.yaml does not contain CIPHER_SALT, generating secret...${NC}"
		echo -e "CIPHER_SALT: $(openssl rand -hex 32)" >> vulcan/env/vulcan-secrets.yaml
	else
		echo -e "${GREEN}vulcan-secrets.yaml already contains CIPHER_SALT, no need to regenerate${NC} ${UNICORN}"
	fi
}

echo ""
echo "Checking if vulcan-secrets.yaml file exist ..."
echo ""

if [ -f vulcan/env/vulcan-secrets.yaml ]; then
	echo -e "${GREEN}vulcan-secrets.yaml already exists${NC}"
	echo -e "${RED}If you would like to regenerate your secrets, please delete vulcan/env/vulcan-secrets.yaml and re-run the script.${NC}"
	echo  ""
	generate_secrets
else
	echo "vulcan-secrets.yaml does not exist, creating..."
	(umask 066; touch vulcan/env/vulcan-secrets.yaml)
	echo ""
	generate_secrets
fi

echo ""
echo "Secret generation done"
echo ""
