# GitHub Agentic Workflows 前置检查清单

> **用途**: 开始 gh-aw 相关任务前，逐项检查以避免踩坑
>
> **来源**: 本清单从实际踩坑中持续沉淀，每条都有对应的失败案例编号

---

## ⚡ 快速检查（每次必看）

- [ ] 读取 `CAPABILITY-BOUNDARIES.md` 确认任务可行性
- [ ] 确认 workflow 文件位于 `.github/workflows/*.md`
- [ ] 运行 `gh aw compile` 验证语法

---

## 🔐 权限与安全

### Permissions 配置

- [ ] 声明的 permissions 满足任务需求
- [ ] 写操作使用 safe-outputs 而非直接权限
  - 来源: [FC-001](FAILURE-CASES.md#fc-001) (待添加)
  - 验证: 检查 frontmatter 中是否有 `safe-outputs` 配置

### Token 权限

- [ ] 跨仓库操作使用 PAT 而非 GITHUB_TOKEN
  - 来源: 官方文档
  - 验证: `github-token: ${{ secrets.PAT }}`

### Secrets 访问

- [ ] Fork PR 触发时无法访问 secrets
  - 来源: GitHub 安全限制
  - 替代: 使用 `pull_request_target` 触发器

---

## 📤 Safe-Outputs 配置

### 写操作检查

- [ ] 创建 Issue 需声明 `safe-outputs.create-issue`
- [ ] 添加评论需声明 `safe-outputs.add-comment`
- [ ] 创建 PR 需声明 `safe-outputs.create-pull-request`
- [ ] 每种写操作都需要单独声明，不会自动继承

### 参数配置

- [ ] `title-prefix` 用于标识自动创建的内容
- [ ] `max` 限制创建数量防止失控
- [ ] `labels` 用于分类和后续检索

---

## 🌐 网络访问

### 沙箱限制

- [ ] 默认沙箱模式限制网络访问
- [ ] 外部 API 需加入 `network.allowed` 白名单
  - 验证: `network: { allowed: [api.example.com] }`
- [ ] 禁用沙箱需显式声明 `sandbox.agent: false`

### 外部服务

- [ ] API 端点可访问（非内网地址）
- [ ] API 有速率限制时添加重试逻辑
- [ ] 超时设置合理（默认可能过短）

---

## 🔧 工具（Tools）配置

### Bash 命令

- [ ] 使用的命令已声明在 `tools.bash` 中
- [ ] 危险命令（如 `rm`）需要显式允许
  - 验证: `bash: ["rm *"]` 或 `bash: [":*"]`

### 文件操作

- [ ] 启用 `tools.edit` 才能读写文件
- [ ] 文件路径使用相对路径（相对于仓库根目录）

### GitHub API

- [ ] 声明需要的 toolsets
  - 验证: `github: { toolsets: [issues, pull_requests] }`

---

## ⏰ 定时任务 (Schedule)

- [ ] cron 间隔 ≥ 5 分钟（GitHub 限制）
- [ ] 明确时区（默认 UTC）
  - 验证: schedule 表达式中的时间是 UTC
- [ ] 考虑时区差异对业务的影响

---

## 🔄 幂等性与并发

- [ ] 重复触发不会产生重复数据
  - 方法: 检查是否存在 → 创建
- [ ] 并发执行有控制
  - 验证: `concurrency` 配置
- [ ] 长任务有超时设置
  - 验证: `timeout-minutes`

---

## 📊 数据假设

- [ ] Issue/PR body 可能为空 → 添加默认值
- [ ] Labels 可能不存在 → 先创建或容错
- [ ] 用户输入可能包含特殊字符 → 转义处理

---

## 🧪 测试验证

- [ ] 本地编译通过: `gh aw compile`
- [ ] 小范围测试后再大规模运行
- [ ] 观察第一次运行的日志

---

## 更新记录

| 日期 | 更新内容 | 关联案例 |
|------|----------|----------|
| 2026-01-02 | 初始版本，从官方文档和已知最佳实践提炼 | - |
