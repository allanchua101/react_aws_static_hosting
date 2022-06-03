#!/bin/bash
set -e

if [ -z $1 ]; then
  echo "Environment parameter is required"
  exit 1
fi

CONFIG_PATH="./envs/${1}.tfvars"

if test -f "$CONFIG_PATH"; then
  echo "Using config file: $CONFIG_PATH"
else
  echo "Config file not found: $CONFIG_PATH"
  exit 1
fi

ENV_CODE="$1"
WORKSPACE_NAME="movies-$1-workspace"
PLAN_FILE="./.plans/$1.tfplan"
PLAN_DIR="./.plans"

if test -d "$PLAN_DIR"; then
  echo "Using plan directory: $PLAN_DIR"
else
  echo "Plan directory not found: $PLAN_DIR"
  mkdir "$PLAN_DIR"
fi

terraform init -backend=false

terraform validate

terraform fmt .

terraform init

terraform workspace new $WORKSPACE_NAME || true
terraform workspace select $WORKSPACE_NAME

terraform plan -out=$PLAN_FILE -var-file="./envs/${1}.tfvars"

echo "Plan saved to $PLAN_FILE"
