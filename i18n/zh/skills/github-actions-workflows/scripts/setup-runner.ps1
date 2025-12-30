# ============================================================
# Self-Hosted Runner Setup Script
# ============================================================
# Configures a Windows Self-Hosted Runner for GitHub Actions
#
# Usage:
#   .\setup-runner.ps1 -RepoUrl "https://github.com/owner/repo" -Token "XXXXX"
#
# Prerequisites:
# - Windows 10/11 or Windows Server 2019+
# - PowerShell 5.1+
# - Administrator privileges (for service installation)
# ============================================================

param(
    [Parameter(Mandatory=$true)]
    [string]$RepoUrl,
    
    [Parameter(Mandatory=$true)]
    [string]$Token,
    
    [Parameter(Mandatory=$false)]
    [string]$RunnerPath = "E:\github-actions-runner",
    
    [Parameter(Mandatory=$false)]
    [string]$Labels = "self-hosted,windows,verse-builder",
    
    [Parameter(Mandatory=$false)]
    [string]$RunnerName = $env:COMPUTERNAME,
    
    [Parameter(Mandatory=$false)]
    [switch]$InstallAsService,
    
    [Parameter(Mandatory=$false)]
    [switch]$Force
)

$ErrorActionPreference = "Stop"

# ============================================
# 1. Download Runner
# ============================================
function Download-Runner {
    param([string]$TargetPath)
    
    Write-Host "=== Downloading GitHub Actions Runner ===" -ForegroundColor Cyan
    
    # Get latest release
    $releases = Invoke-RestMethod -Uri "https://api.github.com/repos/actions/runner/releases/latest"
    $asset = $releases.assets | Where-Object { $_.name -like "*win-x64*" -and $_.name -like "*.zip" }
    
    if (-not $asset) {
        throw "Could not find Windows x64 runner release"
    }
    
    $downloadUrl = $asset.browser_download_url
    $zipPath = Join-Path $env:TEMP "actions-runner.zip"
    
    Write-Host "Downloading from: $downloadUrl"
    Invoke-WebRequest -Uri $downloadUrl -OutFile $zipPath
    
    # Create target directory
    if (Test-Path $TargetPath) {
        if ($Force) {
            Remove-Item -Path $TargetPath -Recurse -Force
        } else {
            throw "Runner path already exists. Use -Force to overwrite."
        }
    }
    New-Item -ItemType Directory -Path $TargetPath -Force | Out-Null
    
    # Extract
    Write-Host "Extracting to: $TargetPath"
    Expand-Archive -Path $zipPath -DestinationPath $TargetPath -Force
    Remove-Item $zipPath
    
    Write-Host "Download complete" -ForegroundColor Green
}

# ============================================
# 2. Configure Runner
# ============================================
function Configure-Runner {
    param(
        [string]$RunnerPath,
        [string]$RepoUrl,
        [string]$Token,
        [string]$Labels,
        [string]$RunnerName
    )
    
    Write-Host "=== Configuring Runner ===" -ForegroundColor Cyan
    
    Push-Location $RunnerPath
    try {
        $configArgs = @(
            "--url", $RepoUrl,
            "--token", $Token,
            "--name", $RunnerName,
            "--labels", $Labels,
            "--unattended"
        )
        
        Write-Host "Running config.cmd with:"
        Write-Host "  URL: $RepoUrl"
        Write-Host "  Name: $RunnerName"
        Write-Host "  Labels: $Labels"
        
        & .\config.cmd @configArgs
        
        if ($LASTEXITCODE -ne 0) {
            throw "Configuration failed with exit code: $LASTEXITCODE"
        }
        
        Write-Host "Configuration complete" -ForegroundColor Green
    }
    finally {
        Pop-Location
    }
}

