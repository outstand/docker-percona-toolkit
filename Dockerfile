FROM debian:bullseye-slim

SHELL ["/bin/bash", "-o", "pipefail", "-c"]
ENV DEBIAN_FRONTEND=noninteractive

RUN set -eux; \
      \
      apt-get update -y; \
      apt-get install -y \
        gnupg2 \
        dirmngr \
        apt-transport-https \
        ca-certificates \
        pwgen \
        lsb-release \
        wget \
        curl \
      ; \
      apt-get clean; \
      rm -f /var/lib/apt/lists/*_*

ARG PERCONA_VERSION=3.5.0-5.bullseye

RUN set -eux; \
      \
      wget https://repo.percona.com/apt/percona-release_latest.generic_all.deb; \
      dpkg -i percona-release_latest.generic_all.deb; \
      percona-release enable tools release

# Uncomment to list package versions
# RUN apt-get update && apt-cache madison percona-toolkit

ENV PERCONA_VERSION=${PERCONA_VERSION}

RUN  apt-get update \
        && apt-get install -y percona-toolkit=${PERCONA_VERSION} \
        && rm -rf /var/lib/apt/lists/*

WORKDIR /
