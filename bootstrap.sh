#!/bin/bash
set -eu -o pipefail

BASEPATH="$(realpath $(dirname ${BASH_SOURCE[0]}))"
source ${BASEPATH}/config.ini

if [[ -z ${DOMAIN_NAME} || -z ${PASSWORD} || -z ${CF_Token} || -z ${CF_Account_ID} ]]; then
    echo "Please fillin all items in config.ini" &>2
    exit 1
fi

V2RAY_CONFIG=${BASEPATH}/v2ray-config.json
COMPOSE_FILE=${BASEPATH}/docker-compose.yml

sed -ri "s@\\$\{DOMAIN_NAME}@${DOMAIN_NAME}@g" $V2RAY_CONFIG

sed -ri "s@\\$\{V2RAY_CONFIG}@${V2RAY_CONFIG}@g" $COMPOSE_FILE
sed -ri "s@\\$\{PASSWORD}@${PASSWORD}@g" $COMPOSE_FILE
sed -ri "s@\\$\{DOMAIN_NAME}@${DOMAIN_NAME}@g" $COMPOSE_FILE
sed -ri "s@\\$\{CF_Token}@${CF_Token}@g" $COMPOSE_FILE
sed -ri "s@\\$\{CF_Account_ID}@${CF_Account_ID}@g" $COMPOSE_FILE

cd $BASEPATH
docker-compose up -d
