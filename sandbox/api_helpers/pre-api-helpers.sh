#!/bin/bash

echo "Executing Pre-API Helpers"

export AWS_PROFILE=aft-management

echo "Account ID: ${VENDED_ACCOUNT_ID}"
ACCOUNT_NAME=$(aws dynamodb get-item --table-name aft-request-metadata --key "{\"id\": {\"S\": \"${VENDED_ACCOUNT_ID}\"}}" | jq -r '.Item.account_name.S')
echo "Account Name: ${ACCOUNT_NAME}"
echo "Adding Account Name to Terraform Locals"
ACCOUNT_NAME=$(echo "$ACCOUNT_NAME" | rev | cut -d'-' -f2- | rev)
sed -i "s|ACCOUNT_NAME|${ACCOUNT_NAME}|g" ${DEFAULT_PATH}/${CUSTOMIZATION}/terraform/locals.tf
echo "Checking Locals file"
cat ${DEFAULT_PATH}/${CUSTOMIZATION}/terraform/locals.tf
