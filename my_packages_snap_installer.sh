#!/bin/bash

# 我的常用庫 SNAP 安裝器 v2 - 交互式版本
# 基於常用套件清單的 SNAP 版本交互式安裝器

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

# 檢查snap是否已安裝
check_snapd() {
    if ! command -v snap &> /dev/null; then
        print_error "snap 尚未安裝，請先安裝 snapd"
        print_info "可以執行: sudo apt install snapd"
        exit 1
    fi
}

# 我的常用庫 SNAP 套件定義
declare -A my_snap_packages

# 1. 系統監控工具
my_snap_packages["btop"]="現代化的系統監控工具"
my_snap_packages["hw-probe"]="硬件探測工具"

# 2. 程式開發
my_snap_packages["code"]="Visual Studio Code"
my_snap_packages["go"]="Go程式語言"
my_snap_packages["node"]="Node.js運行環境"
my_snap_packages["rustup"]="Rust工具鏈安裝器"

# 3. 容器與虛擬化
my_snap_packages["docker"]="Docker容器平台"
my_snap_packages["kubectl"]="Kubernetes命令行工具"
my_snap_packages["microk8s"]="輕量級Kubernetes"

# 4. 多媒體
my_snap_packages["vlc"]="媒體播放器"
my_snap_packages["obs-studio"]="錄屏和直播軟體"
my_snap_packages["gimp"]="圖像編輯器"
my_snap_packages["blender"]="3D建模和動畫軟體"
my_snap_packages["audacity"]="音頻編輯器"

# 5. 雲端與 DevOps 工具
my_snap_packages["terraform"]="基礎設施即代碼"
my_snap_packages["helm"]="Kubernetes包管理器"
my_snap_packages["aws-cli"]="AWS命令行工具"

# 6. 開發工具
my_snap_packages["discord"]="即時通訊軟體"
my_snap_packages["slack"]="團隊協作工具"
my_snap_packages["postman"]="API開發測試工具"
my_snap_packages["firefox"]="Firefox瀏覽器"
my_snap_packages["chromium"]="Chromium瀏覽器"

# 7. 文件處理與辦公
my_snap_packages["libreoffice"]="辦公軟體套件"

# 8. 實用工具
my_snap_packages["htop"]="進程監控工具"
my_snap_packages["tree"]="目錄樹顯示"
my_snap_packages["jq"]="JSON處理工具"

# 分類定義
declare -A categories
categories["monitoring"]="系統監控工具"
categories["development"]="程式開發"
categories["container"]="容器與虛擬化"
categories["multimedia"]="多媒體"
categories["devops"]="雲端與 DevOps 工具"
categories["tools"]="開發工具"
categories["office"]="文件處理與辦公"
categories["utilities"]="實用工具"

# 分類對應的軟體包
declare -A category_packages
category_packages["monitoring"]="btop hw-probe"
category_packages["development"]="code go node rustup"
category_packages["container"]="docker kubectl microk8s"
category_packages["multimedia"]="vlc obs-studio gimp blender audacity"
category_packages["devops"]="terraform helm aws-cli"
category_packages["tools"]="discord slack postman firefox chromium"
category_packages["office"]="libreoffice"
category_packages["utilities"]="htop tree jq"

