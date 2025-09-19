#!/bin/bash

# Linux 軟體包安裝器 v2 - 交互式版本
# 統一分類管理系統，支援交互式選擇與安裝

# 顏色定義
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
BOLD='\033[1m'
NC='\033[0m'

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

# 軟體包定義
declare -A packages

# 1. 系統監控與性能工具
packages["iotop"]="I/O 使用情況監控工具"
packages["dstat"]="系統資源統計工具"
packages["glances"]="跨平台系統監控工具 (Web界面占用 61208/tcp)"
packages["sysstat"]="系統性能統計工具包"
packages["nload"]="網絡流量實時監控"
packages["atop"]="進階系統活動監控"
packages["htop"]="交互式進程查看器"
packages["psensor"]="硬件溫度監控 (GUI)"
packages["neofetch"]="系統信息顯示工具"
packages["ncdu"]="磁碟使用情況分析工具"

# 2. 系統管理工具
packages["samba"]="檔案共享服務 (139/tcp, 445/tcp)"
packages["rsync"]="檔案同步工具"
packages["vsftpd"]="FTP 伺服器 (21/tcp, 20/tcp)"
packages["openssh-server"]="SSH 伺服器 (22/tcp)"
packages["net-tools"]="網絡工具集 (ifconfig, netstat 等)"
packages["curl"]="命令行數據傳輸工具"
packages["wget"]="檔案下載工具"
packages["screen"]="終端會話管理"
packages["tmux"]="終端復用器"
packages["docker.io"]="容器化平台 (2375/tcp, 2376/tcp)"
packages["gparted"]="磁碟分區工具 (GUI)"
packages["fail2ban"]="防暴力破解工具"
packages["ufw"]="簡易防火牆管理"
packages["logwatch"]="日誌監控分析工具"
packages["acpi"]="電源管理工具"

# 3. 網絡工具
packages["traceroute"]="網絡路徑跟踪"
packages["nmap"]="網絡掃描與安全審計"
packages["iputils-ping"]="Ping 網絡測試工具"
packages["dnsutils"]="DNS 查詢工具 (dig, nslookup)"
packages["tcpdump"]="網絡封包分析"
packages["netcat"]="網絡連接工具"
packages["whois"]="域名註冊信息查詢"
packages["mtr"]="網絡診斷工具"
packages["socat"]="網絡數據中繼"
packages["wireshark"]="網絡協議分析器 (GUI)"

# 4. 開發環境
packages["nginx"]="Web 伺服器 (80/tcp, 443/tcp)"
packages["apache2"]="Apache Web 伺服器 (80/tcp, 443/tcp)"
packages["mariadb-server"]="MySQL 相容資料庫 (3306/tcp)"
packages["default-jdk"]="Java 開發工具包"
packages["python3"]="Python 3 程式語言"
packages["python3-pip"]="Python 套件管理器"
packages["nodejs"]="JavaScript 執行環境"
packages["npm"]="Node.js 套件管理器"
packages["php"]="PHP 程式語言"
packages["php-fpm"]="PHP FastCGI 進程管理器 (9000/tcp)"
packages["build-essential"]="編譯工具集"
packages["git"]="版本控制系統"
packages["ruby"]="Ruby 程式語言"
packages["golang-go"]="Go 程式語言"
packages["code"]="Visual Studio Code"
packages["vim"]="Vim 文本編輯器"
packages["nano"]="Nano 文本編輯器"

# 5. 資料庫系統
packages["postgresql"]="PostgreSQL 資料庫 (5432/tcp)"
packages["postgresql-contrib"]="PostgreSQL 額外功能模組"
packages["redis-server"]="Redis 記憶體資料庫 (6379/tcp)"
packages["mongodb"]="MongoDB NoSQL 資料庫 (27017/tcp)"
packages["sqlite3"]="SQLite 輕量資料庫"
packages["mycli"]="MySQL/MariaDB 命令行客戶端"
packages["pgcli"]="PostgreSQL 命令行客戶端"

# 6. 容器與虛擬化
packages["docker-compose"]="Docker 應用編排工具"
packages["kubectl"]="Kubernetes 命令行工具"
packages["virtualbox"]="虛擬機軟體"
packages["vagrant"]="開發環境管理"
packages["qemu-kvm"]="KVM 虛擬化"
packages["libvirt-daemon"]="虛擬化管理守護程序"

# 7. 多媒體工具
packages["ffmpeg"]="多媒體處理框架"
packages["vlc"]="多媒體播放器"
packages["audacity"]="音頻編輯軟體"
packages["gimp"]="圖像編輯軟體"
packages["imagemagick"]="圖像處理命令行工具"

