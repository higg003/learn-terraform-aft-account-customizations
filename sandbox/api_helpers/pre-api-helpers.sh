#!/bin/bash

echo "Executing Pre-API Helpers"

ACCOUNT_ID=$(echo "${CODEBUILD_INITIATOR}" | grep -o '[0-9]\+')
echo "Account ID: ${ACCOUNT_ID}"
ACCOUNT_NAME=$(aws dynamodb get-item --table-name aft-request-metadata --key "{\"id\": {\"S\": \"${ACCOUNT_ID}\"}}" --query "Item.account_name.S")
echo "Account Name: ${ACCOUNT_NAME}"
