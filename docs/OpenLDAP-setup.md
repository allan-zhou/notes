# OpenLDAP

## Install LDAP server

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

## Install phpLDAPadmin web interface

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

## Reference

- [OpenLDAP intro](http://www.openldap.org/doc/admin24/intro.html)

- [install openldap in ubuntu(1)](https://www.digitalocean.com/community/tutorials/how-to-install-and-configure-openldap-and-phpldapadmin-on-ubuntu-16-04)

- [install openldap in ubuntu(2)](https://www.digitalocean.com/community/tutorials/how-to-install-and-configure-a-basic-ldap-server-on-an-ubuntu-12-04-vps)