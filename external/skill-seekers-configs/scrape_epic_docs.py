"""
Epic Games UEFN Documentation Scraper
Uses Playwright to bypass Cloudflare protection
"""

import asyncio
import json
import os
from pathlib import Path

async def scrape_epic_docs():
    from playwright.async_api import async_playwright
    
    urls_to_scrape = [
        "https://dev.epicgames.com/documentation/en-us/uefn/verse-language-quick-reference",
        "https://dev.epicgames.com/documentation/en-us/uefn/verse-api",
        "https://dev.epicgames.com/documentation/en-us/uefn/verse-language-reference",
    ]
    
    output_dir = Path("/workspaces/vibe-coding-cn/output/epic-docs-scraped")
    output_dir.mkdir(parents=True, exist_ok=True)
    
    async with async_playwright() as p:
        # Launch browser with stealth settings
        browser = await p.chromium.launch(
            headless=True,
            args=[
                '--disable-blink-features=AutomationControlled',
                '--disable-dev-shm-usage',
                '--no-sandbox',
            ]
        )
        
        context = await browser.new_context(
            viewport={'width': 1920, 'height': 1080},
            user_agent='Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36',
        )
        
        page = await context.new_page()
        
        # Try to scrape each URL
        results = []
        for url in urls_to_scrape:
            print(f"\n🔍 Attempting to scrape: {url}")
            try:
                # Navigate with extended timeout for Cloudflare challenge
                response = await page.goto(url, wait_until='networkidle', timeout=60000)
                
                # Wait for Cloudflare challenge to complete
                print("⏳ Waiting for page to load (Cloudflare challenge)...")
                await page.wait_for_timeout(10000)  # Wait 10 seconds
                
                # Check if we're past Cloudflare
                title = await page.title()
                print(f"📄 Page title: {title}")
                
                if "Just a moment" in title:
                    print("⚠️ Still on Cloudflare challenge page, waiting longer...")
                    await page.wait_for_timeout(15000)
                    title = await page.title()
                
                if "Just a moment" not in title:
                    # Extract content
                    content = await page.content()
                    
                    # Try to get main content
                    try:
                        main_content = await page.query_selector('main, article, .content, .documentation-content')
                        if main_content:
                            text_content = await main_content.inner_text()
                        else:
                            text_content = await page.inner_text('body')
                    except:
                        text_content = await page.inner_text('body')
                    
                    # Save results
                    filename = url.split('/')[-1] + '.md'
                    filepath = output_dir / filename
                    with open(filepath, 'w', encoding='utf-8') as f:
                        f.write(f"# {title}\n\n")
                        f.write(f"Source: {url}\n\n")
                        f.write("---\n\n")
                        f.write(text_content)
                    
                    print(f"✅ Saved: {filepath}")
                    results.append({'url': url, 'status': 'success', 'file': str(filepath)})
                else:
                    print(f"❌ Could not bypass Cloudflare for: {url}")
                    results.append({'url': url, 'status': 'blocked'})
                    
            except Exception as e:
                print(f"❌ Error scraping {url}: {e}")
                results.append({'url': url, 'status': 'error', 'error': str(e)})
        
        await browser.close()
        
        # Save summary
        summary_path = output_dir / 'scrape_summary.json'
        with open(summary_path, 'w') as f:
            json.dump(results, f, indent=2)
        
        print(f"\n📊 Summary saved to: {summary_path}")
        return results

if __name__ == "__main__":
    results = asyncio.run(scrape_epic_docs())
    
    success = sum(1 for r in results if r['status'] == 'success')
    print(f"\n✅ Successfully scraped: {success}/{len(results)} pages")
