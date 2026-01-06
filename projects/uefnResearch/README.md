# UEFN 基础研究项目

## 愿景

建立 UEFN/Verse 开发的技术储备库，通过系统化研究基础模块和底层机制，为游戏项目提供可靠的技术支撑。

## 研究范围

本项目专注于 UEFN/Verse 的基础技术研究，包括但不限于：

- **曲线系统**：曲线构造、表达、采样与应用
- **伪随机系统**：随机数生成、分布控制、概率管理
- **数学工具库**：向量运算、几何计算、数值方法
- **数据结构**：高效的游戏数据组织方式
- **性能优化**：Verse 代码性能最佳实践
- **架构模式**：可复用的代码架构和设计模式

## 研究方法

1. **理论调研**：查阅官方文档、API 定义、社区最佳实践
2. **原型验证**：编写最小化原型验证技术可行性
3. **模块沉淀**：将验证通过的代码整理到 `verse/library/` 或 `verse/modules/`
4. **文档输出**：记录研究过程、决策依据、使用指南

## 与其他项目的关系

```
uefnResearch (技术研究)
    ↓
verse/library & verse/modules (代码库)
    ↓
trophyFishing & 其他游戏项目 (应用层)
```

**uefnResearch** 是技术源头，为代码库提供经过验证的实现，代码库再被游戏项目复用。

## 目标平台

- UEFN (Unreal Editor for Fortnite)
- Verse 编程语言

## 开发状态

- [x] 项目初始化
- [ ] 研究主题定义
- [ ] 第一个研究模块完成
- [ ] 代码库集成验证

## 目录结构

- `design/` - 研究设计文档（研究方向、主题列表）
- `architecture/` - 技术架构文档（技术栈、架构决策）
- `progress/` - 进度与日志（当前状态、研究记录）

## 相关技能

- [verseResearch](../../skills/verseDev/verseResearch/) - Verse 技术研究技能
- [verseProjectInit](../../skills/verseDev/verseProjectInit/) - 项目初始化
- [verseArchitectureSelector](../../skills/verseDev/verseArchitectureSelector/) - 架构选型

## 参考资料

- Verse 代码库：[verse/](../../verse/)
- Verse 开发技能：[skills/verseDev/](../../skills/verseDev/)
- UEFN 官方文档：通过 verseDigestSync 获取

---

*项目创建时间：2026-01-06*
