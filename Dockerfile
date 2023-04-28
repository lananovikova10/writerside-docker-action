ARG DOCKER_VERSION=2.1.1279-p3399
FROM registry.jetbrains.team/p/writerside/builder/writerside-builder:${DOCKER_VERSION}

RUN apk add --no-cache \
    curl \
    gnupg \
    tar \
    xz \
    && apk add --no-cache --virtual .build-deps \
    ca-certificates

RUN curl -fsSL https://download.docker.com/linux/static/stable/x86_64/docker-20.10.8.tgz | tar xzvf - --strip 1 -C /usr/local/bin docker/docker

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]




