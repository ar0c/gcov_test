#!/bin/bash
IMAGE_NAME=${1:-gcov_test_temp:test}
docker build --build-arg GOC_SERVER_ADDR=$(hostname -I | awk '{print $1}'):8080 -t $IMAGE_NAME .
