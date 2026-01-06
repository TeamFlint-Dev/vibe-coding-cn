#!/usr/bin/env python3
"""
Cloud Compilation Test Suite for Verse Code
Tests the cloud-based UEFN compilation system
"""

import os
import sys
import json
import time
import argparse
import requests
from pathlib import Path
from typing import Dict, List, Any, Optional
from datetime import datetime

# Configuration
DEFAULT_SERVER_URL = os.getenv("COMPILE_SERVER_URL", "http://localhost:19527")
DEFAULT_API_KEY = os.getenv("COMPILE_API_KEY", "")
DEFAULT_TIMEOUT = 300  # 5 minutes


class CloudCompileClient:
    """Client for interacting with the cloud compilation service"""
    
    def __init__(self, server_url: str, api_key: str = ""):
        self.server_url = server_url.rstrip('/')
        self.api_key = api_key
        self.session = requests.Session()
        if api_key:
            self.session.headers['Authorization'] = f'Bearer {api_key}'
    
    def health_check(self) -> bool:
        """Check if the server is online"""
        try:
            response = self.session.get(f"{self.server_url}/health", timeout=5)
            return response.status_code == 200
        except Exception as e:
            print(f"❌ Health check failed: {e}")
            return False
    
    def compile(self, branch: str = "main") -> Optional[str]:
        """
        Trigger a compilation request
        Returns: request_id if successful, None otherwise
        """
        try:
            response = self.session.post(
                f"{self.server_url}/verse/compile",
                json={"branch": branch},
                timeout=10
            )
            
            if response.status_code == 200:
                data = response.json()
                return data.get('request_id')
            else:
                print(f"❌ Compile request failed: {response.status_code}")
                print(response.text)
                return None
        except Exception as e:
            print(f"❌ Compile request error: {e}")
            return None
    
    def get_status(self, request_id: str) -> Optional[Dict[str, Any]]:
        """Get the status of a compilation request"""
        try:
            response = self.session.get(
                f"{self.server_url}/verse/status/{request_id}",
                timeout=5
            )
            
            if response.status_code == 200:
                return response.json()
            else:
                return None
        except Exception as e:
            print(f"❌ Status check error: {e}")
            return None
    
    def wait_for_result(self, request_id: str, timeout: int = DEFAULT_TIMEOUT, 
                       poll_interval: int = 5) -> Optional[Dict[str, Any]]:
        """
        Wait for compilation to complete
        Returns: result dict if successful, None if timeout
        """
        start_time = time.time()
        
        while time.time() - start_time < timeout:
            status = self.get_status(request_id)
            
            if status is None:
                print(f"⚠️  Could not get status for {request_id}")
                time.sleep(poll_interval)
                continue
            
            state = status.get('status', 'unknown')
            
            if state == 'completed':
                return status.get('result')
            elif state == 'failed':
                print(f"❌ Compilation failed: {status.get('message')}")
                return status.get('result')
            elif state in ['queued', 'running']:
                elapsed = time.time() - start_time
                print(f"⏳ Status: {state} (elapsed: {elapsed:.1f}s)")
                time.sleep(poll_interval)
            else:
                print(f"⚠️  Unknown status: {state}")
                time.sleep(poll_interval)
        
        print(f"❌ Timeout after {timeout}s")
        return None


class TestCase:
    """Represents a single test case"""
    
    def __init__(self, name: str, file_path: Path, expected_success: bool, 
                 description: str = ""):
        self.name = name
        self.file_path = file_path
        self.expected_success = expected_success
        self.description = description
        self.result = None
        self.passed = None
        self.duration = None
        self.errors = []
        self.warnings = []


def load_test_cases(test_dir: Path) -> List[TestCase]:
    """Load all test cases from the test_cases directory"""
    cases = []
    
    # Valid test cases
    valid_files = list(test_dir.glob("valid_*.verse"))
    for file_path in valid_files:
        name = file_path.stem
        cases.append(TestCase(
            name=name,
            file_path=file_path,
            expected_success=True,
            description=f"Valid Verse code: {name}"
        ))
    
    # Error test cases
    error_files = list(test_dir.glob("error_*.verse"))
    for file_path in error_files:
        name = file_path.stem
        cases.append(TestCase(
            name=name,
            file_path=file_path,
            expected_success=False,
            description=f"Invalid Verse code: {name}"
        ))
    
    return cases


