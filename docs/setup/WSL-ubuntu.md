# win10下安装ubuntu备忘

## 使用xshell连接ubuntu

备份配置文件

```bash
cd /etc/ssh
#备份
sudo cp sshd_config sshd_config.backup
sudo vim sshd_config
```

修改端口等配置

```bash
Port 8022 #修改端口（两系统不能同时使用22端口自行更改）
ListenAddress 0.0.0.0  # 取消注释,打开本地监听
UsePrivilegeSeparation no
PermitRootLogin yes
# （注释）StrictModes yes
PasswordAuthentication yes #允许密码登陆
```

重启SSH

```bash
sudo service ssh restart
```

如果提示sshd error: ```could not load host key```，则用下面的命令重新生成，重新生成host key

```bash
sudo rm /etc/ssh/ssh*key
sudo dpkg-reconfigure openssh-server
```

## 安装docker

- 问题

```bash
Cannot connect to the Docker daemon at unix:///var/run/docker.sock. Is the docker daemon running?
```

```bash
# .bash_profile
export DOCKER_HOST=tcp://127.0.0.1:2375
```

- <https://medium.com/@sebagomez/installing-the-docker-client-on-ubuntus-windows-subsystem-for-linux-612b392a44c4>

- <https://davidburela.wordpress.com/2018/06/27/running-docker-on-wsl-windows-subsystem-for-linux/>

## Reference

- <https://docs.microsoft.com/zh-cn/windows/wsl/about>
- <https://blog.csdn.net/anychenp/article/details/78922320>
- <https://segmentfault.com/q/1010000006239403>
- <https://liyangkai.com/18062701/>
