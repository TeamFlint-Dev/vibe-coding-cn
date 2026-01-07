# verseResearch 研究前置检查清单

> **用途**: 启动研究前的检查项，避免重复劳动和低价值研究  
> **使用时机**: 每次准备开始新研究时

---

## ✅ 阶段 1: 研究必要性检查

### 1.1 是否值得研究？

- [ ] **明确价值**：这个研究对实际开发有明确价值
- [ ] **非重复劳动**：已检查是否有现成研究（检查位置见下文）
- [ ] **非低价值主题**：不是已有明确文档的基础内容
- [ ] **非一次性问题**：问题具有普遍性，不是特定项目的特殊情况

**检查现成研究的位置**：

```bash
# 1. 检查 projects/uefnResearch/ 是否已有相关研究
ls projects/uefnResearch/architecture/
ls projects/uefnResearch/design/

# 2. 检查 verseResearch/reports/ 历史报告（参考用）
ls skills/verseDev/verseResearch/reports/

# 3. 检查 verse/library 和 verse/modules 是否已有实现
ls verse/library/
ls verse/modules/

# 4. 搜索相关关键词
grep -r "关键词" projects/uefnResearch/
grep -r "关键词" skills/verseDev/shared/references/
```

---

## ✅ 阶段 2: 研究问题明确性检查

### 2.1 SMART 原则检查

- [ ] **Specific（具体）**：研究问题具体，不是宽泛的主题
  - ❌ 错误示例："研究 SceneGraph"
  - ✅ 正确示例："SceneGraph Component 的继承 vs 组合性能差异"

- [ ] **Measurable（可衡量）**：有明确的验证标准
  - ❌ 错误示例："研究哪个更好"
  - ✅ 正确示例："对比 1000 个 Entity 下的内存和 CPU 开销"

- [ ] **Achievable（可实现）**：在现有条件下可完成
  - [ ] 有 UEFN 编辑器环境
  - [ ] 有远程编译工具（`tools/verseCompiler`）
  - [ ] 研究时间在合理范围（1-5 天）

- [ ] **Relevant（相关）**：与当前项目或技能栈相关
  - [ ] 结论可应用于 verseDev 技能栈
  - [ ] 或对未来项目有参考价值

- [ ] **Time-bound（有时限）**：设定研究时间限制
  - [ ] 预计完成时间：______ （填写日期）
  - [ ] 如超过时间未完成，重新评估研究价值

---

## ✅ 阶段 3: 资料准备检查

### 3.1 关键资料是否可获取？

- [ ] **API Digest 文件**：已确认相关 API 在 Digest 中存在
  - [ ] `skills/verseDev/shared/api-digests/Verse.digest.verse`
  - [ ] `skills/verseDev/shared/api-digests/Fortnite.digest.verse`
  - [ ] `skills/verseDev/shared/api-digests/UnrealEngine.digest.verse`

