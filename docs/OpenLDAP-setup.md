# OpenLDAP

- [Install using APT](#Install%20using%20APT)
- [Install using docker](#Install%20using%20docker)

## Environment

- ubuntu server 16.04

## Install using APT

以Ubuntu server为例

- using apt-get

```bash
sudo apt-get update
sudo apt-get install slapd ldap-utils
```

安装过程中会让输入管理员密码

- reconfigure  slapd

```bash
sudo dpkg-reconfigure slapd
```

- reconfigure questions:

  - Omit OpenLDAP server configuration? No
  - DNS domain name: ldapserver.com
  - Organization name: development
  - Administrator password? set the admin password
  - Database backend? MDB
  - Remove the database when slapd is purged? No
  - Move old database? Yes
  - Allow LDAPv2 protocol? No

- config firewall

```bash
sudo ufw allow ldap
```

- test connection

```bash
ldapwhoami -H ldap:// -x
# output
anonymous
```

### Install phpLDAPadmin web interface

- using apt-get

```bash
sudo apt-get install phpldapadmin
```

- set config file

```bash
sudo cp /etc/phpldapadmin/config.php /etc/phpldapadmin/config.php.backup

sudo vim /etc/phpldapadmin/config.php
```

根据LDAP server配置，修改以下两项默认配置

```bash
$servers->setValue('server','base',array('dc=ldapserver,dc=com'));

$servers->setValue('login','bind_id','cn=admin,dc=ldapserver,dc=com');
```

- login using browser

```bash
domain_name_or_IP_address/phpldapadmin
```

## Install using docker

- download images

```bash
docker pull osixia/openldap
docker pull osixia/phpldapadmin
```

- config data volumes

```bash
mkdir -p /data/ldap

cd /data/ldap
mkdir data config

# data: 数据目录
# config: 配置文件目录
```

- run openldap

--env LDAP_REPLICATION=true \

```bash
docker run --detach \
  --hostname ldap.example.org \
  --name ldap-service \
  -p 389:389 \
  -p 636:636 \
  -v /data/ldap/data:/var/lib/ldap \
  -v /data/ldap/config:/etc/ldap/slapd.d \
  --env LDAP_ORGANISATION="zhongyishanyuan"  \
  --env LDAP_DOMAIN="yiqishanyuan.com" \
  --env LDAP_ADMIN_PASSWORD="admin" \
  --env LDAP_BASE_DN="yiqishanyuan.com" \
  osixia/openldap:latest
```

- run phpldapadmin

```bash
docker run --detach \
  --hostname phpldapadmin.example.org \
  --name phpldapadmin-service \
  --link ldap-service:ldap-host \
  --env PHPLDAPADMIN_LDAP_HOSTS="#PYTHON2BASH:[{'ldap.example.org': [{'server': [{'port': 389}, {'base': \"array('dc=yiqishanyuan,dc=com')\"}]},
{'login': [{'bind_id': 'cn=admin,dc=yiqishanyuan,dc=com'}]}]}]" \
  -p 4431:443 \
  -p 8001:80 \
  osixia/phpldapadmin:latest
```

```bash
docker run --detach \
  --hostname phpldapadmin.example.org \
  --name phpldapadmin-service \
  --link ldap-service:ldap-host \
  --env PHPLDAPADMIN_LDAP_HOSTS="#PYTHON2BASH:[{'ldap.example.org': [{'server': [{'tls': True}]},{'login': [{'bind_id': 'cn=admin,dc=yiqishanyuan,dc=com'}]}]}]" \
  -p 4431:443 \
  -p 8001:80 \
  osixia/phpldapadmin:latest
```

```shell
--env PHPLDAPADMIN_LDAP_HOSTS="#PYTHON2BASH:[{'ldap.example.org': [{'server': [{'tls': True}]},{'login': [{'bind_id': 'cn=${ADMIN_PASSWORD},${CNNAME},dc=${DC}'}]}]},]" \
```

```shell
docker run --name ldap-service --hostname ldap-service --detach osixia/openldap:latest
docker run --name phpldapadmin-service --hostname phpldapadmin-service --link ldap-service:ldap-host --env PHPLDAPADMIN_LDAP_HOSTS=ldap-host --detach osixia/phpldapadmin:latest

```

## Glossary

- slapd

slapd is an LDAP directory server that runs on many different platforms.  
You can use it to provide a directory service of your very own.  
Your directory can contain pretty much anything you want to put in it.  
You can connect it to the global LDAP directory service, or run a service all by yourself.

## Reference

- [OpenLDAP intro](http://www.openldap.org/doc/admin24/intro.html)

- [install openldap in ubuntu(1)](https://www.digitalocean.com/community/tutorials/how-to-install-and-configure-openldap-and-phpldapadmin-on-ubuntu-16-04)

- [install openldap in ubuntu(2)](https://www.digitalocean.com/community/tutorials/how-to-install-and-configure-a-basic-ldap-server-on-an-ubuntu-12-04-vps)

- [docker openldap](https://github.com/osixia/docker-openldap)
