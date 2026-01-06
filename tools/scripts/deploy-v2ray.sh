#!/bin/bash
#
# V2Ray 代理部署脚本
# ==================
#
# 用途：在云服务器上安装和配置 V2Ray 代理，解决 GitHub 等国外服务访问问题
#
# 使用方法：
#   1. 上传到服务器：scp deploy-v2ray.sh user@server:/tmp/
#   2. 执行安装：sudo bash /tmp/deploy-v2ray.sh install
#   3. 配置节点：sudo bash /tmp/deploy-v2ray.sh config <subscription_url>
#   4. 启动服务：sudo bash /tmp/deploy-v2ray.sh start
#
# 网络排查指引（给其他 Agent）：
# ================================
# 如果遇到 GitHub 访问慢或超时，检查以下内容：
#
# 1. 检查 V2Ray 服务状态：
#    sudo systemctl status v2ray
#
# 2. 检查代理端口是否监听：
#    ss -tlnp | grep 1080
#
# 3. 测试代理连通性：
#    curl -x socks5://127.0.0.1:1080 https://api.github.com
#
# 4. Git 代理配置：
#    git config --global http.proxy socks5://127.0.0.1:1080
#    git config --global https.proxy socks5://127.0.0.1:1080
#
# 5. 临时使用代理执行命令：
#    ALL_PROXY=socks5://127.0.0.1:1080 curl https://github.com
#
# 6. 如果节点失效，更换节点：
#    sudo bash /opt/v2ray/deploy-v2ray.sh switch <node_index>
#
# 配置文件位置：
#   - V2Ray 配置：/etc/v2ray/config.json
#   - 节点列表：/opt/v2ray/nodes.json
#   - 本脚本：/opt/v2ray/deploy-v2ray.sh
#
# 代理端口：127.0.0.1:1080 (SOCKS5)
#

set -e

V2RAY_VERSION="5.22.0"
V2RAY_DIR="/usr/local/share/v2ray"
CONFIG_DIR="/etc/v2ray"
DATA_DIR="/opt/v2ray"
SOCKS_PORT=1080

# 颜色输出
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

log_info() { echo -e "${GREEN}[INFO]${NC} $1"; }
log_warn() { echo -e "${YELLOW}[WARN]${NC} $1"; }
log_error() { echo -e "${RED}[ERROR]${NC} $1"; }

# 安装 V2Ray
install_v2ray() {
    log_info "安装 V2Ray v${V2RAY_VERSION}..."
    
    # 创建目录
    mkdir -p "$V2RAY_DIR" "$CONFIG_DIR" "$DATA_DIR"
    
    # 下载（如果本地没有）
    local zip_file="$DATA_DIR/v2ray-linux-64.zip"
    if [ ! -f "$zip_file" ]; then
        log_info "下载 V2Ray..."
        # 优先从 GitHub 下载，如果失败则提示手动上传
        if ! curl -L -o "$zip_file" \
            "https://github.com/v2fly/v2ray-core/releases/download/v${V2RAY_VERSION}/v2ray-linux-64.zip" 2>/dev/null; then
            log_warn "自动下载失败，请手动上传 v2ray-linux-64.zip 到 $zip_file"
            log_warn "下载地址：https://github.com/v2fly/v2ray-core/releases"
            exit 1
        fi
    fi
    
    # 解压
    log_info "解压 V2Ray..."
    unzip -o "$zip_file" -d "$V2RAY_DIR"
    chmod +x "$V2RAY_DIR/v2ray"
    
    # 创建 systemd 服务
    cat > /etc/systemd/system/v2ray.service << 'EOF'
[Unit]
Description=V2Ray Service
After=network.target

[Service]
Type=simple
ExecStart=/usr/local/share/v2ray/v2ray run -c /etc/v2ray/config.json
Restart=on-failure
RestartSec=5

[Install]
WantedBy=multi-user.target
EOF

    systemctl daemon-reload
    systemctl enable v2ray
    
    # 复制本脚本到数据目录
    cp "$0" "$DATA_DIR/deploy-v2ray.sh"
    chmod +x "$DATA_DIR/deploy-v2ray.sh"
    
    log_info "V2Ray 安装完成"
    log_info "配置文件: $CONFIG_DIR/config.json"
    log_info "管理脚本: $DATA_DIR/deploy-v2ray.sh"
}

