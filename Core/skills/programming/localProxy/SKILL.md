# Local Proxy 配置技能

> 本地代理配置与网络问题排查

## 概述

当遇到网络连接问题时，首先检查本地代理配置。本机使用 V2RayN 代理。

## 代理软件信息

| 项目 | 值 |
|------|-----|
| 软件 | V2RayN |
| 配置目录 | `D:\v2rayN-Core\v2rayN-windows-64\binConfigs\` |
| 主配置文件 | `config.json` |
| SOCKS 端口 | `10808` |
| 代理地址 | `http://127.0.0.1:10808` |

## 常见问题与解决

### 问题1：请求超时/连接失败

**症状**：
- SSH 连接超时
- curl/HTTP 请求返回 503
- "连接方在一段时间后没有正确答复"

**原因**：请求走了代理，但代理服务器无法访问目标（如国内服务器）

**解决**：添加直连规则

### 问题2：GitHub Actions Runner 下载失败

**症状**：
- `Failed to download action 'actions/checkout@v4'`
- `不知道这样的主机 (codeload.github.com:443)`

**原因**：Runner 无法访问 GitHub（需要代理）

**解决**：确保代理正常运行，或在 Runner 启动前配置代理环境变量

## 添加直连规则

当某个 IP 需要直连（不走代理）时：

### 方法1：PowerShell 脚本

```powershell
$configPath = "D:\v2rayN-Core\v2rayN-windows-64\binConfigs\config.json"
$config = Get-Content $configPath -Raw | ConvertFrom-Json

# 添加直连规则（插入到最前面）
$newRule = @{
    type = "field"
    ip = @("目标IP地址")
    outboundTag = "direct"
}
$config.routing.rules = @($newRule) + $config.routing.rules

# 保存
$config | ConvertTo-Json -Depth 20 | Set-Content $configPath -Encoding UTF8
Write-Host "已添加直连规则，请重启 V2RayN"
```

### 方法2：手动编辑

编辑 `config.json`，在 `routing.rules` 数组**最前面**添加：

```json
{
  "type": "field",
  "ip": ["目标IP地址"],
  "outboundTag": "direct"
}
```

### 方法3：V2RayN GUI

1. 右键托盘图标 → 设置 → 路由设置
2. 在"直连的IP"中添加 IP 地址
3. 确定并重启服务

## 当前直连规则

已配置的直连 IP：

| IP | 用途 |
|----|------|
| `193.112.183.143` | 腾讯云 Webhook 服务器 |

## 验证直连配置

```powershell
# 查看第一条规则（直连规则应在最前面）
(Get-Content "D:\v2rayN-Core\v2rayN-windows-64\binConfigs\config.json" -Raw | ConvertFrom-Json).routing.rules[0] | ConvertTo-Json
```

## 重启代理服务

修改配置后必须重启：
- V2RayN 托盘图标 → 右键 → 重启服务
- 或关闭 V2RayN 后重新打开

## 环境变量配置

如果某个程序需要使用代理：

```powershell
$env:HTTP_PROXY = "http://127.0.0.1:10808"
$env:HTTPS_PROXY = "http://127.0.0.1:10808"
```

如果需要排除某些地址：

```powershell
$env:NO_PROXY = "localhost,127.0.0.1,193.112.183.143"
```

## Agent 排查流程

遇到网络问题时：

1. **确认代理状态**：V2RayN 是否运行？
2. **确认目标类型**：
   - 国外站点（GitHub 等）→ 需要走代理
   - 国内站点/服务器 → 需要直连
3. **检查直连规则**：目标 IP 是否在直连列表？
4. **添加规则**：如需要，添加直连规则并重启