# 8. 安全工具
packages["iptables"]="進階防火牆規則"
packages["chkrootkit"]="Rootkit 檢測工具"
packages["rkhunter"]="Rootkit 獵手"
packages["clamav"]="防毒軟體"
packages["lynis"]="系統安全審計"

# 9. 雲端與 DevOps 工具
packages["terraform"]="基礎設施即代碼"
packages["ansible"]="自動化配置管理"
packages["awscli"]="AWS 命令行工具"
packages["gcloud"]="Google Cloud 命令行工具"
packages["snapd"]="Snap 套件管理器"

# 10. 實用工具
packages["tree"]="目錄樹狀顯示"
packages["jq"]="JSON 處理工具"
packages["zip"]="壓縮工具"
packages["unzip"]="解壓縮工具"
packages["p7zip-full"]="7-Zip 壓縮工具"
packages["figlet"]="ASCII 藝術字生成"
packages["fortune"]="隨機格言顯示"
packages["sl"]="Steam Locomotive 趣味指令"

# 分類定義
declare -A categories
categories["monitoring"]="系統監控與性能工具"
categories["management"]="系統管理工具"
categories["network"]="網絡工具"
categories["development"]="開發環境"
categories["database"]="資料庫系統"
categories["container"]="容器與虛擬化"
categories["multimedia"]="多媒體工具"
categories["security"]="安全工具"
categories["devops"]="雲端與 DevOps 工具"
categories["utilities"]="實用工具"

# 分類對應的軟體包
declare -A category_packages
category_packages["monitoring"]="iotop dstat glances sysstat nload atop htop psensor neofetch ncdu"
category_packages["management"]="samba rsync vsftpd openssh-server net-tools curl wget screen tmux docker.io gparted fail2ban ufw logwatch acpi"
category_packages["network"]="traceroute nmap iputils-ping dnsutils tcpdump netcat whois mtr socat wireshark"
category_packages["development"]="nginx apache2 mariadb-server default-jdk python3 python3-pip nodejs npm php php-fpm build-essential git ruby golang-go code vim nano"
category_packages["database"]="postgresql postgresql-contrib redis-server mongodb sqlite3 mycli pgcli"
category_packages["container"]="docker-compose kubectl virtualbox vagrant qemu-kvm libvirt-daemon"
category_packages["multimedia"]="ffmpeg vlc audacity gimp imagemagick"
category_packages["security"]="iptables chkrootkit rkhunter clamav lynis"
category_packages["devops"]="terraform ansible awscli gcloud snapd"
category_packages["utilities"]="tree jq zip unzip p7zip-full figlet fortune sl"

# 顯示主選單
show_main_menu() {
    clear
    print_header "=================================================="
    print_header "          Linux 軟體包安裝管理系統 v2"
    print_header "=================================================="
    echo
    echo "選擇安裝類別："
    echo
    local i=1
    for category in monitoring management network development database container multimedia security devops utilities; do
        echo " [$i] ${categories[$category]}"
        ((i++))
    done
    echo
    echo " [A] 顯示所有軟體包"
    echo " [C] 自定義選擇"
    echo " [S] 搜尋軟體包"
    echo " [U] 更新軟體包列表"
    echo " [G] 更新並升級系統"
    echo " [Q] 退出"
    echo
    echo -n "請選擇: "
}

