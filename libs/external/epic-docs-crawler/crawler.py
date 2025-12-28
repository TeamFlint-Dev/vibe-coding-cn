#!/usr/bin/env python3
"""
Epic Games UEFN Documentation Crawler
使用 Playwright 绕过 Cloudflare 保护抓取官方文档

Usage:
    python crawler.py                    # 抓取核心 API 文档
    python crawler.py --full             # 抓取全部文档
    python crawler.py --url <url>        # 抓取指定页面
"""

import os
import sys
import json
import time
import hashlib
import argparse
import asyncio
from pathlib import Path
from datetime import datetime
from urllib.parse import urljoin, urlparse

try:
    from playwright.async_api import async_playwright
    from playwright_stealth import Stealth
    from markdownify import markdownify as md
except ImportError:
    print("请先安装依赖: pip install playwright playwright-stealth markdownify")
    print("然后运行: playwright install chromium --with-deps")
    sys.exit(1)


# ============== 配置 ==============

BASE_URL = "https://dev.epicgames.com/documentation/en-us/uefn"

# 核心文档 URLs（优先抓取）
CORE_DOCS = [
    "/verse-language-reference",
    "/verse-api",
    "/verse-language-quick-reference",
    "/specifiers-and-attributes-in-verse",
    "/modules-and-paths-in-verse",
    "/option-values-in-verse",
    "/failure-and-failable-expressions-in-verse",
    "/concurrency-in-verse",
    "/concurrency-overview-in-verse",
    "/classes-and-objects-in-verse",
    "/interfaces-in-verse",
    "/structs-in-verse",
    "/array-in-verse",
    "/map-in-verse",
    "/types-in-verse",
]

# 扩展文档（--full 模式）
EXTENDED_DOCS = [
    # Devices
    "/devices",
    "/using-devices-in-verse",
    "/creative-devices-in-verse",
    "/trigger-device-in-verse",
    "/button-device-in-verse",
    "/item-spawner-device-in-verse",
    "/timer-device-in-verse",
    "/hud-message-device-in-verse",
    "/scoreboard-device-in-verse",
    "/player-spawner-device-in-verse",
    "/teleporter-device-in-verse",
    "/elimination-manager-device-in-verse",
    # UI
    "/custom-ui-in-verse",
    "/creating-custom-ui",
    "/ui-widgets-in-verse",
    # Characters & Players
    "/characters-in-verse",
    "/players-in-verse",
    "/teams-in-verse",
    "/playspaces-in-verse",
    # Gameplay
    "/game-flow-in-verse",
    "/game-modes-in-verse",
    "/scoring-in-verse",
    "/rounds-in-verse",
    # Props & Assets
    "/props-in-verse",
    "/spawning-props-in-verse",
    "/assets-in-verse",
    # Animation & Effects
    "/animation-in-verse",
    "/visual-effects-in-verse",
    "/audio-in-verse",
    # Math & Spatial
    "/math-in-verse",
    "/transforms-in-verse",
    "/vectors-in-verse",
    "/rotations-in-verse",
    # Best Practices
    "/verse-style-guide",
    "/debugging-verse-code",
    "/verse-best-practices",
    "/performance-in-verse",
]

# 输出目录
OUTPUT_DIR = Path(__file__).parent.parent.parent.parent / "i18n/zh/skills/uefn-dev/references/official-docs"


# ============== 爬虫实现 ==============

