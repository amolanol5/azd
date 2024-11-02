#!/bin/bash

# installing tools
echo "installing yq and microcks-cli"
sudo wget -q https://github.com/mikefarah/yq/releases/latest/download/yq_linux_amd64 -O /usr/bin/yq && sudo chmod +x /usr/bin/yq

# Archivo YAML
cd $FOLDER_COGNITO_USERS

YAML_FILE="users-$ACCOUNT.yaml"
JSON_FILE="json-$ACCOUNT.yaml"

# Convert YAML to JSON
yq -o=json < "$YAML_FILE" > "$JSON_FILE"

# Iterate over each pool
jq -c '.pools[]' "$JSON_FILE" | while read -r pool; do
  POOL_ID=$(jq -r '.id' <<< "$pool")

  # Iterate over each user in the pool
  jq -c '.users_to_delete[]' <<< "$pool" | while read -r user; do
    USERNAME=$(jq -r '.id' <<< "$user")

    echo "aws cognito-idp admin-delete-user --user-pool-id $POOL_ID --username $USERNAME"

    # Verificar si el usuario existe en el pool
    # aws cognito-idp admin-get-user --user-pool-id "$POOL_ID" --username "$USERNAME" &>/dev/null

    # if [ $? -eq 0 ]; then
    #         # Si el usuario existe, eliminarlo
    #         echo "aws cognito-idp admin-delete-user --user-pool-id "$POOL_ID" --username "$USERNAME""
    #         echo "Usuario $USERNAME eliminado del pool $POOL_ID"
    # else
    #         # Si el usuario no existe, registrar en el log
    #         echo "Usuario $USERNAME no existe o ya fue eliminado del pool $POOL_ID"
    # fi

  done
done
