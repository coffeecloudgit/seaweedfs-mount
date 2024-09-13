
## 安装步骤

```shell
cd /usr/local
mkdir weed-fs
cd weed-fs
wget https://github.com/coffeecloudgit/seaweedfs-mount/releases/download/v3.73/weed-fs.tar.gz
tar -zxvf weed-fs.tar.gz
vim fs.conf
./fs.sh install
systemctl start weed-fs.service
df -h
ls /weed-fs
```



