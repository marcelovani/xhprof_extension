#!make
include .env
export $(shell sed 's/=.*//' .env)

build:
	@make build-image

build-image:
	sh scripts/build_image.sh

deploy-image:
	sh scripts/deploy_image.sh

build-deploy-image:
	make build-image
	make deploy-image
