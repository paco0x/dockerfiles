From golang:alpine

MAINTAINER Penghui Liao

ARG V2RAY_DIR=/opt/v2ray-plugin
ARG SHADOWSOCKS_DIR=/opt/shadowsocks

# Build v2ray-plugin
RUN set -ex \
    && apk add --no-cache git \
    && git clone https://github.com/shadowsocks/v2ray-plugin.git $V2RAY_DIR \
    && cd $V2RAY_DIR \
    && git checkout $(git describe --abbrev=0 --tags) \
    && go build -o /usr/bin/v2ray-plugin \
    && rm -rf /opt/v2ray-plugin

RUN set -ex \
    # Build environment setup
    && apk add --no-cache --virtual .build-deps \
        autoconf \
        automake \
        build-base \
        c-ares-dev \
        libev-dev \
        libtool \
        libsodium-dev \
        linux-headers \
        mbedtls-dev \
        pcre-dev \
    # Build & install
    && git clone https://github.com/shadowsocks/shadowsocks-libev.git $SHADOWSOCKS_DIR \
    && cd $SHADOWSOCKS_DIR \
    && git checkout $(git describe --abbrev=0 --tags) \
    && git submodule update --init --recursive \
    && ./autogen.sh \
    && ./configure --prefix=/usr --disable-documentation \
    && make install \
    && apk del .build-deps \
    # Runtime dependencies setup
    && apk add --no-cache \
        rng-tools \
        $(scanelf --needed --nobanner /usr/bin/ss-* \
        | awk '{ gsub(/,/, "\nso:", $2); print "so:" $2 }' \
        | sort -u) \
    && rm -rf $SHADOWSOCKS_DIR

ENV SERVER_ADDR 0.0.0.0
ENV SERVER_PORT 8388
ENV PASSWORD ChangeMe!!!
ENV METHOD chacha20-ietf-poly1305
ENV TIMEOUT 86400
ENV DNS_ADDRS 1.1.1.1,1.0.0.1
ENV ARGS -u

EXPOSE $SERVER_PORT/tcp $SERVER_PORT/udp

# Start shadowsocks-libev server
CMD ss-server \
    -s $SERVER_ADDR \
    -p $SERVER_PORT \
    -k $PASSWORD \
    -m $METHOD \
    -t $TIMEOUT \
    -d $DNS_ADDRS \
    --reuse-port \
    --no-delay \
    $ARGS
