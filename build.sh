#!/bin/bash
IMAGE_NAME=${1:-gcov_test_temp}
docker build --build-arg GOC_SERVER_ADDR=$(hostname -I | awk '{print $1}'):8080 --progress=plain -t $IMAGE_NAME .
