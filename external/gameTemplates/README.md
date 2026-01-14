# UEFN 官方游戏模板库（仅代码）

本目录包含 Epic Games 官方提供的 31 个 UEFN 游戏模板的 **Verse 源代码**。

> ⚠️ **仅包含代码**：美术资源（.uasset, .umap）已移除以保持仓库轻量。每个模板的 `Content/ASSETS.md` 文件说明了如何获取完整资源。

## 📊 总览

- **模板数量**: 31 个
- **Verse 代码文件**: 174 个
- **总大小**: ~900 KB（仅代码）

## 📦 包含的模板

| 模板名称 | Verse 文件 | 说明 |
|---------|-----------|------|
| **AlphaTycoon** | 35 | 大富翁类游戏模板 |
| **AnimationTemplate** | 1 | 动画系统示例 |
| **BuildYourFirstIsland** | 1 | 入门教程项目 |
| **CharacterCameraAndNPC** | 1 | 角色相机与 NPC 系统 |
| **DesertedDominationTemplate** | 6 | 据点占领玩法 |
| **EquipFurnitureProps** | 0 | 家具道具装备系统 |
| **FXTemplate** | 0 | 特效系统示例 |
| **GreyBoxing101** | 0 | 关卡原型设计 |
| **Gunfight** | 5 | 枪战玩法模板 |
| **InIslandTransactions** | 17 | 岛内交易系统 |
| **IntroToUEFN** | 0 | UEFN 介绍项目 |
| **LandscapeTemplate** | 0 | 地形系统示例 |
| **LightingTemplate** | 0 | 光照系统示例 |
| **MaterialTemplate** | 0 | 材质系统示例 |
| **ModelingTemplate** | 0 | 建模工具示例 |
| **PropHuntTemplate** | 8 | 躲猫猫玩法 |
| **SceneGraphTemplate** | 6 | Scene Graph API 示例 |
| **SpeedwayRacewithPersistence** | 12 | 赛车+持久化数据 |
| **StandUpComedyClubTemplate** | 1 | 脱口秀俱乐部场景 |
| **StrongholdTemplate** | 7 | 堡垒防守玩法 |
| **TalismanEnvironmentTemplate** | 2 | Talisman 环境资源 |
| **TalismanMetaHumanTemplate** | 1 | MetaHuman 角色示例 |
| **TimeOfDayTemplate** | 0 | 昼夜循环系统 |
| **TriadInfiltration** | 4 | 潜入玩法示例 |
| **UserInterfaceTemplate** | 10 | UI 系统完整示例 |
| **VerseDetonationTemplate** | 1 | Verse 爆破玩法 |
| **VerseDeviceTemplate** | 8 | Verse 设备系统 |
| **VerseEliminationTemplate** | 1 | Verse 淘汰赛玩法 |
| **VerseParkourTemplate** | 1 | Verse 跑酷玩法 |
| **VerseProceduralBuilding** | 43 | 程序化建筑生成 |
| **VillageStarterTemplate** | 3 | 村庄场景启动模板 |

## 🎯 重点推荐（按代码量排序）

1. **VerseProceduralBuilding** (43 文件) - 程序化建筑生成
2. **AlphaTycoon** (35 文件) - 完整的大富翁游戏逻辑
3. **InIslandTransactions** (17 文件) - 岛内交易系统
4. **SpeedwayRacewithPersistence** (12 文件) - 数据持久化示例
5. **UserInterfaceTemplate** (10 文件) - UI 编程完整示例

## 📂 目录结构

每个模板包含：
```
TemplateName/
├── Content/
│   ├── *.verse                # Verse 源代码（可直接阅读）
│   └── ASSETS.md              # 美术资源获取说明（占位文件）
├── TemplateName.uefnproject   # UEFN 项目配置
└── TemplateName.uplugin       # 插件配置
```

## 🔧 获取完整美术资源

### 方法 1: 本地路径
如果你有本地模板副本：
```
E:\GameTemplate\[TemplateName]\
```

### 方法 2: 从 UEFN 获取
1. 打开 UEFN
2. 创建新项目，选择对应模板
3. 资源将自动包含在项目中

## 📚 使用指南

### 查找 Verse 代码示例

```powershell
# 查找所有 Verse 文件
Get-ChildItem -Path external/gameTemplates -Filter "*.verse" -Recurse

# 搜索特定功能的代码
Select-String -Path "external/gameTemplates/**/*.verse" -Pattern "function"
```

## 📖 相关文档

- UEFN 官方文档: https://dev.epicgames.com/documentation/en-us/uefn
- Verse 语言参考: https://dev.epicgames.com/documentation/en-us/uefn/verse-language-reference
- 本仓库 Verse 开发指南: [skills/verseDev/](../../skills/verseDev/)

---

**最后更新**: 2026-01-15
**来源**: E:\GameTemplate (Epic Games Official Templates)
