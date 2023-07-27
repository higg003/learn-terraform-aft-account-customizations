#!/bin/bash

echo "Executing Pre-API Helpers"
aws s3 ls --profile aft-management
echo "Tables in DynamoDB: ${TEST}"
ACCOUNT_ID=$(echo "${CODEBUILD_INITIATOR}" | grep -o '[0-9]\+')
echo "Account ID: ${ACCOUNT_ID}"
ACCOUNT_NAME=$(aws dynamodb get-item --table-name aft-request-metadata --key "{\"id\": {\"S\": \"${ACCOUNT_ID}\"}}" --profile aft-management | jq -r '.Item.account_name.S')
echo "Account Name: ${ACCOUNT_NAME}"
