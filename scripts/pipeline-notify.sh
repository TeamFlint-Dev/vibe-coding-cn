#!/bin/bash
# pipeline-notify - 流水线事件通知工具 (Shell 包装器)
#
# 用于 GitHub Actions 中调用，封装 Python CLI 工具
#
# 用法:
#   ./pipeline-notify ready --pipeline-id p001 --type skills-distill --stages "ingest,classify,extract"
#   ./pipeline-notify status --pipeline-id p001
#   ./pipeline-notify health

set -e

# 获取脚本所在目录
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# 查找 Python 解释器
PYTHON=""
if command -v python3 &> /dev/null; then
    PYTHON="python3"
elif command -v python &> /dev/null; then
    PYTHON="python"
else
    echo "Error: Python not found"
    exit 1
fi

# 查找 pipeline-notify.py 的位置
# 优先级: 同目录 > .github/tools > scripts/
NOTIFY_SCRIPT=""

if [ -f "$SCRIPT_DIR/pipeline-notify.py" ]; then
    NOTIFY_SCRIPT="$SCRIPT_DIR/pipeline-notify.py"
elif [ -f "$SCRIPT_DIR/../.github/tools/pipeline-notify.py" ]; then
    NOTIFY_SCRIPT="$SCRIPT_DIR/../.github/tools/pipeline-notify.py"
elif [ -f "$(git rev-parse --show-toplevel 2>/dev/null)/.github/tools/pipeline-notify.py" ]; then
    NOTIFY_SCRIPT="$(git rev-parse --show-toplevel)/.github/tools/pipeline-notify.py"
elif [ -f "$(git rev-parse --show-toplevel 2>/dev/null)/scripts/pipeline-notify.py" ]; then
    NOTIFY_SCRIPT="$(git rev-parse --show-toplevel)/scripts/pipeline-notify.py"
fi

if [ -z "$NOTIFY_SCRIPT" ] || [ ! -f "$NOTIFY_SCRIPT" ]; then
    echo "Error: pipeline-notify.py not found"
    echo "Searched in:"
    echo "  - $SCRIPT_DIR/pipeline-notify.py"
    echo "  - .github/tools/pipeline-notify.py"
    echo "  - scripts/pipeline-notify.py"
    exit 1
fi

# 执行 Python 脚本
exec "$PYTHON" "$NOTIFY_SCRIPT" "$@"