# 配置 VMess 节点
config_vmess() {
    local address="$1"
    local port="$2"
    local uuid="$3"
    local alter_id="${4:-0}"
    local network="${5:-tcp}"
    
    log_info "配置 VMess 节点: $address:$port"
    
    cat > "$CONFIG_DIR/config.json" << EOF
{
  "inbounds": [{
    "port": $SOCKS_PORT,
    "listen": "127.0.0.1",
    "protocol": "socks",
    "settings": {
      "udp": true
    }
  }],
  "outbounds": [{
    "protocol": "vmess",
    "settings": {
      "vnext": [{
        "address": "$address",
        "port": $port,
        "users": [{
          "id": "$uuid",
          "alterId": $alter_id,
          "security": "auto"
        }]
      }]
    },
    "streamSettings": {
      "network": "$network"
    }
  }]
}
EOF

    log_info "配置已保存到 $CONFIG_DIR/config.json"
}

# 解析订阅链接（简化版，只支持 VMess）
parse_subscription() {
    local sub_url="$1"
    log_info "解析订阅链接..."
    
    # 下载并解码订阅内容
    local content
    content=$(curl -s "$sub_url" | base64 -d 2>/dev/null || echo "")
    
    if [ -z "$content" ]; then
        log_error "无法解析订阅链接"
        exit 1
    fi
    
    # 保存原始节点列表
    echo "$content" > "$DATA_DIR/nodes.txt"
    
    # 解析第一个 VMess 节点
    local first_node
    first_node=$(echo "$content" | head -n 1)
    
    if [[ "$first_node" == vmess://* ]]; then
        local json
        json=$(echo "${first_node#vmess://}" | base64 -d 2>/dev/null)
        
        local address port uuid aid net
        address=$(echo "$json" | jq -r '.add // .address')
        port=$(echo "$json" | jq -r '.port')
        uuid=$(echo "$json" | jq -r '.id')
        aid=$(echo "$json" | jq -r '.aid // 0')
        net=$(echo "$json" | jq -r '.net // "tcp"')
        
        config_vmess "$address" "$port" "$uuid" "$aid" "$net"
    else
        log_error "不支持的节点类型，请手动配置"
        exit 1
    fi
}

# 切换节点
switch_node() {
    local index="${1:-1}"
    
    if [ ! -f "$DATA_DIR/nodes.txt" ]; then
        log_error "没有节点列表，请先配置订阅"
        exit 1
    fi
    
    local node
    node=$(sed -n "${index}p" "$DATA_DIR/nodes.txt")
    
    if [ -z "$node" ]; then
        log_error "节点 $index 不存在"
        log_info "可用节点数量: $(wc -l < "$DATA_DIR/nodes.txt")"
        exit 1
    fi
    
    log_info "切换到节点 $index..."
    
    if [[ "$node" == vmess://* ]]; then
        local json
        json=$(echo "${node#vmess://}" | base64 -d 2>/dev/null)
        
        local address port uuid aid net ps
        address=$(echo "$json" | jq -r '.add // .address')
        port=$(echo "$json" | jq -r '.port')
        uuid=$(echo "$json" | jq -r '.id')
        aid=$(echo "$json" | jq -r '.aid // 0')
        net=$(echo "$json" | jq -r '.net // "tcp"')
        ps=$(echo "$json" | jq -r '.ps // "unknown"')
        
        log_info "节点名称: $ps"
        config_vmess "$address" "$port" "$uuid" "$aid" "$net"
        
        # 重启服务
        systemctl restart v2ray
        log_info "节点已切换并重启服务"
    fi
}

# 配置 Git 代理
config_git_proxy() {
    log_info "配置 Git 代理..."
    git config --global http.proxy "socks5://127.0.0.1:$SOCKS_PORT"
    git config --global https.proxy "socks5://127.0.0.1:$SOCKS_PORT"
    log_info "Git 代理已配置"
}

# 移除 Git 代理
remove_git_proxy() {
    log_info "移除 Git 代理..."
    git config --global --unset http.proxy || true
    git config --global --unset https.proxy || true
    log_info "Git 代理已移除"
}

# 测试连接
test_connection() {
    log_info "测试代理连接..."
    
    # 测试本地代理
    if ss -tlnp | grep -q ":$SOCKS_PORT"; then
        log_info "✓ 代理端口 $SOCKS_PORT 已监听"
    else
        log_error "✗ 代理端口 $SOCKS_PORT 未监听"
        return 1
    fi
    
    # 测试 GitHub 连接
    if curl -s -x "socks5://127.0.0.1:$SOCKS_PORT" --connect-timeout 10 \
        "https://api.github.com" > /dev/null; then
        log_info "✓ GitHub API 连接正常"
    else
        log_error "✗ GitHub API 连接失败"
        return 1
    fi
    
    log_info "代理测试通过"
}

# 显示状态
show_status() {
    echo ""
    echo "V2Ray 代理状态"
    echo "=============="
    
    # 服务状态
    if systemctl is-active --quiet v2ray; then
        echo -e "服务状态: ${GREEN}运行中${NC}"
    else
        echo -e "服务状态: ${RED}已停止${NC}"
    fi
    
    # 端口状态
    if ss -tlnp | grep -q ":$SOCKS_PORT"; then
        echo -e "代理端口: ${GREEN}$SOCKS_PORT (监听中)${NC}"
    else
        echo -e "代理端口: ${RED}$SOCKS_PORT (未监听)${NC}"
    fi
    
    # Git 代理
    local git_proxy
    git_proxy=$(git config --global http.proxy 2>/dev/null || echo "未配置")
    echo "Git 代理: $git_proxy"
    
    # 节点信息
    if [ -f "$CONFIG_DIR/config.json" ]; then
        local addr port
        addr=$(jq -r '.outbounds[0].settings.vnext[0].address' "$CONFIG_DIR/config.json" 2>/dev/null)
        port=$(jq -r '.outbounds[0].settings.vnext[0].port' "$CONFIG_DIR/config.json" 2>/dev/null)
        echo "当前节点: $addr:$port"
    fi
    
    echo ""
}

# 帮助信息
show_help() {
    echo "V2Ray 代理管理脚本"
    echo ""
    echo "用法: $0 <命令> [参数]"
    echo ""
    echo "命令:"
    echo "  install              安装 V2Ray"
    echo "  config <sub_url>     从订阅链接配置节点"
    echo "  switch <index>       切换到指定节点（从1开始）"
    echo "  start                启动服务"
    echo "  stop                 停止服务"
    echo "  restart              重启服务"
    echo "  status               查看状态"
    echo "  test                 测试连接"
    echo "  git-proxy            配置 Git 代理"
    echo "  git-unproxy          移除 Git 代理"
    echo "  help                 显示帮助"
    echo ""
    echo "快速排查网络问题:"
    echo "  1. 检查状态: $0 status"
    echo "  2. 测试连接: $0 test"
    echo "  3. 切换节点: $0 switch 2"
    echo "  4. 重启服务: $0 restart"
}

# 主入口
case "${1:-help}" in
    install)
        install_v2ray
        ;;
    config)
        parse_subscription "$2"
        ;;
    switch)
        switch_node "$2"
        ;;
    start)
        systemctl start v2ray
        log_info "V2Ray 已启动"
        ;;
    stop)
        systemctl stop v2ray
        log_info "V2Ray 已停止"
        ;;
    restart)
        systemctl restart v2ray
        log_info "V2Ray 已重启"
        ;;
    status)
        show_status
        ;;
    test)
        test_connection
        ;;
    git-proxy)
        config_git_proxy
        ;;
    git-unproxy)
        remove_git_proxy
        ;;
    help|--help|-h)
        show_help
        ;;
    *)
        log_error "未知命令: $1"
        show_help
        exit 1
        ;;
esac
