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
```
i18n/zh/skills/uefn-dev/references/official-docs/
├── index.json                    # 文档索引
├── verse_language_reference.md
├── verse_api.md
└── ...
```

## 已有资源

项目已包含从 GitHub 抓取的完整 API 文档：

```
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
