#!/bin/bash
# llm-wiki 初始化脚本
# 自动创建知识库的目录结构
# 用法：bash init-wiki.sh <知识库路径> <主题>

set -e

WIKI_ROOT="${1:-$HOME/Documents/我的知识库}"
TOPIC="${2:-我的知识库}"
DATE=$(date +%Y-%m-%d)
SKILL_DIR="$(cd "$(dirname "$0")/.." && pwd)"

echo "🔧 正在创建知识库..."
echo "   路径：$WIKI_ROOT"
echo "   主题：$TOPIC"
echo ""

# 创建目录结构
mkdir -p "$WIKI_ROOT"/raw/{articles,tweets,wechat,pdfs,notes,assets}
mkdir -p "$WIKI_ROOT"/wiki/{entities,topics,sources,comparisons,synthesis}

echo "✅ 目录结构已创建"

# 从模板生成文件
# Schema 文件
sed -e "s|{{TOPIC}}|$TOPIC|g" \
    -e "s|{{DATE}}|$DATE|g" \
    -e "s|{{WIKI_ROOT}}|$WIKI_ROOT|g" \
    "$SKILL_DIR/templates/schema-template.md" > "$WIKI_ROOT/.wiki-schema.md"
echo "✅ Schema 文件已生成"

# index.md
sed -e "s|{{TOPIC}}|$TOPIC|g" \
    -e "s|{{DATE}}|$DATE|g" \
    "$SKILL_DIR/templates/index-template.md" > "$WIKI_ROOT/index.md"
echo "✅ 索引文件已生成"

# log.md
sed -e "s|{{TOPIC}}|$TOPIC|g" \
    -e "s|{{DATE}}|$DATE|g" \
    "$SKILL_DIR/templates/log-template.md" > "$WIKI_ROOT/log.md"
echo "✅ 日志文件已生成"

# overview.md
sed -e "s|{{TOPIC}}|$TOPIC|g" \
    -e "s|{{DATE}}|$DATE|g" \
    "$SKILL_DIR/templates/overview-template.md" > "$WIKI_ROOT/wiki/overview.md"
echo "✅ 总览文件已生成"

echo ""
echo "🎉 知识库创建完成！"
echo ""
echo "📁 目录结构："
echo "   $WIKI_ROOT/"
echo "   ├── raw/        （原始素材）"
echo "   ├── wiki/       （知识库）"
echo "   ├── index.md    （索引）"
echo "   ├── log.md      （日志）"
echo "   └── .wiki-schema.md （配置）"
echo ""
echo "💡 下一步：给 Claude 一个链接或文件，开始构建知识库！"
