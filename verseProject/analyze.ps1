#!/usr/bin/env pwsh
# Verse 代码分析脚本 (Windows)
# 用法: .\analyze.ps1 [-Format <text|json|jsonl|markdown|agent>]

param(
    [ValidateSet("text", "json", "jsonl", "markdown", "agent")]
    [string]$Format = "agent"
)

$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$VerseLsp = Join-Path $ScriptDir "bin\win64\VerseLspCE-Win64-Shipping.exe"
$VProject = Join-Path $ScriptDir "VibeCodingCN.vproject"

if (-not (Test-Path $VerseLsp)) {
    Write-Error "VerseLspCE not found at: $VerseLsp"
    exit 1
}

if (-not (Test-Path $VProject)) {
    Write-Error "vproject file not found at: $VProject"
    exit 1
}

Write-Host "Analyzing Verse code..." -ForegroundColor Cyan
& $VerseLsp --analyze $VProject --format $Format
$exitCode = $LASTEXITCODE

if ($exitCode -eq 0) {
    Write-Host "`n✅ Analysis completed successfully!" -ForegroundColor Green
} else {
    Write-Host "`n❌ Analysis found issues (exit code: $exitCode)" -ForegroundColor Red
}

exit $exitCode
