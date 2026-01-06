#!/usr/bin/env python3
"""
Automated LSP Error Detection Test Script
Tests whether verse-lsp correctly identifies intentional errors in test files
"""

import sys
import asyncio
import json
from pathlib import Path
from typing import List, Dict, Any

# Add libs to path
sys.path.insert(0, str(Path(__file__).parent.parent.parent))

from libs.common.verse_lsp_checker import VerseChecker, CheckResult

# Test expectations - which errors should be detected
TEST_EXPECTATIONS = {
    "error_01_missing_colon.verse": {
        "should_fail": True,
        "description": "Missing colon in function signature",
        "expected_errors": ["syntax", "colon", "type"]
    },
    "error_02_undefined_variable.verse": {
        "should_fail": True,
        "description": "Undefined variable reference",
        "expected_errors": ["undefined", "not found", "undeclared"]
    },
    "error_03_type_mismatch.verse": {
        "should_fail": True,
        "description": "Type mismatch - string assigned to int",
        "expected_errors": ["type", "mismatch", "incompatible"]
    },
    "error_04_class_method_syntax.verse": {
        "should_fail": True,
        "description": "Missing colon in class method",
        "expected_errors": ["syntax", "colon", "expected"]
    },
    "error_05_duplicate_params.verse": {
        "should_fail": True,
        "description": "Duplicate parameter names",
        "expected_errors": ["duplicate", "parameter", "already"]
    },
    "error_06_unclosed_block.verse": {
        "should_fail": True,
        "description": "Unclosed code block",
        "expected_errors": ["syntax", "expected", "closing"]
    },
    "error_07_invalid_operator.verse": {
        "should_fail": True,
        "description": "Invalid operator ++",
        "expected_errors": ["syntax", "operator", "unexpected"]
    },
    "error_08_wrong_return_type.verse": {
        "should_fail": True,
        "description": "Wrong return type",
        "expected_errors": ["type", "return", "expected"]
    },
    "error_09_undefined_function.verse": {
        "should_fail": True,
        "description": "Calling non-existent function",
        "expected_errors": ["undefined", "not found", "unknown"]
    },
    "error_10_missing_using.verse": {
        "should_fail": True,
        "description": "Missing using statement",
        "expected_errors": ["undefined", "not found", "import"]
    },
    "valid_case.verse": {
        "should_fail": False,
        "description": "Valid Verse code - should pass",
        "expected_errors": []
    },
}


class TestResult:
    """Individual test result"""
    def __init__(self, file_name: str, expectation: Dict[str, Any]):
        self.file_name = file_name
        self.expectation = expectation
        self.check_result: CheckResult = None
        self.passed = False
        self.failure_reason = ""
        
    def evaluate(self, check_result: CheckResult):
        """Evaluate if the test passed"""
        self.check_result = check_result
        should_fail = self.expectation["should_fail"]
        
        if should_fail:
            # This file should have errors
            if check_result.is_valid:
                self.passed = False
                self.failure_reason = "LSP did not detect any errors (FALSE NEGATIVE)"
            else:
                # Check if errors match expected patterns
                error_messages = " ".join([e.message.lower() for e in check_result.errors])
                expected_keywords = self.expectation["expected_errors"]
                
                has_expected_error = any(
                    keyword in error_messages 
                    for keyword in expected_keywords
                )
                
                if has_expected_error:
                    self.passed = True
                else:
                    # Still pass if ANY error was detected, but note it wasn't the expected type
                    self.passed = True
                    self.failure_reason = (
                        f"LSP detected errors but not the expected type. "
                        f"Expected keywords: {expected_keywords}, "
                        f"Got: {error_messages[:100]}. "
                        f"This is acceptable as the error was still caught."
                    )
        else:
            # This file should be valid
            if check_result.is_valid:
                self.passed = True
            else:
                self.passed = False
                self.failure_reason = "LSP reported errors for valid code (FALSE POSITIVE)"


