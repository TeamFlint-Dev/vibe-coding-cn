# LSP Error Detection Test Suite

This test suite validates that the Verse LSP (Language Server Protocol) correctly identifies syntax and semantic errors in Verse code.

## Purpose

The LSP checker is critical for catching errors before code is deployed to UEFN. This test suite ensures:

1. **LSP detects intentional errors** (avoiding false negatives)
2. **LSP doesn't flag valid code as errors** (avoiding false positives)
3. **Error reporting is accurate** (correct line numbers, helpful messages)

## Test Cases

### Error Test Cases (Should Fail)

| File | Error Type | Description |
|------|------------|-------------|
| `error_01_missing_colon.verse` | Syntax | Missing colon in function signature |
| `error_02_undefined_variable.verse` | Semantic | Reference to undefined variable |
| `error_03_type_mismatch.verse` | Type | String assigned to int variable |
| `error_04_class_method_syntax.verse` | Syntax | Missing colon in class method |
| `error_05_duplicate_params.verse` | Semantic | Duplicate parameter names |
| `error_06_unclosed_block.verse` | Syntax | Unclosed code block |
| `error_07_invalid_operator.verse` | Syntax | Invalid operator `++` |
| `error_08_wrong_return_type.verse` | Type | Function returns wrong type |
| `error_09_undefined_function.verse` | Semantic | Call to non-existent function |
| `error_10_missing_using.verse` | Semantic | Missing required using statement |

### Valid Test Case (Should Pass)

| File | Description |
|------|-------------|
| `valid_case.verse` | Valid Verse code that should pass all checks |

## Running Tests

### Prerequisites

1. Set up the Verse LSP environment:

```bash
cd /home/runner/work/vibe-coding-cn/vibe-coding-cn
./scripts/verse-lsp/setup-verse-env.sh
```

2. Install Python dependencies:

```bash
pip install -r scripts/verse-lsp/requirements.txt
```

### Run Test Suite

```bash
# Run all tests
python3 tests/verse-lsp/test_lsp_error_detection.py

# Or use make command (if added to Makefile)
make test-lsp
```

## Test Output

The test script provides:

1. **Console Output**: Real-time test progress with colored output
2. **Summary Report**: Success rate and analysis
3. **JSON Report**: Detailed results in `test_report.json`

### Example Output

```
======================================================================
LSP Error Detection Test Suite
======================================================================

Found 11 test files

Testing: error_01_missing_colon.verse
  Description: Missing colon in function signature
  Expected: FAIL
  LSP Result: ERRORS FOUND
    - Error count: 1
    - [3:32] Expected ':'
  ✅ TEST PASSED

...

======================================================================
Test Results Summary
======================================================================

Total Tests: 11
Passed: 9 ✅
Failed: 2 ❌
Success Rate: 81.8%

Failed Tests:
----------------------------------------------------------------------
❌ error_02_undefined_variable.verse
   Undefined variable reference
   Reason: LSP did not detect any errors (FALSE NEGATIVE)

======================================================================
LSP Capability Analysis
======================================================================

⚠ FALSE NEGATIVES (2): LSP failed to detect errors
  - error_02_undefined_variable.verse: Undefined variable reference
  - error_10_missing_using.verse: Missing using statement

======================================================================
Recommendations
======================================================================

🔧 Actions needed for false negatives:
  1. Review LSP configuration and rules
  2. Check if digest files are up to date
  3. Verify LSP binary version matches latest UEFN
  4. Consider filing bug report with Epic Games
```

## Understanding Results

### False Negatives (Critical)

**Problem**: LSP fails to detect errors that exist in the code.

**Impact**: Buggy code may pass validation and cause runtime errors in UEFN.

**Actions**:
- Review LSP configuration
- Update digest files from latest UEFN
- Verify LSP binary version
- File bug report with Epic Games if persistent

### False Positives (Warning)

**Problem**: LSP reports errors for valid code.

**Impact**: Valid code may be rejected, slowing development.

**Actions**:
- Review test case syntax
- Check Verse best practices
- Verify digest compatibility

## Integration with CI/CD

Add to `.github/workflows/ci.yml`:

```yaml
- name: Run LSP Error Detection Tests
  run: |
    ./scripts/verse-lsp/setup-verse-env.sh
    python3 tests/verse-lsp/test_lsp_error_detection.py
```

## JSON Report Format

The `test_report.json` file contains:

```json
{
  "total_tests": 11,
  "passed": 9,
  "failed": 2,
  "tests": [
    {
      "file_name": "error_01_missing_colon.verse",
      "description": "Missing colon in function signature",
      "expected_to_fail": true,
      "passed": true,
      "failure_reason": "",
      "lsp_found_errors": true,
      "error_count": 1,
      "errors": [
        {
          "line": 3,
          "column": 32,
          "message": "Expected ':'"
        }
      ]
    }
  ]
}
```

## Maintenance

### Adding New Test Cases

1. Create a new `.verse` file with intentional error
2. Add entry to `TEST_EXPECTATIONS` in `test_lsp_error_detection.py`:

```python
"error_11_your_error.verse": {
    "should_fail": True,
    "description": "Description of the error",
    "expected_errors": ["keyword1", "keyword2"]
}
```

3. Run tests to verify

### Updating Expectations

If LSP behavior changes (e.g., after UEFN update):

1. Review test failures
2. Update `TEST_EXPECTATIONS` if errors are expected
3. Update test cases if Verse syntax changed

## Troubleshooting

### "LSP binary not found"

```bash
./scripts/verse-lsp/setup-verse-env.sh
```

### "No test files found"

Verify you're in the correct directory:

```bash
ls tests/verse-lsp/*.verse
```

### "LSP process failed to start"

Check LSP binary permissions:

```bash
chmod +x .verse-sdk/bin/*/verse-lsp*
```

## References

- [Verse LSP Checker Documentation](../../scripts/verse-lsp/README.md)
- [UEFN Verse Documentation](https://dev.epicgames.com/documentation/en-us/uefn/verse-language-reference)
- [Language Server Protocol](https://microsoft.github.io/language-server-protocol/)
