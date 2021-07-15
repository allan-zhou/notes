# Install Docker-ce in Ubuntu

## Install docker-ce using the repository

- set up the repository of docker

```bash
sudo apt-get update
```

```bash
sudo apt-get install \
        apt-transport-https \
        ca-certificates \
        curl \
        software-properties-common
```

```bash
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
```

```bash
sudo apt-key fingerprint 0EBFCD88
```

```bash
sudo add-apt-repository \
       "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
       $(lsb_release -cs) \
       stable"
```

- intall docker

```bash
sudo apt-get update
sudo apt-get install docker-ce
```

```bash
# 安装特定版本

# 查看主机可以安装的版本
apt-cache madison docker-ce
# sudo apt-get install docker-ce=<VERSION>
sudo apt-get install docker-ce=18.03.0~ce-0~ubuntu
```

- check install

```bash
sudo docker version
sudo docker run hello-world
```

## Uninstall docker-ce

- Uninstall the Docker CE package

```bash
sudo apt-get purge docker-ce
```

- Images, containers, volumes, or customized configuration files on your host are not automatically removed. To delete all images, containers, and volumes:

```bash
sudo rm -rf /var/lib/docker
```

## Manage Docker as a non-root user

- create the docker group

```bash
sudo groupadd docker
```

- add your user to the docker group.

```bash
sudo usermod -aG docker $USER
```

- log out and log back in so that your group membership is re-evaluated

## 国内安装源

- 准备

```bash
sudo apt-get update
sudo apt-get -y install apt-transport-https ca-certificates curl software-properties-common
```

- 安装GPG证书

```bash
curl -fsSL http://mirrors.aliyun.com/docker-ce/linux/ubuntu/gpg | sudo apt-key add -
```

- 写入软件源信息

```bash
sudo add-apt-repository "deb [arch=amd64] http://mirrors.aliyun.com/docker-ce/linux/ubuntu $(lsb_release -cs) stable"
```

- 更新并安装 Docker-CE

```bash
sudo apt-get -y update

sudo apt-get -y install docker-ce
```

## Reference

- [ubuntu install docker-ce](https://docs.docker.com/install/linux/docker-ce/ubuntu/)
- [linux-postinstall](https://docs.docker.com/install/linux/linux-postinstall/)