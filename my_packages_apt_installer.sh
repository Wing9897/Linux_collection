#!/bin/bash

# 我的常用庫 APT 安裝器
# 基於 /home/wing/下載/我的常用庫.md 的套件清單

# 顏色定義
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
BOLD='\033[1m'
NC='\033[0m' # No Color

# 打印帶顏色的訊息
print_info() { echo -e "${BLUE}[INFO]${NC} $1"; }
print_success() { echo -e "${GREEN}[SUCCESS]${NC} $1"; }
print_warning() { echo -e "${YELLOW}[WARNING]${NC} $1"; }
print_error() { echo -e "${RED}[ERROR]${NC} $1"; }
print_header() { echo -e "${BOLD}${CYAN}$1${NC}"; }

# 檢查權限
check_sudo() {
    if ! sudo -v &>/dev/null; then
        print_error "需要sudo權限才能安裝軟體包"
        exit 1
    fi
}

# 系統更新
update_system() {
    print_info "更新軟體包列表..."
    if sudo apt update; then
        print_success "軟體包列表更新完成"
    else
        print_error "軟體包列表更新失敗"
        return 1
    fi
}

# 我的常用庫套件定義
declare -A my_packages

# 1. 系統監控工具
my_packages["iotop"]="I/O監控工具"
my_packages["htop"]="進程監控工具"
my_packages["atop"]="高級系統監控"
my_packages["btop"]="現代化的系統監控工具"
my_packages["psensor"]="溫度監控"
my_packages["neofetch"]="系統信息顯示"
my_packages["ncdu"]="磁盤使用分析"
my_packages["lsb-release"]="系統版本信息"
my_packages["iftop"]="網路帶寬監控"
my_packages["nethogs"]="按進程顯示網路使用"
my_packages["lm-sensors"]="硬件傳感器監控"

# 2. 系統操作工具
my_packages["gparted"]="磁盤分區工具"
my_packages["screen"]="終端復用器"
my_packages["tmux"]="終端復用器"
my_packages["nautilus"]="文件管理器"
my_packages["timeshift"]="系統備份還原"
my_packages["wine"]="Windows應用兼容層"
my_packages["watchdog"]="文件系統監控"
my_packages["rsync"]="文件同步工具"

# 3. 伺服器開發
my_packages["ufw"]="防火牆工具"
my_packages["fail2ban"]="入侵防護"
my_packages["apache2"]="Web伺服器"
my_packages["nginx"]="Web伺服器/反向代理"
my_packages["certbot"]="Let's Encrypt SSL證書"
my_packages["haproxy"]="負載均衡器"

# 4. 資料庫
my_packages["mariadb-server"]="MySQL分支資料庫"
my_packages["postgresql-contrib"]="PostgreSQL擴展"
my_packages["redis-server"]="內存資料庫"
my_packages["mongodb"]="NoSQL資料庫"
my_packages["sqlite3"]="輕量級資料庫"
my_packages["mysql-server"]="MySQL資料庫"
my_packages["mycli"]="MySQL CLI工具"
my_packages["pgcli"]="PostgreSQL CLI工具"
my_packages["sqlitebrowser"]="SQLite圖形界面"
my_packages["phpmyadmin"]="MySQL/MariaDB Web管理"
my_packages["adminer"]="輕量級資料庫管理"

# 5. 系統服務
my_packages["samba"]="文件共享服務"
my_packages["vsftpd"]="FTP伺服器"
my_packages["openssh-server"]="SSH伺服器"
my_packages["cockpit"]="Web系統管理界面"

# 6. 網路工具
my_packages["net-tools"]="網路配置工具"
my_packages["curl"]="HTTP客戶端"
my_packages["wget"]="文件下載工具"
my_packages["traceroute"]="路由追蹤"
my_packages["nmap"]="網路掃描工具"
my_packages["tcpdump"]="網路封包分析"
my_packages["whois"]="域名查詢"
my_packages["mtr"]="網路診斷工具"
my_packages["wireshark"]="網路封包分析器"
my_packages["xrdp"]="遠程桌面協議"
my_packages["openvpn"]="VPN客戶端/伺服器"
my_packages["socat"]="網路工具"
my_packages["iperf3"]="網路性能測試"
my_packages["netcat"]="網路連接工具"
my_packages["speedtest-cli"]="網路速度測試"

# 7. 程式開發
my_packages["default-jdk"]="Java開發套件"
my_packages["python3"]="Python程式語言"
my_packages["python3-pip"]="Python套件管理器"
my_packages["nodejs"]="Node.js運行環境"
my_packages["npm"]="Node.js套件管理器"
my_packages["php"]="PHP程式語言"
my_packages["build-essential"]="編譯工具鏈"
my_packages["git"]="版本控制系統"
my_packages["golang-go"]="Go程式語言"
my_packages["ruby"]="Ruby程式語言"
my_packages["vim"]="文本編輯器"
my_packages["nano"]="簡易文本編輯器"
my_packages["cmake"]="跨平台構建系統"

