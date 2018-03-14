# ubuntu 创建swap

## 创建swap分区

- 添加swap文件

```bash
mkdir swap
cd swap
dd if=/dev/zero of=sfile bs=1M count=8192
```

- 修改权限

```bash
chmod 600 sfile
```

- 转化为swap文件

```bash
mkswap sfile
```

- 激活swap文件

```bash
swapon sfile
```

- 查看

```bash
free -m
```

## 配置系统启动时挂载Swap分区文件

```bash
vim /etc/fstab
```

添加以下内容

```bash
sfile none swap sw 0 0
```

## 卸载swap分区

```bash
swapoff sfile
```

## Reference

- <https://www.jianshu.com/p/833e81c0d854>
- <http://man.linuxde.net/dd>
- <http://www.cnblogs.com/EasonJim/p/7487596.html>