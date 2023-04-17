#!/bin/bash

set -e

echo "Using Docker version: $docker_version"

docker build --build-arg DOCKER_VERSION=$docker_version -t writerside-builder:$docker_version .
/opt/builder/bin/idea.sh helpbuilderinspect -source-dir . -product $PRODUCT --runner github -output-dir artifacts/ || true
echo "Test existence of $ARTIFACT artifact"
test -e artifacts/$ARTIFACT

