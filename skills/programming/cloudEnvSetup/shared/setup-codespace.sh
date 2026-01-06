#!/bin/bash
# Codespaces 环境初始化脚本
# 使用方法: source ./setup-codespace.sh
# 前提: 需要在 Codespaces Secrets 中配置 SSH_PRIVATE_KEY, SERVER_IP, SSH_USER, SSH_PORT

set -e

echo "🚀 Setting up Codespaces environment..."

# ==================== SSH 配置 ====================
if [ -n "$SSH_PRIVATE_KEY" ]; then
    echo "📦 Configuring SSH..."
    
    mkdir -p ~/.ssh
    chmod 700 ~/.ssh
    
    # 写入私钥
    echo "$SSH_PRIVATE_KEY" > ~/.ssh/tencent-agent.pem
    chmod 600 ~/.ssh/tencent-agent.pem
    
    # 添加 known_hosts
    if [ -n "$SERVER_IP" ]; then
        ssh-keyscan -H "$SERVER_IP" >> ~/.ssh/known_hosts 2>/dev/null || true
    fi
    
    # 创建 SSH config
    cat > ~/.ssh/config << EOF
# 腾讯云 Webhook 服务器
Host tencent
    HostName ${SERVER_IP:-193.112.183.143}
    User ${SSH_USER:-ubuntu}
    Port ${SSH_PORT:-22}
    IdentityFile ~/.ssh/tencent-agent.pem
    StrictHostKeyChecking no
    ServerAliveInterval 60
    ServerAliveCountMax 3

# 默认配置
Host *
    AddKeysToAgent yes
EOF
    
    chmod 600 ~/.ssh/config
    echo "✅ SSH configured. Connect with: ssh tencent"
else
    echo "⚠️  SSH_PRIVATE_KEY not found in environment. SSH not configured."
    echo "   Please add it to Codespaces Secrets in repo settings."
fi

# ==================== Git 配置 ====================
echo "📦 Configuring Git..."

# 设置默认分支名
git config --global init.defaultBranch main

# 设置常用别名
git config --global alias.st status
git config --global alias.co checkout
git config --global alias.br branch
git config --global alias.ci commit
git config --global alias.lg "log --oneline --graph --decorate"

echo "✅ Git configured"

# ==================== 验证连接 ====================
if [ -n "$SERVER_IP" ] && [ -n "$SSH_PRIVATE_KEY" ]; then
    echo ""
    echo "🔍 Testing server connection..."
    if ssh -o ConnectTimeout=5 tencent "echo 'Connection successful'" 2>/dev/null; then
        echo "✅ Server connection verified"
    else
        echo "⚠️  Could not connect to server. Check network/firewall."
    fi
fi

# ==================== 环境变量导出 ====================
echo ""
echo "📋 Available environment variables:"
echo "   SERVER_IP: ${SERVER_IP:-<not set>}"
echo "   SSH_USER: ${SSH_USER:-<not set>}"
echo "   SSH_PORT: ${SSH_PORT:-<not set>}"
echo "   WEBHOOK_PORT: ${WEBHOOK_PORT:-<not set>}"

# ==================== 快捷命令 ====================
echo ""
echo "🎯 Quick commands:"
echo "   ssh tencent              - Connect to server"
echo "   ssh tencent 'command'    - Run remote command"
echo ""
echo "🚀 Codespaces environment ready!"