def run_test(client: CloudCompileClient, test_case: TestCase, 
             branch: str, verbose: bool = False) -> bool:
    """
    Run a single test case
    Returns: True if test passed, False otherwise
    """
    print(f"\n{'='*70}")
    print(f"Test: {test_case.name}")
    print(f"Description: {test_case.description}")
    print(f"Expected: {'SUCCESS' if test_case.expected_success else 'FAIL'}")
    print(f"{'='*70}")
    
    start_time = time.time()
    
    # Trigger compilation
    print("📤 Triggering compilation...")
    request_id = client.compile(branch=branch)
    
    if not request_id:
        print("❌ Failed to trigger compilation")
        test_case.passed = False
        return False
    
    print(f"✅ Request ID: {request_id}")
    
    # Wait for result
    print("⏳ Waiting for compilation result...")
    result = client.wait_for_result(request_id, timeout=DEFAULT_TIMEOUT)
    
    test_case.duration = time.time() - start_time
    
    if result is None:
        print("❌ No result received")
        test_case.passed = False
        return False
    
    # Parse result
    test_case.result = result
    actual_success = result.get('success', False)
    test_case.errors = result.get('errors', [])
    test_case.warnings = result.get('warnings', [])
    
    # Check if test passed
    test_case.passed = (actual_success == test_case.expected_success)
    
    # Print result
    print(f"\nActual Result: {'SUCCESS' if actual_success else 'FAIL'}")
    print(f"Duration: {test_case.duration:.1f}s")
    
    if test_case.errors:
        print(f"\n📋 Errors ({len(test_case.errors)}):")
        for error in test_case.errors:
            print(f"  - {error}")
    
    if test_case.warnings:
        print(f"\n⚠️  Warnings ({len(test_case.warnings)}):")
        for warning in test_case.warnings:
            print(f"  - {warning}")
    
    if verbose and result.get('raw_output'):
        print(f"\n📄 Raw Output:")
        print(result['raw_output'])
    
    # Test verdict
    if test_case.passed:
        print(f"\n✅ TEST PASSED")
    else:
        print(f"\n❌ TEST FAILED")
        if test_case.expected_success and not actual_success:
            print("   Expected success but got failure")
        elif not test_case.expected_success and actual_success:
            print("   Expected failure but got success")
    
    return test_case.passed


def run_test_suite(server_url: str, api_key: str, branch: str, 
                   verbose: bool = False) -> Dict[str, Any]:
    """Run the complete test suite"""
    
    client = CloudCompileClient(server_url, api_key)
    
    # Health check
    print("🏥 Checking server health...")
    if not client.health_check():
        print("❌ Server is not healthy!")
        return {
            'success': False,
            'error': 'Server health check failed'
        }
    print("✅ Server is healthy\n")
    
    # Load test cases
    test_dir = Path(__file__).parent / "test_cases"
    if not test_dir.exists():
        print(f"⚠️  Test cases directory not found: {test_dir}")
        print("   Creating directory with placeholder...")
        test_dir.mkdir(parents=True, exist_ok=True)
        
        # Create a placeholder test case
        placeholder = test_dir / "valid_hello_world.verse"
        placeholder.write_text("""using { /Fortnite.com/Devices }

hello_device := class(creative_device):
    OnBegin<override>()<suspends>: void =
        Print("Hello World")
""")
        print(f"✅ Created placeholder: {placeholder}")
    
    test_cases = load_test_cases(test_dir)
    
    if not test_cases:
        print("⚠️  No test cases found!")
        return {
            'success': False,
            'error': 'No test cases found'
        }
    
    print(f"📦 Loaded {len(test_cases)} test cases\n")
    
    # Run tests
    results = []
    passed = 0
    failed = 0
    
    for test_case in test_cases:
        if run_test(client, test_case, branch, verbose):
            passed += 1
        else:
            failed += 1
        
        results.append({
            'name': test_case.name,
            'description': test_case.description,
            'expected': 'success' if test_case.expected_success else 'fail',
            'actual': 'success' if test_case.result and test_case.result.get('success') else 'fail',
            'passed': test_case.passed,
            'duration': test_case.duration,
            'errors': test_case.errors,
            'warnings': test_case.warnings
        })
    
    # Summary
    print(f"\n{'='*70}")
    print("TEST SUMMARY")
    print(f"{'='*70}")
    print(f"Total Tests: {len(test_cases)}")
    print(f"Passed: {passed} ✅")
    print(f"Failed: {failed} ❌")
    print(f"Success Rate: {passed/len(test_cases)*100:.1f}%")
    
    return {
        'success': failed == 0,
        'timestamp': datetime.now().isoformat(),
        'total_tests': len(test_cases),
        'passed': passed,
        'failed': failed,
        'tests': results
    }


def main():
    parser = argparse.ArgumentParser(description='Verse Cloud Compilation Test Suite')
    parser.add_argument('--server', default=DEFAULT_SERVER_URL,
                       help='Cloud compilation server URL')
    parser.add_argument('--api-key', default=DEFAULT_API_KEY,
                       help='API key for authentication')
    parser.add_argument('--branch', default='main',
                       help='Git branch to test')
    parser.add_argument('--test-connection', action='store_true',
                       help='Only test server connection')
    parser.add_argument('--verbose', '-v', action='store_true',
                       help='Show verbose output')
    parser.add_argument('--output', '-o', type=str,
                       help='Save results to JSON file')
    
    args = parser.parse_args()
    
    print(f"""
{'='*70}
Verse Cloud Compilation Test Suite
{'='*70}
Server: {args.server}
Branch: {args.branch}
{'='*70}
""")
    
    # Connection test only
    if args.test_connection:
        client = CloudCompileClient(args.server, args.api_key)
        if client.health_check():
            print("✅ Connection successful!")
            return 0
        else:
            print("❌ Connection failed!")
            return 1
    
    # Run full test suite
    try:
        results = run_test_suite(args.server, args.api_key, args.branch, args.verbose)
        
        # Save results if requested
        if args.output:
            output_path = Path(args.output)
            output_path.write_text(json.dumps(results, indent=2))
            print(f"\n💾 Results saved to: {output_path}")
        
        # Exit code
        return 0 if results.get('success') else 1
        
    except KeyboardInterrupt:
        print("\n\n⚠️  Test interrupted by user")
        return 130
    except Exception as e:
        print(f"\n\n❌ Unexpected error: {e}")
        import traceback
        traceback.print_exc()
        return 1


if __name__ == '__main__':
    sys.exit(main())
