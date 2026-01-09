#!/bin/bash
# =============================================================================
# GitHub Actions Self-Hosted Runner 安装脚本
# 
# 用途: 在腾讯云 Ubuntu 服务器上安装和配置 GitHub Actions self-hosted runner
# 服务器: 193.112.183.143 (Ubuntu 22.04 LTS)
# =============================================================================

set -e

# =============================================================================
# 配置变量（需要在运行前设置）
# =============================================================================
RUNNER_VERSION="${RUNNER_VERSION:-2.321.0}"
REPO_OWNER="${REPO_OWNER:-TeamFlint-Dev}"
REPO_NAME="${REPO_NAME:-vibe-coding-cn}"
RUNNER_NAME="${RUNNER_NAME:-tencent-cloud-runner}"
RUNNER_LABELS="${RUNNER_LABELS:-self-hosted,linux,x64,tencent-cloud}"
RUNNER_WORK_DIR="${RUNNER_WORK_DIR:-/opt/actions-runner/_work}"
RUNNER_INSTALL_DIR="${RUNNER_INSTALL_DIR:-/opt/actions-runner}"
RUNNER_USER="${RUNNER_USER:-ubuntu}"

# =============================================================================
# 颜色定义
# =============================================================================
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

log_info() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

log_warn() {
    echo -e "${YELLOW}[WARN]${NC} $1"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# =============================================================================
# 前置检查
# =============================================================================
check_prerequisites() {
    log_info "检查前置条件..."
    
    # 检查是否为 root 或有 sudo 权限
    if [[ $EUID -ne 0 ]]; then
        if ! sudo -n true 2>/dev/null; then
            log_error "需要 root 权限或 sudo 权限"
            exit 1
        fi
    fi
    
    # 检查 RUNNER_CFG_PAT 环境变量
    if [[ -z "${RUNNER_CFG_PAT}" ]]; then
        log_error "请设置 RUNNER_CFG_PAT 环境变量（GitHub PAT，需要 repo 和 admin:repo_hook 权限）"
        echo ""
        echo "示例:"
        echo "  export RUNNER_CFG_PAT='ghp_xxxxxxxxxxxxxxxxxxxx'"
        echo ""
        echo "PAT 需要以下权限:"
        echo "  - repo (Full control of private repositories)"
        echo "  - admin:repo_hook (管理 repository hooks) - 可选"
        echo ""
        exit 1
    fi
    
    log_info "前置检查通过"
}

# =============================================================================
# 停止并清理旧的 webhook 服务
# =============================================================================
cleanup_old_webhook() {
    log_info "清理旧的 webhook 服务..."
    
    # 停止 webhook 服务
    if sudo systemctl is-active --quiet webhook 2>/dev/null; then
        log_info "停止 webhook 服务..."
        sudo systemctl stop webhook
        sudo systemctl disable webhook
    fi
    
    # 备份旧配置
    if [[ -d "/opt/webhook" ]]; then
        BACKUP_DIR="/opt/webhook-backup-$(date +%Y%m%d-%H%M%S)"
        log_info "备份旧 webhook 目录到 $BACKUP_DIR..."
        sudo mv /opt/webhook "$BACKUP_DIR"
    fi
    
    log_info "旧服务清理完成"
}

# =============================================================================
# 安装系统依赖
# =============================================================================
install_dependencies() {
    log_info "安装系统依赖..."
    
    sudo apt-get update
    sudo apt-get install -y \
        curl \
        jq \
        git \
        libicu-dev \
        libssl-dev \
        libkrb5-3 \
        zlib1g \
        build-essential
    
    log_info "系统依赖安装完成"
}

# =============================================================================
# 获取注册令牌
# =============================================================================
get_registration_token() {
    log_info "获取 Runner 注册令牌..."
    
    REGISTRATION_TOKEN=$(curl -s -X POST \
        -H "Authorization: token ${RUNNER_CFG_PAT}" \
        -H "Accept: application/vnd.github+json" \
        "https://api.github.com/repos/${REPO_OWNER}/${REPO_NAME}/actions/runners/registration-token" \
        | jq -r '.token')
    
    if [[ -z "${REGISTRATION_TOKEN}" || "${REGISTRATION_TOKEN}" == "null" ]]; then
        log_error "获取注册令牌失败，请检查 PAT 权限"
        exit 1
    fi
    
    log_info "注册令牌获取成功"
}

# =============================================================================
# 下载并安装 Runner
# =============================================================================
install_runner() {
    log_info "安装 GitHub Actions Runner v${RUNNER_VERSION}..."
    
    # 创建安装目录
    sudo mkdir -p "${RUNNER_INSTALL_DIR}"
    sudo chown "${RUNNER_USER}:${RUNNER_USER}" "${RUNNER_INSTALL_DIR}"
    
    cd "${RUNNER_INSTALL_DIR}"
    
    # 下载 runner
    RUNNER_PACKAGE="actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz"
    RUNNER_URL="https://github.com/actions/runner/releases/download/v${RUNNER_VERSION}/${RUNNER_PACKAGE}"
    
    if [[ ! -f "${RUNNER_PACKAGE}" ]]; then
        log_info "下载 Runner 包..."
        curl -O -L "${RUNNER_URL}"
    fi
    
    # 解压
    log_info "解压 Runner 包..."
    tar xzf "./${RUNNER_PACKAGE}"
    
    # 安装依赖
    log_info "安装 Runner 依赖..."
    sudo ./bin/installdependencies.sh
    
    log_info "Runner 安装完成"
}

# =============================================================================
# 配置 Runner
# =============================================================================
configure_runner() {
    log_info "配置 Runner..."
    
    cd "${RUNNER_INSTALL_DIR}"
    
    # 如果已配置，先移除
    if [[ -f ".runner" ]]; then
        log_warn "检测到已有配置，先移除..."
        ./config.sh remove --token "${REGISTRATION_TOKEN}" || true
    fi
    
    # 配置 runner
    ./config.sh \
        --url "https://github.com/${REPO_OWNER}/${REPO_NAME}" \
        --token "${REGISTRATION_TOKEN}" \
        --name "${RUNNER_NAME}" \
        --labels "${RUNNER_LABELS}" \
        --work "${RUNNER_WORK_DIR}" \
        --unattended \
        --replace
    
    log_info "Runner 配置完成"
}

# =============================================================================
# 安装为系统服务
# =============================================================================
install_service() {
    log_info "安装 Runner 为系统服务..."
    
    cd "${RUNNER_INSTALL_DIR}"
    
    # 安装服务
    sudo ./svc.sh install "${RUNNER_USER}"
    
    # 启动服务
    sudo ./svc.sh start
    
    # 检查状态
    sudo ./svc.sh status
    
    log_info "Runner 服务安装并启动完成"
}

# =============================================================================
# 验证安装
# =============================================================================
verify_installation() {
    log_info "验证安装..."
    
    # 检查服务状态
    if sudo systemctl is-active --quiet "actions.runner.${REPO_OWNER}-${REPO_NAME}.${RUNNER_NAME}.service"; then
        log_info "✅ Runner 服务正在运行"
    else
        log_error "❌ Runner 服务未运行"
        exit 1
    fi
    
    # 显示 runner 信息
    echo ""
    echo "=============================================="
    echo "GitHub Actions Self-Hosted Runner 安装完成!"
    echo "=============================================="
    echo ""
    echo "Runner 信息:"
    echo "  - 名称: ${RUNNER_NAME}"
    echo "  - 标签: ${RUNNER_LABELS}"
    echo "  - 仓库: ${REPO_OWNER}/${REPO_NAME}"
    echo "  - 安装目录: ${RUNNER_INSTALL_DIR}"
    echo "  - 工作目录: ${RUNNER_WORK_DIR}"
    echo ""
    echo "管理命令:"
    echo "  查看状态: sudo ${RUNNER_INSTALL_DIR}/svc.sh status"
    echo "  停止服务: sudo ${RUNNER_INSTALL_DIR}/svc.sh stop"
    echo "  启动服务: sudo ${RUNNER_INSTALL_DIR}/svc.sh start"
    echo "  重启服务: sudo systemctl restart actions.runner.${REPO_OWNER}-${REPO_NAME}.${RUNNER_NAME}.service"
    echo "  查看日志: sudo journalctl -u actions.runner.${REPO_OWNER}-${REPO_NAME}.${RUNNER_NAME}.service -f"
    echo ""
    echo "在 workflow 中使用:"
    echo "  runs-on: [self-hosted, linux, x64, tencent-cloud]"
    echo ""
}

# =============================================================================
# 主流程
# =============================================================================
main() {
    echo ""
    echo "========================================================"
    echo "  GitHub Actions Self-Hosted Runner 安装脚本"
    echo "  目标: ${REPO_OWNER}/${REPO_NAME}"
    echo "========================================================"
    echo ""
    
    check_prerequisites
    cleanup_old_webhook
    install_dependencies
    get_registration_token
    install_runner
    configure_runner
    install_service
    verify_installation
}

# 运行主函数
main "$@"
