# 信息源记录（Information Sources）

这份文档整理和索引各类信息源，便于查阅和引用。

---

## 为什么需要信息源记录？

知识的可靠性取决于信息源的质量。记录信息源有助于：
1. **评估可靠性** - 知道信息来自哪里
2. **追溯来源** - 需要深入了解时知道去哪里查
3. **交叉验证** - 对比多个信息源的说法
4. **持续学习** - 建立系统化的学习资源库

---

## 信息源分类

### 🔴 一级源（最可靠）

官方文档、官方 API 参考、官方示例代码

#### Verse 语言

| 资源 | 类型 | 路径/URL | 说明 | 最后访问 |
|------|------|---------|------|----------|
| **UEFN API Digest Repository** | 官方 API 版本追踪 | https://github.com/vz-creates/uefn | 社区维护的 UEFN API Digest 版本追踪仓库（v24.01-v41.00+） | 2026-01-12 |
| **Verse API Digest** | 官方 API 定义 | `verseProject/digests/Verse/Verse.digest.verse` | Verse 核心 API 官方定义文件（2524 行，v41.00） | 2026-01-12 |
| **Fortnite API Digest** | 官方 API 定义 | `verseProject/digests/Fortnite/Fortnite.digest.verse` | Fortnite 游戏 API 官方定义文件（12749 行，v41.00） | 2026-01-12 |
| **UnrealEngine API Digest** | 官方 API 定义 | `verseProject/digests/UnrealEngine/UnrealEngine.digest.verse` | UE5 相关 API 官方定义文件（1755 行，v41.00） | 2026-01-12 |
| **UEFN Documentation** | 官方文档（本地副本） | `external/epic-docs-crawler/uefn_docs_organized/` | Epic Games 官方文档本地副本（5071+ 页） | 2026-01-12 |
| Verse Language Reference | 官方文档（在线） | https://dev.epicgames.com/documentation/en-us/uefn/verse-language-reference | Verse 语言官方在线参考文档 | - |

#### UEFN 文档本地索引（快速查找）

**主索引文件**：`external/epic-docs-crawler/uefn_docs_organized/README.md`（完整目录）  
**简明摘要**：`external/epic-docs-crawler/uefn_docs_organized/SUMMARY.md`（分类统计）  
**JSON 索引**：`external/epic-docs-crawler/uefn_docs_organized/_compact_index.json`（可编程查询）

| 文档分类 | 页面数 | 索引文件 | 目录位置 |
|---------|--------|---------|---------|
| **API 参考** | 3759 | `API-Fortnite.com.md`, `API-Verse.org.md`, `API-UnrealEngine.com.md` | `API/` |
| **教程和指南** | 286 | `Tutorials.md`, `Tutorials-Build-Games.md`, `Tutorials-Devices.md` | `Tutorials/` |
| **设备参考** | 255 | `Devices.md` | `Devices/` |
| **编辑器功能** | 323 | `Editor.md` | `Editor/` |
| **Creative 模式** | 238 | `Creative.md`, `Creative-Islands.md` | `Creative/` |
| **Verse 语言** | 140 | `Verse-Language.md` | `Verse-Language/` |
| **发布说明** | 51 | `ReleaseNotes.md` | `ReleaseNotes/` |
| **其他** | 118 | `Other.md`, `Reference.md`, `Publishing.md` | `Other/`, `Reference/`, `Publishing/` |

**查询示例**：
```bash
# 搜索特定 API
grep -r "timer" external/epic-docs-crawler/uefn_docs_organized/API/

# 查看 Verse 语言教程列表
cat external/epic-docs-crawler/uefn_docs_organized/Verse-Language.md

# 使用 jq 查询 JSON 索引
cat external/epic-docs-crawler/uefn_docs_organized/_compact_index.json | jq '.pages[] | select(.title | contains("Timer"))'
```

#### 效果系统（Effects）

