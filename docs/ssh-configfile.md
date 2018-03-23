# ssh的用户配置文件config管理ssh会话

```bash
vim ~/.ssh/config
```

```vim
Host userver1
    HostName 192.168.1.20
    User root
    Port 22
    IdentityFile ~/.ssh/id_rsa_userver1
```

```vim
Host 别名
    Hostname 主机名
    Port 端口
    User 用户名
```

## Reference

- <http://daemon369.github.io/ssh/2015/03/21/using-ssh-config-file>

192.168.1.205  chainserver01
192.168.1.209  chainserver02
192.168.1.42   chainserver03
192.168.1.25   chainserver04
192.168.1.185  chainserver05
192.168.1.182  chainserver06
192.168.1.244  chainserver07
