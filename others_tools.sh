#!/bin/bash

# 更新系統
sudo apt update && sudo apt upgrade -y

# 額外熱門包安裝
echo "安裝額外熱門包..."
sudo apt install -y \
  vim \                  # 文本編輯器
  nano \                 # 另一個文本編輯器
  tmux \                 # 終端復用器
  tree \                 # 目錄樹形顯示
  jq \                   # JSON 處理工具
  terraform \            # 基礎設施即代碼工具
  docker-compose \       # Docker 應用管理工具
  kubectl \              # Kubernetes 命令行工具
  postman \              # API 測試工具
  ffmpeg \               # 媒體處理工具
  ncdu \                 # 磁碟使用情況分析工具

echo "額外熱門包安裝完成！"
