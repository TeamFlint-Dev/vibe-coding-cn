# Verse CLI Build Tool - PowerShell Wrapper
# 用法: .\verse-build.ps1 [选项]

param(
    [string]$Host = "127.0.0.1",
    [int]$Port = 1962,
    [switch]$Push,
    [switch]$Watch,
    [string[]]$Dir,
    [switch]$Verbose,
    [switch]$Help
)

$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path

# 构建参数
$args = @()

if ($Host -ne "127.0.0.1") {
    $args += "--host", $Host
}

if ($Port -ne 1962) {
    $args += "--port", $Port
}

if ($Push) {
    $args += "--push"
}

if ($Watch) {
    $args += "--watch"
}

foreach ($d in $Dir) {
    $args += "--dir", $d
}

if ($Verbose) {
    $args += "--verbose"
}

if ($Help) {
    $args += "--help"
}

# 运行 Node.js 脚本
$process = Start-Process -FilePath "node" -ArgumentList (@("$ScriptDir\verse-build.js") + $args) -NoNewWindow -Wait -PassThru

exit $process.ExitCode
