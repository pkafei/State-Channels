FROM frolvlad/alpine-gcc

MAINTAINER Portia Burton

# Install git
RUN apk add git

# Update the Alpine SDKs and all of the C dependencies
RUN apk add --update alpine-sdk
RUN apk add --no-cache openssl-dev libffi-dev
RUN apk add gmp-dev

# Add the Python dependencies
RUN apk add --no-cache python3 && \
    python3 -m ensurepip && \
    rm -r /usr/lib/python*/ensurepip && \
    pip3 install --upgrade pip setuptools && \
    if [ ! -e /usr/bin/pip ]; then ln -s pip3 /usr/bin/pip ; fi && \
    if [[ ! -e /usr/bin/python ]]; then ln -sf /usr/bin/python3 /usr/bin/python; fi && \
    rm -r /root/.cache && \
    pip install virtualenv

RUN apk add python3-dev

RUN git clone https://github.com/pkafei/State-Channels

# Install Virtual Environment
RUN virtualenv -p python3 env
