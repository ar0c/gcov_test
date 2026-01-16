#!/bin/bash
if [ -z "$(docker images -q gcov_test_temp:test 2> /dev/null)" ]; then
docker build --build-arg GOC_SERVER_ADDR=$(hostname -I | awk '{print $1}'):8080 -t gcov_test_temp:test .
fi
docker rm -f gcov_test 2>/dev/null || true && docker run -d -e ECHO_APP_ID=gcov_test --rm --name gcov_test --hostname gcov_test-default gcov_test_temp:test /go/bin/main