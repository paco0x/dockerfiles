From alpine:latest

MAINTAINER Penghui Liao

ARG SOURCE_DIR=/opt/acme.sh
ARG HOME_DIR=/acme
ARG DATA_DIR=/acme/data

WORKDIR $HOME_DIR

ENV ENV=/etc/.profile

RUN set -ex \
    && apk --no-cache add -f \
        git \
        openssl \
        socat \
        coreutils \
        bind-tools \
        curl \
        tzdata \
        oath-toolkit-oathtool \
    && git clone https://github.com/Neilpang/acme.sh.git $SOURCE_DIR \
    && cd $SOURCE_DIR \
    && git checkout $(git describe --abbrev=0 --tags) \
    && mkdir -p $DATA_DIR \
    && ./acme.sh --install --home $HOME_DIR --config-home $DATA_DIR --cert-home $DATA_DIR \
    && cp $HOME_DIR/acme.sh.env $ENV \
    && rm -rf /var/cache/apk/* \
    && crontab -l | grep acme.sh | sed 's#> /dev/null##' | crontab -

CMD ["crond", "-f"]
