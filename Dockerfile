FROM debian:buster-slim
MAINTAINER Percona Development <info@percona.com>

RUN apt-get update && apt-get install -y --no-install-recommends \
                gnupg2 \
                dirmngr \
                apt-transport-https ca-certificates \
                pwgen \
                lsb-release \
                wget \
        && rm -rf /var/lib/apt/lists/*

RUN wget https://repo.percona.com/apt/percona-release_latest.generic_all.deb \
      && dpkg -i percona-release_latest.generic_all.deb \
      && percona-release enable tools release

# Uncomment to list package versions
# RUN apt-get update && apt-cache madison percona-toolkit

ENV PERCONA_VERSION 3.2.0-1.buster

RUN  apt-get update \
        && apt-get install -y percona-toolkit=${PERCONA_VERSION} \
        && rm -rf /var/lib/apt/lists/* 

WORKDIR /
