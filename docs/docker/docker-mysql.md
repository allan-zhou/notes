# docker mysql

```bash
# 下载镜像
docker pull mysql:8.0

# 启动
docker run --name mysql -v //e/docker_v/mysql/data:/var/lib/mysql -p 3306:3306 -e MYSQL_ROOT_PASSWORD=123456 -d mysql:8.0

# 进入容器
docker exec -it mysql bash

# 修改密码加密规则
#mysql8 之前的版本中加密规则是mysql_native_password，而在mysql8之后，加密规则是caching_sha2_password，
ALTER USER 'root'@'%' IDENTIFIED WITH mysql_native_password BY '123456';

# 登录mysql
mysql -uroot -p123456

# 创建远程登录用户

```

