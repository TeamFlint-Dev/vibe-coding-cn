# UEFN 官方游戏模板库

本目录包含 Epic Games 官方提供的 31 个 UEFN 游戏模板，已通过 Git LFS 管理。

## 📊 总览

- **模板数量**: 31 个
- **Verse 代码文件**: 174 个
- **美术资源文件**: 3,216 个 .uasset 文件
- **总大小**: 2.03 GB（通过 Git LFS 管理）

## 📦 包含的模板

| 模板名称 | Verse 文件 | 资源数 | 说明 |
|---------|-----------|--------|------|
| **AlphaTycoon** | 35 | 307 | 大富翁类游戏模板 |
| **AnimationTemplate** | 1 | 45 | 动画系统示例 |
| **BuildYourFirstIsland** | 1 | 2 | 入门教程项目 |
| **CharacterCameraAndNPC** | 1 | 55 | 角色相机与 NPC 系统 |
| **DesertedDominationTemplate** | 6 | 30 | 据点占领玩法 |
| **EquipFurnitureProps** | 0 | 2 | 家具道具装备系统 |
| **FXTemplate** | 0 | 33 | 特效系统示例 |
| **GreyBoxing101** | 0 | 79 | 关卡原型设计 |
| **Gunfight** | 5 | 10 | 枪战玩法模板 |
| **InIslandTransactions** | 17 | 147 | 岛内交易系统 |
| **IntroToUEFN** | 0 | 16 | UEFN 介绍项目 |
| **LandscapeTemplate** | 0 | 27 | 地形系统示例 |
| **LightingTemplate** | 0 | 120 | 光照系统示例 |
| **MaterialTemplate** | 0 | 197 | 材质系统示例 |
| **ModelingTemplate** | 0 | 87 | 建模工具示例 |
| **PropHuntTemplate** | 8 | 20 | 躲猫猫玩法 |
| **SceneGraphTemplate** | 6 | 67 | Scene Graph API 示例 |
| **SpeedwayRacewithPersistence** | 12 | 20 | 赛车+持久化数据 |
| **StandUpComedyClubTemplate** | 1 | 78 | 脱口秀俱乐部场景 |
| **StrongholdTemplate** | 7 | 31 | 堡垒防守玩法 |
| **TalismanEnvironmentTemplate** | 2 | 286 | Talisman 环境资源 |
| **TalismanMetaHumanTemplate** | 1 | 306 | MetaHuman 角色示例 |
| **TimeOfDayTemplate** | 0 | 18 | 昼夜循环系统 |
| **TriadInfiltration** | 4 | 3 | 潜入玩法示例 |
| **UserInterfaceTemplate** | 10 | 891 | UI 系统完整示例 |
| **VerseDetonationTemplate** | 1 | 6 | Verse 爆破玩法 |
| **VerseDeviceTemplate** | 8 | 187 | Verse 设备系统 |
| **VerseEliminationTemplate** | 1 | 6 | Verse 淘汰赛玩法 |
| **VerseParkourTemplate** | 1 | 38 | Verse 跑酷玩法 |
| **VerseProceduralBuilding** | 43 | 34 | 程序化建筑生成 |
| **VillageStarterTemplate** | 3 | 68 | 村庄场景启动模板 |

## 🎯 重点推荐

### Verse 代码学习（按代码量排序）

1. **VerseProceduralBuilding** (43 文件) - 程序化建筑生成
2. **AlphaTycoon** (35 文件) - 完整的大富翁游戏逻辑
3. **InIslandTransactions** (17 文件) - 岛内交易系统
4. **SpeedwayRacewithPersistence** (12 文件) - 数据持久化示例
5. **UserInterfaceTemplate** (10 文件) - UI 编程完整示例

### 美术资源学习

1. **UserInterfaceTemplate** (891 资源) - UI 组件库
2. **AlphaTycoon** (307 资源) - 游戏场景资源
3. **TalismanMetaHumanTemplate** (306 资源) - 高质量角色
4. **TalismanEnvironmentTemplate** (286 资源) - 环境美术
5. **MaterialTemplate** (197 资源) - 材质系统

## 📂 目录结构

每个模板包含：
```
TemplateName/
├── Content/                    # 内容目录
│   ├── *.verse                # Verse 代码文件
│   ├── *.uasset               # 美术资源（通过 Git LFS）
│   ├── *.umap                 # 地图文件（通过 Git LFS）
│   └── ...                    # 其他资源文件
├── TemplateName.uefnproject   # UEFN 项目配置
└── TemplateName.uplugin       # 插件配置
```

## ⚠️ 注意事项

### 已排除的内容

为了减少仓库大小，导入时排除了：
- `__ExternalActors__/` - 外部 Actor 数据（减少 ~81,000 文件）
- `__ExternalObjects__/` - 外部对象数据
- 总计减少 ~725 MB

这些文件夹包含的是关卡中放置的 Actor 实例数据，对于学习代码和资源结构不是必需的。

### Git LFS 配置

所有 `.uasset` 和 `.umap` 文件通过 Git LFS 管理，配置见 [.gitattributes](../../.gitattributes)：

```gitattributes
external/gameTemplates/**/*.uasset filter=lfs diff=lfs merge=lfs -text
external/gameTemplates/**/*.umap filter=lfs diff=lfs merge=lfs -text
```

**首次克隆仓库后需要执行**：
```bash
git lfs pull
```

## 🔧 本地完整模板

如果需要包含 `__ExternalActors__` 和 `__ExternalObjects__` 的完整项目，请参考本地路径：
```
E:\GameTemplate\[TemplateName]\
```

## 📚 使用指南

### 查找 Verse 代码示例

```bash
# 查找所有 Verse 文件
find external/gameTemplates -name "*.verse"

# 搜索特定功能的代码
grep -r "function" external/gameTemplates/**/*.verse
```

### 在 UEFN 中打开

1. 复制模板到你的工作目录
2. 用 UEFN 打开 `.uefnproject` 文件
3. 如需完整 Actor 数据，从 `E:\GameTemplate` 复制对应的 `__ExternalActors__` 文件夹

## 🔄 更新

本模板库从 Epic Games 官方模板导入，导入脚本见：
- [tools/Import-GameTemplates.ps1](../../tools/Import-GameTemplates.ps1)

如需更新到最新版本：
```powershell
.\tools\Import-GameTemplates.ps1
```

## 📖 相关文档

- UEFN 官方文档: https://dev.epicgames.com/documentation/en-us/uefn
- Verse 语言参考: https://dev.epicgames.com/documentation/en-us/uefn/verse-language-reference
- 本仓库 Verse 开发指南: [skills/verseDev/](../../skills/verseDev/)

---

**最后更新**: 2026-01-15  
**来源**: E:\GameTemplate (Epic Games Official Templates)
