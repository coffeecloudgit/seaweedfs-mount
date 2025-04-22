#!/bin/bash
current_folder=$(basename "$(pwd)")
echo "current folder: $current_folder"

WORKDIR=$(dirname "${BASH_SOURCE-$0}")
cd $WORKDIR
WORKDIR=$(pwd)

install(){
  echo "$WORKDIR"

  cat > /etc/systemd/system/${current_folder}.service <<-EOF
[Unit]
Description=SeaweedFS Mount
After=network.target
After=syslog.target

[Service]
Type=simple
Restart=always
RestartSec=10
User=root
Group=root
ExecStartPre=-/bin/sleep 5s
WorkingDirectory=$WORKDIR
ExecStart=$WORKDIR/weed mount -options=$WORKDIR/fs.conf
SyslogIdentifier=seaweedfs-mount

[Install]
WantedBy=multi-user.target
EOF

}
#卸载 挂载服务
uninstall(){
  umount /${current_folder}
  sudo systemctl stop ${current_folder}.service
  sudo systemctl disable ${current_folder}.service
}

#使用说明，用来提示输入参数
usage() {
 echo "Usage: bash fs-dir.sh [install|uninstall|sync]"
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
