### Run shadowsocks
```
$ docker pull liaoishere/shadowsocks
$ docker run --restart unless-stopped -e "PASSWORD=pass" --name shadowsocks -p 1080:1080 -d liaoishere/shadowsocks
```

### Run parity with SSL enabled
```
$ cd parity
```

Replace hostname, port and password in docker-compose.yml

```
$ docker-compose up -d
```