# 顯示分類軟體包（勾選模式）
show_category_packages() {
    local category=$1
    local package_list=(${category_packages[$category]})
    local selected_packages=()

    while true; do
        clear
        print_header "=================================================="
        print_header "     ${categories[$category]} - 勾選模式"
        print_header "=================================================="
        echo

        local i=1
        for pkg in "${package_list[@]}"; do
            if [[ -n "${packages[$pkg]}" ]]; then
                local mark=" "
                if [[ " ${selected_packages[*]} " =~ " $pkg " ]]; then
                    mark="✓"
                fi
                printf " [%s] %2d) %-18s - %s\n" "$mark" $i "$pkg" "${packages[$pkg]}"
            fi
            ((i++))
        done
        echo
        echo "操作說明："
        echo " 輸入數字切換勾選    [A] 全選    [N] 全不選"
        echo " [I] 安裝已勾選      [B] 返回    [Q] 退出"

        if [ ${#selected_packages[@]} -gt 0 ]; then
            echo
            print_info "已勾選 ${#selected_packages[@]} 個軟體包: ${selected_packages[*]}"
        fi

        echo
        echo -n "輸入選項: "
        read -r choice

        case $choice in
            [0-9]*)
                if [[ $choice =~ ^[0-9]+$ ]] && [ $choice -ge 1 ] && [ $choice -le ${#package_list[@]} ]; then
                    local pkg=${package_list[$((choice-1))]}
                    if [[ " ${selected_packages[*]} " =~ " $pkg " ]]; then
                        # 移除套件
                        local temp_array=()
                        for item in "${selected_packages[@]}"; do
                            if [ "$item" != "$pkg" ]; then
                                temp_array+=("$item")
                            fi
                        done
                        selected_packages=("${temp_array[@]}")
                        print_info "取消勾選: $pkg"
                    else
                        selected_packages+=("$pkg")
                        print_success "已勾選: $pkg"
                    fi
                    sleep 0.5
                else
                    print_error "無效選項: $choice"
                    sleep 1
                fi
                ;;
            [aA])
                selected_packages=("${package_list[@]}")
                print_success "已全選所有軟體包"
                sleep 1
                ;;
            [nN])
                selected_packages=()
                print_info "已取消所有勾選"
                sleep 1
                ;;
            [iI])
                if [ ${#selected_packages[@]} -gt 0 ]; then
                    install_packages "${selected_packages[@]}"
                    return
                else
                    print_warning "尚未勾選任何軟體包"
                    sleep 1
                fi
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
                ;;
        esac
    done
}

# 顯示所有軟體包
show_all_packages() {
    clear
    print_header "=================================================="
    print_header "              所有可用軟體包"
    print_header "=================================================="
    echo

    for category in monitoring management network development database container multimedia security devops utilities; do
        echo -e "${YELLOW}${categories[$category]}:${NC}"
        local package_list=(${category_packages[$category]})
        for pkg in "${package_list[@]}"; do
            if [[ -n "${packages[$pkg]}" ]]; then
                printf "  %-20s - %s\n" "$pkg" "${packages[$pkg]}"
            fi
        done
        echo
    done

    echo -n "按Enter鍵返回主選單..."
    read -r
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
        echo "  - $pkg: ${packages[$pkg]}"
    done
    echo

    echo -n "確認安裝? (y/N): "
    read -r confirm
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
        if sudo apt install -y "$pkg" >/dev/null 2>&1; then
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
    read -r
}

# 更新系統
update_system() {
    print_info "更新軟體包列表..."
    if sudo apt update; then
        print_success "軟體包列表更新完成"
    else
        print_error "軟體包列表更新失敗"
        return 1
    fi
    echo -n "按Enter鍵繼續..."
    read -r
}

# 系統升級功能
upgrade_system() {
    print_info "更新並升級系統..."
    if sudo apt update && sudo apt upgrade -y; then
        print_success "系統更新升級完成"
    else
        print_error "系統更新升級失敗"
        return 1
    fi
    echo -n "按Enter鍵繼續..."
    read -r
}

# 搜尋軟體包
search_packages() {
    clear
    print_header "軟體包搜尋"
    echo
    echo -n "輸入搜尋關鍵字: "
    read -r keyword

    if [[ -z "$keyword" ]]; then
        print_warning "搜尋關鍵字不能為空"
        echo -n "按Enter鍵返回..."
        read -r
        return
    fi

    echo
    print_info "搜尋結果："
    echo

    local found=0
    for pkg in "${!packages[@]}"; do
        if [[ "$pkg" == *"$keyword"* ]] || [[ "${packages[$pkg]}" == *"$keyword"* ]]; then
            printf "%-20s - %s\n" "$pkg" "${packages[$pkg]}"
            ((found++))
        fi
    done

    if [ $found -eq 0 ]; then
        print_warning "未找到相關軟體包"
    else
        print_success "找到 $found 個相關軟體包"
    fi

    echo
    echo -n "按Enter鍵返回主選單..."
    read -r
}

# 自定義選擇
custom_selection() {
    local all_packages=()
    local selected_packages=()

    # 收集所有軟體包
    for category in monitoring management network development database container multimedia security devops utilities; do
        local package_list=(${category_packages[$category]})
        all_packages+=("${package_list[@]}")
    done

    # 去重並排序
    all_packages=($(printf "%s\n" "${all_packages[@]}" | sort -u))

    local page=1
    local per_page=15
    local total_pages=$(((${#all_packages[@]} + per_page - 1) / per_page))

    while true; do
        clear
        print_header "=================================================="
        print_header "   自定義軟體包選擇 - 頁面 $page/$total_pages"
        print_header "=================================================="
        echo

        local start=$(((page - 1) * per_page))
        local end=$((start + per_page - 1))
        if [ $end -ge ${#all_packages[@]} ]; then
            end=$((${#all_packages[@]} - 1))
        fi

        local display_idx=1
        for i in $(seq $start $end); do
            local pkg=${all_packages[$i]}
            local mark=" "
            if [[ " ${selected_packages[*]} " =~ " $pkg " ]]; then
                mark="✓"
            fi
            printf " [%s] %2d) %-18s - %s\n" "$mark" $display_idx "$pkg" "${packages[$pkg]}"
            ((display_idx++))
        done

        echo
        echo "操作說明："
        echo " 輸入數字切換勾選    [A] 本頁全選     [N] 本頁全不選"
        echo " [>] 下一頁          [<] 上一頁       [P] 跳到指定頁"
        echo " [I] 安裝已勾選      [C] 清除所有勾選  [S] 搜尋"
        echo " [B] 返回主選單      [Q] 退出"

        if [ ${#selected_packages[@]} -gt 0 ]; then
            echo
            print_info "已勾選 ${#selected_packages[@]} 個軟體包"
        fi

        echo
        echo -n "輸入選項: "
        read -r choice

        case $choice in
            [0-9]*)
                if [[ $choice =~ ^[0-9]+$ ]] && [ $choice -ge 1 ] && [ $choice -le $((end - start + 1)) ]; then
                    local actual_idx=$((start + choice - 1))
                    local pkg=${all_packages[$actual_idx]}
                    if [[ " ${selected_packages[*]} " =~ " $pkg " ]]; then
                        # 移除套件
                        local temp_array=()
                        for item in "${selected_packages[@]}"; do
                            if [ "$item" != "$pkg" ]; then
                                temp_array+=("$item")
                            fi
                        done
                        selected_packages=("${temp_array[@]}")
                        print_info "取消勾選: $pkg"
                    else
                        selected_packages+=("$pkg")
                        print_success "已勾選: $pkg"
                    fi
                    sleep 0.5
                else
                    print_error "無效選項: $choice"
                    sleep 1
                fi
                ;;
            [aA])
                for i in $(seq $start $end); do
                    local pkg=${all_packages[$i]}
                    if [[ ! " ${selected_packages[*]} " =~ " $pkg " ]]; then
                        selected_packages+=("$pkg")
                    fi
                done
                print_success "已勾選本頁所有軟體包"
                sleep 1
                ;;
            [nN])
                for i in $(seq $start $end); do
                    local pkg=${all_packages[$i]}
                    # 移除套件
                    local temp_array=()
                    for item in "${selected_packages[@]}"; do
                        if [ "$item" != "$pkg" ]; then
                            temp_array+=("$item")
                        fi
                    done
                    selected_packages=("${temp_array[@]}")
                done
                print_info "已取消本頁所有勾選"
                sleep 1
                ;;
            '>')
                if [ $page -lt $total_pages ]; then
                    ((page++))
                else
                    print_warning "已是最後一頁"
                    sleep 1
                fi
                ;;
            '<')
                if [ $page -gt 1 ]; then
                    ((page--))
                else
                    print_warning "已是第一頁"
                    sleep 1
                fi
                ;;
            [pP])
                echo
                echo -n "跳到第幾頁 (1-$total_pages): "
                read -r target_page
                if [[ $target_page =~ ^[0-9]+$ ]] && [[ $target_page -ge 1 && $target_page -le $total_pages ]]; then
                    page=$target_page
                else
                    print_error "無效頁數"
                    sleep 1
                fi
                ;;
            [iI])
                if [ ${#selected_packages[@]} -gt 0 ]; then
                    install_packages "${selected_packages[@]}"
                    return
                else
                    print_warning "尚未勾選任何軟體包"
                    sleep 1
                fi
                ;;
            [cC])
                selected_packages=()
                print_info "已清除所有勾選"
                sleep 1
                ;;
            [sS])
                search_packages
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
                ;;
        esac
    done
}

# 主程序
main() {
    # 檢查權限
    check_sudo

    # 主循環
    while true; do
        show_main_menu
        read -r choice

        case $choice in
            "1") show_category_packages "monitoring" ;;
            "2") show_category_packages "management" ;;
            "3") show_category_packages "network" ;;
            "4") show_category_packages "development" ;;
            "5") show_category_packages "database" ;;
            "6") show_category_packages "container" ;;
            "7") show_category_packages "multimedia" ;;
            "8") show_category_packages "security" ;;
            "9") show_category_packages "devops" ;;
            "0") show_category_packages "utilities" ;;
            [aA]) show_all_packages ;;
            [cC]) custom_selection ;;
            [sS]) search_packages ;;
            [uU]) update_system ;;
            [gG]) upgrade_system ;;
            [qQ])
                print_success "感謝使用 Linux 軟體包安裝管理系統！"
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