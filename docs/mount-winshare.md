# Ubuntu mount windows共享文件夹

- 在windows中设置共享文件夹,假设共享文件夹的网络路径是

```bash
\\windows-pcname\sharefoldername

# 也可以直接用ip替换windows的pcname
\\192.168.1.*\sharefoldername
```

- 在Ubuntu中安装cifs

```bash
sudo apt-get install cifs-utils
```

- 在Ubuntu中mount共享文件夹

```bash
sudo mount -t cifs -o username=win10,password=zhoujl //192.168.1.83/arxan /mnt/window
```

- 如果要永久mount，即Ubuntu重启后仍然自动mount

```bash
vim /etc/fstab
```

在文件中添加以下内容

```bash
//windows-pcname/sharefoldername  /mnt/window  cifs  username=msusername,password=mspassword,iocharset=utf8,sec=ntlm  0  0
```

添加之后，执行以下命令

```bash
sudo mount -a
```

- umount共享文件夹

```bash
sudo umount /mnt/window
```

## 参考链接

- [https://wiki.ubuntu.com/MountWindowsSharesPermanently](https://wiki.ubuntu.com/MountWindowsSharesPermanently)
- [http://www.01happy.com/linux-access-windows-shares-folders/](http://www.01happy.com/linux-access-windows-shares-folders/)
