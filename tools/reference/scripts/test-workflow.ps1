#!/usr/bin/env pwsh
# 测试触发 workflow
Set-Location E:\Repos\vibe-coding-cn
gh workflow list
Write-Host "---"
gh workflow run verse-uefn-compile.yml --ref main -f request_id=test-100 -f branch=main -f commit=ff73f16f -f callback_url="http://193.112.183.143:19527/verse/result"
Write-Host "Workflow triggered!"
