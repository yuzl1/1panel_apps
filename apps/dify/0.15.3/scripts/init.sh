#!/bin/bash

if [ -f .env ]; then
  source .env

  # setup-1 add default values
  CURRENT_DIR=$(pwd)
  sed -i '/^ENV_FILE=/d' .env
  sed -i '/^GLOBAL_ENV_FILE=/d' .env
  echo "ENV_FILE=${CURRENT_DIR}/.env" >> .env
  echo "GLOBAL_ENV_FILE=${CURRENT_DIR}/envs/global.env" >> .env
  echo "APP_ENV_FILE=${CURRENT_DIR}/envs/dify.env" >> .env

  # setup-2 update dir permissions
  mkdir -p "$DIFY_ROOT_PATH"

  cp -r conf/. "$DIFY_ROOT_PATH/"

  # setup-3 sync environment variables
  env_source="envs/dify.env"
  if [ -f "$env_source" ]; then
    while IFS='=' read -r key value; do
      if [[ -z "$key" || "$key" =~ ^# ]]; then
        continue
      fi
      if ! grep -q "^$key=" .env; then
        echo "$key=$value" >> .env
      fi
    done < "$env_source"
  fi

  echo "Check Finish."

else
  echo "Error: .env file not found."
fi