# 8. 容器與虛擬化
my_packages["docker-compose"]="Docker編排工具"
my_packages["kubectl"]="Kubernetes命令行工具"
my_packages["virtualbox"]="虛擬機軟體"
my_packages["qemu-kvm"]="虛擬化技術"
my_packages["libvirt-daemon"]="虛擬化管理"
my_packages["vagrant"]="開發環境管理"

# 9. 多媒體
my_packages["ffmpeg"]="音視頻處理工具"
my_packages["vlc"]="媒體播放器"
my_packages["audacity"]="音頻編輯器"
my_packages["gimp"]="圖像編輯器"
my_packages["imagemagick"]="命令行圖像處理"
my_packages["obs-studio"]="錄屏和直播軟體"
my_packages["kicad"]="電路設計軟體"
my_packages["blender"]="3D建模和動畫軟體"
my_packages["inkscape"]="矢量圖形編輯器"

# 10. 雲端與 DevOps 工具
my_packages["terraform"]="基礎設施即代碼"
my_packages["ansible"]="自動化部署工具"
my_packages["awscli"]="AWS命令行工具"
my_packages["snapd"]="Snap套件管理器"

# 11. 文件處理
my_packages["tree"]="目錄樹顯示"
my_packages["jq"]="JSON處理工具"
my_packages["zip"]="壓縮工具"
my_packages["unzip"]="解壓工具"
my_packages["p7zip-full"]="7-Zip壓縮工具"

# 12. 安全工具
my_packages["gpg"]="加密和數字簽名工具"
my_packages["openssl"]="SSL/TLS工具包"

# 13. 終端增強工具
my_packages["tmuxinator"]="tmux會話管理工具"

# 14. 系統信息工具
my_packages["hwinfo"]="詳細硬件信息顯示"

# 分類定義
declare -A categories
categories["monitoring"]="系統監控工具"
categories["system"]="系統操作工具"
categories["server"]="伺服器開發"
categories["database"]="資料庫"
categories["services"]="系統服務"
categories["network"]="網路工具"
categories["development"]="程式開發"
categories["container"]="容器與虛擬化"
categories["multimedia"]="多媒體"
categories["devops"]="雲端與 DevOps 工具"
categories["filetools"]="文件處理"
categories["security"]="安全工具"
categories["terminal"]="終端增強工具"
categories["sysinfo"]="系統信息工具"

# 分類對應的軟體包
declare -A category_packages
category_packages["monitoring"]="iotop htop atop btop psensor neofetch ncdu lsb-release iftop nethogs lm-sensors"
category_packages["system"]="gparted screen tmux nautilus timeshift wine watchdog rsync"
category_packages["server"]="ufw fail2ban apache2 nginx certbot haproxy"
category_packages["database"]="mariadb-server postgresql-contrib redis-server mongodb sqlite3 mysql-server mycli pgcli sqlitebrowser phpmyadmin adminer"
category_packages["services"]="samba vsftpd openssh-server cockpit"
category_packages["network"]="net-tools curl wget traceroute nmap tcpdump whois mtr wireshark xrdp openvpn socat iperf3 netcat speedtest-cli"
category_packages["development"]="default-jdk python3 python3-pip nodejs npm php build-essential git golang-go ruby vim nano cmake"
category_packages["container"]="docker-compose kubectl virtualbox qemu-kvm libvirt-daemon vagrant"
category_packages["multimedia"]="ffmpeg vlc audacity gimp imagemagick obs-studio kicad blender inkscape"
category_packages["devops"]="terraform ansible awscli snapd"
category_packages["filetools"]="tree jq zip unzip p7zip-full"
category_packages["security"]="gpg openssl"
category_packages["terminal"]="tmuxinator"
category_packages["sysinfo"]="hwinfo"


# 顯示主選單
show_main_menu() {
    clear
    print_header "=================================================="
    print_header "           我的常用庫 APT 安裝器"
    print_header "=================================================="
    echo
    echo "選擇安裝類別 (輸入數字或字母後按Enter)："
    echo
    echo " [1] ${categories[monitoring]}"
    echo " [2] ${categories[system]}"
    echo " [3] ${categories[server]}"
    echo " [4] ${categories[database]}"
    echo " [5] ${categories[services]}"
    echo " [6] ${categories[network]}"
    echo " [7] ${categories[development]}"
    echo " [8] ${categories[container]}"
    echo " [9] ${categories[multimedia]}"
    echo " [0] ${categories[devops]}"
    echo
    echo " [A] ${categories[filetools]}"
    echo " [B] ${categories[security]}"
    echo " [C] ${categories[terminal]}"
    echo " [D] ${categories[sysinfo]}"
    echo
    echo " [L] 列出所有套件"
    echo " [I] 安裝所有套件"
    echo " [U] 更新系統"
    echo " [Q] 退出"
    echo
    echo -n "請選擇: "
}

