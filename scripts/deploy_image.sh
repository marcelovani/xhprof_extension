#!/bin/sh

# Load variables from .env file.
export $(echo $(cat ../.env | sed 's/#.*//g'| xargs) | envsubst)

echo "\033[0m"
echo "\033[1;33m[INFO] Deploying ${NAMESPACE}/${COMPOSE_PROJECT_NAME}" \
  && docker push ${NAMESPACE}/${COMPOSE_PROJECT_NAME}
