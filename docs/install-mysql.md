# Install MySQL on Ubuntu

- [Install using APT](#install-using-apt)
- [Install using docker](#install-using-docker)

## Prerequisites

- Ubuntu Server 16.04

## Install using APT

- installing

```bash
sudo apt-get update
sudo apt-get install mysql-server
```

- check status

```bash
sudo service mysql status

sudo service mysql stop

sudo service mysql start
```

- Directory Structure

```txt
/var/lib/mysql/ 数据目录
/etc/mysql/  配置目录
```

- uninstalling

```bash
sudo apt-get remove mysql-server-*
```

## Install using docker

- 创建mysql配置文件

```bash
vim /data/mysql/config/my.cnf
```

填下一下内容

```bash
[mysqld]
user=mysql
```

- 运行docker container

```bash
docker run --name mysql \
    -p 3306:3306 \
    --volume /data/mysql/config/my.cnf:/etc/my.cnf \
    --volume /data/mysql/data:/var/lib/mysql \
    --env MYSQL_ROOT_PASSWORD=123456 \
    --restart always \
    -d mysql/mysql-server:latest
```

## Configuration

- 配置字符集

```plaintext
[mysqld]
character_set_server=utf8
```

查看mysql字符集

```bash
show variables like 'char%';
```

## Reference

- [install mysql on ubuntu 16.04](https://www.digitalocean.com/community/tutorials/how-to-install-mysql-on-ubuntu-16-04)

- [mysql-apt-repo-quick-guide](https://dev.mysql.com/doc/mysql-apt-repo-quick-guide/en/)

- [install mysql using docker](https://dev.mysql.com/doc/refman/5.7/en/docker-mysql-more-topics.html)

- [mysql server-configuration](https://dev.mysql.com/doc/refman/5.7/en/mysqld-option-tables.html)
