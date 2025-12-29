<#
.SYNOPSIS
    Runs the Verse Development Loop: Cloud Agent -> Local Build -> Cloud Agent Fix.

.DESCRIPTION
    This script orchestrates a feedback loop between the GitHub Agentic Workflow and the local Verse compiler.
    1. Triggers the 'verse-dev-loop' workflow on GitHub.
    2. Waits for completion.
    3. Pulls the latest changes (assuming Agent pushed to the current branch or a known branch).
    4. Runs local compilation using 'verse-build.ps1'.
    5. If compilation fails, triggers the workflow again with error logs.

.PARAMETER Requirement
    The initial requirement for the Verse code.

.PARAMETER MaxRetries
    Maximum number of fix attempts. Default is 3.

.EXAMPLE
    .\scripts\verse-loop.ps1 -Requirement "Create a PhysicsWrapper"
#>

param(
    [Parameter(Mandatory=$true)]
    [string]$Requirement,

    [int]$MaxRetries = 3
)

$ErrorActionPreference = "Stop"
$WorkflowName = "verse-dev-loop"
$BuildScript = "i18n\zh\skills\verseDev\verse-cli\verse-build.ps1"

# Helper function to get the latest run ID
function Get-LatestRunId {
    $run = gh run list --workflow $WorkflowName --limit 1 --json databaseId | ConvertFrom-Json
    return $run.databaseId
}

# Main Loop
$currentAttempt = 0
$currentErrors = ""

while ($currentAttempt -le $MaxRetries) {
    $currentAttempt++
    Write-Host "`n=== Attempt $currentAttempt / $($MaxRetries + 1) ===" -ForegroundColor Cyan

    # 1. Trigger Cloud Agent
    Write-Host "Triggering Cloud Agent..." -ForegroundColor Yellow
    if ($currentErrors) {
        Write-Host "Sending compile errors to Agent..." -ForegroundColor Red
        gh aw run $WorkflowName -f requirement="$Requirement" -f compile_errors="$currentErrors"
    } else {
        gh aw run $WorkflowName -f requirement="$Requirement"
    }

    # 2. Wait for Agent
    Write-Host "Waiting for Agent to finish..." -ForegroundColor Yellow
    Start-Sleep -Seconds 5 # Give it a moment to start
    $runId = Get-LatestRunId
    gh run watch $runId
    
    # Check if the workflow itself failed
    $runStatus = gh run view $runId --json conclusion | ConvertFrom-Json
    if ($runStatus.conclusion -ne "success") {
        Write-Error "Cloud Agent workflow failed! Check GitHub Actions logs."
    }

    # 3. Pull Changes
    # Note: This assumes the Agent pushed to the current branch or we need to switch.
    # For simplicity, we assume the user is on the correct branch or the Agent updates it.
    # In a real PR scenario, we might need to checkout the PR branch.
    Write-Host "Pulling latest code..." -ForegroundColor Yellow
    git pull

    # 4. Local Build
    Write-Host "Running Local Build..." -ForegroundColor Yellow
    
    # Capture output
    $buildOutput = & $BuildScript 2>&1 | Out-String
    $lastExitCode = $LASTEXITCODE

    if ($lastExitCode -eq 0) {
        Write-Host "Build Success!" -ForegroundColor Green
        
        # 5. Trigger Documentation Workflow (Optional)
        Write-Host "Triggering Documentation Agent..." -ForegroundColor Cyan
        gh aw run verse-docs-updater -f feature_name="$Requirement"
        
        exit 0
    } else {
        Write-Host "Build Failed!" -ForegroundColor Red
        $currentErrors = $buildOutput
        
        # Truncate errors if too long to avoid CLI limits
        if ($currentErrors.Length -gt 5000) {
            $currentErrors = $currentErrors.Substring(0, 5000) + "...(truncated)"
        }
        
        Write-Host "Errors captured. Retrying..."
    }
}

Write-Error "Max retries reached. Please fix manually."
