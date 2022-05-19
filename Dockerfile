FROM jenkins/inbound-agent:latest

LABEL MAINTAINER="Juan Luis Rodriguez <juanluisrp@geocat.net>"

USER root
RUN apt-get update && apt-get install -y \
        git \
        ant \
        graphviz \
        imagemagick \
        python3 \
        python3-pip \
        python3-venv \
        python3-dev \
        zlib1g \
        zlib1g-dev \
        build-essential \
    && rm -rf /var/lib/apt/lists/*

RUN python3 -m pip install -U pip \
  && python3 -m pip install Sphinx==3.5.4 Pillow python-levenshtein \
  && python3 -m pip install recommonmark \
  && python3 -m pip install sphinx-copybutton \
  && mkdir -p /root/environments \
  && python3 -m venv /root/environments/py3

RUN mkdir /workspace
RUN chown jenkins:jenkins /workspace

USER jenkins
RUN python3 -m pip install -U pip \
  && python3 -m pip install Sphinx==3.5.4 Pillow python-levenshtein \
  &&  python3 -m pip install recommonmark \
  && python3 -m pip install sphinx-copybutton \
  && mkdir -p /home/jenkins/environments \
  && python3 -m venv environments/py3






