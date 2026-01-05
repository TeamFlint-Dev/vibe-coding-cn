#!/usr/bin/env python3
import re

def fix_owner_references(filepath):
    with open(filepath, 'r', encoding='utf-8') as f:
        content = f.read()
    
    original = content
    
    # Replace Owner. with Entity. in code blocks
    # But be careful - only in verse code blocks
    content = re.sub(r'\bOwner\.', 'Entity.', content)
    
    # Also replace standalone Owner references in some contexts
    # Pattern: if (Owner := Entity)
    content = re.sub(r'if \(Owner := Entity\):', 'if (MyEntity := Entity):', content)
    
    if content != original:
        with open(filepath, 'w', encoding='utf-8') as f:
            f.write(content)
        return True
    return False

files = [
    '03-composition-patterns.md',
    'comprehensive-guide.md',
    'ERRATA.md'
]

for f in files:
    if fix_owner_references(f):
        print(f"✅ Fixed Owner references in {f}")
    else:
        print(f"ℹ️  No Owner references in {f}")
