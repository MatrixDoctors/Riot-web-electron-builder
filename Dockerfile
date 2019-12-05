FROM node:buster

MAINTAINER Mathijs van Gorcum <mathijs@vgorcum.com>

ENTRYPOINT ["/start.sh"]
VOLUME ["/data"]

ARG REBUILD=1

COPY start.sh /start.sh

RUN dpkg --add-architecture i386 \
    && apt-get update \
    && apt-get install -y wine \
    && apt-get install -y mono-devel \
    && apt-get install -y jq \
    && rm -rf /var/lib/apt/* /var/cache/apt/*
