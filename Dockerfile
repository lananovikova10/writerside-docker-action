ARG DOCKER_VERSION=${docker-version}
FROM registry.jetbrains.team/p/writerside/builder/writerside-builder:${DOCKER_VERSION}

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]

