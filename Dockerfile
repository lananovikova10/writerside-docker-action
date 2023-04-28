ARG DOCKER_VERSION=2.1.1279-p3399
FROM registry.jetbrains.team/p/writerside/builder/writerside-builder:${DOCKER_VERSION}

RUN apt-get update && apt-get install -y docker.io

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]

