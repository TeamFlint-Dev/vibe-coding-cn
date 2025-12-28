# UEFN 官方文档爬虫方案

> **文档类型**: 技术方案文档  
> **创建日期**: 2025-12-27  
> **版本**: v1.0  
> **目的**: 将此方案转换为可复用的Agent Skill

---

## 📋 方案概述

### 目标
爬取 Epic Games 官方 UEFN (Unreal Editor for Fortnite) 文档，并按主题分类整理为本地 Markdown 文件库。

### 挑战与解决方案

| 挑战 | 解决方案 |
|------|----------|
| Cloudflare 反爬保护 | 使用 CDP 连接已认证的浏览器会话 |
| 代码块折叠/隐藏 | 点击 "Expand code" 按钮 + 从隐藏 textarea 提取 |
| 5000+ 页面平铺混乱 | 按主题自动分类整理 |
| API 文档量大 (74%) | 按模块层级组织，生成简化索引 |

### 最终成果

```
总页面数: 5,038
├── API文档: 3,759 (74.6%) - 按模块分层
├── 教程指南: 286 (5.7%)
├── 设备参考: 255 (5.1%)
├── 编辑器功能: 323 (6.4%)
├── Creative模式: 238 (4.7%)
└── 其他: 177 (3.5%)
```

---

## 🏗️ 技术架构

### 技术栈

| 组件 | 技术 | 版本 | 用途 |
|------|------|------|------|
| 运行时 | Python | 3.13+ | 脚本运行 |
| 浏览器自动化 | Playwright | 1.57+ | CDP 连接、页面操作 |
| HTML 解析 | BeautifulSoup4 | 4.14+ | DOM 解析 |
| 格式转换 | Markdownify | 1.2+ | HTML → Markdown |
| 浏览器 | Chrome | - | 需手动启动调试模式 |

### 核心文件结构

```
uefn_doc_crawler/
├── crawler_connect_browser.py   # 主爬虫（CDP连接）
├── run_crawler.py               # 启动脚本（支持断点续爬）
├── organize_docs.py             # 文档分类整理
├── generate_compact_index.py    # 生成简化索引
├── test_single_page.py          # 单页测试
└── docs_output/
    ├── uefn_docs/               # 原始爬取结果（平铺）
    └── uefn_docs_organized/     # 分类整理后
        ├── README.md            # 主索引
        ├── SUMMARY.md           # 简化摘要
        ├── _compact_index.json  # JSON索引
        └── [分类目录]/
```

---

## 🔧 核心组件详解

### 1. CDP 浏览器连接 (crawler_connect_browser.py)

**原理**: 通过 Chrome DevTools Protocol 连接到已打开的浏览器，复用用户的登录状态和 Cookie，绕过 Cloudflare 验证。

**关键代码**:
```python
from playwright.sync_api import sync_playwright

def connect_browser(self):
    """连接到已运行的Chrome浏览器"""
    self.playwright = sync_playwright().start()
    self.browser = self.playwright.chromium.connect_over_cdp(
        f"http://localhost:{self.debug_port}"
    )
    self.context = self.browser.contexts[0]
    self.page = self.context.pages[0] if self.context.pages else self.context.new_page()
```

**浏览器启动命令** (PowerShell):
```powershell
Start-Process chrome -ArgumentList "--remote-debugging-port=9222", "--user-data-dir=$env:TEMP\chrome_debug_profile"
```

### 2. 代码块完整提取

**问题**: 官方文档的代码块有两种隐藏方式：
1. 折叠显示，完整代码在隐藏的 `<textarea aria-label="Copy full snippet">`
2. "Expand code" 按钮，点击后才加载完整代码

**解决方案**:
```python
def _expand_code_blocks(self):
    """展开所有折叠的代码块"""
    # 第一步：点击所有 "Expand code" 按钮
    expand_buttons = self.page.query_selector_all('button:has-text("Expand code")')
    for button in expand_buttons:
        button.click()
    time.sleep(1.5)  # 等待内容加载
    
    # 第二步：从隐藏 textarea 提取完整代码
    code_elements = self.page.query_selector_all('code')
    for code_el in code_elements:
        textarea = code_el.query_selector('textarea[aria-label="Copy full snippet"]')
        if textarea:
            full_code = textarea.input_value()
            if full_code:
                # 用 JavaScript 替换 code 元素内容
                self.page.evaluate('''(args) => {
                    args.codeEl.textContent = args.fullCode;
                }''', {'codeEl': code_el, 'fullCode': full_code})
```

