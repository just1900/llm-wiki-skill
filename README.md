# llm-wiki — 个人知识库构建 Skill

> 基于 [Karpathy 的 llm-wiki 方法论](https://gist.github.com/karpathy/442a6bf555914893e9891c11519de94f)，为 Claude Code 打造的个人知识库构建系统。

## 它做什么

把碎片化的信息变成持续积累、互相链接的知识库。你只需要提供素材（网页、推文、公众号、YouTube、PDF、本地文件），AI 做所有的整理工作。

核心区别：知识被**编译一次，持续维护**，而不是每次查询都从原始文档重新推导。

## 功能

- **零配置初始化**：一句话创建知识库，自动生成目录结构和模板
- **智能素材路由**：根据 URL 域名自动选择最佳提取方式
  - X/Twitter → x-article-extractor
  - 微信公众号 → baoyu-url-to-markdown
  - YouTube → youtube-transcript
  - 其他网页 → baoyu-url-to-markdown
- **结构化 Wiki**：自动生成素材摘要、实体页、主题页，用 `[[双向链接]]` 互相关联
- **知识库健康检查**：自动检测孤立页面、断链、矛盾信息
- **Obsidian 兼容**：所有内容都是本地 markdown，直接用 Obsidian 打开查看

## 安装

```bash
# 克隆到 Claude Code 的 skills 目录
git clone https://github.com/Kiro/llm-wiki-skill.git ~/.claude/skills/llm-wiki
```

## 使用

在 Claude Code 中直接说：

```
帮我初始化一个知识库
```

然后开始喂素材：

```
帮我消化这篇：https://example.com/article
```

## 目录结构

```
你的知识库/
├── raw/                    # 原始素材（不可变）
│   ├── articles/
│   ├── tweets/
│   ├── wechat/
│   └── pdfs/
├── wiki/                   # AI 生成的知识库
│   ├── entities/           # 实体页（人物、概念、工具）
│   ├── topics/             # 主题页
│   ├── sources/            # 素材摘要
│   ├── comparisons/        # 对比分析
│   └── synthesis/          # 综合分析
├── index.md                # 索引
├── log.md                  # 操作日志
└── .wiki-schema.md         # 配置
```

## 致谢

本项目复用和集成了以下开源项目，感谢它们的作者：

- **[baoyu-url-to-markdown](https://github.com/JimLiu/baoyu-skills#baoyu-url-to-markdown)** — by [JimLiu](https://github.com/JimLiu)
  网页和公众号文章提取，通过 Chrome CDP 渲染并转换为 markdown

- **youtube-transcript** — YouTube 视频字幕/逐字稿提取

- **x-article-extractor** — X (Twitter) 内容提取（长文章、推文串、单条推文）

核心方法论来自：

- **[Andrej Karpathy](https://karpathy.ai/)** — [llm-wiki gist](https://gist.github.com/karpathy/442a6bf555914893e9891c11519de94f)

## License

MIT
