### Run shadowsocks with kcptun
1. clone the project

2. install docker-compose
```
$ sudo curl -L https://github.com/docker/compose/releases/download/1.16.1/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
```

3. replace the password in docker-compose.yml

4. run compose
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
