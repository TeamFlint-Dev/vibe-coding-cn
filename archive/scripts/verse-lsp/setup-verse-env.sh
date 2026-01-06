#!/usr/bin/env bash
# Verse LSP 环境设置脚本
# 用途：从 VSIX 提取 LSP 二进制，同步 digest 文件

set -euo pipefail

# 颜色输出
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# 脚本所在目录
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "${SCRIPT_DIR}/../.." && pwd)"

# 配置路径
VSIX_PATH="${REPO_ROOT}/libs/external/vscode-verse/Verse.vsix"
SDK_DIR="${REPO_ROOT}/.verse-sdk"
BIN_DIR="${SDK_DIR}/bin"
DIGEST_DIR="${SDK_DIR}/digests"
TEMP_DIR="${SDK_DIR}/temp"

# digest 仓库信息
DIGEST_REPO_URL="https://github.com/vz-creates/uefn.git"
DIGEST_REPO_TAG="v39.11"

# 日志函数
log_info() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

log_warn() {
    echo -e "${YELLOW}[WARN]${NC} $1"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# 检查依赖
check_dependencies() {
    log_info "检查依赖..."
    
    if ! command -v unzip &> /dev/null; then
        log_error "未找到 unzip 命令，请先安装"
        exit 1
    fi
    
    if ! command -v git &> /dev/null; then
        log_error "未找到 git 命令，请先安装"
        exit 1
    fi
    
    log_info "依赖检查通过"
}

# 检查 VSIX 文件
check_vsix() {
    log_info "检查 VSIX 文件..."
    
    if [ ! -f "${VSIX_PATH}" ]; then
        log_error "未找到 VSIX 文件: ${VSIX_PATH}"
        exit 1
    fi
    
    log_info "找到 VSIX 文件: ${VSIX_PATH}"
}

# 创建目录结构
create_directories() {
    log_info "创建目录结构..."
    
    mkdir -p "${BIN_DIR}"/{Linux,Mac,Win64}
    mkdir -p "${DIGEST_DIR}"
    mkdir -p "${TEMP_DIR}"
    
    log_info "目录结构创建完成"
}

# 提取 LSP 二进制
extract_lsp_binaries() {
    log_info "从 VSIX 提取 LSP 二进制..."
    
    # 清理临时目录
    rm -rf "${TEMP_DIR}"/*
    
    # 解压 VSIX
    log_info "解压 VSIX..."
    unzip -q "${VSIX_PATH}" -d "${TEMP_DIR}"
    
    # 提取各平台的二进制文件
    local platforms=("Linux" "Mac" "Win64")
    
    for platform in "${platforms[@]}"; do
        log_info "提取 ${platform} 二进制..."
        
        if [ "${platform}" = "Win64" ]; then
            local binary_name="verse-lsp.exe"
        else
            local binary_name="verse-lsp"
        fi
        
        local source_path="${TEMP_DIR}/extension/bin/${platform}/${binary_name}"
        local target_path="${BIN_DIR}/${platform}/${binary_name}"
        
        if [ -f "${source_path}" ]; then
            cp "${source_path}" "${target_path}"
            chmod +x "${target_path}" 2>/dev/null || true
            log_info "✓ ${platform}/${binary_name}"
        else
            log_warn "未找到 ${platform} 二进制: ${source_path}"
        fi
    done
    
    # 复制 Mac 的依赖库
    if [ -d "${TEMP_DIR}/extension/bin/Mac" ]; then
        log_info "复制 Mac 依赖库..."
        cp "${TEMP_DIR}/extension/bin/Mac/"*.dylib "${BIN_DIR}/Mac/" 2>/dev/null || true
    fi
    
    # 清理临时文件
    rm -rf "${TEMP_DIR}"
    
    log_info "LSP 二进制提取完成"
}

# 克隆 digest 文件
clone_digest_files() {
    log_info "克隆 digest 文件..."
    
    local temp_repo="${TEMP_DIR}/uefn-repo"
    
    # 克隆特定标签
    log_info "克隆 ${DIGEST_REPO_URL} (${DIGEST_REPO_TAG})..."
    git clone --depth 1 --branch "${DIGEST_REPO_TAG}" "${DIGEST_REPO_URL}" "${temp_repo}" 2>/dev/null || {
        log_warn "标签 ${DIGEST_REPO_TAG} 不存在，尝试克隆最新版本..."
        git clone --depth 1 "${DIGEST_REPO_URL}" "${temp_repo}"
    }
    
    # 复制 digest 文件
    local digest_source="${temp_repo}/Modules/FortniteGame"
    
    if [ -d "${digest_source}" ]; then
        log_info "复制 digest 文件..."
        
        # 复制 Fortnite digest
        if [ -f "${digest_source}/Fortnite/Fortnite.digest.verse" ]; then
            cp "${digest_source}/Fortnite/Fortnite.digest.verse" "${DIGEST_DIR}/"
            log_info "✓ Fortnite.digest.verse"
        fi
        
        # 复制 UnrealEngine digest
        if [ -f "${digest_source}/UnrealEngine/UnrealEngine.digest.verse" ]; then
            cp "${digest_source}/UnrealEngine/UnrealEngine.digest.verse" "${DIGEST_DIR}/"
            log_info "✓ UnrealEngine.digest.verse"
        fi
        
        # 复制 Verse digest
        if [ -f "${digest_source}/Verse/Verse.digest.verse" ]; then
            cp "${digest_source}/Verse/Verse.digest.verse" "${DIGEST_DIR}/"
            log_info "✓ Verse.digest.verse"
        fi
    else
        log_error "未找到 digest 文件目录: ${digest_source}"
        rm -rf "${temp_repo}"
        exit 1
    fi
    
    # 清理临时仓库
    rm -rf "${temp_repo}"
    
    log_info "Digest 文件同步完成"
}

# 验证安装
verify_installation() {
    log_info "验证安装..."
    
    local all_ok=true
    
    # 检查二进制文件
    log_info "检查 LSP 二进制..."
    
    if [ -f "${BIN_DIR}/Linux/verse-lsp" ]; then
        log_info "✓ Linux/verse-lsp"
    else
        log_warn "✗ Linux/verse-lsp 未找到"
        all_ok=false
    fi
    
    if [ -f "${BIN_DIR}/Mac/verse-lsp" ]; then
        log_info "✓ Mac/verse-lsp"
    else
        log_warn "✗ Mac/verse-lsp 未找到"
        all_ok=false
    fi
    
    if [ -f "${BIN_DIR}/Win64/verse-lsp.exe" ]; then
        log_info "✓ Win64/verse-lsp.exe"
    else
        log_warn "✗ Win64/verse-lsp.exe 未找到"
        all_ok=false
    fi
    
    # 检查 digest 文件
    log_info "检查 digest 文件..."
    
    local digests=("Fortnite.digest.verse" "UnrealEngine.digest.verse" "Verse.digest.verse")
    for digest in "${digests[@]}"; do
        if [ -f "${DIGEST_DIR}/${digest}" ]; then
            log_info "✓ ${digest}"
        else
            log_warn "✗ ${digest} 未找到"
            all_ok=false
        fi
    done
    
    if [ "${all_ok}" = true ]; then
        log_info "✓ 所有组件验证通过"
        return 0
    else
        log_warn "部分组件未找到，但可以继续使用"
        return 1
    fi
}

# 显示使用信息
show_usage_info() {
    log_info "=========================================="
    log_info "Verse LSP 环境设置完成！"
    log_info "=========================================="
    echo ""
    echo "安装位置: ${SDK_DIR}"
    echo ""
    echo "LSP 二进制:"
    echo "  - Linux:  ${BIN_DIR}/Linux/verse-lsp"
    echo "  - Mac:    ${BIN_DIR}/Mac/verse-lsp"
    echo "  - Win64:  ${BIN_DIR}/Win64/verse-lsp.exe"
    echo ""
    echo "Digest 文件: ${DIGEST_DIR}"
    echo ""
    echo "使用方法:"
    echo "  1. 安装 Python 依赖: pip install -r scripts/verse-lsp/requirements.txt"
    echo "  2. 检查 Verse 代码: python scripts/verse-lsp/check-verse.py <file.verse>"
    echo "  3. Python API: from libs.common.verse_lsp_checker import VerseChecker"
    echo ""
}

# 主函数
main() {
    log_info "开始设置 Verse LSP 环境..."
    
    check_dependencies
    check_vsix
    create_directories
    extract_lsp_binaries
    clone_digest_files
    verify_installation || true
    show_usage_info
    
    log_info "完成！"
}

# 运行主函数
main "$@"
