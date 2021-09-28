# Tomcat Setup

- download Tomcat

下载地址：<https://mirrors.cnnic.cn/apache/tomcat/>

- 解压安装包

```bash
sudo tar -zxvf apache-tomcat-8.5.29.tar.gz -C /opt/
```

- (可选)修改tomcat目录名称

```bash
mv apache-tomcat-8.5.29/ tomcat/
```

- 配置环境变量

```bash
vim /etc/profile.d/tomcat.sh
```

添加一下内容

```bash
CATALINA_HOME=/opt/tomcat

export CATALINA_HOME
```

加载配置

```bash
source /etc/profile.d/tomcat.sh
```

- 启动tomcat

```bash
cd /opt/tomcat

bin/startup.sh
```

tomcat的默认端口是8080，可使用浏览器访问

## 配置端口

```bash
cd /usr/local/tomcat

vim conf/server.xml
```

## 日志

```bash
cd /usr/local/tomcat

cat logs/catalina.out
tail -f catalina.out
```

## Reference

- 中国互联网络信息中心-镜像：<http://mirrors.cnnic.cn/apache/>
- <https://www.cnblogs.com/wangcMove/p/7606051.html>
- <https://www.cnblogs.com/marblemm/p/7150559.html>
