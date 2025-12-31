@echo off
:: Verse CLI Build Tool - Windows Batch Wrapper
:: 用法: verse-build.bat [选项]

setlocal enabledelayedexpansion

:: 获取脚本所在目录
set "SCRIPT_DIR=%~dp0"

:: 运行 Node.js 脚本
node "%SCRIPT_DIR%verse-build.js" %*

:: 返回退出码
exit /b %ERRORLEVEL%
