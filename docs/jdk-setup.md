# ubuntu下安装JDK

- [Install using downloaded packages(Recommend)](#install-using-downloaded-packages)
- [Install using APT](#install-using-apt)

## Install using downloaded packages

### Prerequisites

- Ubuntu Server 16.04
- jdk版本 [官网下载地址](http://www.oracle.com/technetwork/java/javase/downloads/jdk8-downloads-2133151.html)

### 创建安装目录

```bash
sudo mkdir /usr/local/java
```

### 解压安装包，并进入解压目录

```bash
sudo tar -zxvf jdk-8u151-linux-x64.tar.gz -C /usr/local/java/

cd /usr/local/java
```

### 更名解压包，便于配置环境变量

```bash
sudo mv jdk1.8.0_151 jdk
```

## 设置java环境变量

```bash
sudo vim /etc/profile.d/jdk.sh
```

添加以下内容并保存文件

```bash
export JAVA_HOME=/usr/local/java/jdk

export JRE_HOME=/usr/local/java/jdk/jre

export CLASSPATH=.:$JAVA_HOME/lib:$JRE_HOME/lib:$CLASSPATH

export PATH=$PATH:$JAVA_HOME/bin:$JRE_HOME/bin
```

执行source命令使环境变量生效

```bash
source /etc/profile.d/jdk.sh
```

### 设置默认jdk

```bash
sudo update-alternatives --install "/usr/bin/java" "java" "/usr/local/java/jdk/bin/java" 300

sudo update-alternatives --install "/usr/bin/javac" "javac" "/usr/local/java/jdk/bin/javac" 300

sudo update-alternatives --install "/usr/bin/javaws" "javaws" "/usr/local/java/jdk/bin/javaws" 300
```

### 检验安装成功

```bash
java -version
```

```bash
java version "1.8.0_151"
Java(TM) SE Runtime Environment (build 1.8.0_151-b12)
Java HotSpot(TM) 64-Bit Server VM (build 25.151-b12, mixed mode)
```

## Install using APT

### install

- add Oracle's PPA, then update your package repository.

```bash
sudo add-apt-repository ppa:webupd8team/java
sudo apt-get update
```

- install latest stable version of Java

```bash
sudo apt-get install oracle-java8-installer
```

- configure the default version

```bash
sudo update-alternatives --config java
```

### directory structure

- which java

/usr/bin/java/

- whereis java

/usr/bin/java
/usr/share/java
/usr/lib/jvm/java-8-oracle/bin/java /usr/lib/jvm/java-8-oracle/jre/bin/java
/usr/share/man/man1/java.1.gz

### uninstall use apt-get

```bash
sudo apt-get remove oracle-java8-installer
# sudo apt-get purge oracle-java8-installer
```

## Open JDK和Oracle JDK

- OpenJDK是Java开发工具包的开源实现

- Oracle JDK是Java开发工具包的官方Oracle版本

尽管OpenJDK已经足够满足大多数的案例，但是许多程序比如Android Studio建议使用Oracle JDK, 以避免UI/性问

## 参考链接

- [https://docs.oracle.com/javase/9/](https://docs.oracle.com/javase/9/)
