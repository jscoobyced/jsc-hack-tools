FROM debian:buster-slim

ENV DEBIAN_FRONTEND=noninteractive

LABEL maintainer="JscDroidDev"

RUN apt-get update \
    && apt-get install apt-utils locales -y \
    && apt-get upgrade -y \
    && apt-get autoremove --purge -y

RUN sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen \
    && locale-gen
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8
