# ubuntu安装配置openssh

安装

```bash
sudo apt-get install openssh-server
```

确认sshserver是否启动

```bash
ps -e|grep ssh
```

## 客户端设置快捷登录

打开.bashrc配置文件

```bash
vim ~/.bashrc
```

添加以下内容

```bash
alias server='ssh username@192.168.1.1'
```

重新加载配置文件

```bash
source ~/.bashrc
```

## 参考链接

- [https://www.jianshu.com/p/029b14e2d0af](https://www.jianshu.com/p/029b14e2d0af)
