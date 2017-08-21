### Run shadowsocks
```
$ docker pull liaoishere/shadowsocks
$ docker run --restart unless-stopped -e "PASSWORD=pass" --name shadowsocks -p 1080:1080 -d liaoishere/shadowsocks
```
