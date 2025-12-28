#!/usr/bin/env python3
"""
Epic Games UEFN Documentation Crawler - Firecrawl 版本
使用 Firecrawl API 抓取受 Cloudflare 保护的 Epic 文档

Firecrawl 是专业的网页抓取服务，能够处理 JavaScript 渲染和 Cloudflare 保护。
免费额度: 500 credits/month

获取 API Key: https://www.firecrawl.dev/

Usage:
    export FIRECRAWL_API_KEY="your-api-key"
    python crawler_firecrawl.py                    # 抓取核心文档
    python crawler_firecrawl.py --full             # 抓取全部文档
    python crawler_firecrawl.py --url <url>        # 抓取指定页面
"""

import os
import sys
import json
import hashlib
import argparse
from pathlib import Path
from datetime import datetime

try:
    from firecrawl import FirecrawlApp
except ImportError:
    print("请先安装依赖: pip install firecrawl-py")
    sys.exit(1)


# ============== 配置 ==============

BASE_URL = "https://dev.epicgames.com/documentation/en-us/uefn"

# 核心文档 URLs
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

# 扩展文档
EXTENDED_DOCS = [
    "/devices",
    "/using-devices-in-verse",
    "/creative-devices-in-verse",
    "/custom-ui-in-verse",
    "/creating-custom-ui",
    "/characters-in-verse",
    "/players-in-verse",
    "/teams-in-verse",
    "/props-in-verse",
    "/verse-style-guide",
    "/debugging-verse-code",
    "/verse-best-practices",
]

OUTPUT_DIR = Path(__file__).parent.parent.parent.parent / "i18n/zh/skills/uefn-dev/references/official-docs"


