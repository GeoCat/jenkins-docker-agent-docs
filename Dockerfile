FROM jenkins/inbound-agent:latest

LABEL org.opencontainers.image.authors="Juan Luis Rodriguez <juanluisrp@geocat.net>"

USER root
RUN apt-get update && apt-get install -y \
        curl \
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

ENV PIP_BREAK_SYSTEM_PACKAGES 1
RUN curl -o- https://raw.githubusercontent.com/transifex/cli/master/install.sh | bash \
  && mv tx /usr/local/bin \
  && chmod +x /usr/local/bin/tx \
  && pip3 install --no-cache-dir --requirement /tmp/requirements.txt \
  && python3 -m venv /root/environments/py3 \
  && cat /root/environments/py3/bin/activate \
  && . /root/environments/py3/bin/activate \
  && python3 -m pip install -U pip \
  && pip install --no-cache-dir  --requirement /tmp/requirements.txt

RUN mkdir /workspace \
  && chown jenkins:jenkins /workspace

USER jenkins
RUN  python3 -m venv "${HOME}/environments/py3" \
  && pip3 install --no-cache-dir  --requirement /tmp/requirements.txt \
  && python3 -m venv environments/py3 \
  && . "${HOME}/environments/py3/bin/activate" \
  && python3 -m pip install -U pip \
  && pip install --no-cache-dir --requirement /tmp/requirements.txt
