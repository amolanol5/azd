#!/bin/bash

# installing tools
echo "installing yq and microcks-cli"
sudo wget https://github.com/mikefarah/yq/releases/latest/download/yq_linux_amd64 -O /usr/bin/yq && sudo chmod +x /usr/bin/yq

# delete cognito user
echo "deleting user"
echo $FOLDER_COGNITO_USERS
echo "aws cognito-idp admin-delete-user --user-pool-id $POOL_ID --username $USERNAME"







# # finding files
# path="service-mocks/api-mocks"
# yaml_files=$(find  $path/*/ -type f -maxdepth 1  -name "*.yml")

# # import mocks
# echo "importing mocks to microcks"
# for files in $yaml_files; do
#     echo " ******** importing: $files ******** " 
#     microcks-cli import "$files" \
#         --microcksURL=$MICROCKS_BASE_URL/api/ \
#         --keycloakClientId=$MICROCKS_CLIENT_ID \
#         --keycloakClientSecret=$MICROCKS_CLIENT_SECRET
# done