# 顯示主選單
show_main_menu() {
    clear
    print_header "=================================================="
    print_header "           我的常用庫 SNAP 安裝器 v2"
    print_header "=================================================="
    echo
    echo "選擇安裝類別："
    echo
    local i=1
    for category in monitoring development container multimedia devops tools office utilities; do
        echo " [$i] ${categories[$category]}"
        ((i++))
    done
    echo
    echo " [A] 顯示所有套件"
    echo " [I] 安裝所有套件"
    echo " [R] 重新整理 snap"
    echo " [S] 顯示已安裝的 snap 套件"
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
            if [[ -n "${my_snap_packages[$pkg]}" ]]; then
                local mark=" "
                if [[ " ${selected_packages[*]} " =~ " $pkg " ]]; then
                    mark="✓"
                fi
                printf " [%s] %2d) %-20s - %s\n" "$mark" $i "$pkg" "${my_snap_packages[$pkg]}"
            fi
            ((i++))
        done
        echo
        echo "操作說明："
        echo " 輸入數字切換勾選    [A] 全選    [N] 全不選"
        echo " [I] 安裝已勾選      [B] 返回    [Q] 退出"

        if [ ${#selected_packages[@]} -gt 0 ]; then
            echo
            print_info "已勾選 ${#selected_packages[@]} 個套件"
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
                print_success "已全選所有套件"
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
                    print_warning "尚未勾選任何套件"
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
    print_header "              所有可用 SNAP 軟體包"
    print_header "=================================================="
    echo

    for category in monitoring development container multimedia devops tools office utilities; do
        echo -e "${YELLOW}${categories[$category]}:${NC}"
        local package_list=(${category_packages[$category]})
        for pkg in "${package_list[@]}"; do
            if [[ -n "${my_snap_packages[$pkg]}" ]]; then
                printf "  %-20s - %s\n" "$pkg" "${my_snap_packages[$pkg]}"
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
        print_warning "沒有選擇任何套件"
        return
    fi

    clear
    print_header "SNAP 套件安裝確認"
    echo
    print_info "準備安裝以下 SNAP 套件："
    for pkg in "${package_list[@]}"; do
        if [[ -n "${my_snap_packages[$pkg]}" ]]; then
            echo "  - $pkg: ${my_snap_packages[$pkg]}"
        else
            echo "  - $pkg"
        fi
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
    print_info "開始安裝 SNAP 套件..."

    local success_count=0
    local fail_count=0

    for pkg in "${package_list[@]}"; do
        print_info "正在安裝: $pkg"

        # 某些套件需要特殊安裝參數
        case $pkg in
            "code"|"kubectl"|"helm"|"microk8s"|"aws-cli")
                if sudo snap install "$pkg" --classic >/dev/null 2>&1; then
                    print_success "$pkg 安裝成功 (classic)"
                    ((success_count++))
                else
                    print_error "$pkg 安裝失敗"
                    ((fail_count++))
                fi
                ;;
            *)
                if sudo snap install "$pkg" >/dev/null 2>&1; then
                    print_success "$pkg 安裝成功"
                    ((success_count++))
                else
                    print_error "$pkg 安裝失敗"
                    ((fail_count++))
                fi
                ;;
        esac
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

# 安裝所有套件
install_all_packages() {
    local all_packages=()

    # 收集所有軟體包
    for category in monitoring development container multimedia devops tools office utilities; do
        local package_list=(${category_packages[$category]})
        all_packages+=("${package_list[@]}")
    done

    # 去重
    all_packages=($(printf "%s\n" "${all_packages[@]}" | sort -u))

    install_packages "${all_packages[@]}"
}

# 重新整理 snap
refresh_snap() {
    print_info "重新整理 snap 套件..."
    if sudo snap refresh; then
        print_success "snap 套件重新整理完成"
    else
        print_error "snap 套件重新整理失敗"
    fi
    echo -n "按Enter鍵繼續..."
    read -r
}

# 顯示已安裝的 snap 套件
show_installed_snaps() {
    clear
    print_header "已安裝的 SNAP 套件"
    echo
    snap list
    echo
    echo -n "按Enter鍵返回主選單..."
    read -r
}

# 主程序
main() {
    # 檢查 snapd
    check_snapd

    # 主循環
    while true; do
        show_main_menu
        read -r choice

        case $choice in
            "1") show_category_packages "monitoring" ;;
            "2") show_category_packages "development" ;;
            "3") show_category_packages "container" ;;
            "4") show_category_packages "multimedia" ;;
            "5") show_category_packages "devops" ;;
            "6") show_category_packages "tools" ;;
            "7") show_category_packages "office" ;;
            "8") show_category_packages "utilities" ;;
            [aA]) show_all_packages ;;
            [iI]) install_all_packages ;;
            [rR]) refresh_snap ;;
            [sS]) show_installed_snaps ;;
            [qQ])
                print_success "感謝使用我的常用庫 SNAP 安裝器！"
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