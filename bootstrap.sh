#!/bin/bash
set -eu -o pipefail

BASEPATH="$(realpath $(dirname ${BASH_SOURCE[0]}))"
ENVFILE=${BASEPATH}/.env
source ${ENVFILE}

if [[ -z ${DOMAIN_NAME} || -z ${PASSWORD} || -z ${CF_Token} || -z ${CF_Account_ID} ]]; then
    echo "Please fillin all items in ${ENVFILE}" >&2
    exit 1
fi

if ! rpm -q docker-ce &>/dev/null; then
    # Fix CentOS 8 docker containerd.io version issue
    if grep 'release 8' /etc/centos-release &>/dev/null; then
         dnf install -y https://download.docker.com/linux/centos/7/x86_64/stable/Packages/containerd.io-1.2.6-3.3.el7.x86_64.rpm
    fi
    curl -L https://get.docker.com | bash
    systemctl enable docker
    systemctl start docker
fi

if ! which docker-compose &>/dev/null; then
    sudo curl -L "https://github.com/docker/compose/releases/download/1.26.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    chmod +x /usr/local/bin/docker-compose
fi

V2RAY_CONFIG=${BASEPATH}/v2ray-config.json
CADDY_FILE=${BASEPATH}/Caddyfile
COMPOSE_FILE=${BASEPATH}/docker-compose.yml
PROMETHEUS_CONFIG=${BASEPATH}/prometheus/prometheus.yml
GRAFANA_PROVISIONING_DIR=${BASEPATH}/grafana/provisioning
GRAFANA_DASHBOARD_DIR=${BASEPATH}/grafana/dashboards
if [[ -z ${V2RAY_UUID} ]]; then
    V2RAY_UUID=$(uuidgen)
fi
sed -ri "s@V2RAY_UUID=.*@V2RAY_UUID=${V2RAY_UUID}@g" ${ENVFILE}
sed -ri "s@CADDY_FILE=.*@CADDY_FILE=${CADDY_FILE}@g" ${ENVFILE}
sed -ri "s@V2RAY_CONFIG=.*@V2RAY_CONFIG=${V2RAY_CONFIG}@g" ${ENVFILE}
sed -ri "s@GRAFANA_PROVISIONING_DIR=.*@GRAFANA_PROVISIONING_DIR=${GRAFANA_PROVISIONING_DIR}@" ${ENVFILE}
sed -ri "s@GRAFANA_DASHBOARD_DIR=.*@GRAFANA_DASHBOARD_DIR=${GRAFANA_DASHBOARD_DIR}@" ${ENVFILE}
sed -ri "s@PROMETHEUS_CONFIG=.*@PROMETHEUS_CONFIG=${PROMETHEUS_CONFIG}@g" ${ENVFILE}

sed -ri "s@\\$\{DOMAIN_NAME}@${DOMAIN_NAME}@g" $CADDY_FILE
sed -ri "s@\\$\{V2RAY_UUID}@${V2RAY_UUID}@g" $V2RAY_CONFIG

cd $BASEPATH
docker-compose up -d
