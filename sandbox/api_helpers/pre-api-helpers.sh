#!/bin/bash

echo "Executing Pre-API Helpers"
printenv
echo
CUSTOMIZATION=$(aws dynamodb get-item --table-name aft-request-metadata --key "{\"id\": {\"S\": \"$VENDED_ACCOUNT_ID\"}}" --attributes-to-get "account_customizations_name" | jq --raw-output ".Item.account_customizations_name.S")
echo "Customization: ${CUSTOMIZATION}"
TEST=$(aws dynamodb list-tables --region us-east-1)
echo "Tables in DynamoDB: ${TEST}"
ACCOUNT_ID=$(echo "${CODEBUILD_INITIATOR}" | grep -o '[0-9]\+')
echo "Account ID: ${ACCOUNT_ID}"
ACCOUNT_NAME=$(aws dynamodb get-item --table-name aft-request-metadata --key "{\"id\": {\"S\": \"${ACCOUNT_ID}\"}}")
echo "Account Name: ${ACCOUNT_NAME}"
