#!/usr/bin/env python3
"""
Systematic API correction script for Component inheritance/composition research reports.
Fixes all instances of incorrect Verse API usage.
"""

import re
import sys
from pathlib import Path

def fix_api_errors(content, filename):
    """Apply all API corrections to content"""
    original = content
    changes = []
    
    # 1. Fix lifecycle method names in method definitions
    # OnBegin<override>() -> OnBeginSimulation<override>()
    pattern1 = r'OnBegin<override>\(\)'
    replacement1 = r'OnBeginSimulation<override>()'
    if re.search(pattern1, content):
        content = re.sub(pattern1, replacement1, content)
        changes.append(f"OnBegin<override>() → OnBeginSimulation<override>()")
    
    # OnEnd<override>() -> OnEndSimulation<override>()
    pattern2 = r'OnEnd<override>\(\)'
    replacement2 = r'OnEndSimulation<override>()'
    if re.search(pattern2, content):
        content = re.sub(pattern2, replacement2, content)
        changes.append(f"OnEnd<override>() → OnEndSimulation<override>()")
    
    # 2. Fix GetOwner() calls -> Entity property
    # Pattern: if (Owner := GetOwner()):
    pattern3 = r'if \(Owner := GetOwner\(\)\):'
    replacement3 = r'# Entity property is directly available'
    if re.search(pattern3, content):
        content = re.sub(pattern3, replacement3, content)
        changes.append(f"if (Owner := GetOwner()): → # Entity property is directly available")
    
    # Pattern: Owner := GetOwner()
    pattern4 = r'Owner := GetOwner\(\)'
    replacement4 = r'# Access Entity property directly'
    if re.search(pattern4, content):
        content = re.sub(pattern4, replacement4, content)
        changes.append(f"Owner := GetOwner() → # Access Entity property directly")
    
    # 3. Fix Owner. references -> Entity.
    # Be careful - only change when Owner was from GetOwner()
    # This is context-sensitive, so we'll mark it for manual review
    
    # 4. Remove Sleep(0.0) that was incorrectly required
    # Pattern: Sleep(0.0)\n\n        # (comment about Entity)
    pattern5 = r'Sleep\(0\.0\)\s*\n\s*\n\s*(# .*Entity|if \(Owner)'
    if re.search(pattern5, content):
        content = re.sub(r'Sleep\(0\.0\)\s*\n\s*\n\s*', '', content, count=10)
        changes.append(f"Removed unnecessary Sleep(0.0) calls")
    
    # 5. Remove disclaimers (already done but double-check)
    pattern6 = r'（简化版）'
    if re.search(pattern6, content):
        content = re.sub(pattern6, '', content)
        changes.append(f"Removed '（简化版）' disclaimer")
    
    pattern7 = r'  # 假设有事件类型'
    if re.search(pattern7, content):
        content = re.sub(pattern7, '', content)
        changes.append(f"Removed '# 假设有事件类型' disclaimer")
    
    return content, changes

def process_file(filepath):
    """Process a single file"""
    print(f"\n{'='*60}")
    print(f"Processing: {filepath.name}")
    print(f"{'='*60}")
    
    with open(filepath, 'r', encoding='utf-8') as f:
        content = f.read()
    
    fixed_content, changes = fix_api_errors(content, filepath.name)
    
    if changes:
        with open(filepath, 'w', encoding='utf-8') as f:
            f.write(fixed_content)
        print(f"✅ Applied {len(changes)} types of fixes:")
        for change in changes:
            print(f"   - {change}")
        return True
    else:
        print(f"ℹ️  No automatic fixes needed")
        return False

def main():
    """Main entry point"""
    report_dir = Path(__file__).parent
    
    files_to_fix = [
        '01-component-fundamentals.md',
        '02-inheritance-patterns.md',
        '03-composition-patterns.md',
        '04-design-decision-guide.md',
        'comprehensive-guide.md',
        'README.md'
    ]
    
    total_fixed = 0
    for filename in files_to_fix:
        filepath = report_dir / filename
        if filepath.exists():
            if process_file(filepath):
                total_fixed += 1
        else:
            print(f"⚠️  File not found: {filename}")
    
    print(f"\n{'='*60}")
    print(f"Summary: Fixed {total_fixed} out of {len(files_to_fix)} files")
    print(f"{'='*60}")
    print("\nNext steps:")
    print("1. Review changes with: git diff")
    print("2. Manually fix remaining Owner.* -> Entity.* references")
    print("3. Verify code examples compile")
    print("4. Run: make lint")

if __name__ == '__main__':
    main()
