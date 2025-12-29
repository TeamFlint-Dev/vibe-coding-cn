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
$CurrentBranch = ""

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
    
    $args = @($WorkflowName, "-f", "requirement=$Requirement")
    if ($currentErrors) {
        Write-Host "Sending compile errors to Agent..." -ForegroundColor Red
        $args += "-f"
        $args += "compile_errors=$currentErrors"
    }
    
    if ($CurrentBranch) {
        Write-Host "Targeting branch: $CurrentBranch" -ForegroundColor Cyan
        $args += "--ref"
        $args += $CurrentBranch
    }

    gh aw run @args

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

    # 3. Pull Changes / Checkout PR
    Write-Host "Checking for new Pull Requests..." -ForegroundColor Yellow
    $latestPR = gh pr list --limit 1 --json number,headRefName,createdAt | ConvertFrom-Json
    
    if ($latestPR) {
        Write-Host "Found PR #$($latestPR.number) on branch $($latestPR.headRefName). Checking out..." -ForegroundColor Yellow
        gh pr checkout $latestPR.number
        $CurrentBranch = $latestPR.headRefName
    } else {
        Write-Host "No PR found. Pulling latest code..." -ForegroundColor Yellow
        git pull
        $CurrentBranch = "main"
    }

    # 4. Local Build
    $buildSuccess = $false
    while (-not $buildSuccess) {
        Write-Host "Running Local Build..." -ForegroundColor Yellow
        
        # Check if build script exists
        if (-not (Test-Path $BuildScript)) {
            Write-Error "Build script not found at $BuildScript. Please create it or configure the path."
            exit 1
        }

        # Capture output
        $buildOutput = & $BuildScript 2>&1 | Out-String
        $lastExitCode = $LASTEXITCODE

        if ($lastExitCode -eq 0) {
            $buildSuccess = $true
            break
        }
        
        if ($buildOutput -match "ECONNREFUSED" -or $buildOutput -match "Connection refused") {
             Write-Host "Error: Could not connect to UEFN. Please ensure UEFN is running and the project is loaded." -ForegroundColor Red
             Write-Host "Press any key to retry build (or Ctrl+C to exit)..."
             $null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
             continue
        } else {
             # Real build error
             break
        }
    }

    if ($buildSuccess) {
        Write-Host "Build Success!" -ForegroundColor Green
        
        # 5. Trigger Documentation Workflow (Optional)
        Write-Host "Triggering Documentation Agent..." -ForegroundColor Cyan
        gh aw run verse-docs-updater -f feature_name="$Requirement" --ref $CurrentBranch
        
        exit 0
    } else {
        Write-Host "Build Failed!" -ForegroundColor Red
        $currentErrors = $buildOutput
        
        # Truncate errors if too long to avoid CLI limits
        if ($currentErrors.Length -gt 5000) {
            $currentErrors = $currentErrors.Substring(0, 5000) + "...(truncated)"
        }
        
        Write-Host "Errors captured. Retrying on branch $CurrentBranch..."
        
        # Loop back
        # We recursively call the loop or just continue the while loop?
        # The script is a while loop.
        # We need to update the 'requirement' to include the errors?
        # Actually, the loop at the top uses $currentErrors.
        # So we just loop.
        
        # IMPORTANT: We must ensure the next run targets the SAME branch so we iterate on the PR.
        # But 'gh aw run' without --ref defaults to default branch.
        # We need to modify the 'gh aw run' command at the top of the loop to use $CurrentBranch.
    }
}
    }
}

Write-Error "Max retries reached. Please fix manually."
