# Maven Setup

## Prerequisites

- 安装JDK并设置相关环境变量

## 下载 Maven

下载地址：<http://maven.apache.org/download.html>

## 解压 Maven 到安装目录

```bash
sudo tar -zxvf apache-maven-3.5.3-bin.tar.gz -C /opt/

cd /opt/
```

### (*)更名解压包，便于配置环境变量

```bash
sudo mv apache-maven-3.5.3 maven
```

## 设置 Maven 环境变量

```bash
sudo vim /etc/profile.d/maven.sh
```

添加 **MAVEN_HOME** 到环境变量中。

```bash
export M2_HOME=/opt/apache-maven-3.5.3
export MAVEN_HOME=/opt/apache-maven-3.5.3

export PATH=$PATH:$MAVEN_HOME/bin
```

执行source命令使环境变量生效

```bash
source /etc/profile.d/maven.sh
```

## 验证 Maven 安装

```bash
mvn --version
```

提示如下信息

```bash
Apache Maven 3.5.3 (3383c37e1f9e9b3bc3df5050c29c8aff9f295297; 2018-02-25T03:49:05+08:00)
Maven home: /usr/local/maven
Java version: 1.8.0_161, vendor: Oracle Corporation
Java home: /usr/local/java/jdk/jre
Default locale: en_US, platform encoding: UTF-8
OS name: "linux", version: "4.13.0-37-generic", arch: "amd64", family: "unix"
```

## Reference

- <https://www.w3cschool.cn/maven/j3x41ht2.html>
