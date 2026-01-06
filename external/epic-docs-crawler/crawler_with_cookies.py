#!/usr/bin/env python3
"""
Epic Games UEFN Documentation Crawler - Cookie 辅助版本

此版本需要用户先在浏览器中访问 Epic 文档，通过 Cloudflare 验证后导出 cookies。
然后爬虫使用这些 cookies 来抓取文档。

步骤:
1. 在 Chrome 中打开: https://dev.epicgames.com/documentation/en-us/uefn/verse-api
2. 完成 Cloudflare 验证
3. 安装 "EditThisCookie" 或 "Cookie-Editor" 扩展
4. 导出 cookies 为 JSON 格式，保存到 cookies.json
5. 运行此脚本: python crawler_with_cookies.py

Usage:
    python crawler_with_cookies.py --cookies cookies.json
    python crawler_with_cookies.py --cookies cookies.json --full
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
from urllib.parse import urlparse

try:
    from playwright.async_api import async_playwright
    from markdownify import markdownify as md
except ImportError:
    print("请先安装依赖: pip install playwright markdownify")
    sys.exit(1)


BASE_URL = "https://dev.epicgames.com/documentation/en-us/uefn"

CORE_DOCS = [
    "/verse-language-reference",
    "/verse-api",
    "/verse-language-quick-reference",
    "/specifiers-and-attributes-in-verse",
    "/modules-and-paths-in-verse",
    "/option-values-in-verse",
    "/failure-and-failable-expressions-in-verse",
    "/concurrency-in-verse",
    "/classes-and-objects-in-verse",
    "/interfaces-in-verse",
    "/structs-in-verse",
    "/array-in-verse",
    "/map-in-verse",
    "/types-in-verse",
]

EXTENDED_DOCS = [
    "/devices",
    "/using-devices-in-verse", 
    "/custom-ui-in-verse",
    "/characters-in-verse",
    "/players-in-verse",
    "/verse-style-guide",
    "/debugging-verse-code",
]

OUTPUT_DIR = Path(__file__).parent.parent.parent.parent / "i18n/zh/skills/uefn-dev/references/official-docs"


class CookieCrawler:
    """使用预设 cookies 的爬虫"""
    
    def __init__(self, cookies_file: str, output_dir: Path = OUTPUT_DIR):
        self.output_dir = Path(output_dir)
        self.output_dir.mkdir(parents=True, exist_ok=True)
        self.cookies = self._load_cookies(cookies_file)
        self.browser = None
        self.context = None
        self.page = None
        self.playwright = None
        self.crawled_urls = set()
        self.failed_urls = []
        self.index = {}
        
        self.index_file = self.output_dir / "index.json"
        if self.index_file.exists():
            with open(self.index_file, "r", encoding="utf-8") as f:
                self.index = json.load(f)
    
    def _load_cookies(self, cookies_file: str) -> list:
        """加载 cookies 文件"""
        if not os.path.exists(cookies_file):
            print(f"❌ Cookies 文件不存在: {cookies_file}")
            print("\n📋 获取 cookies 的步骤:")
            print("1. 在 Chrome 中打开: https://dev.epicgames.com/documentation/en-us/uefn/verse-api")
            print("2. 完成 Cloudflare 验证（如有）")
            print("3. 安装 'EditThisCookie' 或 'Cookie-Editor' Chrome 扩展")
            print("4. 点击扩展图标 -> 导出 -> 选择 JSON 格式")
            print("5. 保存为 cookies.json")
            print(f"6. 运行: python {__file__} --cookies cookies.json")
            sys.exit(1)
        
        with open(cookies_file, 'r', encoding='utf-8') as f:
            cookies = json.load(f)
        
        # 转换为 Playwright 格式
        playwright_cookies = []
        for cookie in cookies:
            pc = {
                'name': cookie.get('name'),
                'value': cookie.get('value'),
                'domain': cookie.get('domain', '.dev.epicgames.com'),
                'path': cookie.get('path', '/'),
            }
            if cookie.get('expirationDate'):
                pc['expires'] = cookie['expirationDate']
            if cookie.get('secure'):
                pc['secure'] = cookie['secure']
            if cookie.get('httpOnly'):
                pc['httpOnly'] = cookie['httpOnly']
            if cookie.get('sameSite'):
                pc['sameSite'] = cookie['sameSite'].capitalize()
            playwright_cookies.append(pc)
        
        print(f"✅ 已加载 {len(playwright_cookies)} 个 cookies")
        return playwright_cookies
    
    async def _init_browser(self):
        """初始化浏览器并注入 cookies"""
        self.playwright = await async_playwright().start()
        
        self.browser = await self.playwright.chromium.launch(
            headless=True,
            args=['--disable-blink-features=AutomationControlled']
        )
        
        # 使用用户的精确浏览器指纹
        self.context = await self.browser.new_context(
            viewport={'width': 2560, 'height': 1440},
            device_scale_factor=0.9,
            user_agent='Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36',
            locale='zh-CN',
            timezone_id='Asia/Shanghai',
            color_scheme='light',
        )
        
        # 注入 cookies
        await self.context.add_cookies(self.cookies)
        
        self.page = await self.context.new_page()
        
        # 设置额外的浏览器属性
        await self.page.add_init_script("""
            Object.defineProperty(navigator, 'webdriver', { get: () => undefined });
            Object.defineProperty(navigator, 'platform', { get: () => 'Win32' });
            Object.defineProperty(navigator, 'languages', { get: () => ['zh-CN', 'zh', 'en'] });
            Object.defineProperty(screen, 'colorDepth', { get: () => 24 });
        """)
        
        print("🌐 浏览器已启动，cookies 已注入")
    
    async def _extract_content(self) -> dict:
        """提取页面内容"""
        result = {"title": "", "content": ""}
        
        try:
            await self.page.wait_for_selector('article, main', timeout=10000)
        except:
            pass
        
        try:
            h1 = await self.page.query_selector('h1')
            if h1:
                result["title"] = await h1.inner_text()
        except:
            result["title"] = await self.page.title() or "Untitled"
        
        for selector in ['article', 'main article', '.documentation-content', 'main']:
            try:
                el = await self.page.query_selector(selector)
                if el:
                    html = await el.inner_html()
                    result["content"] = md(html, heading_style="atx", code_language="verse")
                    if len(result["content"]) > 200:
                        break
            except:
                continue
        
        return result
    
    def _save_content(self, url: str, content: dict):
        """保存内容"""
        path = url.replace(BASE_URL, '').strip('/')
        filename = (path or 'index').replace('/', '_').replace('-', '_')
        filepath = self.output_dir / f"{filename}.md"
        
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
        
        self.index[url] = {
            "title": content["title"],
            "file": filepath.name,
            "size": len(content["content"]),
        }
        
        with open(self.index_file, 'w', encoding='utf-8') as f:
            json.dump(self.index, f, indent=2, ensure_ascii=False)
        
        print(f"  💾 已保存: {filepath.name} ({len(content['content'])/1024:.1f} KB)")
    
    async def crawl_url(self, url: str) -> bool:
        """抓取单个 URL"""
        full_url = url if url.startswith('http') else BASE_URL + url
        print(f"\n📄 正在抓取: {full_url}")
        
        try:
            response = await self.page.goto(full_url, wait_until='domcontentloaded', timeout=60000)
            
            # 等待内容加载
            await asyncio.sleep(3)
            
            if response and response.status == 403:
                print("  ❌ 403 Forbidden - Cookies 可能已过期")
                self.failed_urls.append(full_url)
                return False
            
            await asyncio.sleep(2)
            
            # 检查是否仍在 Cloudflare 页面
            title = await self.page.title()
            if "just a moment" in (title or "").lower():
                print("  ❌ 仍被 Cloudflare 拦截，请更新 cookies")
                self.failed_urls.append(full_url)
                return False
            
            content = await self._extract_content()
            
            if len(content.get("content", "")) < 100:
                print("  ❌ 内容过少")
                self.failed_urls.append(full_url)
                return False
            
            self._save_content(full_url, content)
            self.crawled_urls.add(full_url)
            
            await asyncio.sleep(3)
            return True
            
        except Exception as e:
            print(f"  ❌ 失败: {e}")
            self.failed_urls.append(full_url)
            return False
    
    async def crawl_core(self):
        """抓取核心文档"""
        print("\n" + "="*60)
        print("🎯 使用 Cookies 抓取核心 UEFN/Verse 文档")
        print("="*60)
        
        await self._init_browser()
        
        success = 0
        for doc in CORE_DOCS:
            if await self.crawl_url(doc):
                success += 1
        
        print(f"\n✅ 完成: {success}/{len(CORE_DOCS)}")
        if self.failed_urls:
            print(f"❌ 失败: {len(self.failed_urls)}")
    
    async def crawl_full(self):
        """抓取全部文档"""
        await self._init_browser()
        
        all_docs = CORE_DOCS + EXTENDED_DOCS
        success = 0
        for doc in all_docs:
            if await self.crawl_url(doc):
                success += 1
        
        print(f"\n✅ 完成: {success}/{len(all_docs)}")
    
    async def close(self):
        """关闭浏览器"""
        if self.browser:
            await self.browser.close()
        if self.playwright:
            await self.playwright.stop()


async def main_async(args):
    crawler = CookieCrawler(args.cookies, Path(args.output) if args.output else OUTPUT_DIR)
    try:
        if args.full:
            await crawler.crawl_full()
        else:
            await crawler.crawl_core()
    finally:
        await crawler.close()


def main():
    parser = argparse.ArgumentParser(description="Epic UEFN 文档爬虫 (Cookie 辅助)")
    parser.add_argument('--cookies', type=str, default='cookies.json', help='Cookies JSON 文件路径')
    parser.add_argument('--full', action='store_true', help='抓取全部文档')
    parser.add_argument('--output', type=str, help='输出目录')
    
    args = parser.parse_args()
    asyncio.run(main_async(args))


if __name__ == "__main__":
    main()
