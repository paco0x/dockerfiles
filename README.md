### Run shadowsocks-libev with v2ray-plugin

1. Clone the project

2. Install docker-compose and docker

3. Config your DNS records of your VPS(cloudflare is recommended)

4. Generate certs using acme.sh

Please refer to: [acme.sh](https://github.com/Neilpang/acme.sh)

5. Replace the password and domain names in docker-compose.yml

6. Run compose
```
$ docker-compose up -d
```

### Run parity with SSL enabled
```
$ cd parity
```

Replace hostname, port and password in docker-compose.yml

```
$ docker-compose up -d
```
