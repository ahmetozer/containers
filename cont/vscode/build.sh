#!/usr/bin/env bash

docker buildx build --push \
                --tag ${IMAGE_ID}/${IMAGE_NAME}:${VERSION} \
                --tag ${IMAGE_ID}/${IMAGE_NAME}:${COMMIT_SHA} \
                --platform linux/amd64 .