# Postman setup on Ubuntu

下载地址：

- 官网：<https://dl.pstmn.io/download/latest/linux64>
- 我的网盘：<https://pan.baidu.com/s/15xWnqLreWupL24piJOMYHA>

```bash
wget https://dl.pstmn.io/download/latest/linux64 -O postman.tar.gz
sudo tar -xzf postman.tar.gz -C /opt
rm postman.tar.gz
sudo ln -s /opt/Postman/Postman /usr/bin/postman
```

## Reference

- <https://blog.bluematador.com/posts/postman-how-to-install-on-ubuntu-1604/>