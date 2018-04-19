# Redis Setup

- install using download package

## install using download package

- 准备编译工具

```bash
apt-get update
apt-get install build-essential tcl
```

- 下载安装包

下载地址：<https://redis.io/download>

- 编译安装

```bash
tar -zxvf redis-4.0.9.tar.gz
cd redis-4.0.9
```

```bash
make
make test
make install
```

- 配置 Redis

```bash
mkdir /etc/redis
cp redis.conf /etc/redis
```

```bash
vim /etc/redis/redis.conf
```

修改如下配置

```bash
supervised systemd

# 工作目录
dir /var/lib/redis


```

- Create a Redis systemd Unit File

```bash
vim /etc/systemd/system/redis.service
```

添加以下内容

```bash
[Unit]
Description=Redis In-Memory Data Store
After=network.target

[Service]
User=redis
Group=redis
ExecStart=/usr/local/bin/redis-server /etc/redis/redis.conf
ExecStop=/usr/local/bin/redis-cli shutdown
Restart=always

[Install]
WantedBy=multi-user.target
```

- 创建 Redis User, Group and Directories

```bash
# 创建用户
adduser --system --group --no-create-home redis

# 创建工作目录
mkdir /var/lib/redis

chown redis:redis /var/lib/redis

chmod 770 /var/lib/redis
```

- 启动 Redis

```bash
systemctl start redis
systemctl status redis

# OR
service redis start
service redis status
```

- 测试redis安装

```bash
redis-cli

127.0.0.1:6379> ping
#output
PONG
```

## 设置密码

- 直接在配置文件中修改 ```requirepass```

- 通过命令行

```bash
config set requirepass 123456

auth 123456
```

## 设置远程访问

修改配置文件

```bash
# 注释掉bind=127.0.0.1
# 或者 配置
bind=0.0.0.0

# 设置密码requirepass，如
requirepass=123456
```

## Reference

- <https://www.digitalocean.com/community/tutorials/how-to-install-and-configure-redis-on-ubuntu-16-04>
