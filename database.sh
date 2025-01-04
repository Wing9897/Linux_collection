#!/bin/bash

# 更新系統
sudo apt update && sudo apt upgrade -y

# 數據庫管理包安裝
echo "安裝數據庫管理相關工具的包..."
sudo apt install -y \
  postgresql \           # 另一個流行的數據庫
  redis-server \         # 快速鍵值存儲
  mongodb \              # NoSQL 數據庫
  sqlite3 \              # 輕量級資料庫
  mycli \                # MySQL 命令行工具
  pgAdmin4 \             # PostgreSQL 管理工具
  dbeaver \              # 通用數據庫管理工具

echo "數據庫管理包安裝完成！"
