#!/bin/bash
# Verse 代码分析脚本 (Linux/macOS)
# 用法: ./analyze.sh [--format <text|json|jsonl|markdown|agent>]

FORMAT="agent"

# Parse arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        --format)
            FORMAT="$2"
            shift 2
            ;;
        *)
            echo "Unknown option: $1"
            echo "Usage: $0 [--format <text|json|jsonl|markdown|agent>]"
            exit 1
            ;;
    esac
done

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
VERSE_LSP="$SCRIPT_DIR/bin/linux/VerseLspCE-Linux-Shipping"
VPROJECT="$SCRIPT_DIR/VibeCodingCN.vproject"

if [ ! -f "$VERSE_LSP" ]; then
    echo "Error: VerseLspCE not found at: $VERSE_LSP"
    exit 1
fi

if [ ! -f "$VPROJECT" ]; then
    echo "Error: vproject file not found at: $VPROJECT"
    exit 1
fi

# Make executable if not already
chmod +x "$VERSE_LSP" 2>/dev/null

echo "Analyzing Verse code..."
"$VERSE_LSP" --analyze "$VPROJECT" --format "$FORMAT"
EXIT_CODE=$?

if [ $EXIT_CODE -eq 0 ]; then
    echo -e "\n✅ Analysis completed successfully!"
else
    echo -e "\n❌ Analysis found issues (exit code: $EXIT_CODE)"
fi

exit $EXIT_CODE