# 顯示分類軟體包
show_category_packages() {
    local category=$1
    local package_list=(${category_packages[$category]})

    clear
    print_header "=================================================="
    print_header "     ${categories[$category]} - 套件列表"
    print_header "=================================================="
    echo

    local i=1
    for pkg in "${package_list[@]}"; do
        if [[ -n "${my_packages[$pkg]}" ]]; then
            printf " %2d) %-18s - %s\n" $i "$pkg" "${my_packages[$pkg]}"
            ((i++))
        fi
    done

    echo
    echo "操作選項："
    echo " [I] 安裝此類別所有套件"
    echo " [B] 返回主選單"
    echo " [Q] 退出"
    echo
    echo -n "輸入選項: "
    read choice
    # 去除隱藏字符（回車符、空格等）
    choice=$(echo "$choice" | tr -d '\r\n' | xargs)

    case $choice in
        [iI])
            install_packages "${package_list[@]}"
            ;;
        [bB])
            return
            ;;
        [qQ])
            print_success "感謝使用！"
            exit 0
            ;;
        *)
            print_error "無效選項: $choice"
            sleep 1
            show_category_packages "$category"
            ;;
    esac
}

# 顯示所有軟體包
show_all_packages() {
    clear
    print_header "=================================================="
    print_header "              所有可用軟體包"
    print_header "=================================================="
    echo

    for category in monitoring system server database services network development container multimedia devops filetools security terminal sysinfo; do
        echo -e "${YELLOW}${categories[$category]}:${NC}"
        local package_list=(${category_packages[$category]})
        for pkg in "${package_list[@]}"; do
            if [[ -n "${my_packages[$pkg]}" ]]; then
                printf "  %-20s - %s\n" "$pkg" "${my_packages[$pkg]}"
            fi
        done
        echo
    done

    echo -n "按Enter鍵返回主選單..."
    read_char
    echo
}

# 安裝軟體包
install_packages() {
    local package_list=("$@")

    if [ ${#package_list[@]} -eq 0 ]; then
        print_warning "沒有選擇任何軟體包"
        return
    fi

    clear
    print_header "軟體包安裝確認"
    echo
    print_info "準備安裝以下軟體包："
    for pkg in "${package_list[@]}"; do
        if [[ -n "${my_packages[$pkg]}" ]]; then
            echo "  - $pkg: ${my_packages[$pkg]}"
        else
            echo "  - $pkg"
        fi
    done
    echo

    read -p "確認安裝? (y/N): " confirm
    if [[ ! $confirm =~ ^[Yy]$ ]]; then
        print_info "安裝已取消"
        sleep 1
        return
    fi

    echo
    print_info "開始安裝軟體包..."

    local success_count=0
    local fail_count=0

    for pkg in "${package_list[@]}"; do
        print_info "正在安裝: $pkg"
        if sudo apt install -y "$pkg" &>/dev/null; then
            print_success "$pkg 安裝成功"
            ((success_count++))
        else
            print_error "$pkg 安裝失敗"
            ((fail_count++))
        fi
    done

    echo
    print_info "安裝完成統計："
    print_success "成功: $success_count 個"
    if [ $fail_count -gt 0 ]; then
        print_error "失敗: $fail_count 個"
    fi

    echo
    echo -n "按Enter鍵繼續..."
    read_char
    echo
}

# 安裝所有套件
install_all_packages() {
    local all_packages=()

    # 收集所有軟體包
    for category in monitoring system server database services network development container multimedia devops filetools security terminal sysinfo; do
        local package_list=(${category_packages[$category]})
        all_packages+=("${package_list[@]}")
    done

    # 去重
    all_packages=($(printf "%s\n" "${all_packages[@]}" | sort -u))

    install_packages "${all_packages[@]}"
}

# 處理分類選擇
handle_category() {
    local category=$1
    show_category_packages "$category"
}

# 主程序
main() {
    # 檢查權限
    check_sudo

    # 主循環
    while true; do
        show_main_menu
        echo -n "輸入選項: "
        read choice
        # 去除隱藏字符（回車符、空格等）
        choice=$(echo "$choice" | tr -d '\r\n' | xargs)

        case $choice in
            "1") handle_category "monitoring" ;;
            "2") handle_category "system" ;;
            "3") handle_category "server" ;;
            "4") handle_category "database" ;;
            "5") handle_category "services" ;;
            "6") handle_category "network" ;;
            "7") handle_category "development" ;;
            "8") handle_category "container" ;;
            "9") handle_category "multimedia" ;;
            "0") handle_category "devops" ;;
            [aA]) handle_category "filetools" ;;
            [bB]) handle_category "security" ;;
            [cC]) handle_category "terminal" ;;
            [dD]) handle_category "sysinfo" ;;
            [lL]) show_all_packages ;;
            [iI]) install_all_packages ;;
            [uU])
                update_system
                echo -n "按Enter鍵繼續..."
                read_char
                echo
                ;;
            [qQ])
                print_success "感謝使用我的常用庫 APT 安裝器！"
                exit 0
                ;;
            *)
                print_error "無效選項: $choice"
                sleep 1
                ;;
        esac
    done
}

# 執行主程序
main