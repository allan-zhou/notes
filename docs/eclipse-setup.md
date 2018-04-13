# Eclipse Setup

- download eclipse

下载地址:<http://mirrors.ustc.edu.cn/eclipse/technology/epp/downloads/release/oxygen/3/eclipse-jee-oxygen-3-linux-gtk-x86_64.tar.gz>

- 将eclipse解压到安装目录 ```/opt``` 文件夹下

```bash
sudo tar -zxvf eclipse-jee-oxygen-3-linux-gtk-x86_64.tar.gz -C /opt/
```

- 创建eclipse桌面快捷图标

```bash
cd ~/Desktop/

vim eclipse.desktop
```

填入以下内容

```plaintext
[Desktop Entry]
Encoding=UTF-8
Name=Eclipse
Comment=Eclipse
Exec=/opt/eclipse/eclipse
Icon=/opt/eclipse/icon.xpm
Terminal=false
StartupNotify=true
Type=Application
Categories=Application;Development;
```

将eclipse变为可执行文件

```bash
chmod +x eclipse.desktop
```

添加到应用程序列表方便查询

```bash
sudo cp eclipse.desktop  /usr/share/applications/
```

## Reference

- [中科大镜像](http://mirrors.ustc.edu.cn/eclipse/technology/epp/downloads/release/)
- [北京理工大学镜像](http://mirror.bit.edu.cn/eclipse/)
- <http://blog.csdn.net/bai_yechuang2012/article/details/51669139>