# R00-SceneGraph-Device-Boundary 调研报告索引

> **调研主题**: UEFN Device 不可替代功能分析  
> **调研编号**: R00-2  
> **调研日期**: 2026-01-05

---

## 报告组成

### 主报告

📄 **[README.md](./README.md)** - 完整调研报告

**内容概览**：
- 执行摘要（核心发现速览）
- SceneGraph vs Device 能力对比
- 6 大领域边界分析：
  - UI/HUD/Billboard 系统
  - 音频系统
  - 物理碰撞系统
  - 官方游戏机制
  - VFX 视觉效果
  - 特殊触发事件
- 典型 UseCase 对比
- 迁移建议与最佳实践
- FAQ 常见问题
- 能力矩阵总表

---

### 支持文档

📄 **[MIGRATION-GUIDE.md](./MIGRATION-GUIDE.md)** - 混合架构迁移指南

**内容概览**：
- 从纯 Device 到混合架构
- 从纯 SceneGraph 到混合架构
- 混合架构设计模式（分层通信、功能域隔离、事件总线）
- 常见迁移陷阱及解决方案
- 迁移检查清单

---

📄 **[CODE-EXAMPLES.md](./CODE-EXAMPLES.md)** - 实战代码示例集

**内容概览**：
- UI 系统示例（SceneGraph 自定义血条、Device Billboard）
- 音频系统示例（Device 音频播放、Patchwork 音乐）
- 物理系统示例（SceneGraph 物理控制、Device 碰撞检测）
- 游戏机制示例（Device 计分系统、回合制）
- 完整混合架构模板（包含 SG 逻辑层、Device Bridge 层、UI 控制层）

---

## 快速导航

### 我想了解...

| 问题 | 参考文档 | 章节 |
|------|---------|------|
| **SceneGraph 能做什么？** | README.md | SceneGraph 能力概览 |
| **Device 有哪些？** | README.md | Device 系统能力概览 |
| **UI 用 SG 还是 Device？** | README.md | 4.1 UI/HUD/Billboard 系统 |
| **音频怎么实现？** | README.md | 4.2 音频系统 |
| **物理碰撞怎么做？** | README.md | 4.3 物理碰撞系统 |
| **计分系统用哪个？** | README.md | 4.4 官方游戏机制 |
| **如何迁移到混合架构？** | MIGRATION-GUIDE.md | 全文 |
| **有没有代码示例？** | CODE-EXAMPLES.md | 全文 |
| **SG 和 Device 如何通信？** | MIGRATION-GUIDE.md | 混合架构设计模式 |
| **常见错误有哪些？** | MIGRATION-GUIDE.md | 常见迁移陷阱 |

---

## 核心结论速查

### ✅ SceneGraph 可以做

- 自定义 UI（屏幕空间）
- 游戏逻辑和状态管理
- 组件化设计
- 事件驱动架构
- 物理控制（施力、速度、碰撞检测）
- 基础音频播放（`sound_component`）
- 基础粒子效果（`particle_system_component`）
- 光照效果（`light_component` 系列）

### ❌ SceneGraph 不能做（必须用 Device）

- 官方计分/回合系统 → `score_manager_device`, `round_settings_device`
- 世界空间 UI → `billboard_device`
- 后期处理效果 → `post_process_device`
- 复杂音频系统 → `audio_player_device`, Patchwork 系列

### 🟡 混合使用最佳

- UI: SG 自定义 UI + Device 系统 HUD
- 音频: SG 基础播放 + Device 复杂控制
- VFX: SG 粒子效果 + Device 后期处理
- 碰撞: SG mesh事件 + Device trigger（更简单）
- 游戏机制: SG 自定义逻辑 + Device 官方集成

---

## 推荐阅读顺序

### 新手开发者

1. **README.md** - 执行摘要
2. **README.md** - 4.1 UI 系统、4.2 音频系统
3. **CODE-EXAMPLES.md** - 示例 1-3
4. **README.md** - FAQ

### 有 Device 经验

1. **README.md** - SceneGraph 能力概览
2. **MIGRATION-GUIDE.md** - 从纯 Device 到混合架构
3. **CODE-EXAMPLES.md** - 混合架构模板

### 有 SceneGraph 经验

1. **README.md** - Device 系统能力概览
2. **MIGRATION-GUIDE.md** - 从纯 SceneGraph 到混合架构
3. **README.md** - 领域边界分析（找出 SG 无法实现的功能）

---

## 数据来源

- ✅ Epic Games 官方 API 文档
- ✅ 本仓库 API Digests（Verse/Fortnite/UnrealEngine）
- ✅ 本仓库 SceneGraph 参考文档
- ✅ 本仓库 Device 系统调研（315 个设备）

**API 版本**：
- Verse API: `++Fortnite+Release-39.10-CL-48971054`
- Fortnite API: `++Fortnite+Release-39.11-CL-49242330`

---

## 相关资源

### 本仓库资源

- [SceneGraph API 参考](../../shared/references/scenegraph-api-reference.md)
- [SceneGraph 框架指南](../../shared/references/scenegraph-framework-guide.md)
- [UEFN 设备系统调研](../../shared/references/uefn-device-system-research.md)
- [设备快速参考](../../shared/references/device-quick-reference.md)
- [API Digests](../../shared/api-digests/)

### 官方文档

- [Scene Graph in UEFN](https://dev.epicgames.com/documentation/en-us/fortnite/scene-graph-in-unreal-editor-for-fortnite)
- [Scene Events](https://dev.epicgames.com/documentation/en-us/fortnite/scene-events-in-unreal-editor-for-fortnite)
- [Verse API Reference](https://dev.epicgames.com/documentation/en-us/fortnite/verse-api)
- [UEFN Devices](https://dev.epicgames.com/documentation/en-us/fortnite/devices-in-unreal-editor-for-fortnite)

---

## 版本记录

| 版本 | 日期 | 变更说明 |
|------|------|---------|
| 1.0 | 2026-01-05 | 初始发布，包含主报告、迁移指南、代码示例 |

---

## 反馈与贡献

如有问题或建议，请：
1. 查阅 FAQ（README.md）
2. 查看代码示例（CODE-EXAMPLES.md）
3. 参考迁移指南（MIGRATION-GUIDE.md）
4. 提交 Issue 或 PR

---

**调研总结**：混合架构是当前 UEFN 开发的最佳实践，充分利用 SceneGraph 的可编程性和 Device 的系统级功能。
