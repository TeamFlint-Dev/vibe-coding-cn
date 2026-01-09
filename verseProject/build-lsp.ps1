#!/usr/bin/env pwsh
# VerseLspCE 一键编译同步 (快捷入口)
# 用法: .\build-lsp.ps1 [-Analyze] [-Clean]

param(
    [switch]$Analyze,   # 编译后运行 analyze
    [switch]$Clean      # 清理后重新编译
)

$scriptPath = Join-Path $PSScriptRoot "..\scripts\build-lsp.ps1"

$args = @()
if ($Analyze) { $args += "-Analyze" }
if ($Clean) { $args += "-Clean" }

& $scriptPath @args
