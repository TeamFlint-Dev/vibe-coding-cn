#!/usr/bin/env python3
"""
Simple Cloud Compilation Test
Tests if the cloud compilation service is working by compiling the current branch
"""

import sys
import requests
import time

SERVER_URL = "http://193.112.183.143:19527"
TIMEOUT = 300  # 5 minutes

def test_connection():
    """Test if server is online"""
    try:
        response = requests.get(f"{SERVER_URL}/health", timeout=5)
        if response.status_code == 200:
            print("✅ Server is online")
            return True
        else:
            print(f"❌ Server returned {response.status_code}")
            return False
    except Exception as e:
        print(f"❌ Connection failed: {e}")
        return False

def trigger_compile(branch):
    """Trigger compilation for a branch"""
    try:
        response = requests.post(
            f"{SERVER_URL}/verse/compile",
            json={"branch": branch},
            timeout=10
        )
        
        if response.status_code == 200:
            data = response.json()
            request_id = data.get('request_id')
            print(f"✅ Compilation triggered: {request_id}")
            return request_id
        else:
            print(f"❌ Failed to trigger: {response.status_code}")
            print(response.text)
            return None
    except Exception as e:
        print(f"❌ Error: {e}")
        return None

def wait_for_result(request_id):
    """Wait for compilation result"""
    start_time = time.time()
    last_status = None
    
    while time.time() - start_time < TIMEOUT:
        try:
            response = requests.get(
                f"{SERVER_URL}/verse/status/{request_id}",
                timeout=5
            )
            
            if response.status_code == 200:
                data = response.json()
                status = data.get('status')
                
                if status != last_status:
                    elapsed = time.time() - start_time
                    print(f"⏳ Status: {status} (elapsed: {elapsed:.1f}s)")
                    last_status = status
                
                if status == 'completed':
                    result = data.get('result', {})
                    print("\n✅ Compilation completed!")
                    print(f"   Errors: {result.get('error_count', 0)}")
                    print(f"   Warnings: {result.get('warning_count', 0)}")
                    print(f"   Duration: {result.get('duration', 'N/A')}")
                    
                    if result.get('errors'):
                        print("\n   Errors:")
                        for error in result['errors'][:5]:  # Show first 5
                            print(f"     - {error}")
                    
                    return result.get('error_count', 0) == 0
                
                elif status == 'failed':
                    print("\n❌ Compilation failed!")
                    if data.get('errors'):
                        for error in data['errors'][:5]:
                            print(f"   - {error}")
                    return False
            
        except Exception as e:
            print(f"⚠️  Error checking status: {e}")
        
        time.sleep(5)
    
    print(f"\n❌ Timeout after {TIMEOUT}s")
    return False

def main():
    branch = sys.argv[1] if len(sys.argv) > 1 else "copilot/research-verse-lsp-error-detection"
    
    print("=" * 70)
    print("Simple Cloud Compilation Test")
    print("=" * 70)
    print(f"Server: {SERVER_URL}")
    print(f"Branch: {branch}")
    print("=" * 70)
    print()
    
    # Test connection
    print("Step 1: Testing connection...")
    if not test_connection():
        return 1
    print()
    
    # Trigger compilation
    print("Step 2: Triggering compilation...")
    request_id = trigger_compile(branch)
    if not request_id:
        return 1
    print()
    
    # Wait for result
    print("Step 3: Waiting for result...")
    success = wait_for_result(request_id)
    print()
    
    if success:
        print("✅ Test passed!")
        return 0
    else:
        print("❌ Test failed!")
        return 1

if __name__ == '__main__':
    sys.exit(main())
