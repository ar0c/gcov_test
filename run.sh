#!/bin/bash
IMAGE_NAME="gcov_test_repo:test"
if [ -z "$(docker images -q $IMAGE_NAME 2> /dev/null)" ]; then
    ./build.sh $IMAGE_NAME
fi
docker rm -f gcov_test 2>/dev/null || true && docker run -d -e ECHO_APP_ID=gcov_test --rm --name gcov_test --hostname ar0c/gcov_test-default $IMAGE_NAME /go/bin/main