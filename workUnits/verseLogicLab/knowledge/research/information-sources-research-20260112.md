# 信息源调研报告

**日期**: 2026-01-12  
**调研人**: Verse Logic Lab Lead  
**任务**: 调研仓库中触手可得的信息源，为后续研究做准备

---

## 1. 调研目标

- 识别仓库中所有可用的信息源
- 为 UEFN 文档副本建立完整索引
- 创建按任务类型查找信息源的导航体系
- 为后续研究任务提供快速查找参考

---

## 2. 调研方法

### 2.1 目录扫描

使用 `find`、`ls` 等命令系统扫描仓库结构：
- `external/` - 外部资源和工具
- `verseProject/digests/` - 官方 API 定义
- `resources/` - 内部文档资源
- `workUnits/verseLogicLab/knowledge/` - 知识库

### 2.2 文档统计

统计各类文档的数量和规模：
- Markdown 文件数量
- 代码行数（API Digest）
- 目录结构深度

### 2.3 内容分析

阅读关键索引文件：
- `external/epic-docs-crawler/README.md`
- `external/epic-docs-crawler/uefn_docs_organized/README.md`
- `external/epic-docs-crawler/uefn_docs_organized/SUMMARY.md`

---

## 3. 发现的信息源

### 3.1 一级源（官方资源）

#### API Digest 文件

位置：`verseProject/digests/`

| 文件 | 行数 | 说明 |
|------|------|------|
| `Verse/Verse.digest.verse` | 2,368 | Verse 核心 API 定义 |
| `Fortnite/Fortnite.digest.verse` | 12,191 | Fortnite 游戏 API 定义 |
| `UnrealEngine/UnrealEngine.digest.verse` | 1,391 | UE5 相关 API 定义 |
| **总计** | **15,950** | |

**价值**：
- 最权威的 API 参考
- 直接来自 UEFN 安装目录
- 包含完整的类型签名和模块定义

#### UEFN 官方文档本地副本

位置：`external/epic-docs-crawler/uefn_docs_organized/`

**统计**：
- 总页面数：5,071+ 页
- Markdown 文件数：5,071+ 个
- 存储空间：约 200 MB

**文档分类**：

| 分类 | 页面数 | 主要内容 |
|------|--------|----------|
| API 参考 | 3,759 | Fortnite (3033), Verse (419), UE5 (306) |
| 教程和指南 | 286 | 游戏开发、设备使用、模板教程 |
| 设备参考 | 255 | Creative 设备详细说明 |
| 编辑器功能 | 323 | 动画、音频、材质等系统 |
| Creative 模式 | 238 | 岛屿管理、预制体 |
| Verse 语言 | 140 | 语法、示例、最佳实践 |
| 发布说明 | 51 | 版本更新历史 |
| 其他 | 118 | 发布指南、游戏类型等 |

**索引文件**：
- `README.md` - 完整目录（5038 页索引）
- `SUMMARY.md` - 分类统计和概览
- `_compact_index.json` - JSON 格式（可编程查询）
- `_categories.json` - 分类元数据

**特点**：
- ✅ 内容完整，涵盖所有官方文档
- ✅ 结构清晰，按主题分类
- ✅ 支持多种索引方式（Markdown + JSON）
- ✅ 可离线访问，无需网络
- ⚠️ 需要定期更新以保持同步

### 3.2 二级源（工具和配置）

#### VSCode Verse 扩展

位置：`external/vscode-verse/Verse.vsix`

**价值**：
- 官方语法高亮和代码补全
- 可能包含语法定义文件
- 可用于编辑器集成

#### Skill Seekers 配置

位置：`external/skill-seekers-configs/`

文件：
- `uefn.json` - UEFN 单独配置
- `uefn-unified.json` - 统一配置
- `scrape_epic_docs.py` - 文档抓取脚本

**价值**：
- 记录了文档抓取的 URL 结构
- 配置了文档分类规则
- 可用于自动化更新文档

#### 文档爬虫工具

位置：`external/epic-docs-crawler/`

工具：
- `crawler.py` - Playwright 爬虫
- `crawler_firecrawl.py` - Firecrawl API 爬虫
- `crawler_with_cookies.py` - Cookie 辅助爬虫

**价值**：
- 可用于更新本地文档副本
- 提供了多种爬取方案（应对 Cloudflare 保护）

### 3.3 三级源（内部资源）

#### 提示词库

位置：`external/prompts-library/`

**内容**：
- AI 交互提示词集合
- 提示词文档和使用指南
- Excel ↔ Markdown 转换工具

#### 资源文档库

位置：`resources/documents/`

**内容**：
- 技能规范文档（基建规范、代谢系统）
- 教程和指南（tmux、ssh、telegram 等）
- 项目内部经验积累

#### 错误笔记

位置：`docs/error-notes/`

**价值**：
- 记录开发中遇到的错误
- 可能包含解决方案

---

## 4. 信息源分级

### 4.1 可靠性评估

| 等级 | 来源类型 | 可信度 | 典型资源 |
|------|----------|--------|----------|
| **一级** | 官方文档、API 定义 | 最高 | Digest 文件、UEFN 文档 |
| **二级** | 官方工具、配置 | 高 | VSCode 扩展、爬虫工具 |
| **三级** | 内部经验、笔记 | 中等 | 提示词库、错误笔记 |

