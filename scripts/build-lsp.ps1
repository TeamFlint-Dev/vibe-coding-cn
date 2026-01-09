#!/usr/bin/env pwsh
# VerseLspCE 一键编译同步脚本
# 在 vibe-coding-cn 工作区直接调用，无需打开 UE 源码

param(
    [ValidateSet("Win64", "Linux", "All")]
    [string]$Platform = "Win64",
    
    [ValidateSet("Shipping", "Development", "Debug")]
    [string]$Configuration = "Shipping",
    
    [switch]$Clean,           # 清理后重新编译
    [switch]$Analyze,         # 编译后运行 analyze
    [switch]$SkipSync,        # 不同步到 verseProject/bin
    [switch]$Verbose
)

$ErrorActionPreference = "Stop"
$startTime = Get-Date

# ============================================================================
# 路径配置
# ============================================================================

$UERoot = "E:\ue5sorce\UnrealEngine"
$VibeCodingRoot = "E:\Repos\vibe-coding-cn"
$VerseProjectRoot = "$VibeCodingRoot\verseProject"

# UE 编译工具
$UBTPath = "$UERoot\Engine\Binaries\DotNET\UnrealBuildTool\UnrealBuildTool.exe"
$BuildBat = "$UERoot\Engine\Build\BatchFiles\Build.bat"

# 输出二进制位置
$BinaryPaths = @{
    "Win64" = @{
        Source = "$UERoot\Engine\Binaries\Win64\VerseLspCE-Win64-$Configuration.exe"
        Target = "$VerseProjectRoot\bin\win64"
    }
    "Linux" = @{
        Source = "E:\ue5sorce\VerseLspCE-dist\VerseLspCE-Linux-$Configuration"
        Target = "$VerseProjectRoot\bin\linux"
    }
}

# ============================================================================
# 辅助函数
# ============================================================================

function Write-Step($Message) {
    Write-Host "`n━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor DarkGray
    Write-Host " $Message" -ForegroundColor Cyan
    Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor DarkGray
}

function Write-Success($Message) {
    Write-Host "  ✓ $Message" -ForegroundColor Green
}

function Write-Info($Message) {
    Write-Host "  → $Message" -ForegroundColor White
}

function Write-Warn($Message) {
    Write-Host "  ⚠ $Message" -ForegroundColor Yellow
}

function Write-Fail($Message) {
    Write-Host "  ✗ $Message" -ForegroundColor Red
}

function Get-ElapsedTime {
    $elapsed = (Get-Date) - $startTime
    return "{0:mm}:{0:ss}" -f $elapsed
}

# ============================================================================
# 前置检查
# ============================================================================

Write-Step "Environment Check"

if (-not (Test-Path $UERoot)) {
    throw "UE root not found: $UERoot"
}
Write-Success "UE root: $UERoot"

if (-not (Test-Path $BuildBat)) {
    throw "Build.bat not found: $BuildBat"
}
Write-Success "Build system ready"

if (-not (Test-Path $VibeCodingRoot)) {
    throw "vibe-coding-cn not found: $VibeCodingRoot"
}
Write-Success "Target workspace: $VibeCodingRoot"

# ============================================================================
# 清理（如果需要）
# ============================================================================

if ($Clean) {
    Write-Step "Cleaning previous build"
    
    $intermediatePath = "$UERoot\Engine\Intermediate\Build\Win64\VerseLspCE"
    if (Test-Path $intermediatePath) {
        Remove-Item $intermediatePath -Recurse -Force
        Write-Success "Cleaned intermediate files"
    } else {
        Write-Info "No intermediate files to clean"
    }
}

# ============================================================================
# 编译
# ============================================================================

$platforms = if ($Platform -eq "All") { @("Win64") } else { @($Platform) }
# 注意: Linux 交叉编译需要特殊配置，这里默认只支持 Win64

foreach ($plat in $platforms) {
    Write-Step "Building VerseLspCE ($plat, $Configuration)"
    
    Push-Location $UERoot
    try {
        $buildArgs = @(
            "VerseLspCE",
            $plat,
            $Configuration
        )
        
        if ($Verbose) {
            $buildArgs += "-Verbose"
        }
        
        Write-Info "Command: Build.bat $($buildArgs -join ' ')"
        Write-Host ""
        
        & $BuildBat @buildArgs
        
        if ($LASTEXITCODE -ne 0) {
            throw "Build failed with exit code $LASTEXITCODE"
        }
        
        Write-Success "Build completed for $plat"
    }
    finally {
        Pop-Location
    }
}

# ============================================================================
# 同步到 verseProject/bin
# ============================================================================

if (-not $SkipSync) {
    Write-Step "Syncing binaries"
    
    foreach ($plat in $platforms) {
        $paths = $BinaryPaths[$plat]
        $sourcePath = $paths.Source
        $targetDir = $paths.Target
        
        if (-not (Test-Path $sourcePath)) {
            Write-Warn "Binary not found: $sourcePath"
            continue
        }
        
        # 确保目标目录存在
        if (-not (Test-Path $targetDir)) {
            New-Item -ItemType Directory -Path $targetDir -Force | Out-Null
        }
        
        $sourceInfo = Get-Item $sourcePath
        $targetPath = Join-Path $targetDir $sourceInfo.Name
        
        Copy-Item $sourcePath $targetDir -Force
        $sizeMB = ($sourceInfo.Length / 1MB).ToString("F2")
        Write-Success "Synced: $($sourceInfo.Name) ($sizeMB MB)"
    }
}

# ============================================================================
# 验证
# ============================================================================

Write-Step "Verification"

$verifyPath = "$VerseProjectRoot\bin\win64\VerseLspCE-Win64-$Configuration.exe"
if (Test-Path $verifyPath) {
    $version = & $verifyPath --version 2>&1
    Write-Success "Version: $version"
} else {
    Write-Warn "Binary not found at expected path"
}

# ============================================================================
# 运行 Analyze（如果需要）
# ============================================================================

if ($Analyze) {
    Write-Step "Running Verse Analysis"
    
    $analyzeScript = "$VerseProjectRoot\analyze.ps1"
    if (Test-Path $analyzeScript) {
        Push-Location $VerseProjectRoot
        try {
            & $analyzeScript
        }
        finally {
            Pop-Location
        }
    } else {
        Write-Warn "analyze.ps1 not found"
    }
}

# ============================================================================
# 完成
# ============================================================================

Write-Step "Build Complete"

$elapsed = Get-ElapsedTime
Write-Host ""
Write-Host "  Platform:      $Platform" -ForegroundColor White
Write-Host "  Configuration: $Configuration" -ForegroundColor White
Write-Host "  Elapsed:       $elapsed" -ForegroundColor White
Write-Host ""
Write-Host "  Binary location:" -ForegroundColor Gray
Write-Host "    $VerseProjectRoot\bin\win64\" -ForegroundColor Yellow
Write-Host ""
Write-Host "  Quick commands:" -ForegroundColor Gray
Write-Host "    .\scripts\build-lsp.ps1              # 编译 + 同步" -ForegroundColor DarkGray
Write-Host "    .\scripts\build-lsp.ps1 -Analyze     # 编译 + 同步 + 分析" -ForegroundColor DarkGray
Write-Host "    .\scripts\build-lsp.ps1 -Clean       # 清理后重新编译" -ForegroundColor DarkGray
Write-Host ""
