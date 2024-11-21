#!/bin/bash

WORKDIR=$(dirname "${BASH_SOURCE-$0}")
cd $WORKDIR
WORKDIR=$(pwd)

install(){
  echo "$WORKDIR"

  cat > /etc/systemd/system/weed-fs-unseal.service <<-EOF
[Unit]
Description=SeaweedFS Mount Unseal
After=network.target
After=syslog.target

[Service]
Type=simple
Restart=always
RestartSec=10
User=root
Group=root
ExecStartPre=-/bin/sleep 6s
WorkingDirectory=$WORKDIR
ExecStart=$WORKDIR/weed mount -options=$WORKDIR/fs.conf
SyslogIdentifier=seaweedfs-mount-unseal

[Install]
WantedBy=multi-user.target
EOF

}
#卸载 挂载服务
uninstall(){
  umount /weed-fs-unseal
  sudo systemctl stop weed-fs-unseal.service
  sudo systemctl disable weed-fs-unseal.service
}

#使用说明，用来提示输入参数
usage() {
 echo "Usage: bash fs-unseal.sh [install|uninstall|sync]"
 exit 1
}

#根据输入参数，选择执行对应方法，不输入则执行使用说明
case "$1" in
 "install")
 install
 ;;
 "uninstall")
 uninstall
 ;;
 *)
 usage
 ;;
esac