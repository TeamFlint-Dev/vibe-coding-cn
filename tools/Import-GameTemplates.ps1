<#
.SYNOPSIS
    从 E:\GameTemplate 导入官方游戏模板到 external/gameTemplates
    
.DESCRIPTION
    复制每个模板的 Content 文件夹内容，排除 __ExternalActors__ 和 __ExternalObjects__
    同时复制项目配置文件（.uefnproject, .uplugin）
    
.EXAMPLE
    .\tools\Import-GameTemplates.ps1
#>

[CmdletBinding()]
param(
    [string]$SourcePath = "E:\GameTemplate",
    [string]$TargetPath = "external/gameTemplates"
)

$ErrorActionPreference = "Stop"

Write-Host "开始导入游戏模板..." -ForegroundColor Green
Write-Host "源路径: $SourcePath"
Write-Host "目标路径: $TargetPath"
Write-Host ""

# 获取所有模板目录
$templates = Get-ChildItem -Path $SourcePath -Directory

$totalTemplates = $templates.Count
$currentIndex = 0
$copiedFiles = 0
$totalSize = 0

foreach ($template in $templates) {
    $currentIndex++
    $templateName = $template.Name
    
    Write-Host "[$currentIndex/$totalTemplates] 处理: $templateName" -ForegroundColor Cyan
    
    $targetDir = Join-Path $TargetPath $templateName
    New-Item -Path $targetDir -ItemType Directory -Force | Out-Null
    
    # 复制 Content 文件夹（排除 __ExternalActors__ 和 __ExternalObjects__）
    $contentPath = Join-Path $template.FullName "Content"
    if (Test-Path $contentPath) {
        $files = Get-ChildItem -Path $contentPath -Recurse -File | Where-Object {
            $_.FullName -notlike "*__ExternalActors__*" -and 
            $_.FullName -notlike "*__ExternalObjects__*"
        }
        
        foreach ($file in $files) {
            $relativePath = $file.FullName.Substring($contentPath.Length + 1)
            $targetFile = Join-Path $targetDir "Content" $relativePath
            
            $targetFileDir = Split-Path $targetFile -Parent
            if (-not (Test-Path $targetFileDir)) {
                New-Item -Path $targetFileDir -ItemType Directory -Force | Out-Null
            }
            
            Copy-Item -Path $file.FullName -Destination $targetFile -Force
            $copiedFiles++
            $totalSize += $file.Length
        }
        
        Write-Host "  ✓ Content: $($files.Count) 个文件" -ForegroundColor Gray
    }
    
    # 复制项目配置文件
    $configFiles = @()
    $configFiles += Get-ChildItem -Path $template.FullName -File -Filter "*.uefnproject" -ErrorAction SilentlyContinue
    $configFiles += Get-ChildItem -Path $template.FullName -File -Filter "*.uplugin" -ErrorAction SilentlyContinue
    
    foreach ($configFile in $configFiles) {
        $targetFile = Join-Path $targetDir $configFile.Name
        Copy-Item -Path $configFile.FullName -Destination $targetFile -Force
        $copiedFiles++
        $totalSize += $configFile.Length
        Write-Host "  ✓ 配置: $($configFile.Name)" -ForegroundColor Gray
    }
}

$totalSizeMB = [math]::Round($totalSize / 1MB, 2)
$totalSizeGB = [math]::Round($totalSize / 1GB, 2)

Write-Host ""
Write-Host "导入完成!" -ForegroundColor Green
Write-Host "  模板数量: $totalTemplates"
Write-Host "  文件总数: $copiedFiles"
Write-Host "  总大小: $totalSizeMB MB ($totalSizeGB GB)"
