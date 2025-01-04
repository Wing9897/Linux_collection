#!/bin/bash

# 更新系統
sudo apt update && sudo apt upgrade -y

# 系統管理用途包安裝
echo "安裝系統管理用途的包..."
sudo apt install -y \
  samba \                # 文件共享服務
  rsync \                # 文件同步工具
  vsftpd \               # FTP Server
  openssh-server \       # SSH Server
  net-tools \            # 網絡工具
  curl \                 # 數據傳輸工具
  wget \                 # 下載工具
  htop \                 # 交互式進程查看器
  psensor \              # 硬件監控工具
  neofetch \             # 系統信息顯示工具
  screen \               # 終端會話管理工具
  watchdog \             # 系統監控工具
  docker \               # 容器化平台
  gparted \              # 磁碟分區工具
  fail2ban \             # 防止暴力破解的安全工具
  ufw \                  # 簡易防火牆管理
  logwatch \             # 日誌監控工具
  acpi                    # 硬件電源狀態工具

echo "系統管理包安裝完成！"
