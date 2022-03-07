#!/usr/bin/env bash

echo "Build container images"
echo IMAGE_ID=$IMAGE_ID
echo VERSION=$VERSION

SHARE_BIN=$(realpath $0)
SHARE_DIR=$(dirname $SHARE_BIN)
echo SHARE_DIR=$SHARE_DIR
cd $SHARE_DIR/../
WORK_DIR=$PWD

[ "$VERSION" == "master" ] && VERSION=latest
for d in cont/*; do
    if [[ ! -L "${d%/}" ]]; then
        export IMAGE_NAME=$(basename $d)
        echo "${IMAGE_ID}/${IMAGE_NAME}"
        cd $d
        if [ -f "build.sh" ]; then
            echo "custom build.sh will be used"
            chmod +x build.sh
            ./build.sh
        else
            echo "generic build.sh will be used"
            docker buildx build --push \
                --tag ${IMAGE_ID}/${IMAGE_NAME}:${VERSION} \
                --platform linux/amd64,linux/arm/v7,linux/arm64 .
        fi
        unset IMAGE_NAME
        cd $WORK_DIR
    else
        echo "symlinks are excluded: $d"
    fi
done
