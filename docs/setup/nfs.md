# NFS on Ubuntu

## NFS Server

安装依赖

```bash
apt install nfs-kernel-server
```

打开配置文件

```bash
vim /etc/exports
```

添加以下内容

```txt
/home/zhoujl  *(rw,sync,no_root_squash)
```

重启服务

```bash
service nfs-kernel-server restart
```

## NFS Client

安装依赖

```bash
apt install -y nfs-common
```

- mount command

```bash
mount -t nfs4 -o proto=tcp,port=2049 bc-p1:/home/zhoujl /mnt/zhoujl

mount -t nfs4 -o proto=tcp,port=2049 bctest-server1:/arxan /mnt/arxan
mount -t nfs4 -o proto=tcp,port=2049 bctest-server1:/home/zhoujl /mnt/zhoujl
```

- mount using configfile ```/etc/fstab```

```txt
chainserver02:/shared   /mnt/shared   nfs4    _netdev,auto  0  0

bc-p1:/home/zhoujl  /mnt/zhoujl  nfs4  _netdev,auto  0  0
```

```bash
mount -a
```

- umount command

```bash
umount -v bc-p1:/home/zhoujl

umount -v bctest-server1:/mnt/zhoujl
```

## Reference

- <https://help.ubuntu.com/lts/serverguide/network-file-system.html>
- <https://help.ubuntu.com/community/NFSv4Howto>
- <https://linux.die.net/man/5/exports>
