### Run shadowsocks-libev with v2ray-plugin behind cloudflare

You can use this repo to run shadowsocks-libev with v2ray-plugin or v2ray behind cloudflare, and all services are running in docker container(including acme.sh cronjob).

You can use acme.sh to update your SSL Certs

1. Clone the project

2. Install docker-compose and docker

3. Config your DNS records of your VPS on cloudflare and setup the cloudflare API token

Cloudflare API token needs read access to Zone.Zone, and write access to Zone.DNS, across all Zones.

4. Fillin the password, domain name, cf token and cf account ID in config.ini

5. Run bootstrap.sh script, this will start up the docker containers.
```
$ ./bootstrap.sh
```

6. Generate acme certs for the first time

Run acme.sh in docker to generate certs in shared docker volume:

```
$ docker exec -it acme-cron sh --login
# acme.sh --log --issue --dns dns_cf -d ${DOMAIN_NAME}
```

After that, your certs ared generated in the docker volume. Check shadowsocks-libev container status, it should be OK after this step.

More info please refer to: [acme.sh](https://github.com/Neilpang/acme.sh)


### Run parity with SSL enabled
```
$ cd parity
```

Replace hostname, port and password in docker-compose.yml

```
$ docker-compose up -d
```
