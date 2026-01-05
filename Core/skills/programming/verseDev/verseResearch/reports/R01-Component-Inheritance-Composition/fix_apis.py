#!/usr/bin/env python3
import re
import sys

def fix_file(filename):
    with open(filename, 'r', encoding='utf-8') as f:
        content = f.read()
    
    original = content
    
    # Remove disclaimers
    content = re.sub(r'（简化版）', '', content)
    content = re.sub(r'  # 假设有事件类型', '', content)
    
    # Fix Sleep(0.0) - this was my invention, remove it
    # But be careful - only in certain contexts
    content = re.sub(r'Sleep\(0\.0\)\s*\n\s*\n\s*# 获取所属 Entity', '# Entity 属性直接可用', content)
    content = re.sub(r'Sleep\(0\.0\)\s*\n\s*\n\s*if \(Owner := Entity\):', '# Entity 属性直接可用', content)
    
    # Fix if (Owner := GetOwner()) pattern - but this is tricky
    # For now, just note these need manual review
    
    if content != original:
        with open(filename, 'w', encoding='utf-8') as f:
            f.write(content)
        print(f"Fixed {filename}")
        return True
    else:
        print(f"No changes in {filename}")
        return False

if __name__ == '__main__':
    files = [
        '01-component-fundamentals.md',
        '02-inheritance-patterns.md',
        '03-composition-patterns.md',
        '04-design-decision-guide.md',
        'comprehensive-guide.md',
        'README.md'
    ]
    
    for f in files:
        try:
            fix_file(f)
        except Exception as e:
            print(f"Error processing {f}: {e}")