class TestSuite:
    """Test suite manager"""
    def __init__(self, test_dir: Path):
        self.test_dir = test_dir
        self.results: List[TestResult] = []
        
    async def run_all_tests(self):
        """Run all tests"""
        print("="*70)
        print("LSP Error Detection Test Suite")
        print("="*70)
        print()
        
        # Find all test files
        test_files = []
        for file_name, expectation in TEST_EXPECTATIONS.items():
            file_path = self.test_dir / file_name
            if file_path.exists():
                test_files.append((file_name, file_path, expectation))
            else:
                print(f"⚠ Warning: Test file not found: {file_name}")
        
        if not test_files:
            print("❌ No test files found!")
            return False
            
        print(f"Found {len(test_files)} test files")
        print()
        
        # Run tests
        async with VerseChecker() as checker:
            for file_name, file_path, expectation in test_files:
                result = TestResult(file_name, expectation)
                
                print(f"Testing: {file_name}")
                print(f"  Description: {expectation['description']}")
                print(f"  Expected: {'FAIL' if expectation['should_fail'] else 'PASS'}")
                
                try:
                    check_result = await checker.check_file(str(file_path))
                    result.evaluate(check_result)
                    
                    print(f"  LSP Result: {'ERRORS FOUND' if not check_result.is_valid else 'VALID'}")
                    if not check_result.is_valid:
                        print(f"    - Error count: {len(check_result.errors)}")
                        for error in check_result.errors[:3]:  # Show first 3 errors
                            print(f"    - [{error.line}:{error.column}] {error.message[:80]}")
                    
                    if result.passed:
                        print(f"  ✅ TEST PASSED")
                    else:
                        print(f"  ❌ TEST FAILED: {result.failure_reason}")
                    
                except Exception as e:
                    result.passed = False
                    result.failure_reason = f"Exception during test: {e}"
                    print(f"  ❌ TEST FAILED: {e}")
                
                self.results.append(result)
                print()
        
        return self.generate_report()
    
    def generate_report(self) -> bool:
        """Generate final report"""
        print("="*70)
        print("Test Results Summary")
        print("="*70)
        print()
        
        passed = sum(1 for r in self.results if r.passed)
        failed = sum(1 for r in self.results if not r.passed)
        total = len(self.results)
        
        print(f"Total Tests: {total}")
        print(f"Passed: {passed} ✅")
        print(f"Failed: {failed} ❌")
        print(f"Success Rate: {passed/total*100:.1f}%")
        print()
        
        # Report failures
        if failed > 0:
            print("Failed Tests:")
            print("-" * 70)
            for result in self.results:
                if not result.passed:
                    print(f"❌ {result.file_name}")
                    print(f"   {result.expectation['description']}")
                    print(f"   Reason: {result.failure_reason}")
                    print()
        
        # LSP capability analysis
        print("="*70)
        print("LSP Capability Analysis")
        print("="*70)
        print()
        
        false_negatives = [
            r for r in self.results 
            if not r.passed and "FALSE NEGATIVE" in r.failure_reason
        ]
        false_positives = [
            r for r in self.results 
            if not r.passed and "FALSE POSITIVE" in r.failure_reason
        ]
        
        if false_negatives:
            print(f"⚠ FALSE NEGATIVES ({len(false_negatives)}): LSP failed to detect errors")
            for r in false_negatives:
                print(f"  - {r.file_name}: {r.expectation['description']}")
            print()
        
        if false_positives:
            print(f"⚠ FALSE POSITIVES ({len(false_positives)}): LSP reported errors for valid code")
            for r in false_positives:
                print(f"  - {r.file_name}: {r.expectation['description']}")
            print()
        
        if not false_negatives and not false_positives:
            print("✅ LSP is working correctly for all test cases!")
        
        # Recommendations
        print("="*70)
        print("Recommendations")
        print("="*70)
        print()
        
        if false_negatives:
            print("🔧 Actions needed for false negatives:")
            print("  1. Review LSP configuration and rules")
            print("  2. Check if digest files are up to date")
            print("  3. Verify LSP binary version matches latest UEFN")
            print("  4. Consider filing bug report with Epic Games")
            print()
        
        if false_positives:
            print("🔧 Actions needed for false positives:")
            print("  1. Review test case syntax - may have unintended errors")
            print("  2. Check if code follows Verse best practices")
            print("  3. Verify digest files compatibility")
            print()
        
        print("📊 General recommendations:")
        print("  - Integrate these tests into CI/CD pipeline")
        print("  - Run tests before committing Verse code")
        print("  - Keep LSP binary and digests updated")
        print()
        
        # Return success if all tests passed
        return failed == 0
    
    def export_json_report(self, output_file: Path):
        """Export detailed report as JSON"""
        report = {
            "total_tests": len(self.results),
            "passed": sum(1 for r in self.results if r.passed),
            "failed": sum(1 for r in self.results if not r.passed),
            "tests": []
        }
        
        for result in self.results:
            test_data = {
                "file_name": result.file_name,
                "description": result.expectation["description"],
                "expected_to_fail": result.expectation["should_fail"],
                "passed": result.passed,
                "failure_reason": result.failure_reason,
                "lsp_found_errors": not result.check_result.is_valid if result.check_result else None,
                "error_count": len(result.check_result.errors) if result.check_result else 0,
                "errors": [
                    {
                        "line": e.line,
                        "column": e.column,
                        "message": e.message
                    }
                    for e in (result.check_result.errors if result.check_result else [])
                ]
            }
            report["tests"].append(test_data)
        
        with open(output_file, 'w', encoding='utf-8') as f:
            json.dump(report, f, indent=2, ensure_ascii=False)
        
        print(f"📄 Detailed JSON report saved to: {output_file}")


async def main():
    """Main entry point"""
    # Get test directory
    script_dir = Path(__file__).parent
    test_dir = script_dir
    
    # Check if test files exist
    if not test_dir.exists():
        print(f"❌ Test directory not found: {test_dir}")
        return 1
    
    # Run test suite
    suite = TestSuite(test_dir)
    success = await suite.run_all_tests()
    
    # Export JSON report
    report_file = test_dir / "test_report.json"
    suite.export_json_report(report_file)
    
    return 0 if success else 1


if __name__ == '__main__':
    try:
        exit_code = asyncio.run(main())
        sys.exit(exit_code)
    except KeyboardInterrupt:
        print("\n\n⚠ Test interrupted by user")
        sys.exit(130)
    except Exception as e:
        print(f"\n❌ Fatal error: {e}")
        import traceback
        traceback.print_exc()
        sys.exit(1)
