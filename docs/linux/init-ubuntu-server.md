# Init Ubunut Server

## Add Public Key Authentication

```bash
# 客户机生成密钥对
ssh-keygen

# 复制客户机公钥到server
ssh-copy-id root@123.56.18.206
```

## 设置aliyun源

```bash
# 备份
cp /etc/apt/sources.list /etc/apt/sources.list.backup

vim /etc/apt/sources.list
# 全局替换，共14处
:%s/us.archive.ubuntu.com/mirrors.aliyun.com/g
#:%s/archive.ubuntu.com/mirrors.aliyun.com/g

# 全局替换，共6处
:%s/security.ubuntu.com/mirrors.aliyun.com/g
```