### 3. 验证页面检测

**问题**: 需要区分 Cloudflare 验证页面和正常文档页面。

**解决方案**: 先检查文档特征，再检查验证关键词
```python
def _is_verification_page(self) -> bool:
    """检测是否为验证页面"""
    page_text = self.page.content().lower()
    
    # 先检查是否有文档特征（避免误判）
    doc_indicators = ['documentation', 'fortnite', 'verse', 'unreal']
    if any(indicator in page_text for indicator in doc_indicators):
        return False
    
    # 再检查验证页面特征
    verification_keywords = ['verify you are human', 'checking your browser', 'please wait']
    return any(keyword in page_text for keyword in verification_keywords)
```

### 4. 断点续爬

**实现**: 使用 `_index.json` 记录已爬取的 URL
```python
def _load_visited_urls(self) -> set:
    """从索引文件加载已访问的URL"""
    index_path = self.output_dir / "_index.json"
    if index_path.exists():
        with open(index_path, 'r', encoding='utf-8') as f:
            data = json.load(f)
            return {page['url'] for page in data.get('pages', [])}
    return set()
```

### 5. 文档分类整理 (organize_docs.py)

**分类规则** (按优先级):
```python
categories = {
    # API 文档 - 按模块分
    "API/Verse.org": lambda url: "/verse-api/versedotorg" in url,
    "API/UnrealEngine.com": lambda url: "/verse-api/unrealenginedotcom" in url,
    "API/Fortnite.com": lambda url: "/verse-api/fortnitedotcom" in url,
    
    # 发布说明
    "ReleaseNotes": lambda url: "release-notes" in url,
    
    # Verse 语言教程
    "Verse-Language": lambda url: url.endswith("-in-verse"),
    
    # 教程
    "Tutorials/Build-Games": lambda url: "build-a-" in url or "capture-the-flag" in url,
    "Tutorials/Devices": lambda url: "device-design-example" in url,
    
    # 设备参考
    "Devices": lambda url: "-device" in url and "example" not in url,
    
    # 编辑器功能
    "Editor/UI": lambda url: "user-interface" in url,
    "Editor/Audio": lambda url: "audio" in url,
    # ... 更多规则
}
```

---

## 📖 使用方法

### 第一步：环境准备

```powershell
# 1. 创建虚拟环境
python -m venv .venv
.\.venv\Scripts\Activate.ps1

# 2. 安装依赖
pip install playwright beautifulsoup4 markdownify
playwright install chromium
```

### 第二步：启动浏览器

```powershell
# 关闭所有 Chrome 进程
Get-Process chrome -ErrorAction SilentlyContinue | Stop-Process -Force

# 以调试模式启动 Chrome
Start-Process chrome -ArgumentList "--remote-debugging-port=9222", "--user-data-dir=$env:TEMP\chrome_debug_profile"

# 手动访问目标网站，完成任何验证
# https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-documentation
```

### 第三步：运行爬虫

```powershell
# 全量爬取
python run_crawler.py

# 单页测试
python test_single_page.py
```

### 第四步：分类整理

```powershell
# 预览分类结果
python organize_docs.py --dry-run

# 执行分类
python organize_docs.py

# 生成简化索引
python generate_compact_index.py
```

---

## 📁 输出结构

### 原始爬取结果
```
docs_output/uefn_docs/
├── _index.json                           # 爬取索引
├── fortnite-documentation/
│   └── index.md
├── verse-api/
│   └── index.md
└── [其他5000+文件夹]/
    └── index.md
```

### 分类整理后
```
docs_output/uefn_docs_organized/
├── README.md                             # 主索引
├── SUMMARY.md                            # 简化摘要
├── _compact_index.json                   # JSON索引
├── _categories.json                      # 分类数据
│
├── API/                                  # API文档 (3759页)
│   └── verse-api/
│       ├── fortnitedotcom/               # Fortnite.com模块
│       │   ├── ai/
│       │   ├── devices/
│       │   ├── ui/
│       │   └── ...
│       ├── unrealenginedotcom/           # UnrealEngine.com模块
│       └── versedotorg/                  # Verse.org模块
│
├── Tutorials/                            # 教程 (148页)
│   ├── Build-Games/
│   ├── Devices/
│   └── Starter-Templates/
│
├── Devices/                              # 设备参考 (255页)
├── Editor/                               # 编辑器功能 (323页)
│   ├── Animation/
│   ├── Audio/
│   ├── Lighting/
│   ├── Materials/
│   └── ...
│
├── Creative/                             # Creative模式 (238页)
│   ├── Islands/
│   └── Prefabs/
│
├── Verse-Language/                       # Verse语言 (138页)
├── ReleaseNotes/                         # 发布说明 (49页)
├── Reference/                            # 参考资料 (4页)
├── Publishing/                           # 发布相关 (6页)
└── Other/                                # 其他 (116页)
```

