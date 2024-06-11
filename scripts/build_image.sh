#!/bin/sh
# Builds the Docker image

# Load variables from .env file.
export $(echo $(cat ../.env | sed 's/#.*//g'| xargs) | envsubst)

# Clean up folders.
rm -rf extension
if [ -f /tmp/xhprof ]; then
  rm -rf /tmp/xhprof;
fi

# Clone the xhprof repository and copy the extensions folder
git clone https://github.com/longxinH/xhprof.git /tmp/xhprof
cp -a /tmp/xhprof/extension extension

echo "\033[1;104m"
echo "\033[1;33m[INFO] Build ${NAMESPACE}/${COMPOSE_PROJECT_NAME}:php${PHP_VERSION}" \
  && docker build --force-rm -t ${NAMESPACE}/${COMPOSE_PROJECT_NAME}:php${PHP_VERSION} . \
                  --build-arg PHP_VERSION=${PHP_VERSION}
echo Please remember to commit any changes in the extension folder
git --no-pager diff

echo "To use the image, run: docker run -d -it --rm --name ${COMPOSE_PROJECT_NAME}_php${PHP_VERSION} ${NAMESPACE}/${COMPOSE_PROJECT_NAME}:php${PHP_VERSION}"
echo "\033[0m"
