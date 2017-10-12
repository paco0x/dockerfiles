FROM golang:alpine

MAINTAINER Penghui Liao

RUN apk update && \
    apk upgrade && \
    apk add git
RUN go get -ldflags "-X main.VERSION=$(date -u +%Y%m%d) -s -w" github.com/xtaci/kcptun/client && go get -ldflags "-X main.VERSION=$(date -u +%Y%m%d) -s -w" github.com/xtaci/kcptun/server

ENV PASSWORD password
ENV TARGET 127.0.0.1:1080
ENV MODE fast2
ENV CRYPT aes-128

EXPOSE 1080/udp

CMD /go/bin/server -t $TARGET -l :1080 --mode $MODE --key $PASSWORD --crypt $CRYPT
