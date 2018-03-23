docker默认镜像源被墙了，这样操作改用阿里镜像。

1.新建文件：vim  /etc/docker/daemon.json
2.内容：
{
 "registry-mirrors": ["https://uxk0ognt.mirror.aliyuncs.com"]
}
{ 
"registry-mirrors": ["https://registry.docker-cn.com"] 
}
3.保存内容
sudo  systemctl daemon-reload
sudo systemctl restart docker