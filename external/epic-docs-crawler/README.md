# Epic Games UEFN Documentation Crawler

抓取 Epic Games 官方 UEFN/Verse 文档的工具集。

## ⚠️ Cloudflare 保护说明

Epic Games 文档 (dev.epicgames.com) 使用 **Cloudflare Bot Fight Mode** 保护，自动化抓取非常困难。以下是几种可用的方法：

## 方法一：使用 GitHub 镜像（推荐）

最可靠的方法是使用社区维护的 GitHub 镜像，无需绕过 Cloudflare：

```bash
# 克隆官方 API 镜像
git clone https://github.com/vz-creates/uefn.git

# API 文件位置
ls uefn/Modules/FortniteGame/Verse/
```

这些 `.digest.verse` 文件是从 UEFN 安装目录导出的**官方 API 定义**，比网页文档更完整。

## 方法二：Firecrawl API（付费服务）

[Firecrawl](https://www.firecrawl.dev/) 是专业的网页抓取服务，能处理 Cloudflare：

```bash
# 安装
pip install firecrawl-py

# 设置 API Key（免费 500 credits/月）
export FIRECRAWL_API_KEY="your-api-key"

# 运行
python crawler_firecrawl.py
python crawler_firecrawl.py --full
python crawler_firecrawl.py --crawl-site 50  # 抓取整个站点
```

## 方法三：手动导出 Cookies

如果你需要特定页面的内容：

1. 在 Chrome 中打开 Epic 文档并完成验证
2. 安装 [EditThisCookie](https://chrome.google.com/webstore/detail/editthiscookie/fngmhnnpilhplaeedifhccceomclgfbg) 扩展
3. 导出 cookies 为 JSON
4. 运行爬虫：

```bash
python crawler_with_cookies.py --cookies cookies.json
python crawler_with_cookies.py --cookies cookies.json --full
```

## 方法四：Playwright（成功率低）

直接使用 Playwright + Stealth 模式，但 Cloudflare 检测率高：

```bash
pip install playwright playwright-stealth markdownify
playwright install chromium --with-deps

python crawler.py --url "/verse-language-quick-reference"
python crawler.py           # 抓取核心文档
python crawler.py --full    # 抓取全部文档
```

## 输出目录

抓取的文档保存在：

```text
i18n/zh/skills/uefn-dev/references/official-docs/
├── index.json                    # 文档索引
├── verse_language_reference.md
├── verse_api.md
└── ...
```

## 📚 UEFN 官方文档库 (uefn_docs_organized/)

本目录包含从 Epic Games 官方网站 (dev.epicgames.com) 爬取的完整 UEFN 文档，共 **5038 页**。

### 文档来源

- **来源网站**: <https://dev.epicgames.com/documentation/en-us/uefn/>
- **文档类型**: Markdown 格式，UTF-8 编码
- **索引文件**: `README.md` (主索引), `SUMMARY.md` (简化摘要), `_compact_index.json` (JSON 索引)

### 目录结构

```text
uefn_docs_organized/
├── README.md                      # 完整文档索引 (5038 页)
├── SUMMARY.md                     # 快速概览和统计
├── _compact_index.json            # JSON 格式索引
├── _categories.json               # 分类元数据
│
├── API/                           # API 文档 (3759 页)
│   ├── API-Fortnite.com.md       # Fortnite API 索引 (3033 页)
│   ├── API-UnrealEngine.com.md   # Unreal Engine API 索引 (306 页)
│   └── API-Verse.org.md          # Verse 核心 API 索引 (419 页)
│
├── Tutorials/                     # 教程和指南 (286 页)
│   ├── Build-Games/              # 游戏开发教程
│   ├── Devices/                  # 设备使用教程
│   └── Starter-Templates/        # 模板教程
│
├── Devices/                       # 设备参考 (255 页)
│   └── (各类 Creative 设备文档)
│
├── Editor/                        # 编辑器功能 (323 页)
│   ├── Animation/                # 动画系统
│   ├── Audio/                    # 音频系统
│   ├── Materials/                # 材质系统
│   └── ...
│
├── Creative/                      # Creative 模式 (238 页)
│   ├── Islands/                  # 岛屿管理
│   └── Prefabs/                  # 预制体
│
├── Verse-Language/                # Verse 语言 (140 页)
│   ├── Quick-Reference/          # 快速参考
│   ├── Guide/                    # 语言指南
│   └── Examples/                 # 示例代码
│
├── ReleaseNotes/                  # 发布说明 (51 页)
│   └── (各版本更新日志)
│
└── Other/                         # 其他文档 (118 页)
    ├── Reference/                # 参考资料
    ├── Publishing/               # 发布指南
    ├── GameTypes/                # 游戏类型
    └── Brands/                   # 品牌规则
```

### 使用场景

#### 1. UEFN 能力边界调研

进行 UEFN/Verse 开发前，必须先了解其能力边界：

```bash
# 查看 API 概览
cat uefn_docs_organized/SUMMARY.md

# 搜索特定 API
grep -r "timer" uefn_docs_organized/API/

# 查看设备能力
ls uefn_docs_organized/Devices/
```

#### 2. 快速查找文档

使用索引文件快速定位所需文档：

```bash
# 查看完整索引
cat uefn_docs_organized/README.md

# JSON 格式查询 (可用 jq 工具)
cat uefn_docs_organized/_compact_index.json | jq '.pages[] | select(.title | contains("Timer"))'
```

#### 3. 学习 Verse 语言

从入门到进阶的完整学习路径：

```text
1. Verse-Language/ → 基础语法
2. Tutorials/Build-Games/ → 实战教程
3. API/Verse.org.md → API 参考
```

#### 4. 设备使用参考

查找特定 Creative 设备的配置和用法：

```bash
# 查看所有设备
cat uefn_docs_organized/Devices.md

# 查找特定设备
find uefn_docs_organized/Devices/ -name "*timer*"
```

### 文档更新

如需更新文档，重新运行爬虫脚本：

```bash
# 使用 Firecrawl (推荐)
python crawler_firecrawl.py --crawl-site 100

# 使用 Cookies (需要手动导出)
python crawler_with_cookies.py --cookies cookies.json --full
```

> **注意**: Epic Games 文档使用 Cloudflare 保护，直接爬取可能失败。建议使用 Firecrawl API 或手动导出 Cookies。

## 已有资源

项目已包含从 GitHub 抓取的完整 API 文档：

```text
i18n/zh/skills/uefn-verse-complete/references/
├── fortnite-api.verse     (556 KB) - 完整 Fortnite API
├── verse-core-api.verse   (122 KB) - Verse 核心 API
├── unreal-engine-api.verse (85 KB) - UE5 API
├── fortnite-digest.md     (217 KB) - API 参考文档
└── ... (共 25 个文件, 1.2 MB)
```

## 文件说明

| 文件 | 说明 |
|------|------|
| `crawler.py` | Playwright 爬虫（自动化尝试） |
| `crawler_firecrawl.py` | Firecrawl API 爬虫 |
| `crawler_with_cookies.py` | Cookie 辅助爬虫 |
