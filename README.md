
## 安装步骤

```shell
cd /usr/local
mkdir weed-fs
cd weed-fs
wget https://github.com/coffeecloudgit/seaweedfs-mount/releases/download/v3.77/weed-fs.tar.gz
tar -zxvf weed-fs.tar.gz
vim fs.conf
bash fs.sh install
mkdir /weed-fs
systemctl start weed-fs.service
df -h
ls /weed-fs
```



