# 待重写 Skills 清单

> 状态：待实施
> 创建日期：2026-01-07
> 说明：以下 Skills 需要根据 DLSD 架构和实际编码经验重写

---

## 重写原则

1. **实践优先**：先在项目中积累 DLSD 实践经验，再提炼 Skill
2. **渐进完善**：从核心功能开始，逐步完善
3. **案例驱动**：每个 Skill 必须包含来自真实项目的代码示例

---

## 优先级清单

### P0 - 高优先级（影响新项目创建和质量保证）

| Skill | 原路径 | 说明 | 状态 |
|-------|--------|------|------|
| **verseProjectInit** | `_archived/verseProjectInit/` | 项目初始化模板需按 DLSD 目录结构更新 | ⏳ 待重写 |
| **verseCodeAuditor** | `_archived/verseCodeAuditor/` | 代码审计规则需适配 DLSD-ARC/QUA 规则 | ⏳ 待重写 |

### P1 - 中优先级（影响开发效率）

| Skill | 原路径 | 说明 | 状态 |
|-------|--------|------|------|
| **verseAgentLoop** | `_archived/verseAgentLoop/` | 自动编码循环框架，Prompt 需适配 DLSD | ⏳ 待重写 |
| **verseTactician** | `_archived/verseTactician/` | 战术手册，错误分类需适配 DLSD 层级 | ⏳ 待重写 |
| **versePromptAuditor** | `_archived/versePromptAuditor/` | Prompt 审计，审计范围需更新 | ⏳ 待重写 |

### P2 - 低优先级（可后续按需重写）

| Skill | 原路径 | 说明 | 状态 |
|-------|--------|------|------|
| **verseAuditDispatcher** | `_archived/verseAuditDispatcher/` | 审计调度框架 | ⏳ 待重写 |
| **verseRequirementProposer** | `_archived/verseRequirementProposer/` | 需求提案，需求类别需适配 DLSD | ⏳ 待重写 |
| **verseOrchestrator** | `_archived/verseOrchestrator/` | 协调器，调度逻辑需适配 DLSD 四层 | ⏳ 待重写 |

---

## 保留参考（无需重写）

| Skill | 原路径 | 说明 |
|-------|--------|------|
| **verseDigestSync** | `_archived/verseDigestSync/` | 纯工具类，与架构无关，可保留原有功能 |
| **verseResearch** | `_archived/verseResearch/` | 研究方法论，与架构无关 |

---

## 重写检查清单

重写 Skill 时需确保：

- [ ] 移除所有对 Layer 1-5 的引用
- [ ] 使用 DLSD 四层术语（Data/Logic/Session/Driver）
- [ ] 更新规则引用从 `ARC-xxx` 到 `DLSD-ARC-xxx`
- [ ] 代码示例遵循 DLSD 命名规范
- [ ] 包含来自真实项目的验证案例
- [ ] 通过远程编译验证

---

## 进度追踪

| 日期 | Skill | 操作 | 备注 |
|------|-------|------|------|
| 2026-01-07 | - | 创建清单 | 初始版本 |
