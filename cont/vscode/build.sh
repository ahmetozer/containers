#!/usr/bin/env bash

docker buildx build --push \
                --tag ${IMAGE_ID}:${IMAGE_NAME} \
                --platform linux/amd64 .