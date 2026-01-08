# 常见问题排查

## 事件触发问题

### "Resource not accessible by integration"

**症状：**

```
Error: Resource not accessible by integration
```

**原因：**

- 使用 `GITHUB_TOKEN` 触发 `repository_dispatch`
- Token 权限不足

**解决方案：**

1. 创建 Classic PAT（勾选 `repo` 和 `workflow` 权限）
2. 添加到仓库 Secrets
3. 在工作流中使用：

```yaml
env:
  GH_TOKEN: ${{ secrets.ACTIONAGENT }}
```

### "Unexpected inputs provided"

**症状：**

```
could not create workflow dispatch event: HTTP 422: Unexpected inputs provided: ["unknown_param"]
```

**原因：**

- `gh workflow run` 传递了工作流未定义的 inputs

**解决方案：**
检查工作流的 `inputs` 定义：

```yaml
on:
  workflow_dispatch:
    inputs:
      task_id:        # 确保名称匹配
        required: false
```

### 事件未触发工作流

**检查清单：**

1. 工作流是否在默认分支（通常是 main）
2. `on:` 触发器是否正确配置
3. 事件类型是否匹配：

```yaml
on:
  repository_dispatch:
    types: [my-event]  # 必须精确匹配
```

## API 调用问题

### JSON 解析错误

**症状：**

```
json: cannot unmarshal string into Go value of type map[string]interface{}
```

**原因：**
使用 `-f` 参数传递 JSON，导致被当作字符串

**错误示例：**

```bash
gh api repos/.../dispatches -f client_payload='{"key":"value"}'
```

**正确示例：**

```bash
echo '{"event_type":"test","client_payload":{}}' | gh api repos/.../dispatches --input -
```

### "Not Found" 错误

**症状：**

```
gh api: Not Found (HTTP 404)
```

**原因：**

- 仓库名称错误
- Token 无权访问该仓库
- API 路径错误

**调试步骤：**

```bash
# 验证仓库访问
gh api repos/{owner}/{repo}

# 验证 token
gh auth status
```

## PowerShell 输出问题

### 输出文件编码错误

**症状：**

- 输出变量为空
- 中文字符乱码

**原因：**
PowerShell 默认编码与 GitHub Actions 不兼容

**解决方案：**

```powershell
# ✅ 明确指定 UTF-8 编码
'result=success' | Out-File -FilePath $env:GITHUB_OUTPUT -Append -Encoding utf8
```

### 重定向运算符语法错误

**症状：**

```
The term '>>' is not recognized...
```

**原因：**
PowerShell 5.1 的 `>>` 重定向行为与 Bash 不同

**错误示例：**

```powershell
"result=success" >> $env:GITHUB_OUTPUT  # ❌
```

**正确示例：**

```powershell
'result=success' | Out-File -FilePath $env:GITHUB_OUTPUT -Append -Encoding utf8  # ✅
```

### 变量展开问题

**症状：**
输出的值为字面量 `$variable` 而非变量值

**原因：**
使用单引号阻止了变量展开

**解决方案：**

```powershell
# 需要展开变量时使用双引号或字符串插值
$result = "success"
"result=$result" | Out-File -FilePath $env:GITHUB_OUTPUT -Append -Encoding utf8

# 或使用 -f 格式化
'result={0}' -f $result | Out-File -FilePath $env:GITHUB_OUTPUT -Append -Encoding utf8
```

## YAML 解析问题

### 中文注释导致解析错误

**症状：**

```
Error: Invalid workflow file
yaml: line X: mapping values are not allowed in this context
```

**原因：**
某些 YAML 解析器对非 ASCII 字符处理异常

**解决方案：**

- 使用纯 ASCII 注释（英文）
- 或在文件开头声明编码（不推荐）

### 缩进错误

**症状：**

```
Error: Invalid workflow file
yaml: line X: did not find expected key
```

**调试步骤：**

1. 确保使用空格而非 Tab
2. 检查缩进一致性（通常 2 空格）
3. 使用在线 YAML 验证器

### 引号嵌套问题

**症状：**
JSON 字符串被截断或语法错误

**原因：**
引号嵌套不正确

**解决方案 - 使用 heredoc：**

```yaml
run: |
  gh api repos/${{ github.repository }}/dispatches --input - << 'EOF'
  {
    "event_type": "test",
    "client_payload": {
      "message": "Hello, World!"
    }
  }
  EOF
```

## Self-Hosted Runner 问题

### Runner 离线

**检查步骤：**

```powershell
# 检查进程
Get-Process -Name "Runner*"

# 查看日志
Get-Content E:\github-actions-runner\_diag\Runner*.log -Tail 100
```

**常见原因：**

- Runner 服务未启动
- 网络连接问题
- Token 过期

### 工作流卡在 "Queued"

**原因：**

- 没有匹配的 Runner
- Runner 忙于其他任务
- 标签不匹配

**解决方案：**

```yaml
# 确保标签正确
runs-on: [self-hosted, windows, verse-builder]
```

### 本地文件访问失败

**原因：**
Runner 用户没有目标路径的权限

**解决方案：**

```powershell
# 授予权限
icacls "E:\Game\FishTycoon" /grant "RunnerUser:(OI)(CI)F"
```

## gh-aw 问题

### Lock 文件与源文件不同步

