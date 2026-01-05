# verseResearch Skill

> **类型**: Research & Investigation  
> **职责**: UEFN/Verse 技术调研、边界探索、最佳实践总结

---

## When to Use This Skill

当需要：

- 调研 UEFN/Verse 新功能或 Beta 特性
- 明确技术边界和能力范围
- 对比不同技术方案的优劣
- 为团队提供技术选型依据
- 总结最佳实践和避坑指南

---

## 核心职责

### 1. 技术边界调研

探索 UEFN/Verse 的能力边界：

- SceneGraph vs Device
- Verse API 覆盖范围
- 官方支持的功能范围
- Beta 功能的成熟度

### 2. 方案对比分析

对比不同技术方案：

- 性能对比
- 开发效率对比
- 维护成本对比
- 学习曲线对比

### 3. 最佳实践总结

基于调研和实践，总结：

- 推荐的架构模式
- 常见问题解决方案
- FAQ 和风险点
- 决策树和选择矩阵

### 4. 持续跟踪

跟踪 UEFN/Verse 的演进：

- 监控官方文档更新
- 跟踪社区讨论
- 记录 API 变更
- 更新调研报告

---

## 调研报告规范

### 报告命名

```text
R[序号]-[主题]-[子主题]/
├── README.md           # 主报告
├── attachments/        # 附件（截图、代码示例等）
└── references.md       # 参考资料索引

```text

**示例**：

- `R00-SceneGraph-Device-Boundary/` - SceneGraph 与 Device 边界调研
- `R01-Verse-Performance-Optimization/` - Verse 性能优化调研
- `R02-UEFN-Publishing-Process/` - UEFN 发布流程调研

### 报告结构

每个调研报告应包含：

```markdown
# [调研主题]

> **报告编号**: Rxx-xxx  
> **创建时间**: YYYY-MM-DD  
> **调研基准**: 版本/时间  
> **状态**: 进行中 🔄 / 已完成 ✅

## 执行摘要

- 调研背景
- 核心结论
- 关键发现

## 详细分析

- 能力清单
- 对比分析
- 示例代码

## 推荐方案

- 典型场景
- 选择决策树
- 最佳实践

## FAQ 与风险点

- 常见问题
- 已知限制
- 风险缓解

## 后续行动

- 需要深入调研的领域
- 拆分子任务
- 时间表

## 参考资源

- 内部文档
- 官方文档
- 社区资源

## 版本历史

- 记录每次更新

```text

---

## 调研方法论

### 1. 信息源分级

| 级别 | 来源 | 可信度 | 使用场景 |
|------|------|--------|----------|
| **L1: 官方文档** | Epic Games 官方文档 | ⭐⭐⭐⭐⭐ | 作为权威依据 |
| **L2: API 定义** | Verse API Digest 文件 | ⭐⭐⭐⭐⭐ | 确认具体能力 |
| **L3: 官方示例** | Epic 提供的示例项目 | ⭐⭐⭐⭐ | 学习最佳实践 |
| **L4: 社区实践** | 论坛、GitHub、博客 | ⭐⭐⭐ | 参考实际经验 |
| **L5: 实验验证** | 自己的测试项目 | ⭐⭐⭐⭐⭐ | 验证假设 |

### 2. 调研流程

```text

1. 明确调研目标
   ↓
2. 收集信息
   ├─ 阅读官方文档
   ├─ 查阅 API Digest
   ├─ 搜索社区资源
   └─ 查看现有项目代码
   ↓
3. 实验验证
   ├─ 创建测试项目
   ├─ 编写验证代码
   └─ 记录实验结果
   ↓
4. 分析总结
   ├─ 整理能力清单
   ├─ 对比优劣
   └─ 提炼最佳实践
   ↓
5. 编写报告
   ├─ 结构化输出
   ├─ 附上代码示例
   └─ 标注信息来源
   ↓
6. 持续更新
   └─ 跟踪技术演进

```text

### 3. 验证标准

每个结论都应有：

- ✅ **引用来源**：官方文档链接或实验记录
- ✅ **示例代码**：可运行的代码片段
- ✅ **适用场景**：明确使用条件
- ✅ **已知限制**：标注边界和风险

---

## 已完成的调研

### R00: SceneGraph 与 Device 边界调研

**状态**: ✅ 初步完成

**核心发现**：

1. SceneGraph 和 Device 可以共存
2. SceneGraph 仍是 Beta，发布前需禁用
3. 推荐混合使用：SG 核心逻辑 + Device 外围功能

**报告位置**: `reports/R00-SceneGraph-Device-Boundary/README.md`

**后续任务**：

- [ ] 性能基准测试
- [ ] 发布流程澄清
- [ ] Device API 完整对照表
- [ ] 混合架构实践案例
- [ ] 可复用组件库

---

## 进行中的调研

*（暂无）*

---

## 计划中的调研

| 序号 | 主题 | 优先级 | 预计开始时间 |
|------|------|--------|--------------|
| R01 | Verse 性能优化最佳实践 | 中 | TBD |
| R02 | UEFN 发布流程完整指南 | 高 | TBD |
| R03 | Multiplayer 多人游戏架构 | 中 | TBD |
| R04 | Verse 调试工具与技巧 | 低 | TBD |

---

## 相关资源

### 共享资源

| 目录 | 内容 |
|------|------|
| `../shared/references/` | SceneGraph、Device 参考文档 |
| `../shared/api-digests/` | Verse/Fortnite/UnrealEngine API |

### 官方资源

- [UEFN 文档](https://dev.epicgames.com/documentation/en-us/fortnite/)
- [Verse API 参考](https://dev.epicgames.com/documentation/en-us/fortnite/verse-api)
- [Epic Developer Forum](https://forums.unrealengine.com/c/fortnite/uefn/)

### 社区资源

- [Awesome Verse](https://github.com/spilth/awesome-verse)
- [UEFN Tools](https://uefntools.com/)

---

## 贡献指南

### 启动新调研

1. 创建报告目录：`reports/Rxx-[Topic]/`
2. 复制报告模板
3. 填写调研目标和计划
4. 开始收集信息

### 更新现有调研

1. 在版本历史中记录变更
2. 更新相关章节
3. 确保引用来源的准确性
4. 通知相关团队成员

### 质量标准

- ✅ 所有结论有可靠来源
- ✅ 代码示例可运行
- ✅ 风险点和限制明确标注
- ✅ 定期更新以反映最新变化

---

*最后更新: 2026-01-05*
