FROM jenkins/inbound-agent:latest

LABEL MAINTAINER="Juan Luis Rodriguez <juanluisrp@geocat.net>"

USER root
RUN apt-get update && apt-get install -y \
        git \
        graphviz \
        imagemagick \
        make \
        python3 \
        python3-pip \
    && rm -rf /var/lib/apt/lists/*

RUN python3 -m pip install -U pip
RUN python3 -m pip install Sphinx==3.0.1 Pillow

USER ${user}
