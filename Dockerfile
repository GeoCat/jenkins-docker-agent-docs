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

COPY requirements.txt /tmp/requirements.txt

RUN pip3 install -r /tmp/requirements.txt \
  && python3 -m venv /root/environments/py3 \
  && cat /root/environments/py3/bin/activate \
  && . /root/environments/py3/bin/activate \
  && python3 -m pip install -U pip \
  && pip install -r /tmp/requirements.txt

RUN mkdir /workspace
RUN chown jenkins:jenkins /workspace

USER jenkins
RUN  python3 -m venv ${HOME}/environments/py3 \
  && pip3 install -r /tmp/requirements.txt \
  && python3 -m venv environments/py3 \
  && . ${HOME}/environments/py3/bin/activate \
  && python3 -m pip install -U pip \
  && pip install -r /tmp/requirements.txt






