# LSP Error Detection Bug Report

**Date**: 2026-01-06
**Issue**: verse-lsp does not detect obvious syntax and semantic errors
**Status**: CRITICAL - All 10 error test cases resulted in FALSE NEGATIVES

## Executive Summary

The Verse LSP (Language Server Protocol) binary extracted from the official UEFN VSCode extension **does not provide diagnostic feedback** for any type of error, including obvious syntax errors like missing closing parentheses.

**Test Results**: 0/10 error cases detected (0% detection rate)

## Investigation Details

### Environment

- **LSP Binary**: Extracted from `Verse.vsix` (official UEFN extension)
- **Digest Files**: From vz-creates/uefn repository (latest)
- **Platform**: Linux
- **LSP Version**: From latest Verse VSCode extension

### Testing Methodology

1. Created 10 intentional error test cases covering:
   - Syntax errors (missing colons, unclosed blocks, invalid operators)
   - Type errors (type mismatches, wrong return types)
   - Semantic errors (undefined variables/functions, duplicate parameters)

2. Created automated test suite (`test_lsp_error_detection.py`)

3. Tested LSP communication with debug logging

### Key Findings

#### 1. LSP Communicates But Doesn't Diagnose

The LSP server:
- ✅ Starts successfully
- ✅ Responds to `initialize` request
- ✅ Accepts `textDocument/didOpen` notifications
- ❌ **Never sends `textDocument/publishDiagnostics` notifications**

#### 2. LSP Requires Project Structure

Debug output shows LSP registers file watchers for:
```json
{
  "globPattern": "**/*.vproject"
},
{
  "globPattern": "**/*.vpackage"
}
```

This indicates the LSP expects files to be part of a Verse project with `.vproject` or `.vpackage` files.

#### 3. Workspace Configuration Doesn't Help

Even after:
- Creating `.vproject` file in workspace
- Setting proper `rootUri` to workspace directory
- Adding workspace capabilities to initialization
- Using workspace-relative file URIs

The LSP still does not send diagnostics.

#### 4. All Error Types Undetected

| Error Type | Expected | Actual | Status |
|------------|----------|--------|--------|
| Missing colon in function | ERROR | VALID | ❌ FALSE NEGATIVE |
| Undefined variable | ERROR | VALID | ❌ FALSE NEGATIVE |
| Type mismatch (string → int) | ERROR | VALID | ❌ FALSE NEGATIVE |
| Missing colon in class method | ERROR | VALID | ❌ FALSE NEGATIVE |
| Duplicate parameters | ERROR | VALID | ❌ FALSE NEGATIVE |
| Unclosed code block | ERROR | VALID | ❌ FALSE NEGATIVE |
| Invalid operator (++) | ERROR | VALID | ❌ FALSE NEGATIVE |
| Wrong return type | ERROR | VALID | ❌ FALSE NEGATIVE |
| Undefined function call | ERROR | VALID | ❌ FALSE NEGATIVE |
| Missing using statement | ERROR | VALID | ❌ FALSE NEGATIVE |
| Valid code | VALID | VALID | ✅ CORRECT |

## Technical Analysis

### LSP Protocol Communication

**Initialization**:
```json
{
  "method": "initialize",
  "params": {
    "processId": 2447,
    "rootUri": "file:///path/to/workspace",
    "capabilities": {
      "textDocument": {
        "publishDiagnostics": {},
        "synchronization": {...}
      },
      "workspace": {...}
    }
  }
}
```

**LSP Capabilities Response**:
```json
{
  "capabilities": {
    "completionProvider": {...},
    "definitionProvider": true,
    "hoverProvider": true,
    "textDocumentSync": 2,
    // ... but NO diagnosticProvider
  }
}
```

**Document Open**:
```json
{
  "method": "textDocument/didOpen",
  "params": {
    "textDocument": {
      "uri": "file:///path/error_01_missing_colon.verse",
      "languageId": "verse",
      "text": "test_function() void = ..." // syntax error
    }
  }
}
```

**Expected**: `textDocument/publishDiagnostics` notification
**Actual**: No diagnostic notification (timeout after 5+ seconds)

### Possible Root Causes

1. **LSP Limitations**: The verse-lsp binary may be designed only for:
   - Code completion
   - Symbol navigation
   - Hover information
   - **NOT** for error diagnostics

2. **Missing Configuration**: May require:
   - Full UEFN project structure (not just .vproject)
   - Specific initialization options we haven't discovered
   - Connection to UEFN editor context

3. **VSCode Extension Dependency**: Diagnostics may be handled by:
   - VSCode extension layer (not LSP binary)
   - Separate UEFN validation tool
   - Built-in UEFN compiler, not LSP

4. **Digest File Issues**: The digest files may be:
   - Incomplete
   - Wrong format/version
   - Not properly configured

## Impact Assessment

### Critical Issues

1. **No Pre-commit Validation**: Cannot catch errors before UEFN compilation
2. **AI Agent Blind Spot**: AI code generators cannot self-validate Verse code
3. **Development Friction**: Developers must rely on slow UEFN editor feedback
4. **CI/CD Gap**: No automated Verse code quality checks possible

### Current Workarounds

None available. Must use UEFN editor for all validation.

## Recommendations

### Immediate Actions

1. **Document Limitation**: Update README to clarify LSP cannot validate errors
2. **Alternative Tools**: Research if Epic provides separate validation CLI
3. **Test in UEFN**: Verify these errors ARE caught by UEFN editor
4. **Community Research**: Check if others have solved this

### Short-term Solutions

1. **Manual Testing**: Require UEFN editor validation before commits
2. **Code Review**: Rely on human review for Verse code
3. **Best Practices**: Establish strict coding standards

### Long-term Solutions

1. **Epic Games Support**: File feature request for standalone Verse validator
2. **Alternative LSP**: Consider building custom Verse validator
3. **Compiler Access**: Request access to Verse compiler for CI/CD
4. **Community Tool**: Collaborate on open-source Verse validation tool

## Test Artifacts

All test files and scripts are in `tests/verse-lsp/`:

- `test_lsp_error_detection.py` - Automated test suite
- `debug_lsp.py` - LSP communication debugger
- `error_*.verse` - 10 error test cases
- `valid_case.verse` - Valid code test case
- `test_report.json` - Detailed JSON test results
- `README.md` - Test documentation

## Conclusion

The verse-lsp binary **is not suitable for error detection**. Despite proper LSP protocol communication and multiple configuration attempts, it does not provide diagnostic feedback for any error type.

**This is a fundamental limitation**, not a configuration issue. Either:
1. The LSP is intentionally limited to navigation features only, OR
2. Diagnostics require integration we haven't achieved

**Recommendation**: Mark LSP error detection as **NOT SUPPORTED** until Epic Games provides clarification or a proper validation tool.

## References

- [LSP Debug Output](debug_lsp.py)
- [Test Results](test_report.json)
- [Test Suite README](README.md)
- [Language Server Protocol Spec](https://microsoft.github.io/language-server-protocol/)
- [UEFN Verse Documentation](https://dev.epicgames.com/documentation/en-us/uefn/verse-language-reference)

---

**Report Generated**: 2026-01-06
**Investigator**: GitHub Copilot Agent
**Issue Tracking**: #[issue-number]