| 资源 | 类型 | 路径/URL | 说明 | 最后访问 |
|------|------|----------|------|----------|
| **Failure in Verse** | 官方文档（本地） | `external/epic-docs-crawler/uefn_docs_organized/Verse-Language/failure-in-verse/index.md` | Failure context、speculative execution、transacts 要求 | 2026-01-12 |
| **Functions in Verse** | 官方文档（本地） | `external/epic-docs-crawler/uefn_docs_organized/Verse-Language/functions-in-verse/index.md` | 函数定义、效果标注、decides 效果说明 | 2026-01-12 |
| **If in Verse** | 官方文档（本地） | `external/epic-docs-crawler/uefn_docs_organized/Verse-Language/if-in-verse/index.md` | if 条件中的 decides 行为、transactional rollback | 2026-01-12 |
| Verse Effects Guide | 官方文档（在线） | https://dev.epicgames.com/documentation/en-us/fortnite/failure-in-verse | Verse 效果系统在线文档 | 2026-01-12 |
| User Feedback (@wyughakut) | 用户反馈 | PR Comment #3739768476 | 指出 `<decides>` 与 `<transacts>` 可以同时使用 | 2026-01-12 |

---

### 🟡 二级源（较可靠）

官方社区、官方 GitHub Issues、经验丰富的开发者

| 资源 | 类型 | 路径/URL | 说明 | 最后访问 |
|------|------|---------|------|----------|
| **VSCode Verse Extension** | 官方工具 | `external/vscode-verse/Verse.vsix` | 官方 Verse 语言 VSCode 扩展包 | 2026-01-12 |
| **Skill Seekers 配置** | 工具配置 | `external/skill-seekers-configs/` | UEFN 文档抓取和索引配置 | 2026-01-12 |
| UEFN Forums | 官方论坛 | https://forums.unrealengine.com/c/development-discussion/uefn/1807 | UEFN 官方社区论坛 | - |
| Verse GitHub Discussions | 官方讨论 | [待补充] | Verse 相关的 GitHub 讨论 | - |

---

### 🟢 三级源（参考）

第三方博客、教程、个人经验分享

| 资源 | 类型 | 路径/URL | 说明 | 最后访问 |
|------|------|---------|------|----------|
| **提示词库** | 内部资源 | `external/prompts-library/` | AI 交互提示词集合和文档 | 2026-01-12 |
| **资源文档库** | 内部资源 | `resources/documents/` | 项目内部教程、技能规范等文档 | 2026-01-12 |
| **错误笔记** | 内部资源 | `docs/error-notes/` | 开发过程中遇到的错误记录 | 2026-01-12 |

---

## 📚 仓库内资源快速导航

### 官方 API 定义文件（Digest Files）

这些是从 UEFN 安装目录导出的**官方 API 定义**，是最权威的 API 参考：

```bash
verseProject/digests/
├── Verse/Verse.digest.verse          # Verse 核心 API (2524 行，v41.00)
├── Fortnite/Fortnite.digest.verse    # Fortnite 游戏 API (12749 行，v41.00)
└── UnrealEngine/UnrealEngine.digest.verse  # UE5 API (1755 行，v41.00)
```

