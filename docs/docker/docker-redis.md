# docker redis

```bash
# 下载镜像
docker pull redis
#docker pull redis:6

# 启动
docker run -d -p 6379:6379 --name redis -v //e/docker_v/redis/conf/redis.conf:/etc/redis/redis.conf -v //e/docker_v/redis/data:/data redis redis-server /etc/redis/redis.conf --appendonly yes


docker run -d -p 6370:6379 --name redis_6370 -v //e/docker_v/redis_6370/conf/redis.conf:/etc/redis/redis.conf redis redis-server /etc/redis/redis.conf

# 如果没有 myredis 说明启动失败 查看错误日志
docker logs redis
# 查看 myredis 的 ip 挂载 端口映射等信息
docker inspect redis
# 查看 myredis 的端口映射
docker port redis

# 进入容器,使用shell
docker exec -it redis redis-cli

```
## run 命令参数
-d：表示后台运行，不加-d执行上面的命令你就会看到redis启动的日志信息了
-p：表示端口映射，冒号左面的是我们的宿主机的端口，也就是我们虚拟机的端口，而右侧则表示的是mysql容器内的端口
--name：是我们给redis容器取的名字
-v：表示挂载路径，$PWD表示当前目录下，冒号左面的表示我们宿主机的挂载目录，也就是我们虚拟机所在的文件路径，冒号右边则表是的是redis容器在容器内部的路径，上面的命令我分别挂载了redis.conf(redis的配置文件)，如需使用配置文件的方式启动redis，这里则需要加上，还有redis存放数据所在的目录
--appendonly yes：表示redis开启持久化策略


# redis.conf download
https://redis.io/topics/config
