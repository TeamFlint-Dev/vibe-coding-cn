---
name: verseDigestSync
description: API Digest 同步检测 - 检查上游仓库更新，联动 Wrapper 层审计
version: 2.0.0
---

# Verse Digest Sync

> **类型**: 维护工具（Maintenance Tool）
> **职责**: 检测 UEFN API Digest 上游仓库是否有新更新，联动 Wrapper 层进行影响分析

---

## When to Use This Skill

- **每日首次启动时**: 可选触发，检查上游是否有新提交
- **用户主动请求**: 当用户询问 API 是否有更新时
- **审计前检查**: 在执行 API 一致性审计前，确认 digest 版本

---

## 上游仓库

**仓库地址**: `https://github.com/vz-creates/uefn`

**本地 digest 位置**: `shared/api-digests/`

**版本记录文件**: `shared/api-digests/.last-sync-commit`

---

## 执行流程

```
接收同步检查请求
    │
    ├── 读取本地 .last-sync-commit 文件
    │   └── 如不存在，视为首次同步
    │
    ├── 执行 git ls-remote 获取远程 HEAD
    │   └── git ls-remote https://github.com/vz-creates/uefn HEAD
    │
    ├── 比对 commit hash
    │   ├── 相同 → 报告"无更新"
    │   └── 不同 → 报告"发现新更新"
    │       │
    │       └── 【新增】读取 @wrapper-registry.md
    │           ├── 获取所有 Wrapper 的 digest 参考行号
    │           ├── 分析可能受影响的 Wrapper
    │           └── 生成更新影响报告
    │
    └── 输出结果给用户
```

---

## 检测命令

```bash
# 获取远程仓库最新 commit hash
git ls-remote https://github.com/vz-creates/uefn HEAD

# 输出格式:
# <commit-hash>    HEAD
```

---

## 输出格式

### 无更新时

```markdown
## API Digest 同步检查

**检查时间**: 2025-12-28 10:30
**上游仓库**: https://github.com/vz-creates/uefn
**状态**: ✅ 已是最新

本地记录 commit: `abc1234...`
远程最新 commit: `abc1234...`

无需更新操作。
```

### 发现更新时

```markdown
## API Digest 同步检查

**检查时间**: 2025-12-28 10:30
**上游仓库**: https://github.com/vz-creates/uefn
**状态**: ⚠️ 发现新更新

本地记录 commit: `abc1234...`
远程最新 commit: `def5678...`

### Wrapper 影响分析【新增】

根据 `@wrapper-registry.md` 分析受影响的 Wrapper：

| Wrapper | digest 参考 | 影响程度 | 建议操作 |
|---------|-------------|----------|----------|
| CharacterWrapper | Fortnite L11777-12020 | ⚠️ 需检查 | 运行 API 一致性审计 |

### 建议操作

1. 访问仓库查看更新内容：
   https://github.com/vz-creates/uefn/commits/main

2. 如需更新本地 digest 文件：
   - 下载最新的 digest 文件
   - 替换 `shared/api-digests/` 中对应文件
   - 更新 `.last-sync-commit` 为新的 commit hash

3. **运行 Wrapper 审计**：
   - 调用 verseCodeAuditor 执行 API 一致性检查
   - 重点检查上表中标记的 Wrapper 文件
   - 根据变更情况更新 Wrapper 代码

4. 更新 `@wrapper-registry.md` 状态
```

---

## 本地版本记录

文件: `shared/api-digests/.last-sync-commit`

```
# 上次同步的 commit hash
# 格式: <commit-hash>
# 更新时间: YYYY-MM-DD

49242330abc1234def5678...
```

---

## 与 Wrapper 层联动【CHANGE-005 新增】

### Wrapper 注册表

文件: `shared/project-templates/@wrapper-registry.md`

此文件记录所有 Wrapper 及其 digest 引用行号，用于：
1. 快速定位可能受影响的 Wrapper
2. 支持精准的 API 一致性审计
3. 追踪 Wrapper 更新历史

### 联动流程

```
verseDigestSync 检测到更新
    ↓
读取 @wrapper-registry.md
    ↓
对每个 Wrapper:
    ├── 获取其 digest 参考行号（如 Fortnite L11777-12020）
    ├── 标记为 ⚠️ 需检查
    └── 加入影响分析报告
    ↓
输出 Wrapper 影响分析表
    ↓
用户决定是否更新 digest
    ↓
更新后，运行 verseCodeAuditor
    ├── API-001: digest 定义存在性检查
    ├── API-002: 调用方式一致性检查
    └── API-003: 参数类型一致性检查
    ↓
根据审计结果更新 Wrapper 代码
    ↓
更新 @wrapper-registry.md 状态
```

### 影响程度分级

| 级别 | 标记 | 含义 | 操作 |
|------|------|------|------|
| 高 | 🔴 | digest 中对应行已删除或重大变更 | 立即审计并更新 |
| 中 | ⚠️ | digest 中对应行可能有变更 | 建议审计 |
| 低 | 🟢 | digest 中对应行未变 | 可跳过 |

---

## 与其他 Skill 的联动

### 与 verseCodeAuditor 联动

```
digest 更新后
    ↓
读取 @wrapper-registry.md 获取 Wrapper 列表
    ↓
标记所有 Wrapper 文件需要重新审计
    ↓
verseCodeAuditor 执行 API 一致性检查
    ↓
输出受影响文件列表及具体变更建议
```

### 与 verseWrappers 联动【新增】

```
verseDigestSync 发现更新
    ↓
通知 verseWrappers
    ↓
verseWrappers 参考 api-keyword-mapping.md
    ↓
识别可能需要更新的业务域
    ↓
生成 Wrapper 更新建议
```

### 与 verseOrchestrator 联动

```
每日首次启动
    ↓
verseOrchestrator 可选触发 verseDigestSync
    ↓
如有更新，提示用户
    ↓
用户决定是否立即更新
```

---

## 受影响文件类型

当 digest 更新时，以下文件可能需要检查：

| 文件类型 | 位置 | 影响程度 | 说明 |
|----------|------|----------|------|
| **Wrapper** | `code-library/Wrappers/*Wrapper.verse` | 🔴 高 | 直接封装 API，必须检查 |
| **Helper** | `code-library/Helpers/*.verse` | 🟡 中 | 可能调用 Wrapper，间接影响 |
| **Component** | `code-library/Components/*.verse` | 🟢 低 | 通过 Wrapper 调用，通常无需改动 |
| **SKILL 文档** | `verseWrappers/SKILL.md` 等 | 🔵 信息 | 示例代码可能需要更新 |

---

## 注意事项

1. **网络异常处理**: 如果 `git ls-remote` 失败，报告网络错误但不阻断其他流程
2. **不自动更新**: 此 Skill 仅检测更新，不自动拉取或修改文件
3. **用户决策**: 更新操作由用户手动执行，确保变更可控

---

## Reference Files

- [Fortnite.digest.verse](../shared/api-digests/Fortnite.digest.verse) - Fortnite API digest
- [Verse.digest.verse](../shared/api-digests/Verse.digest.verse) - Verse 核心 API digest
- [UnrealEngine.digest.verse](../shared/api-digests/UnrealEngine.digest.verse) - UE API digest
- [verseCodeAuditor](../verseCodeAuditor/SKILL.md) - API 一致性审计
- [verseWrappers](../verseWrappers/SKILL.md) - Wrapper 层 Skill
- [@wrapper-registry.md](../shared/project-templates/@wrapper-registry.md) - Wrapper 注册表

---

*最后更新: 2025-12-28*