**更新来源**：[vz-creates/uefn](https://github.com/vz-creates/uefn) - 社区维护的 API 版本追踪仓库

**使用方法**：
- 查询 API 签名和类型定义
- 确认函数参数和返回值
- 了解可用的模块和命名空间

**更新流程**：
```bash
# 克隆最新版本
git clone https://github.com/vz-creates/uefn.git /tmp/uefn

# 复制 FortniteGame 模块的 digest 文件（通常是最新的）
cp /tmp/uefn/Modules/FortniteGame/Verse/Verse.digest.verse verseProject/digests/Verse/
cp /tmp/uefn/Modules/FortniteGame/Fortnite/Fortnite.digest.verse verseProject/digests/Fortnite/
cp /tmp/uefn/Modules/FortniteGame/UnrealEngine/UnrealEngine.digest.verse verseProject/digests/UnrealEngine/

# 验证更新
wc -l verseProject/digests/*/*.digest.verse
```

### UEFN 官方文档本地副本

完整的 UEFN 文档镜像，包含 5071+ 页面：

```bash
external/epic-docs-crawler/uefn_docs_organized/
├── README.md              # 完整索引 (5038 页目录)
├── SUMMARY.md             # 快速概览和统计
├── _compact_index.json    # JSON 格式索引（可编程查询）
├── _categories.json       # 分类元数据
│
├── API/                   # API 文档 (3759 页)
│   ├── Fortnite.com/      # Fortnite API (3033 页)
│   ├── Verse.org/         # Verse 核心 API (419 页)
│   └── UnrealEngine.com/  # UE5 API (306 页)
│
├── Verse-Language/        # Verse 语言文档 (140 页)
│   ├── Guide/             # 语言指南
│   ├── Quick-Reference/   # 快速参考
│   └── Examples/          # 示例代码
│
├── Tutorials/             # 教程 (286 页)
│   ├── Build-Games/       # 游戏开发教程 (63 篇)
│   ├── Devices/           # 设备教程 (42 篇)
│   └── Starter-Templates/ # 模板教程 (14 篇)
│
├── Devices/               # 设备参考 (255 页)
├── Editor/                # 编辑器功能 (323 页)
├── Creative/              # Creative 模式 (238 页)
└── ReleaseNotes/          # 发布说明 (51 页)
```

**常用查询命令**：

```bash
# 1. 搜索特定 API 或功能
grep -r "keyword" external/epic-docs-crawler/uefn_docs_organized/API/

# 2. 查看某个分类的完整列表
cat external/epic-docs-crawler/uefn_docs_organized/Verse-Language.md

# 3. 使用 JSON 索引查询（需要 jq 工具）
cat external/epic-docs-crawler/uefn_docs_organized/_compact_index.json | \
  jq '.pages[] | select(.title | contains("Timer"))'

# 4. 统计文档数量
find external/epic-docs-crawler/uefn_docs_organized -name "*.md" | wc -l
```

### 开发工具和配置

```bash
external/
├── vscode-verse/           # VSCode Verse 扩展包
│   └── Verse.vsix          # 可直接安装的扩展
│
├── skill-seekers-configs/  # 文档抓取配置
│   ├── uefn.json           # UEFN 单独配置
│   ├── uefn-unified.json   # 统一配置
│   └── scrape_epic_docs.py # 抓取脚本
│
├── epic-docs-crawler/      # 文档爬虫工具
│   ├── crawler.py          # Playwright 爬虫
│   ├── crawler_firecrawl.py # Firecrawl API 爬虫
│   └── README.md           # 使用说明
│
└── prompts-library/        # AI 提示词库
    ├── main.py             # 交互式转换工具
    └── docs/               # 提示词文档
```

### 内部知识库

```bash
workUnits/verseLogicLab/knowledge/
├── SOURCES.md              # 📍 本文件：信息源索引
├── CONJECTURES.md          # 猜想记录（未验证假设）
├── DECISION_RECORDS.md     # 架构决策记录 (ADR)
├── COMPILATION_LESSONS.json # 编译经验教训
├── PATTERNS.md             # 可复用模式
├── knowledge-gaps.md       # 知识缺口清单
├── improvement-backlog.md  # 改进任务清单
└── research/               # 调研报告目录
```

### 项目代码库

```bash
verseProject/source/library/logicModules/
├── coreMathUtils/          # 核心数学工具模块
│   ├── MathCurves.verse
│   ├── MathVectors.verse
│   ├── MathInterpolation.verse
│   └── ...
│
├── characterAndStateUtils/ # 角色和状态工具模块
│   ├── RpgHealth.verse
│   ├── RpgDamage.verse
│   ├── RpgAttributes.verse
│   └── ...
│
└── inventoryAndItemsUtils/ # 库存和物品工具模块
    ├── InvManagement.verse
    ├── ItemUpgrade.verse
    └── ...
```

---

## 已确认的关键信息

基于可靠信息源确认的重要信息：

### 效果系统（Effects）

✅ **确认信息**：
- `<transacts>` 效果包含 `<decides>` 效果
- `<decides>` 通常需要 `<transacts>` 配合使用
- 效果可以组合使用：`<transacts><decides>`

**信息源**：
- 用户反馈（@wyughakut，2026-01-12，PR #comment_id:3739768476）
- 实践验证（编译错误修正过程）

---

## 待查证的问题

当前需要查证的问题清单：

### 效果系统

- [ ] `<no_rollback>` 效果的完整语义和使用场景
- [ ] 效果层次结构的完整定义（哪些效果包含哪些）
- [ ] 何时必须显式声明效果，何时可以让编译器推断

### 曲线系统

- [ ] Verse 是否有内置的曲线或动画系统
- [ ] 最佳的曲线表示方法（enum vs struct vs trait）
- [ ] 曲线组合和运算的常用模式

---

## 信息源评估标准

| 标准 | 一级源 | 二级源 | 三级源 |
|------|--------|--------|--------|
| 权威性 | 官方发布 | 官方渠道 | 个人/非官方 |
| 准确性 | 最高 | 高 | 不确定 |
| 时效性 | 持续更新 | 较新 | 可能过时 |
| 可验证性 | 直接引用 | 可追溯 | 难以验证 |

---

## 使用指南

### 引用信息源的格式

在 ADR、Lesson、Pattern 中引用信息源时：

```markdown
**信息源**：
- [一级源] Verse Language Reference, Section X.Y
- [二级源] UEFN Forums, Thread "Effect System Discussion"
- [用户反馈] @username, PR Comment #12345, 2026-01-12
```

### 验证流程

```
遇到问题 → 查阅一级源（官方文档）
         ↓ 未找到
查阅二级源（社区讨论）
         ↓ 仍不确定
标记为猜想，记录到 CONJECTURES.md
         ↓ 实践验证
收集证据，更新猜想状态
         ↓ 确认后
更新此文档，记录为"已确认信息"
```

---

## 🔍 信息源发现指南

### 按任务类型查找信息源

| 任务类型 | 推荐信息源 | 查找路径 |
|---------|-----------|---------|
| **查询 API 定义** | Verse/Fortnite/UE API Digest | `verseProject/digests/` |
| **学习 Verse 语法** | UEFN 文档 - Verse Language | `external/epic-docs-crawler/uefn_docs_organized/Verse-Language/` |
| **了解设备用法** | UEFN 文档 - Devices | `external/epic-docs-crawler/uefn_docs_organized/Devices/` |
| **查看教程示例** | UEFN 文档 - Tutorials | `external/epic-docs-crawler/uefn_docs_organized/Tutorials/` |
| **查看已有实现** | verseProject 代码库 | `verseProject/source/library/logicModules/` |
| **解决编译问题** | 编译经验教训 | `workUnits/verseLogicLab/knowledge/COMPILATION_LESSONS.json` |
| **查找设计模式** | 模式库 | `workUnits/verseLogicLab/knowledge/PATTERNS.md` |

### 信息源查找流程

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

### 更新文档的时机

根据 [epic-docs-crawler README](../../external/epic-docs-crawler/README.md)，更新本地文档副本：

```bash
cd external/epic-docs-crawler

# 方法 1: 使用 Firecrawl API (推荐)
python crawler_firecrawl.py --crawl-site 100

# 方法 2: 使用手动导出的 Cookies
python crawler_with_cookies.py --cookies cookies.json --full
```

> ⚠️ **注意**: Epic Games 文档使用 Cloudflare 保护，直接爬取可能失败。

---

## 维护指南

### 定期任务

- **月度审查**: 检查信息源链接是否有效
- **季度更新**: 更新官方文档的新版本链接
- **及时记录**: 每次查阅新资源后立即添加

### 添加新信息源

使用以下模板：

```markdown
| [资源名称] | [类型] | [URL/引用] | [简短说明] | YYYY-MM-DD |
```

---

**记住**：好的信息源是知识的基石。一手信息胜过十个猜测。