class FirecrawlDocsCrawler:
    """使用 Firecrawl API 抓取 Epic 文档"""
    
    def __init__(self, api_key: str = None, output_dir: Path = OUTPUT_DIR):
        self.api_key = api_key or os.environ.get("FIRECRAWL_API_KEY")
        if not self.api_key:
            print("❌ 请设置 FIRECRAWL_API_KEY 环境变量")
            print("   获取 API Key: https://www.firecrawl.dev/")
            sys.exit(1)
        
        self.app = FirecrawlApp(api_key=self.api_key)
        self.output_dir = Path(output_dir)
        self.output_dir.mkdir(parents=True, exist_ok=True)
        self.index = {}
        self.failed_urls = []
        
        # 加载索引
        self.index_file = self.output_dir / "index.json"
        if self.index_file.exists():
            with open(self.index_file, "r", encoding="utf-8") as f:
                self.index = json.load(f)
    
    def _url_to_filename(self, url: str) -> str:
        """URL 转文件名"""
        path = url.replace(BASE_URL, '').strip('/')
        if not path:
            return "index"
        return path.replace('/', '_').replace('-', '_')
    
    def _save_content(self, url: str, content: str, title: str = ""):
        """保存抓取的内容"""
        filename = self._url_to_filename(url)
        filepath = self.output_dir / f"{filename}.md"
        
        markdown = f"""---
title: "{title or filename}"
source: "{url}"
crawled_at: "{datetime.now().isoformat()}"
---

{content}
"""
        
        with open(filepath, 'w', encoding='utf-8') as f:
            f.write(markdown)
        
        self.index[url] = {
            "title": title,
            "file": filepath.name,
            "crawled_at": datetime.now().isoformat(),
            "size": len(content),
        }
        
        with open(self.index_file, 'w', encoding='utf-8') as f:
            json.dump(self.index, f, indent=2, ensure_ascii=False)
        
        print(f"  💾 已保存: {filepath.name} ({len(content)/1024:.1f} KB)")
    
    def crawl_url(self, url: str) -> bool:
        """抓取单个 URL"""
        full_url = url if url.startswith('http') else BASE_URL + url
        print(f"\n📄 正在抓取: {full_url}")
        
        try:
            # 使用 Firecrawl 抓取
            result = self.app.scrape_url(
                full_url,
                params={
                    'formats': ['markdown'],
                    'waitFor': 5000,  # 等待 JS 渲染
                }
            )
            
            if result and result.get('markdown'):
                content = result['markdown']
                title = result.get('metadata', {}).get('title', '')
                self._save_content(full_url, content, title)
                return True
            else:
                print(f"  ❌ 未获取到内容")
                self.failed_urls.append(full_url)
                return False
                
        except Exception as e:
            print(f"  ❌ 抓取失败: {e}")
            self.failed_urls.append(full_url)
            return False
    
    def crawl_site(self, limit: int = 50):
        """使用 Firecrawl 的 crawl 功能抓取整个站点"""
        print(f"\n🌐 开始抓取整个 UEFN 文档站点 (最多 {limit} 页)")
        
        try:
            result = self.app.crawl_url(
                BASE_URL,
                params={
                    'limit': limit,
                    'scrapeOptions': {
                        'formats': ['markdown'],
                    }
                },
                poll_interval=5
            )
            
            if result and result.get('data'):
                for page in result['data']:
                    url = page.get('metadata', {}).get('sourceURL', '')
                    content = page.get('markdown', '')
                    title = page.get('metadata', {}).get('title', '')
                    if content:
                        self._save_content(url, content, title)
                
                print(f"\n✅ 抓取完成: {len(result['data'])} 页")
            else:
                print("❌ 未获取到数据")
                
        except Exception as e:
            print(f"❌ 站点抓取失败: {e}")
    
    def crawl_core(self):
        """抓取核心文档"""
        print("\n" + "="*60)
        print("🎯 使用 Firecrawl 抓取核心 UEFN/Verse 文档")
        print("="*60)
        
        success = 0
        for doc_path in CORE_DOCS:
            if self.crawl_url(doc_path):
                success += 1
        
        self._print_summary(success, len(CORE_DOCS))
    
    def crawl_full(self):
        """抓取全部文档"""
        print("\n" + "="*60)
        print("🎯 使用 Firecrawl 抓取全部 UEFN/Verse 文档")
        print("="*60)
        
        all_docs = CORE_DOCS + EXTENDED_DOCS
        success = 0
        for doc_path in all_docs:
            if self.crawl_url(doc_path):
                success += 1
        
        self._print_summary(success, len(all_docs))
    
    def _print_summary(self, success: int, total: int):
        """打印摘要"""
        print("\n" + "="*60)
        print("📊 抓取完成")
        print("="*60)
        print(f"  ✅ 成功: {success}/{total}")
        print(f"  ❌ 失败: {len(self.failed_urls)}")
        print(f"  📁 输出: {self.output_dir}")
        
        if self.failed_urls:
            print("\n❌ 失败的 URLs:")
            for url in self.failed_urls:
                print(f"    - {url}")


def main():
    parser = argparse.ArgumentParser(description="Epic UEFN 文档爬虫 (Firecrawl)")
    parser.add_argument('--full', action='store_true', help='抓取全部文档')
    parser.add_argument('--url', type=str, help='抓取指定 URL')
    parser.add_argument('--crawl-site', type=int, metavar='LIMIT', help='抓取整个站点')
    parser.add_argument('--api-key', type=str, help='Firecrawl API Key')
    parser.add_argument('--output', type=str, help='输出目录')
    
    args = parser.parse_args()
    
    output_dir = Path(args.output) if args.output else OUTPUT_DIR
    crawler = FirecrawlDocsCrawler(api_key=args.api_key, output_dir=output_dir)
    
    if args.crawl_site:
        crawler.crawl_site(limit=args.crawl_site)
    elif args.url:
        crawler.crawl_url(args.url)
    elif args.full:
        crawler.crawl_full()
    else:
        crawler.crawl_core()


if __name__ == "__main__":
    main()
