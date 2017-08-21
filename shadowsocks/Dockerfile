From alpine

MAINTAINER Penghui Liao

RUN apk add --update \
    python \
    py-pip \
    git \
  && pip install git+https://github.com/shadowsocks/shadowsocks.git@master \
  && rm -rf /var/cache/apk/*

ENV PASSWORD password
ENV METHOD aes-256-cfb

EXPOSE 1080

CMD ssserver -p 1080 -k $PASSWORD -m $METHOD --user nobody