**症状：**
修改了 `.yml` 但 `.lock.yml` 未更新

**解决方案：**

```bash
# 重新生成 lock 文件
gh aw regenerate my-workflow.yml
```

### Secrets 无法访问

**原因：**
gh-aw 沙箱环境不允许访问 secrets

**解决方案：**
直接编辑 `.lock.yml` 文件，手动添加 secrets 引用

## 调试技巧

### 启用调试日志

```yaml
env:
  ACTIONS_STEP_DEBUG: true
  ACTIONS_RUNNER_DEBUG: true
```

### 打印环境信息

```yaml
- name: Debug Info
  run: |
    echo "Event: ${{ github.event_name }}"
    echo "Action: ${{ github.event.action }}"
    echo "Ref: ${{ github.ref }}"
    echo "Payload:"
    cat $GITHUB_EVENT_PATH | jq .
```

### 使用 tmate 进行交互调试

```yaml
- name: Setup tmate session
  if: failure()
  uses: mxschmitt/action-tmate@v3
  with:
    limit-access-to-actor: true
```

## 快速诊断流程

```
1. 工作流未触发？
   ├─> 检查触发器配置
   ├─> 检查分支是否正确
   └─> 检查事件类型是否匹配

2. API 调用失败？
   ├─> 检查 Token 权限
   ├─> 检查 JSON 格式
   └─> 检查 API 路径

3. 输出变量为空？
   ├─> 检查 PowerShell 语法
   ├─> 检查编码设置
   └─> 检查变量名拼写

4. Self-Hosted Runner 问题？
   ├─> 检查 Runner 状态
   ├─> 检查标签匹配
   └─> 检查文件权限
```

## Webhook 服务器问题

### GitHub Actions 评论无法触发 Copilot Agent

**症状：** GitHub Actions 使用 `GITHUB_TOKEN` 发表的评论中 `@copilot` 不会触发 Copilot Agent 响应。

**原因：** GitHub 设计上阻止 Bot 触发其他 Bot（防止无限循环）。

**解决方案：** 使用个人 PAT 以用户身份发表评论：

```python
# Webhook 服务器中添加
GITHUB_USER_PAT = os.environ.get("GITHUB_USER_PAT", "")  # 个人 PAT

def post_comment_as_user(pr_number: int, body: str) -> bool:
    """以用户身份发表评论（可触发 Copilot Agent）"""
    url = f"https://api.github.com/repos/{REPO_OWNER}/{REPO_NAME}/issues/{pr_number}/comments"
    headers = {
        "Authorization": f"Bearer {GITHUB_USER_PAT}",  # 使用个人 PAT
        # ...
    }
```

**评论分离策略：**

| 评论类型 | 发表方式 | 可触发 Copilot |
|---------|---------|---------------|
| 系统消息 (Build Skipped/Succeeded) | GitHub Actions (`GITHUB_TOKEN`) | ❌ |
| 修复请求 (`@copilot ...`) | Webhook (`GITHUB_USER_PAT`) | ✅ |

### SSH 连接被拒绝

**症状：**

```
Connection closed by 193.112.183.143 port 19527
```

**原因：** 端口混淆 - SSH 端口是 22，19527 是 Webhook 服务端口。

**解决方案：**

```bash
# ✅ 正确：SSH 使用默认端口 22
ssh -i ~/.ssh/key.pem ubuntu@server-ip

# ❌ 错误：误用 Webhook 端口
ssh -i ~/.ssh/key.pem -p 19527 ubuntu@server-ip
```

### curl 下载私有仓库文件返回 404

**症状：**

```bash
curl -o file.py https://raw.githubusercontent.com/org/private-repo/main/file.py
# 文件内容是 "404: Not Found"
```

**原因：** 私有仓库需要认证。

**解决方案：**

```bash
# 方案 A：使用 SCP 上传
scp -i key.pem local_file.py ubuntu@server:/opt/webhook/

# 方案 B：使用带 Token 的请求
curl -H "Authorization: token ghp_xxx" \
  https://raw.githubusercontent.com/org/repo/main/file.py

# 方案 C：使用 GitHub API
curl -H "Authorization: token ghp_xxx" \
  -H "Accept: application/vnd.github.raw" \
  https://api.github.com/repos/org/repo/contents/file.py
```

### Webhook 服务启动失败 - SyntaxError

**症状：**

```
SyntaxError: illegal target for annotation
```

**原因：** 下载的文件内容不正确（通常是 404 页面或 HTML）。

**诊断：**

```bash
head -5 /opt/webhook/webhook_server.py
# 如果显示 "404: Not Found" 或 HTML，说明下载失败
```

**解决方案：** 使用 SCP 直接上传正确的文件。

## 手动触发构建

### 添加 `/build` 命令支持

在 Webhook 服务器中添加对 PR 评论的监听：

```python
BUILD_COMMANDS = re.compile(r"^\s*(/build|/编译)\s*$", re.MULTILINE)

def _handle_comment_event(self, data: dict):
    """检测 /build 或 /编译 命令"""
    comment_body = data.get("comment", {}).get("body", "")
    if BUILD_COMMANDS.search(comment_body):
        # 触发构建
        trigger_repository_dispatch(pr_number, pr_title, head_ref)
```

**GitHub Webhook 配置：** 需要勾选 `Issue comments` 事件。
