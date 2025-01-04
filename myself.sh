#!/bin/bash

# 更新系統
echo "更新系統..."
sudo apt update && sudo apt upgrade -y

# 安裝所需包
echo "安裝所需的包..."
sudo apt install -y \
  p7zip-full \          # 7z 文件壓縮/解壓縮工具
  samba \               # 文件共享服務
  rsync \               # 文件同步工具
  vsftpd \              # FTP 伺服器
  openssh-server \      # SSH 伺服器
  net-tools \           # 網絡工具
  curl \                # 數據傳輸工具
  wget \                # 下載工具
  nginx \               # 網頁伺服器
  mariadb-server \      # 數據庫管理系統
  snapd \               # 軟體包管理工具
  htop \                # 交互式進程查看器
  psensor \             # 硬件監控工具
  nautilus \            # 文件管理器
  neofetch \            # 系統信息顯示工具
  screen \              # 終端會話管理工具
  watchdog \            # 系統監控工具
  docker \              # 容器化平台
  gparted \             # 磁碟分區工具
  default-jdk \        # Java 開發包
  python3 \            # Python 3 編程語言
  nodejs \             # JavaScript 執行環境
  npm \                 # Node.js 包管理器
  php \                 # PHP 編程語言
  build-essential \     # 編譯所需的基本工具
  git                   # 版本控制系統

# 完成提示
echo "所有指定包安裝完成！"
