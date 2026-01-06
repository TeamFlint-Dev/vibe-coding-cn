#!/usr/bin/env python3
"""
Debug LSP Communication
Shows all LSP messages exchanged to understand why diagnostics aren't working
"""

import asyncio
import json
import os
import platform
from pathlib import Path
import sys

sys.path.insert(0, str(Path(__file__).parent.parent.parent))

async def debug_lsp():
    """Debug LSP with full message logging"""
    
    # Find LSP binary
    sdk_dir = Path.cwd() / '.verse-sdk' / 'bin'
    system = platform.system()
    if system == 'Linux':
        lsp_path = sdk_dir / 'Linux' / 'verse-lsp'
    elif system == 'Darwin':
        lsp_path = sdk_dir / 'Mac' / 'verse-lsp'
    else:
        lsp_path = sdk_dir / 'Win64' / 'verse-lsp.exe'
    
    print(f"Starting LSP: {lsp_path}")
    
    # Start LSP process
    process = await asyncio.create_subprocess_exec(
        str(lsp_path),
        stdin=asyncio.subprocess.PIPE,
        stdout=asyncio.subprocess.PIPE,
        stderr=asyncio.subprocess.PIPE,
    )
    
    message_id = [0]
    
    async def send_request(method, params):
        """Send request and return response"""
        message_id[0] += 1
        request = {
            'jsonrpc': '2.0',
            'id': message_id[0],
            'method': method,
            'params': params,
        }
        
        content = json.dumps(request)
        message = f"Content-Length: {len(content)}\r\n\r\n{content}"
        
        print(f"\n>>> REQUEST {method} (id={message_id[0]})")
        print(json.dumps(request, indent=2))
        
        process.stdin.write(message.encode('utf-8'))
        await process.stdin.drain()
        
        # Read response
        response = await read_message()
        print(f"\n<<< RESPONSE (id={response.get('id')})")
        print(json.dumps(response, indent=2))
        
        return response
    
    async def send_notification(method, params):
        """Send notification"""
        notification = {
            'jsonrpc': '2.0',
            'method': method,
            'params': params,
        }
        
        content = json.dumps(notification)
        message = f"Content-Length: {len(content)}\r\n\r\n{content}"
        
        print(f"\n>>> NOTIFICATION {method}")
        print(json.dumps(notification, indent=2))
        
        process.stdin.write(message.encode('utf-8'))
        await process.stdin.drain()
    
    async def read_message():
        """Read LSP message"""
        headers = {}
        while True:
            line = await process.stdout.readline()
            if not line or line == b'\r\n':
                break
            header = line.decode('utf-8').strip()
            if ':' in header:
                key, value = header.split(':', 1)
                headers[key.strip()] = value.strip()
        
        content_length = int(headers.get('Content-Length', 0))
        if content_length == 0:
            return {}
        
        content = await process.stdout.readexactly(content_length)
        return json.loads(content.decode('utf-8'))
    
    # Initialize
    digest_dir = Path.cwd() / '.verse-sdk' / 'digests'
    init_response = await send_request('initialize', {
        'processId': os.getpid(),
        'rootUri': f"file://{digest_dir}",
        'capabilities': {
            'textDocument': {
                'publishDiagnostics': {}
            }
        },
    })
    
    print("\n" + "="*70)
    print("LSP Capabilities:")
    print("="*70)
    print(json.dumps(init_response.get('result', {}).get('capabilities', {}), indent=2))
    
    await send_notification('initialized', {})
    
    # Open document with error
    error_code = """using { /Verse.org/Simulation }

test_function():void =
    Print("Hello World"
"""
    
    print("\n" + "="*70)
    print("Opening document with syntax error (missing closing parenthesis)")
    print("="*70)
    
    await send_notification('textDocument/didOpen', {
        'textDocument': {
            'uri': 'file:///test.verse',
            'languageId': 'verse',
            'version': 1,
            'text': error_code,
        }
    })
    
    # Wait and try to read diagnostics
    print("\nWaiting for diagnostics...")
    await asyncio.sleep(3.0)
    
    print("\nAttempting to read diagnostic messages...")
    for attempt in range(5):
        try:
            message = await asyncio.wait_for(read_message(), timeout=1.0)
            print(f"\n<<< MESSAGE (attempt {attempt+1})")
            print(json.dumps(message, indent=2))
            
            if message.get('method') == 'textDocument/publishDiagnostics':
                diagnostics = message.get('params', {}).get('diagnostics', [])
                print(f"\n!!! Found {len(diagnostics)} diagnostics")
        except asyncio.TimeoutError:
            print(f"  Timeout on attempt {attempt+1}")
            break
    
    # Check stderr
    print("\nChecking stderr...")
    stderr_task = asyncio.create_task(process.stderr.read())
    try:
        stderr = await asyncio.wait_for(stderr_task, timeout=1.0)
        if stderr:
            print(f"LSP stderr:\n{stderr.decode('utf-8', errors='ignore')}")
        else:
            print("No stderr output")
    except asyncio.TimeoutError:
        print("No stderr output (timeout)")
        stderr_task.cancel()
    
    # Shutdown
    await send_request('shutdown', {})
    await send_notification('exit', {})
    
    try:
        await asyncio.wait_for(process.wait(), timeout=2.0)
    except asyncio.TimeoutError:
        process.kill()
    
    print("\nDebug session complete")

if __name__ == '__main__':
    asyncio.run(debug_lsp())