### Markdown 文件格式
```markdown
# [文档标题]

> **来源**: [原始URL]
> **爬取时间**: [ISO时间戳]

---

[文档正文内容，包含完整代码块]
```

---

## 🔄 可复用 Skill 设计建议

### Skill 接口设计

```python
class WebDocCrawlerSkill:
    """通用网站文档爬虫 Skill"""
    
    def __init__(self, config: CrawlerConfig):
        """
        config:
            - start_url: str - 起始URL
            - url_pattern: str - 有效URL正则
            - output_dir: str - 输出目录
            - debug_port: int - Chrome调试端口
            - max_pages: int - 最大页面数 (0=无限)
        """
        pass
    
    def crawl(self, resume: bool = True) -> CrawlResult:
        """执行爬取"""
        pass
    
    def organize(self, rules: List[CategoryRule]) -> OrganizeResult:
        """按规则分类整理"""
        pass
    
    def generate_index(self, format: str = "markdown") -> str:
        """生成索引文件"""
        pass
```

### 分类规则接口

```python
@dataclass
class CategoryRule:
    """分类规则"""
    name: str                           # 分类名称
    matcher: Callable[[str], bool]      # URL匹配函数
    priority: int = 0                   # 优先级（越高越先匹配）
    subcategory_extractor: Optional[Callable[[str], str]] = None  # 子分类提取
```

### 配置文件示例

```yaml
# crawler_config.yaml
name: "UEFN Documentation Crawler"
start_url: "https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-documentation"
url_pattern: "https://dev.epicgames.com/documentation/en-us/fortnite/.*"
output_dir: "./docs_output/uefn_docs"
debug_port: 9222

code_extraction:
  expand_buttons:
    - selector: 'button:has-text("Expand code")'
      wait_after_click: 1.5
  hidden_textareas:
    - selector: 'textarea[aria-label="Copy full snippet"]'

categories:
  - name: "API/Fortnite.com"
    pattern: "/verse-api/fortnitedotcom"
    priority: 100
  - name: "Tutorials"
    pattern: "tutorial|walkthrough|getting-started"
    priority: 50
  # ...
```

---

## ⚠️ 注意事项

### 反爬虫处理

1. **必须使用 CDP 连接**: 直接请求会被 Cloudflare 拦截
2. **需要手动完成首次验证**: 启动浏览器后手动访问网站
3. **建议使用独立用户数据目录**: 避免影响日常浏览器使用
4. **控制爬取速度**: 建议每页间隔 0.5-1 秒

### 代码块提取

1. **必须点击 Expand 按钮**: 某些代码块需要点击才能加载
2. **等待时间**: 点击后需等待 1.5 秒让内容加载
3. **使用 JavaScript 替换**: 直接修改 DOM 比提取后处理更可靠

### 分类整理

1. **优先级很重要**: URL 可能匹配多个规则，需要设置优先级
2. **API 文档特殊处理**: 量大需按模块层级组织
3. **生成简化索引**: 方便 AI 助手快速查询

---

## 📊 性能指标

| 指标 | 数值 |
|------|------|
| 总页面数 | 5,038 |
| 爬取时间 | ~8 小时 (含重试) |
| 平均每页 | ~6 秒 |
| 原始大小 | 29.3 MB |
| 整理后大小 | 29.3 MB |
| 失败页面 | 45 (0.9%) |

---

## 🔗 相关文件

| 文件 | 路径 | 说明 |
|------|------|------|
| 主爬虫 | `tools/uefn_doc_crawler/crawler_connect_browser.py` | CDP连接爬虫 |
| 启动脚本 | `tools/uefn_doc_crawler/run_crawler.py` | 断点续爬支持 |
| 分类整理 | `tools/uefn_doc_crawler/organize_docs.py` | 文档分类 |
| 索引生成 | `tools/uefn_doc_crawler/generate_compact_index.py` | 简化索引 |
| 主索引 | `docs/TDD/UEFN-Documentation-Index.md` | 项目集成 |
| JSON索引 | `docs/TDD/UEFN-Documentation-Index.json` | AI查询用 |

---

**文档维护**: 随爬虫更新同步更新  
**最后更新**: 2025-12-27
