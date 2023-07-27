#!/bin/bash

echo "Executing Pre-API Helpers"
# Used to manuplate with the AFT Management account
export AWS_PROFILE=aft-management

echo "Account ID: ${VENDED_ACCOUNT_ID}"

ACCOUNT_NAME=$(aws dynamodb get-item --table-name aft-request-metadata --key "{\"id\": {\"S\": \"${VENDED_ACCOUNT_ID}\"}}" | jq -r '.Item.account_name.S')

echo "Account Name: ${ACCOUNT_NAME}"
echo "Adding Account Name to Terraform Locals"

ACCOUNT_NAME=$(echo "${ACCOUNT_NAME}" | rev | cut -d'-' -f2- | rev)
sed -i "s|ACCOUNT_NAME|${ACCOUNT_NAME}|g" "${DEFAULT_PATH}"/"${CUSTOMIZATION}"/terraform/locals.tf

echo "Checking Locals file"

cat "${DEFAULT_PATH}"/"${CUSTOMIZATION}"/terraform/locals.tf

MSG="CKzzRdQ--5DoiG50St0NL6dIuqJ88FL-3FSNwOl89GlJd5rsGrEgDLjoiO-uDhGv-TF6NNoJEUEH0haJJlQ2cHZvXDzU8jMz2ZOpotBMqMMfVwKZkTTb_YGTSDJVl6Kzsai-k9qPtCbTnK27DPdBOzKeV6695aelHOOp3qjOjx-hLYR6RnTp93OJBQhb2T9SIhl13y51L0JVdBD3q9XLbboZNSgNYKrhzkNj7F_kWE-1WTMN1YuuwE23mNOUHPcCcAGatGC1B_4ti6XXjc-g1okg9ufDZBTMkkg4_XKzOIEV9iF-7_ncn_P5i-pWwCUfDGdqEI8IRYxoDvwmCQHuwhBE4Vb8QOARM8x2neUz3E8MXkoKaslBQR-or27_Xnfsl1tvCzP-T1xPognP_BZqHnQxOCSPZs-JMC_BykIc9AMgQZwDPMpXpkxbw0DeRYFcvh91LHkToCPRcu_q6AzGsB1IbZDIQTm609Teo9rH6vTP_PWRMy7-fK4kCyPhSsQxYdH8Uk6d6TwEkeTZPcBj-w"

echo "Decoding Message"
aws sts decode-authorization-message --encoded-message "${MSG}" | jq -r '.DecodedMessage | fromjson | .[]'