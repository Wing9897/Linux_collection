#!/bin/bash

# 更新系統
sudo apt update && sudo apt upgrade -y

# 網絡相關工具包安裝
echo "安裝網絡相關工具的包..."
sudo apt install -y \
  traceroute \           # 路徑跟踪工具
  nmap \                 # 網絡掃描器
  iputils-ping \         # Ping 工具
  dnsutils \             # DNS 查詢工具
  tcpdump \              # 網絡數據包分析工具
  netcat \               # 網絡連接工具
  whois \                # 域名查詢工具
  mtr \                  # 網絡路徑測試工具
  socat \                # 網絡工具，用於連接和轉發
  net-tools \            # 網絡工具

echo "網絡相關工具包安裝完成！"
