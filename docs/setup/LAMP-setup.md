# Install LAMP on ubuntu

LAMP(Linux OS + Apache web server + MySQL database + PHP)

## Install Apache and Allow in Firewall

### Install Apache

```bash
sudo apt-get update
sudo apt-get install apache2
```

- update apache config

```bash
sudo cp /etc/apache2/apache2.conf /etc/apache2/apache2.conf.backup
sudo vim /etc/apache2/apache2.conf
```

在配置文件底部添加以下内容，并保存

```bash
ServerName server_domain_or_IP
```

- check config

```bash
apache2ctl configtest
```

```bash
Syntax OK
```

- restart apache to implement  changes

```bash
sudo systemctl restart apache2
```

### Adjust the Firewall

```bash
sudo ufw app list
```

```bash
sudo ufw app info "Apache Full"
```

```bash
sudo ufw allow in "Apache Full"
```

## Install MySQL

```bash
sudo apt-get install mysql-server
```

```bash
sudo mysql_secure_installation
```

## Install PHP

```bash
sudo apt-get install php libapache2-mod-php php-mcrypt php-mysql
```

- move the PHP index file above to the first position

```bash
sudo vim /etc/apache2/mods-enabled/dir.conf
```

```php
<IfModule mod_dir.c>
    DirectoryIndex index.php index.html index.cgi index.pl index.xhtml index.htm
</IfModule>
```

- restart the Apache web server in order for our changes to be recognized.

```bash
sudo systemctl restart apache2

#check on the status of the apache2 service
sudo systemctl status apache2
```

- Test PHP Processing

在web根目录下添加如下info.php文件

```bash
sudo vim /var/www/html/info.php
```

```php
<?php
phpinfo();
?>
```

在客户端浏览器中输入以下地址进行测试

```plain text
http://your_server_IP_address/info.php
```

## Reference

- [install LAMP on ubuntu](https://www.digitalocean.com/community/tutorials/how-to-install-linux-apache-mysql-php-lamp-stack-on-ubuntu-16-04)
