# Verse CLI Build Tool - PowerShell Wrapper
# 用法: .\verse-build.ps1 [选项]

param(
    [string]$ServerHost = "127.0.0.1",
    [int]$Port = 1962,
    [switch]$Push,
    [switch]$Watch,
    [string[]]$Dir,
    [switch]$Verbose,
    [switch]$Help
)

$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path

# 构建参数
$nodeArgs = @()

if ($ServerHost -ne "127.0.0.1") {
    $nodeArgs += "--host"
    $nodeArgs += $ServerHost
}

if ($Port -ne 1962) {
    $nodeArgs += "--port"
    $nodeArgs += $Port
}

if ($Push) {
    $nodeArgs += "--push"
}

if ($Watch) {
    $nodeArgs += "--watch"
}

foreach ($d in $Dir) {
    $nodeArgs += "--dir"
    $nodeArgs += $d
}

if ($Verbose) {
    $nodeArgs += "--verbose"
}

if ($Help) {
    $nodeArgs += "--help"
}

# 运行 Node.js 脚本
& node "$ScriptDir\verse-build.js" $nodeArgs
