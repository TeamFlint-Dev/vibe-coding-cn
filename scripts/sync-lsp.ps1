# VerseLspCE 同步脚本
# 从 UE 源码编译并同步到 vibe-coding-cn

param(
    [switch]$Build,        # 是否编译
    [switch]$SyncOnly,     # 仅同步，不编译
    [switch]$Linux,        # 同时同步 Linux 版本
    [switch]$Verbose
)

$ErrorActionPreference = "Stop"

# 路径配置
$UERoot = "E:\ue5sorce\UnrealEngine"
$VibeCodingRoot = "E:\Repos\vibe-coding-cn"
$LspSourceDir = "$UERoot\Engine\Source\Programs\VerseLspCE"
$WinBinaryPath = "$UERoot\Engine\Binaries\Win64\VerseLspCE-Win64-Shipping.exe"
$LinuxBinaryPath = "E:\ue5sorce\VerseLspCE-dist\VerseLspCE-Linux-Shipping"
$TargetWinDir = "$VibeCodingRoot\verseProject\bin\win64"
$TargetLinuxDir = "$VibeCodingRoot\verseProject\bin\linux"

function Write-Step($Message) {
    Write-Host "`n=== $Message ===" -ForegroundColor Cyan
}

function Write-Success($Message) {
    Write-Host "✓ $Message" -ForegroundColor Green
}

function Write-Warning($Message) {
    Write-Host "! $Message" -ForegroundColor Yellow
}

# 检查路径
Write-Step "Checking paths"

if (-not (Test-Path $UERoot)) {
    throw "UE root not found: $UERoot"
}

if (-not (Test-Path $VibeCodingRoot)) {
    throw "vibe-coding-cn not found: $VibeCodingRoot"
}

# 编译（如果需要）
if ($Build) {
    Write-Step "Building VerseLspCE"
    
    if (-not (Test-Path $LspSourceDir)) {
        throw "VerseLspCE source not found: $LspSourceDir"
    }
    
    Push-Location $UERoot
    try {
        # 使用 dotnet build
        $csproj = Get-ChildItem -Path $LspSourceDir -Filter "*.csproj" | Select-Object -First 1
        if ($csproj) {
            Write-Host "Building $($csproj.Name)..."
            dotnet build $csproj.FullName -c Shipping
            if ($LASTEXITCODE -ne 0) {
                throw "Build failed"
            }
            Write-Success "Build completed"
        } else {
            Write-Warning "No .csproj found, using UAT..."
            & ".\Engine\Build\BatchFiles\RunUAT.bat" BuildCookRun -project=VerseLspCE -platform=Win64 -configuration=Shipping
        }
    }
    finally {
        Pop-Location
    }
}

# 同步 Windows 二进制
Write-Step "Syncing Windows binary"

if (-not (Test-Path $WinBinaryPath)) {
    throw "Windows binary not found: $WinBinaryPath"
}

# 确保目标目录存在
if (-not (Test-Path $TargetWinDir)) {
    New-Item -ItemType Directory -Path $TargetWinDir -Force | Out-Null
}

$sourceInfo = Get-Item $WinBinaryPath
$targetPath = Join-Path $TargetWinDir $sourceInfo.Name
$targetExists = Test-Path $targetPath

if ($targetExists) {
    $targetInfo = Get-Item $targetPath
    if ($sourceInfo.LastWriteTime -gt $targetInfo.LastWriteTime) {
        Copy-Item $WinBinaryPath $TargetWinDir -Force
        Write-Success "Updated: $($sourceInfo.Name) ($(($sourceInfo.Length / 1MB).ToString('F2')) MB)"
    } else {
        Write-Host "Already up to date: $($sourceInfo.Name)"
    }
} else {
    Copy-Item $WinBinaryPath $TargetWinDir -Force
    Write-Success "Copied: $($sourceInfo.Name) ($(($sourceInfo.Length / 1MB).ToString('F2')) MB)"
}

# 同步 Linux 二进制（如果需要）
if ($Linux) {
    Write-Step "Syncing Linux binary"
    
    if (-not (Test-Path $LinuxBinaryPath)) {
        Write-Warning "Linux binary not found: $LinuxBinaryPath"
        Write-Warning "Skipping Linux sync"
    } else {
        if (-not (Test-Path $TargetLinuxDir)) {
            New-Item -ItemType Directory -Path $TargetLinuxDir -Force | Out-Null
        }
        
        $linuxInfo = Get-Item $LinuxBinaryPath
        Copy-Item $LinuxBinaryPath $TargetLinuxDir -Force
        Write-Success "Copied: $($linuxInfo.Name) ($(($linuxInfo.Length / 1MB).ToString('F2')) MB)"
    }
}

# 验证
Write-Step "Verification"

$verifyPath = Join-Path $TargetWinDir "VerseLspCE-Win64-Shipping.exe"
if (Test-Path $verifyPath) {
    $version = & $verifyPath --version 2>&1
    Write-Host "Version: $version"
    Write-Success "Sync completed successfully"
} else {
    throw "Verification failed: binary not found"
}

# 显示摘要
Write-Step "Summary"
Write-Host "Source: $WinBinaryPath"
Write-Host "Target: $TargetWinDir"
Write-Host ""
Write-Host "To test:"
Write-Host "  cd $VibeCodingRoot\verseProject"
Write-Host "  .\analyze.ps1"
