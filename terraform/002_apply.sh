#!/bin/bash
set -e

if [ -z $1 ]; then
  echo "Environment parameter is required"
  exit 1
fi

CONFIG_PATH="./envs/$1.tfvars"

if test -f "$CONFIG_PATH"; then
  echo "Configuration file found"
else
  echo "Configuration file not found."
  exit 1
fi

PLAN_FILE="./.plans/$1.tfplan"

terraform apply "$PLAN_FILE"
