---
# Trigger - when should this workflow run?
on:
  pull_request_target:
    types: [opened, synchronize]
    paths:
      - '**.verse'
      - '**/verse/**'
  workflow_dispatch:
    inputs:
      pr_number:
        description: "PR number to build"
        required: false

# Use self-hosted runner for Verse compilation
runs-on: [self-hosted, windows, verse-builder]

# Permissions
permissions:
  contents: read
  pull-requests: read

# Outputs
safe-outputs:
  add-comment:
    max: 2

---

# PR Builder - Verse Compilation Workflow

Build and validate Verse code from Copilot-created Pull Requests on self-hosted runner.

## Instructions

1. Checkout the PR branch code using git clone with the PR head ref
2. Run the Verse build script at `i18n\zh\skills\verseDev\verse-cli\verse-build.ps1`
3. If build succeeds, comment on PR with success message mentioning @Maybank01
4. If build fails, comment on PR with error details and mention @copilot to fix

## Environment

- UEFN_REPO_PATH: E:\Game\FishTycoon\Content\AgentWorkSpace\VibeCodingCN
- Build script location: i18n\zh\skills\verseDev\verse-cli\verse-build.ps1

## Success Comment Template

```
## ✅ 编译成功

本地编译验证通过！
<details><summary>编译输出</summary>
{build_output}
</details>

@Maybank01 请审阅此 PR。
```

## Failure Comment Template

```
## ❌ 编译失败

@copilot 编译未通过，请根据以下错误信息修复代码：
{build_output}

请分析错误原因并推送修复后的代码。
```
