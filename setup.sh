#!/bin/bash
# llm-wiki 依赖安装脚本
# 从 deps/ 目录安装素材提取所需的配套 skill
set -e

SKILLS_DIR="$HOME/.claude/skills"
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
DEPS_DIR="$SCRIPT_DIR/deps"

# 颜色输出
info()  { echo "\033[36m[信息]\033[0m $1"; }
ok()    { echo "\033[32m[完成]\033[0m $1"; }
warn()  { echo "\033[33m[警告]\033[0m $1"; }
err()   { echo "\033[31m[错误]\033[0m $1"; }

echo ""
echo "================================"
echo "  llm-wiki 依赖安装"
echo "================================"
echo ""

# 检查 deps 目录是否存在
if [ ! -d "$DEPS_DIR" ]; then
    err "未找到 deps/ 目录"
    echo "  请确保是从完整仓库克隆的（包含 deps/ 目录）"
    exit 1
fi

# 定义依赖：目录名 → 说明
declare -A DEPS
DEPS=(
    ["baoyu-url-to-markdown"]="网页和公众号文章提取"
    ["x-article-extractor"]="X (Twitter) 内容提取"
    ["youtube-transcript"]="YouTube 字幕提取"
)

INSTALLED=0
SKIPPED=0
MISSING_SOURCE=()

for skill_name in "${!DEPS[@]}"; do
    if [ -d "$SKILLS_DIR/$skill_name" ]; then
        ok "$skill_name 已安装（${DEPS[$skill_name]}）"
        SKIPPED=$((SKIPPED + 1))
    elif [ -d "$DEPS_DIR/$skill_name" ]; then
        info "安装 $skill_name（${DEPS[$skill_name]}）..."
        cp -r "$DEPS_DIR/$skill_name" "$SKILLS_DIR/$skill_name"
        ok "$skill_name 安装完成"
        INSTALLED=$((INSTALLED + 1))
    else
        warn "$skill_name：deps/ 中未找到源文件"
        MISSING_SOURCE+=("$skill_name")
    fi
done

echo ""
echo "================================"

if [ $INSTALLED -gt 0 ]; then
    ok "新安装 $INSTALLED 个依赖，跳过 $SKIPPED 个（已存在）"
fi

if [ ${#MISSING_SOURCE[@]} -gt 0 ]; then
    echo ""
    warn "以下 skill 在 deps/ 中缺失，可尝试手动安装："
    for skill_name in "${MISSING_SOURCE[@]}"; do
        echo "  npx skills add $skill_name"
    done
fi

echo ""
echo "提示：即使部分依赖缺失，llm-wiki 仍可使用："
echo "  - 缺少 baoyu-url-to-markdown → 无法自动提取网页/公众号"
echo "  - 缺少 x-article-extractor → 无法自动提取 X/Twitter 内容"
echo "  - 缺少 youtube-transcript → 无法自动提取 YouTube 字幕"
echo "  - 上述情况可以手动粘贴文本内容作为替代"
