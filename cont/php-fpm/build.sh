#!/usr/bin/env bash

docker buildx build --push \
                --tag ${IMAGE_ID}/${IMAGE_NAME}:${VERSION} \
                --platform linux/amd64,linux/arm/v7,linux/arm64 .