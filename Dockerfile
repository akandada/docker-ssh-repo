##
FROM alpine:3.5
ENV BASE_PACKAGES="\
  dumb-init \
  musl \
  linux-headers \
  build-base \
  bash \
  git \
  py2-cryptography \
  ca-certificates \
  python2 \
  python2-dev \
  py-setuptools \
  postgresql-client \
  postgresql-dev \
  py-lxml \
  libffi-dev \
  py-pillow \
  nginx \
  tiff \
  giflib \
  libjpeg-turbo \
  libpng \
  zlib \
  ghostscript \
  openssh-client"

RUN echo \
    # Add the packages, with a CDN-breakage fallback if needed
    && apk add --no-cache \
      $BASE_PACKAGES \
    # make some useful symlinks that are expected to exist
    && if [[ ! -e /usr/bin/python ]];        then ln -sf /usr/bin/python2.7 /usr/bin/python; fi \
    && if [[ ! -e /usr/bin/python-config ]]; then ln -sf /usr/bin/python2.7-config /usr/bin/python-config; fi \
    && if [[ ! -e /usr/bin/easy_install ]];  then ln -sf /usr/bin/easy_install-2.7 /usr/bin/easy_install; fi \

    # Install and upgrade Pip
    && easy_install pip \
    && pip install pip==9.0.3 \
    && if [[ ! -e /usr/bin/pip ]]; then ln -sf /usr/bin/pip2.7 /usr/bin/pip; fi \
    && echo

RUN mkdir -p /key

ENV HOMEDIR=/code \
    LANG=en_US.UTF-8 \
    LC_ALL=en_US.UTF-8 \
    PYTHONUNBUFFERED=1

WORKDIR $HOMEDIR

# Copying this file over so we can install requirements.txt in one cache-able layer
COPY requirements.txt $HOMEDIR/


ADD id_rsa /tmp/id_rsa
RUN cat /tmp/id_rsa
RUN eval "$(ssh-agent -s)" && \
    chmod 700 /tmp/id_rsa && \
    ssh-add /tmp/id_rsa && \
    ssh -o StrictHostKeyChecking=no git@github.com || true && \
    pip install pip==9.0.3 && \
    pip install -r $HOMEDIR/requirements.txt && \
    rm /tmp/id_rsa && \
    rm -rf ~/.ssh/*