### 4.2 更新频率

| 资源 | 更新方式 | 建议频率 |
|------|----------|----------|
| API Digest | 手动从 UEFN 导出 | 每个主版本更新 |
| UEFN 文档 | 运行爬虫脚本 | 每月或遇到重大更新 |
| 内部知识库 | 开发过程中持续更新 | 实时 |

---

## 5. 信息源使用指南

### 5.1 按任务类型查找

| 任务类型 | 推荐信息源 | 查找路径 |
|---------|-----------|---------|
| 查询 API 定义 | API Digest 文件 | `verseProject/digests/` |
| 学习 Verse 语法 | UEFN 文档 - Verse Language | `external/.../Verse-Language/` |
| 了解设备用法 | UEFN 文档 - Devices | `external/.../Devices/` |
| 查看教程示例 | UEFN 文档 - Tutorials | `external/.../Tutorials/` |
| 查看已有实现 | verseProject 代码库 | `verseProject/source/library/` |
| 解决编译问题 | 编译经验教训 | `knowledge/COMPILATION_LESSONS.json` |
| 查找设计模式 | 模式库 | `knowledge/PATTERNS.md` |

### 5.2 查询命令速查

```bash
# 搜索特定 API
grep -r "keyword" external/epic-docs-crawler/uefn_docs_organized/API/

# 统计文档数量
find external/epic-docs-crawler/uefn_docs_organized -name "*.md" | wc -l

# 查看 Verse API 结构
grep "^[[:space:]]*[a-z_]*:" verseProject/digests/Verse/Verse.digest.verse | head -20

# 查询 JSON 索引（需要 jq）
cat external/epic-docs-crawler/uefn_docs_organized/_compact_index.json | \
  jq '.pages[] | select(.title | contains("Timer"))'
```

### 5.3 信息源查找流程

```
遇到问题
    ↓
1. 检查内部知识库
   - COMPILATION_LESSONS.json (编译问题)
   - PATTERNS.md (设计模式)
   - DECISION_RECORDS.md (架构决策)
    ↓ 未找到
2. 查阅 API Digest 文件
   - verseProject/digests/*.verse
    ↓ 需要详细说明
3. 查阅本地 UEFN 文档
   - external/epic-docs-crawler/uefn_docs_organized/
    ↓ 需要社区经验
4. 搜索在线资源
   - UEFN Forums
   - Epic Developer Community
    ↓ 记录结果
5. 更新知识库
   - 记录到 SOURCES.md
   - 创建 ADR 或 Pattern
   - 如有疑问记录到 CONJECTURES.md
```

---

## 6. 关键发现

### 6.1 信息源丰富度

✅ **优势**：
- 拥有完整的官方 API 定义文件（15,950 行）
- 拥有完整的官方文档本地副本（5,071+ 页）
- 有多种索引方式（Markdown、JSON）
- 可完全离线工作

⚠️ **注意事项**：
- UEFN 文档需要定期更新
- 更新文档需要应对 Cloudflare 保护（建议使用 Firecrawl API）

### 6.2 文档结构

UEFN 文档的组织非常系统化：
- **API 参考**占比最大（74%），说明 API 文档非常详细
- **教程和指南**内容丰富，适合学习
- **Verse 语言文档**独立成章节，便于查找
- **分类索引文件**齐全，支持多种查询方式

### 6.3 缺失的信息源

目前尚未包含的信息源：
- ❌ Verse Language Specification（官方语言规范）
- ❌ 社区博客和教程链接
- ❌ 官方 GitHub 仓库链接
- ❌ Discord/Forum 重要讨论链接

**建议**：在后续使用过程中，遇到有价值的外部资源时及时补充到 SOURCES.md。

---

## 7. 行动建议

### 7.1 短期行动（立即）

- [x] 更新 `SOURCES.md`，添加完整索引
- [x] 创建本调研报告
- [ ] 测试查询命令，确保可用性
- [ ] 向团队介绍信息源使用方法

### 7.2 中期行动（本月内）

- [ ] 创建信息源快速查询脚本
- [ ] 建立文档更新提醒机制
- [ ] 补充外部资源链接（社区、博客等）

### 7.3 长期维护

- [ ] 每月检查 UEFN 是否有重大更新
- [ ] 每季度更新一次本地文档副本
- [ ] 持续收集和整理有价值的信息源

---

## 8. 结论

本次调研成功识别了仓库中所有主要的信息源，并建立了完整的索引体系。

**关键成果**：
1. ✅ 更新了 `SOURCES.md`，添加了详细的信息源索引
2. ✅ 识别了 5,071+ 页官方文档和 15,950 行 API 定义
3. ✅ 创建了按任务类型查找的导航表
4. ✅ 制定了信息源查找流程和使用指南

**价值**：
- 显著提升信息查找效率
- 减少重复搜索和试错
- 建立知识可追溯性
- 为后续研究任务奠定基础

**下一步**：
- 在实际开发中测试和完善这套索引体系
- 根据使用反馈优化查询方法
- 持续补充新发现的信息源

---

**记住**：好的信息源是知识的基石。触手可得的信源，比远在天边的资源更有价值。