class EpicDocsCrawler:
    """Epic Games 文档爬虫 (Playwright 版)"""
    
    def __init__(self, output_dir: Path = OUTPUT_DIR):
        self.output_dir = Path(output_dir)
        self.output_dir.mkdir(parents=True, exist_ok=True)
        self.browser = None
        self.context = None
        self.page = None
        self.playwright = None
        self.crawled_urls = set()
        self.failed_urls = []
        self.index = {}
        
        # 加载已爬取的索引
        self.index_file = self.output_dir / "index.json"
        if self.index_file.exists():
            with open(self.index_file, "r", encoding="utf-8") as f:
                self.index = json.load(f)
    
    async def _init_browser(self):
        """初始化浏览器"""
        self.playwright = await async_playwright().start()
        
        # 使用 Chromium，添加反检测参数
        self.browser = await self.playwright.chromium.launch(
            headless=True,
            args=[
                '--disable-blink-features=AutomationControlled',
                '--disable-dev-shm-usage',
                '--no-sandbox',
                '--disable-setuid-sandbox',
                '--disable-infobars',
                '--window-size=1920,1080',
                '--start-maximized',
            ]
        )
        
        # 创建上下文，模拟真实用户
        self.context = await self.browser.new_context(
            viewport={'width': 1920, 'height': 1080},
            user_agent='Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36',
            locale='en-US',
            timezone_id='America/New_York',
        )
        
        # 添加反检测脚本
        await self.context.add_init_script("""
            // 隐藏 webdriver 属性
            Object.defineProperty(navigator, 'webdriver', {
                get: () => undefined
            });
            
            // 伪造 plugins
            Object.defineProperty(navigator, 'plugins', {
                get: () => [1, 2, 3, 4, 5]
            });
            
            // 伪造 languages
            Object.defineProperty(navigator, 'languages', {
                get: () => ['en-US', 'en']
            });
            
            // 隐藏 automation 相关属性
            window.chrome = { runtime: {} };
        """)
        
        self.page = await self.context.new_page()
        
        # 应用 stealth 模式
        stealth = Stealth()
        await stealth.apply_stealth_async(self.page)
        
        print("🌐 浏览器已启动 (Playwright Chromium + Stealth)")
    
    async def _wait_for_cloudflare(self, timeout: int = 60):
        """等待 Cloudflare 挑战完成"""
        start = time.time()
        check_interval = 2
        
        while time.time() - start < timeout:
            try:
                title = await self.page.title()
                title_lower = title.lower() if title else ""
                
                # 检查是否还在 Cloudflare 页面
                if "just a moment" in title_lower or "checking" in title_lower:
                    print(f"  ⏳ Cloudflare 验证中... ({int(time.time() - start)}s)")
                    await asyncio.sleep(check_interval)
                    continue
                
                # 检查页面内容
                body = await self.page.content()
                if "cf-browser-verification" in body or "challenge-running" in body:
                    print(f"  ⏳ 等待验证完成... ({int(time.time() - start)}s)")
                    await asyncio.sleep(check_interval)
                    continue
                
                # 检查是否有实际内容
                content = await self.page.query_selector('article, main, .documentation-content')
                if content:
                    print("  ✅ 页面加载成功")
                    return True
                
                # 可能还在加载
                await asyncio.sleep(check_interval)
                
            except Exception as e:
                print(f"  ⚠️ 检查状态出错: {e}")
                await asyncio.sleep(check_interval)
        
        return False
    
    async def _extract_content(self) -> dict:
        """从当前页面提取文档内容"""
        result = {
            "title": "",
            "content": "",
            "html": "",
            "breadcrumb": [],
            "links": [],
        }
        
        try:
            # 等待主内容加载
            await self.page.wait_for_selector('article, main, .content', timeout=15000)
        except:
            pass
        
        # 提取标题
        try:
            h1 = await self.page.query_selector('h1')
            if h1:
                result["title"] = await h1.inner_text()
        except:
            result["title"] = await self.page.title() or "Untitled"
        
        # 提取面包屑导航
        try:
            breadcrumb = await self.page.query_selector('.breadcrumb, nav[aria-label="breadcrumb"]')
            if breadcrumb:
                links = await breadcrumb.query_selector_all('a')
                result["breadcrumb"] = [await a.inner_text() for a in links]
        except:
            pass
        
        # 提取主内容
        content_selectors = [
            'article',
            'main article',
            '.documentation-content',
            '.content-body',
            '#content',
            '.markdown-body',
            'main',
        ]
        
        for selector in content_selectors:
            try:
                content_el = await self.page.query_selector(selector)
                if content_el:
                    result["html"] = await content_el.inner_html()
                    result["content"] = md(
                        result["html"],
                        heading_style="atx",
                        code_language="verse",
                        strip=['script', 'style', 'nav', 'footer', 'aside'],
                    )
                    if len(result["content"]) > 200:
                        break
            except:
                continue
        
        # 如果没找到主内容，使用整个页面
        if not result["content"] or len(result["content"]) < 200:
            try:
                full_html = await self.page.content()
                result["html"] = full_html
                result["content"] = md(
                    full_html,
                    heading_style="atx",
                    code_language="verse",
                    strip=['script', 'style', 'nav', 'footer', 'header', 'aside'],
                )
            except:
                result["content"] = "Failed to extract content"
        
        # 提取页内链接（用于发现更多文档）
        try:
            all_links = await self.page.query_selector_all('a[href*="/documentation/en-us/uefn/"]')
            for a in all_links:
                href = await a.get_attribute('href')
                if href:
                    result["links"].append(href)
        except:
            pass
        
        return result
    
    def _url_to_filename(self, url: str) -> str:
        """将 URL 转换为文件名"""
        parsed = urlparse(url)
        path = parsed.path.replace('/documentation/en-us/uefn/', '')
        path = path.strip('/')
        
        if not path:
            return "index"
        
        # 清理文件名
        filename = path.replace('/', '_').replace('-', '_')
        return filename
    
    def _save_content(self, url: str, content: dict):
        """保存抓取的内容"""
        filename = self._url_to_filename(url)
        filepath = self.output_dir / f"{filename}.md"
        
        # 构建 Markdown 文档
        markdown = f"""---
title: "{content['title']}"
source: "{url}"
crawled_at: "{datetime.now().isoformat()}"
---

# {content['title']}

{content['content']}
"""
        
        with open(filepath, 'w', encoding='utf-8') as f:
            f.write(markdown)
        
        # 更新索引
        self.index[url] = {
            "title": content["title"],
            "file": filepath.name,
            "crawled_at": datetime.now().isoformat(),
            "hash": hashlib.md5(content["content"].encode()).hexdigest(),
            "size": len(content["content"]),
        }
        
        # 保存索引
        with open(self.index_file, 'w', encoding='utf-8') as f:
            json.dump(self.index, f, indent=2, ensure_ascii=False)
        
        print(f"  💾 已保存: {filepath.name} ({len(content['content'])/1024:.1f} KB)")
        return filepath
    
    async def crawl_url(self, url: str) -> bool:
        """抓取单个 URL"""
        if url in self.crawled_urls:
            print(f"  ⏭️  已抓取过: {url}")
            return True
        
        # 正确拼接 URL
        if url.startswith('http'):
            full_url = url
        elif url.startswith('/'):
            full_url = BASE_URL + url
        else:
            full_url = BASE_URL + '/' + url
        print(f"\n📄 正在抓取: {full_url}")
        
        try:
            # 访问页面
            response = await self.page.goto(full_url, wait_until='domcontentloaded', timeout=60000)
            
            if response and response.status == 403:
                print(f"  ❌ 403 Forbidden - Cloudflare 拦截")
                self.failed_urls.append(full_url)
                return False
            
            # 等待 Cloudflare 验证
            if not await self._wait_for_cloudflare():
                print(f"  ❌ Cloudflare 验证超时或失败")
                self.failed_urls.append(full_url)
                return False
            
            # 额外等待确保内容加载
            await asyncio.sleep(3)
            
            # 检查是否 404
            title = await self.page.title()
            if "404" in (title or ""):
                print(f"  ❌ 404 Not Found")
                self.failed_urls.append(full_url)
                return False
            
            # 提取内容
            content = await self._extract_content()
            
            if not content["content"] or len(content["content"]) < 100:
                print(f"  ⚠️  内容过少 ({len(content.get('content', ''))} chars)，重试中...")
                await asyncio.sleep(5)
                content = await self._extract_content()
            
            if len(content["content"]) < 100:
                print(f"  ❌ 无法获取有效内容")
                self.failed_urls.append(full_url)
                return False
            
            # 保存
            self._save_content(full_url, content)
            self.crawled_urls.add(full_url)
            
            # 随机延迟，避免被封
            delay = 5 + (hash(url) % 5)
            print(f"  ⏳ 等待 {delay}s...")
            await asyncio.sleep(delay)
            
            return True
            
        except Exception as e:
            print(f"  ❌ 抓取失败: {e}")
            self.failed_urls.append(full_url)
            return False
    
    async def crawl_core(self):
        """抓取核心文档"""
        print("\n" + "="*60)
        print("🎯 开始抓取核心 UEFN/Verse 文档")
        print(f"📁 输出目录: {self.output_dir}")
        print("="*60)
        
        await self._init_browser()
        
        # 先访问首页建立 session
        print("\n📡 正在建立连接...")
        await self.page.goto(BASE_URL, wait_until='domcontentloaded', timeout=60000)
        
        if not await self._wait_for_cloudflare(timeout=90):
            print("❌ 无法通过 Cloudflare 验证")
            await self._print_summary(0, len(CORE_DOCS))
            return
        
        print("✅ Cloudflare 验证通过！开始抓取文档...")
        await asyncio.sleep(3)
        
        # 抓取核心文档
        success = 0
        for doc_path in CORE_DOCS:
            if await self.crawl_url(doc_path):
                success += 1
        
        await self._print_summary(success, len(CORE_DOCS))
    
    async def crawl_full(self):
        """抓取全部文档"""
        print("\n" + "="*60)
        print("🎯 开始抓取全部 UEFN/Verse 文档")
        print(f"📁 输出目录: {self.output_dir}")
        print("="*60)
        
        await self._init_browser()
        
        # 先访问首页
        print("\n📡 正在建立连接...")
        await self.page.goto(BASE_URL, wait_until='domcontentloaded', timeout=60000)
        
        if not await self._wait_for_cloudflare(timeout=90):
            print("❌ 无法通过 Cloudflare 验证")
            return
        
        print("✅ Cloudflare 验证通过！开始抓取文档...")
        await asyncio.sleep(3)
        
        # 合并所有 URLs
        all_docs = CORE_DOCS + EXTENDED_DOCS
        
        success = 0
        for doc_path in all_docs:
            if await self.crawl_url(doc_path):
                success += 1
        
        await self._print_summary(success, len(all_docs))
    
    async def crawl_single(self, url: str):
        """抓取单个页面"""
        await self._init_browser()
        
        # 先访问首页建立 session
        print("\n📡 正在建立连接...")
        await self.page.goto(BASE_URL, wait_until='domcontentloaded', timeout=60000)
        await self._wait_for_cloudflare(timeout=90)
        await asyncio.sleep(3)
        
        success = await self.crawl_url(url)
        
        await self._print_summary(1 if success else 0, 1)
    
    async def _print_summary(self, success: int, total: int):
        """打印抓取摘要"""
        print("\n" + "="*60)
        print("📊 抓取完成")
        print("="*60)
        print(f"  ✅ 成功: {success}/{total}")
        print(f"  ❌ 失败: {len(self.failed_urls)}")
        print(f"  📁 输出目录: {self.output_dir}")
        
        if self.failed_urls:
            print("\n❌ 失败的 URLs:")
            for url in self.failed_urls[:10]:  # 最多显示10个
                print(f"    - {url}")
            if len(self.failed_urls) > 10:
                print(f"    ... 还有 {len(self.failed_urls) - 10} 个")
        
        # 列出保存的文件
        saved_files = list(self.output_dir.glob("*.md"))
        if saved_files:
            print(f"\n📁 已保存 {len(saved_files)} 个文件:")
            total_size = 0
            for f in sorted(saved_files)[:15]:
                size = f.stat().st_size / 1024
                total_size += size
                print(f"    {f.name} ({size:.1f} KB)")
            if len(saved_files) > 15:
                print(f"    ... 还有 {len(saved_files) - 15} 个文件")
            print(f"\n  📦 总大小: {total_size:.1f} KB")
    
    async def close(self):
        """关闭浏览器"""
        if self.browser:
            await self.browser.close()
        if self.playwright:
            await self.playwright.stop()


async def main_async(args):
    """异步主函数"""
    output_dir = Path(args.output) if args.output else OUTPUT_DIR
    crawler = EpicDocsCrawler(output_dir=output_dir)
    
    try:
        if args.url:
            await crawler.crawl_single(args.url)
        elif args.full:
            await crawler.crawl_full()
        else:
            await crawler.crawl_core()
    finally:
        await crawler.close()


def main():
    parser = argparse.ArgumentParser(description="Epic Games UEFN 文档爬虫 (Playwright)")
    parser.add_argument('--full', action='store_true', help='抓取全部文档')
    parser.add_argument('--url', type=str, help='抓取指定 URL')
    parser.add_argument('--output', type=str, help='输出目录')
    
    args = parser.parse_args()
    asyncio.run(main_async(args))


if __name__ == "__main__":
    main()