- [ ] **官方文档**：已找到相关官方文档链接
  - [ ] [UEFN Documentation](https://dev.epicgames.com/documentation/en-us/fortnite)
  - [ ] [Verse Language Reference](https://dev.epicgames.com/documentation/en-us/fortnite/verse-language-reference)
  - [ ] 其他：______（填写链接）

- [ ] **社区资源**（可选）：已搜索社区讨论和最佳实践
  - [ ] [Awesome Verse](https://github.com/spilth/awesome-verse)
  - [ ] GitHub Issues/Discussions
  - [ ] 其他：______（填写链接）

### 3.2 参考框架是否存在？

- [ ] **SceneGraph 框架文档**：`skills/verseDev/shared/references/`
- [ ] **架构检查清单**：`skills/verseDev/shared/checklists/`
- [ ] **已有代码示例**：`verse/library` 或 `verse/modules`

---

## ✅ 阶段 4: 验证环境检查

### 4.1 编译环境

- [ ] **远程编译工具可用**：`tools/verseCompiler/client/compile.ps1`
- [ ] **Git 分支已创建**：验证代码需要 commit 到分支
- [ ] **UEFN 编辑器状态**：确认 Runner 机器上的 UEFN 已打开

### 4.2 测试环境

- [ ] **本地 UEFN 项目**（可选）：可在本地测试运行时行为
- [ ] **测试数据准备**（如适用）：准备边界测试数据

---

## ✅ 阶段 5: 研究计划检查

### 5.1 研究计划是否完整？

- [ ] **研究背景**：为什么需要研究？（1-2 段文字）
- [ ] **研究问题**：具体要回答什么问题？（明确的问题陈述）
- [ ] **研究方法**：如何进行验证？（实验设计）
- [ ] **预期产出**：研究完成后会得到什么？（成果清单）
- [ ] **时间规划**：各阶段的时间分配

### 5.2 实验设计是否合理？

- [ ] **最小化原型**：只测试核心问题，避免无关复杂性
- [ ] **对照实验**：有对比组（如继承 vs 组合）
- [ ] **边界测试**：计划测试边界情况（空值、极大值、极端情况）
- [ ] **可重复性**：实验可由他人重复验证

---

## ✅ 阶段 6: 输出规划检查

### 6.1 研究报告位置

- [ ] **确认存放位置**：`projects/uefnResearch/architecture/` 或 `projects/uefnResearch/design/`
- [ ] **报告命名规范**：`R[编号]-[主题]/` （如 `R03-Component-Performance/`）
- [ ] **文档结构**：准备使用标准研究报告结构（见 verseResearch/SKILL.md）

### 6.2 代码产出规划

- [ ] **验证代码位置**：`verse/library/` 或 `verse/modules/`
- [ ] **模块命名**（如适用）：模块名称和职责已明确
- [ ] **复用性考虑**：考虑代码的通用性和可复用性

---

## 🚨 风险检查

### 高风险项（必须通过）

- [ ] ⚠️ **非猜测性研究**：研究对象有官方文档或可验证（非未发布功能）
- [ ] ⚠️ **非过度推测**：研究方法基于事实验证，非主观推断
- [ ] ⚠️ **非低价值主题**：研究价值已明确，非"研究一下看看"

### 中风险项（建议通过）

- [ ] ⚠️ **时间可控**：研究时间在 5 天内
- [ ] ⚠️ **范围可控**：研究范围明确，不涉及多个不相关子主题
- [ ] ⚠️ **资源充足**：有足够的资料和工具支持

---

## 📋 检查清单总结

### 必须全部通过（阶段 1-2）

如果以下任一项未通过，**停止研究，重新评估**：

- [ ] 研究值得投入时间
- [ ] 没有现成研究可用
- [ ] 研究问题明确且符合 SMART 原则

### 建议通过（阶段 3-6）

如果以下项未完全通过，**补充准备后再开始**：

- [ ] 关键资料已准备
- [ ] 验证环境已就绪
- [ ] 研究计划完整
- [ ] 输出规划明确

---

## 📝 快速自检模板

```markdown
## 研究前自检

### 研究主题
[填写研究主题]

### 研究问题（SMART）
- Specific: [具体问题]
- Measurable: [验证标准]
- Achievable: [可行性]
- Relevant: [相关性]
- Time-bound: [时间限制]

### 现成研究检查
- [ ] projects/uefnResearch/: 未找到相关研究
- [ ] verseResearch/reports/: 未找到相关研究
- [ ] verse/library & modules: 未找到相关实现

### 资料准备
- [ ] API Digest: [相关 API 列表]
- [ ] 官方文档: [文档链接]
- [ ] 社区资源: [资源链接]

### 验证环境
- [ ] 远程编译工具可用
- [ ] Git 分支: [分支名称]

### 预期产出
- [ ] 研究报告: projects/uefnResearch/[路径]
- [ ] 验证代码: verse/[路径]

### 时间规划
- 预计开始: [日期]
- 预计完成: [日期]
- 总时间: [天数]

### 风险评估
- [ ] ✅ 非猜测性研究
- [ ] ✅ 非过度推测
- [ ] ✅ 非低价值主题
- [ ] ✅ 时间可控
- [ ] ✅ 范围可控
```

---

## 🔗 相关文档

- [verseResearch/SKILL.md](SKILL.md) - 研究方法论
- [verseResearch/CAPABILITY-BOUNDARIES.md](CAPABILITY-BOUNDARIES.md) - 能力边界
- [verseResearch/FAILURE-CASES.md](FAILURE-CASES.md) - 常见失败案例
- [projects/uefnResearch/README.md](../../../projects/uefnResearch/README.md) - 研究项目说明

---

*最后更新: 2026-01-06*  
*清单版本: 2.0.0*
