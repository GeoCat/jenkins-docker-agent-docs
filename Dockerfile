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
        python3-venv \
    && rm -rf /var/lib/apt/lists/*

RUN python3 -m pip install -U pip
RUN python3 -m pip install Sphinx==3.2.1 Pillow python-levenshtein
RUN python3 -m pip install recommonmark
RUN mkdir environments \
    && python3 -m venv environments/py3

USER ${user}

