#!/bin/bash
set -e

if [ -z $AWS_PROFILE ]; then
  echo "AWS Profile is required."
  exit 1
fi

if [ -z $ENV_NAME ]; then
  echo "ENV_NAME is required."
  exit 1
fi

if [ -z $PROJECT_NAME ]; then
  echo "PROJECT_NAME is required."
  exit 1
fi

if [ -z $MAIN_DISTRIBUTION_ID ]; then
  echo "MAIN_DISTRIBUTION_ID is required."
  exit 1
fi

cd ../react-app

npm run build

cd ./build

MAIN_BUCKET_NAME="${PROJECT_NAME}-${ENV_NAME}-website-main-s3"
FAILOVER_BUCKET_NAME="${PROJECT_NAME}-${ENV_NAME}-website-failover-s3"

echo $MAIN_BUCKET_NAME
echo $FAILOVER_BUCKET_NAME

aws s3 sync . "s3://${MAIN_BUCKET_NAME}" --delete --profile $AWS_PROFILE
aws s3 sync . "s3://${FAILOVER_BUCKET_NAME}" --delete --profile $AWS_PROFILE

aws cloudfront create-invalidation --distribution-id $MAIN_DISTRIBUTION_ID --paths "/*" --profile $AWS_PROFILE