# ============================================
# 3. Install as Service
# ============================================
function Install-RunnerService {
    param([string]$RunnerPath)
    
    Write-Host "=== Installing as Service ===" -ForegroundColor Cyan
    
    Push-Location $RunnerPath
    try {
        # Check for admin privileges
        $isAdmin = ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
        
        if (-not $isAdmin) {
            Write-Warning "Administrator privileges required for service installation"
            Write-Host "Run this script as Administrator or install manually:"
            Write-Host "  cd $RunnerPath"
            Write-Host "  .\svc.sh install"
            Write-Host "  .\svc.sh start"
            return
        }
        
        & .\svc.sh install
        & .\svc.sh start
        
        Write-Host "Service installed and started" -ForegroundColor Green
    }
    finally {
        Pop-Location
    }
}

# ============================================
# 4. Create Helper Scripts
# ============================================
function Create-HelperScripts {
    param([string]$RunnerPath)
    
    Write-Host "=== Creating Helper Scripts ===" -ForegroundColor Cyan
    
    # Start script
    $startScript = @"
# Start Runner (interactive mode)
cd "$RunnerPath"
.\run.cmd
"@
    $startScript | Out-File -FilePath (Join-Path $RunnerPath "start-runner.ps1") -Encoding utf8
    
    # Stop script
    $stopScript = @"
# Stop Runner
Stop-Process -Name "Runner.Listener" -Force -ErrorAction SilentlyContinue
Stop-Process -Name "Runner.Worker" -Force -ErrorAction SilentlyContinue
Write-Host "Runner stopped"
"@
    $stopScript | Out-File -FilePath (Join-Path $RunnerPath "stop-runner.ps1") -Encoding utf8
    
    # Status script
    $statusScript = @"
# Check Runner Status
`$listener = Get-Process -Name "Runner.Listener" -ErrorAction SilentlyContinue
`$worker = Get-Process -Name "Runner.Worker" -ErrorAction SilentlyContinue

if (`$listener) {
    Write-Host "Runner is RUNNING" -ForegroundColor Green
    Write-Host "  Listener PID: `$(`$listener.Id)"
    if (`$worker) {
        Write-Host "  Worker PID: `$(`$worker.Id)"
    }
} else {
    Write-Host "Runner is STOPPED" -ForegroundColor Red
}
"@
    $statusScript | Out-File -FilePath (Join-Path $RunnerPath "runner-status.ps1") -Encoding utf8
    
    Write-Host "Helper scripts created:" -ForegroundColor Green
    Write-Host "  - start-runner.ps1"
    Write-Host "  - stop-runner.ps1"
    Write-Host "  - runner-status.ps1"
}

# ============================================
# Main Execution
# ============================================
try {
    Write-Host ""
    Write-Host "GitHub Actions Self-Hosted Runner Setup" -ForegroundColor Cyan
    Write-Host "========================================" -ForegroundColor Cyan
    Write-Host ""
    
    # Download
    Download-Runner -TargetPath $RunnerPath
    
    # Configure
    Configure-Runner -RunnerPath $RunnerPath -RepoUrl $RepoUrl -Token $Token -Labels $Labels -RunnerName $RunnerName
    
    # Create helper scripts
    Create-HelperScripts -RunnerPath $RunnerPath
    
    # Install as service (optional)
    if ($InstallAsService) {
        Install-RunnerService -RunnerPath $RunnerPath
    }
    
    Write-Host ""
    Write-Host "=== Setup Complete ===" -ForegroundColor Green
    Write-Host ""
    Write-Host "Runner installed at: $RunnerPath" -ForegroundColor White
    Write-Host "Labels: $Labels" -ForegroundColor White
    Write-Host ""
    Write-Host "To start the runner:" -ForegroundColor Yellow
    Write-Host "  cd $RunnerPath"
    Write-Host "  .\run.cmd"
    Write-Host ""
    Write-Host "Or use the helper script:" -ForegroundColor Yellow
    Write-Host "  .\start-runner.ps1"
    Write-Host ""
    
} catch {
    Write-Host ""
    Write-Host "ERROR: $($_.Exception.Message)" -ForegroundColor Red
    Write-Host ""
    exit 1
}
