#!/bin/bash

# installing tools
echo "installing yq and microcks-cli"
sudo wget https://github.com/mikefarah/yq/releases/latest/download/yq_linux_amd64 -O /usr/bin/yq && sudo chmod +x /usr/bin/yq

# Archivo YAML
cd $FOLDER_COGNITO_USERS
YAML_FILE="users-dev.yaml"


# delete cognito user
# Iterar sobre los pools
yq '.pools[]' "$YAML_FILE" | while IFS= read -r pool; do
  # Extraer el id del pool
  POOL_ID=$(echo "$pool" | yq '.id')
  
  # Iterar sobre los usuarios dentro del pool
  echo "$pool" | yq '.users_to_delete[]' | while IFS= read -r user; do
    # Extraer el email (usado como nombre de usuario en este caso)
    USERNAME=$(echo "$user" | yq '.email')
    
    # Ejecutar el comando AWS
    echo "aws cognito-idp admin-delete-user --user-pool-id $POOL_ID --username $USERNAME "
  done
done