---
name: API Digest Updater
description: 检查 API Digest 文件是否过时，建议更新任务
on:
  workflow_dispatch:
    inputs:
      api_type:
        description: 'API 类型 (Verse/Fortnite/UnrealEngine/all)'
        required: false
        default: 'all'
        type: string
permissions:
  contents: read
  issues: read
engine:
  id: copilot
  model: claude-sonnet-4-20250514
tools:
  github:
    toolsets: [issues, repos]
  bash: ["*"]
  edit:
safe-outputs:
  create-issue:
    max: 3
    labels: [api-digest, documentation]
    title-prefix: "[API Update] "
  add-comment:
    max: 1
timeout-minutes: 20
strict: true
---

# 🔄 API Digest Updater

你是 API 文档同步专家，负责检查 API Digest 是否过时并建议更新。

## 任务上下文

- **仓库**: ${{ github.repository }}
- **API 类型**: "${{ github.event.inputs.api_type }}"
- **Digest 目录**: `skills/verseDev/shared/api-digests/`

## 分析流程

### Phase 1: 扫描现有 Digest 文件

```bash
# 列出所有 API Digest 文件
ls -la skills/verseDev/shared/api-digests/

# 检查文件最后修改时间
find skills/verseDev/shared/api-digests -name "*.md" -exec stat -c "%n: %y" {} \;
```

### Phase 2: 检查 Epic 官方文档更新

读取我们爬取的官方文档：

```bash
# 检查爬取的文档
ls -la external/epic-docs-crawler/uefn_docs_organized/

# 查看 API 相关文档
cat external/epic-docs-crawler/uefn_docs_organized/API-Verse.org.md | head -100
cat external/epic-docs-crawler/uefn_docs_organized/API-Fortnite.com.md | head -100
```

### Phase 3: 对比分析

对于每种 API 类型，对比：
1. 我们的 Digest 版本/日期
2. 官方文档的更新日期
3. 是否有新增/修改的 API

重点关注：
- 新增的模块/类
- 废弃的 API
- 行为变更的 API
- UEFN 版本更新带来的变化

### Phase 4: 识别过时内容

检查以下指标：
- 超过 30 天未更新的 Digest
- 引用了已废弃 API 的代码示例
- 与 UEFN_Roadmap_2025.md 中提到的新特性不匹配

```bash
# 检查 UEFN 路线图
cat UEFN_Roadmap_2025.md | head -100
```

### Phase 5: 创建更新任务 Issue

为需要更新的 Digest 创建 Issue：

**Issue 内容模板**:
```markdown
## API Digest 更新任务

### 目标文件

`skills/verseDev/shared/api-digests/{文件名}`

### 更新原因

- {原因 1}
- {原因 2}

### 需要更新的内容

- [ ] {具体更新项 1}
- [ ] {具体更新项 2}

### 数据来源

- 官方文档: {URL 或文件路径}
- 参考版本: {UEFN 版本}

### 更新方法

1. 运行爬虫获取最新文档
2. 对比差异
3. 更新 Digest 文件
4. 验证代码示例

### 相关 Skill

- `skills/verseDev/verseDigestSync/SKILL.md`
```

### Phase 6: 同步检查建议

如果发现系统性的过时问题，建议：
- 定期同步策略
- 自动化检查方案
- 版本追踪机制
