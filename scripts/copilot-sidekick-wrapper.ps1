<#
.SYNOPSIS
    Launch Copilot Agent Task: Wrap Sidekick API.

.DESCRIPTION
    1. Create task via gh agent-task create
    2. Copilot creates PR -> GitHub Actions (copilot-build.yml) auto:
       - Compile on self-hosted runner
       - Success: @Maybank01 review
       - Fail: @copilot fix
    
    This script only launches the task. Actions handles the rest.

.EXAMPLE
    .\scripts\copilot-sidekick-wrapper.ps1
#>

$ErrorActionPreference = "Stop"

$TaskPrompt = @"
## Task: Wrap Sidekick API as Wrapper

Read the following Skill docs and create SidekickWrapper:

1. Read Skill definition: i18n/zh/skills/verseDev/verse-wrappers/SKILL.md
2. Reference API docs: i18n/zh/skills/verseDev/api-digests/README.md (Sidekick APIs)
3. Check existing Wrapper examples: i18n/zh/skills/verseDev/verse-wrappers/references/

### Requirements:
- Create SidekickWrapper.verse file
- Wrap equipped_sidekick_component core functions:
  - GetMood / SetMood (MoodOverride)
  - PlayReaction
  - ChangeMoodEvent / StartPlayReactionEvent / StopPlayReactionEvent
  - EnableAutomaticReactions / EnablePlayerInteraction
- Provide simplified API interface, hide complex component access logic
- Add error handling and logging
- Follow project Verse coding standards

### Output location:
Place in appropriate Verse code directory based on project structure.
"@

Write-Host ""
Write-Host "============================================================" -ForegroundColor Cyan
Write-Host "  Copilot Agent Task: Sidekick Wrapper" -ForegroundColor Cyan
Write-Host "============================================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "Flow:" -ForegroundColor Yellow
Write-Host "  1. Launch Copilot Agent task"
Write-Host "  2. Copilot creates PR -> Actions auto compile"
Write-Host "  3. Success -> @Maybank01 review"
Write-Host "  4. Fail -> @copilot fix -> loop"
Write-Host ""
Write-Host "Task:" -ForegroundColor Yellow
Write-Host $TaskPrompt -ForegroundColor Gray
Write-Host ""

Write-Host "Launching Copilot Agent task..." -ForegroundColor Yellow
gh agent-task create $TaskPrompt

Write-Host ""
Write-Host "Done! GitHub Actions will handle the rest:" -ForegroundColor Green
Write-Host "  - Task status: gh agent-task list"
Write-Host "  - PR list: gh pr list --author copilot-swe-agent[bot]"
Write-Host "  - Actions: gh run list --workflow copilot-build.yml"
Write-Host ""
