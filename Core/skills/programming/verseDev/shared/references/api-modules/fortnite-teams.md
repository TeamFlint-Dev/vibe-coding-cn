# Fortnite.com/Teams API 模块完整参考

> **文档类型**：API 参考文档  
> **模块路径**：`/Fortnite.com/Teams`  
> **目标平台**：UEFN (Unreal Editor for Fortnite)  
> **最后更新**：2026-01-04

---

## 文档说明

本文档详细介绍 UEFN 的 Teams 模块，用于管理游戏中的团队系统、玩家/Agent 分组、以及团队间的态度关系。

**重要提示**：

- ✅ 所有 API 均来自 Epic Games 官方 Verse API Digest
- ✅ 代码示例基于最佳实践和实际应用场景
- ⚠️ 该模块是 UEFN 核心功能，在多人游戏中必不可少

---

## 目录

1. [模块概述](#模块概述)
2. [核心类/接口清单](#核心类接口清单)
3. [关键 API 详解](#关键-api-详解)
4. [代码示例](#代码示例)
5. [常见误区澄清](#常见误区澄清)
6. [最佳实践](#最佳实践)
7. [参考资源](#参考资源)

---

## 模块概述

### 模块用途

`/Fortnite.com/Teams` 模块提供了完整的团队管理系统，用于：

- **团队创建与管理**：管理游戏中的所有团队
- **成员分配**：将玩家和 AI Agent 分配到不同团队
- **关系管理**：定义团队间的友好/中立/敌对关系
- **查询功能**：查询 Agent 所属团队、团队成员等信息

### 设计理念

Teams 模块采用集合管理模式（Collection Pattern），核心思想是：

1. **集中管理**：所有团队通过 `fort_team_collection` 统一管理
2. **关系明确**：使用 `team_attitude` 枚举明确定义团队关系
3. **类型安全**：利用 Verse 的 `<decides>` 机制确保操作安全性
4. **空间隔离**：每个 `fort_playspace` 拥有独立的团队集合

### 适用场景

- ✅ **PvP 游戏**：对抗模式、团队竞技
- ✅ **PvE 游戏**：玩家对抗 AI
- ✅ **合作游戏**：多人协作任务
- ✅ **混合模式**：玩家分组、AI 友军/敌军
- ✅ **社交游戏**：基于团队的社交互动

---

## 核心类/接口清单

### 接口（Interfaces）

| 接口名称 | 类型 | 功能描述 |
|---------|------|---------|
| `fort_team_collection` | `interface<epic_internal>` | 团队集合管理器，管理所有团队和成员 |

### 枚举（Enums）

| 枚举名称 | 类型 | 功能描述 |
|---------|------|---------|
| `team_attitude` | `enum` | 定义团队间关系：友好/中立/敌对 |

### 依赖模块

```verse
using {/Verse.org/Simulation}
```

- `agent`：玩家或 AI 的抽象表示
- `team`：团队对象（来自 Simulation 模块）

### 功能分类

#### 1. 团队管理类

- `GetTeams()`：获取所有团队

#### 2. 成员管理类

- `AddToTeam()`：添加成员到团队
- `IsOnTeam()`：检查成员是否在团队
- `GetAgents()`：获取团队所有成员
- `GetTeam()`：获取成员所在团队

#### 3. 关系管理类

- `GetTeamAttitude(team, team)`：获取团队间关系
- `GetTeamAttitude(agent, agent)`：获取成员间关系

---

## 关键 API 详解

### fort_team_collection 接口

#### 获取团队集合

**方法**：从 `fort_playspace` 获取

```verse
(Playspace:fort_playspace).GetTeamCollection<native><public>():fort_team_collection
```

**说明**：

- 每个 `fort_playspace` 都有独立的团队集合
- 这是访问 Teams 模块的入口点
- 该方法在 `/Fortnite.com/Playspaces` 模块中定义

---

### 1. GetTeams()

**功能**：获取所有已知团队列表

**签名**：

```verse
GetTeams<public>()<transacts>:[]team
```

**参数**：无

**返回值**：

- **类型**：`[]team`
- **说明**：所有在此团队集合中注册的团队数组

**使用场景**：

- 遍历所有团队进行批量操作
- 统计当前游戏中的团队数量
- 初始化团队相关 UI

**代码示例**：

```verse
PrintAllTeams(TeamCollection:fort_team_collection):void =
    AllTeams := TeamCollection.GetTeams()
    
    Print("总团队数: {AllTeams.Length}")
    for (Team : AllTeams, Index := 0..):
        Print("团队 {Index}: {Team}")
```

**注意事项**：

- ⚠️ 返回的数组顺序不保证固定
- ✅ 包含所有已创建的团队，无论是否有成员

---

### 2. AddToTeam()

**功能**：将 Agent（玩家或 AI）添加到指定团队

**签名**：

```verse
AddToTeam<public>(InAgent:agent, InTeam:team)<transacts><decides>:void
```

**参数**：

- `InAgent`：要添加的 Agent（玩家或 AI）
- `InTeam`：目标团队

**返回值**：

- **类型**：`void`
- **失败条件**：`InTeam` 不在该团队集合中时失败

**使用场景**：

- 游戏开始时分配玩家到团队
- 动态改变玩家所属团队
- 将 AI 加入特定阵营

**代码示例**：

```verse
AssignPlayerToTeam(Player:player, Team:team, TeamCollection:fort_team_collection):void =
    PlayerAgent := agent[Player]
    
    if (TeamCollection.AddToTeam[PlayerAgent, Team]):
        Print("玩家成功加入团队")
    else:
        Print("添加失败：团队不存在")
```

**注意事项**：

- ⚠️ 如果 Agent 已在另一个团队，会自动移除旧团队（隐式移除）
- ✅ 使用 `<decides>` 处理团队不存在的情况
- 🔍 一个 Agent 同时只能属于一个团队

---

### 3. IsOnTeam()

**功能**：检查 Agent 是否在指定团队中

**签名**：

```verse
IsOnTeam<public>(InAgent:agent, InTeam:team)<transacts><decides>:void
```

**参数**：

- `InAgent`：要检查的 Agent
- `InTeam`：目标团队

**返回值**：

- **类型**：`void`
- **成功**：Agent 在该团队中
- **失败**：Agent 不在该团队或团队不存在

**使用场景**：

- 验证玩家是否可以访问团队专属区域
- 条件触发器（仅特定团队触发）
- 团队匹配验证

**代码示例**：

```verse
CheckTeamAccess(Player:player, AllowedTeam:team, TeamCollection:fort_team_collection)<decides>:void =
    PlayerAgent := agent[Player]
    
    # 使用 IsOnTeam 的 <decides> 特性
    TeamCollection.IsOnTeam[PlayerAgent, AllowedTeam]
    
    # 如果执行到这里，说明验证成功
    Print("访问权限验证通过")
```

**注意事项**：

- ✅ 利用 `<decides>` 机制简化条件判断
- ⚠️ 团队不存在时也会失败
- 🎯 最适合用于权限验证逻辑

---

### 4. GetAgents()

**功能**：获取指定团队的所有成员

**签名**：

```verse
GetAgents<public>(InTeam:team)<transacts><decides>:[]agent
```

**参数**：

- `InTeam`：目标团队

**返回值**：

- **类型**：`[]agent`
- **说明**：该团队的所有成员数组
- **失败条件**：团队不在集合中

**使用场景**：

- 遍历团队成员执行操作
- 统计团队人数
- 团队消息广播

**代码示例**：

```verse
CountTeamMembers(Team:team, TeamCollection:fort_team_collection):int =
    if (Members := TeamCollection.GetAgents[Team]):
        return Members.Length
    else:
        return 0

BroadcastToTeam(Team:team, Message:string, TeamCollection:fort_team_collection):void =
    if (Members := TeamCollection.GetAgents[Team]):
        for (Member : Members):
            if (Player := player[Member]):
                # 发送消息给玩家
                Print("{Player.GetDisplayName()} 收到: {Message}")
```

**注意事项**：

- ⚠️ 返回的是 `agent` 数组，需要转换为 `player` 或其他类型
- ✅ 包含玩家和 AI 两种 Agent
- 🔍 空团队返回空数组（不会失败）

---

### 5. GetTeam()

**功能**：查询 Agent 所属的团队

**签名**：

```verse
GetTeam<public>(InAgent:agent)<transacts><decides>:team
```

**参数**：

- `InAgent`：要查询的 Agent

**返回值**：

- **类型**：`team`
- **说明**：Agent 所在的团队
- **失败条件**：Agent 不在任何团队中

**使用场景**：

- 获取玩家当前团队
- 基于团队的逻辑判断
- 团队切换前的状态保存

**代码示例**：

```verse
GetPlayerTeamName(Player:player, TeamCollection:fort_team_collection):string =
    PlayerAgent := agent[Player]
    
    if (Team := TeamCollection.GetTeam[PlayerAgent]):
        return "{Team}"
    else:
        return "无团队"

SwitchTeam(Player:player, NewTeam:team, TeamCollection:fort_team_collection):void =
    PlayerAgent := agent[Player]
    
    # 获取旧团队
    if (OldTeam := TeamCollection.GetTeam[PlayerAgent]):
        Print("从 {OldTeam} 切换到 {NewTeam}")
    
    # 添加到新团队（自动离开旧团队）
    TeamCollection.AddToTeam[PlayerAgent, NewTeam]
```

**注意事项**：

- ⚠️ Agent 必须已分配团队，否则失败
- ✅ 使用 `if` 语句处理未分配团队的情况
- 🔍 新加入游戏的玩家默认没有团队

---

### 6. GetTeamAttitude (团队间)

**功能**：获取两个团队之间的关系态度

**签名**：

```verse
GetTeamAttitude<public>(Team1:team, Team2:team)<transacts><decides>:team_attitude
```

**参数**：

- `Team1`：第一个团队
- `Team2`：第二个团队

**返回值**：

- **类型**：`team_attitude`
- **说明**：两个团队之间的关系
- **失败条件**：任一团队不在集合中

**使用场景**：

- 判断是否允许友军伤害
- 设置 AI 攻击目标优先级
- 决定资源是否共享

**代码示例**：

```verse
CanTeamsShareResources(Team1:team, Team2:team, TeamCollection:fort_team_collection):logic =
    if (Attitude := TeamCollection.GetTeamAttitude[Team1, Team2]):
        # 只有友好关系才能共享资源
        return Attitude = team_attitude.Friendly
    else:
        return false

DetermineAIBehavior(AITeam:team, TargetTeam:team, TeamCollection:fort_team_collection):void =
    if (Attitude := TeamCollection.GetTeamAttitude[AITeam, TargetTeam]):
        if (Attitude = team_attitude.Hostile):
            Print("AI 应攻击目标团队")
        else if (Attitude = team_attitude.Friendly):
            Print("AI 应协助目标团队")
        else:
            Print("AI 保持中立")
```

**注意事项**：

- ✅ 同一团队与自身的关系总是 `Friendly`
- ⚠️ 团队关系由游戏模式预设，无法在运行时修改
- 🔍 默认团队关系由 UEFN 的团队设置决定

---

### 7. GetTeamAttitude (Agent 间)

**功能**：获取两个 Agent 之间的关系态度

**签名**：

```verse
GetTeamAttitude<public>(Agent1:agent, Agent2:agent)<transacts><decides>:team_attitude
```

**参数**：

- `Agent1`：第一个 Agent
- `Agent2`：第二个 Agent

**返回值**：

- **类型**：`team_attitude`
- **说明**：两个 Agent 之间的关系（基于所属团队）
- **失败条件**：任一 Agent 不在任何团队中

**使用场景**：

- 判断玩家能否互相伤害
- AI 选择攻击或协助目标
- 交互系统权限判断

**代码示例**：

```verse
CanDamage(Attacker:player, Target:player, TeamCollection:fort_team_collection):logic =
    AttackerAgent := agent[Attacker]
    TargetAgent := agent[Target]
    
    if (Attitude := TeamCollection.GetTeamAttitude[AttackerAgent, TargetAgent]):
        # 只能伤害敌对关系的目标
        return Attitude = team_attitude.Hostile
    else:
        # 未分配团队时允许伤害
        return true

SelectAITarget(AI:agent, PotentialTargets:[]agent, TeamCollection:fort_team_collection):?agent =
    for (Target : PotentialTargets):
        if (Attitude := TeamCollection.GetTeamAttitude[AI, Target]):
            if (Attitude = team_attitude.Hostile):
                return option{Target}
    
    return false
```

**注意事项**：

- ✅ 自动基于 Agent 所属团队计算关系
- ⚠️ Agent 未分配团队时调用会失败
- 🔍 比团队间查询更常用，因为直接处理游戏实体

---

### team_attitude 枚举

**功能**：定义团队或 Agent 之间的关系类型

**枚举值**：

```verse
team_attitude<native><public> := enum:
    Friendly  # 友好
    Neutral   # 中立
    Hostile   # 敌对
```

#### Friendly（友好）

- **含义**：同队友军关系
- **典型行为**：
  - 不能互相伤害（需配置游戏规则）
  - 共享资源和信息
  - AI 协助而非攻击
- **适用场景**：
  - 同队玩家
  - 友军 NPC
  - 合作任务伙伴

#### Neutral（中立）

- **含义**：无明确关系
- **典型行为**：
  - 通常不会主动攻击
  - 不共享资源
  - AI 保持观望
- **适用场景**：
  - 野生动物
  - 中立 NPC
  - 可交互但不属于任何阵营的物体

#### Hostile（敌对）

- **含义**：敌对关系
- **典型行为**：
  - 可以互相伤害
  - 竞争资源
  - AI 主动攻击
- **适用场景**：
  - 对立团队玩家
  - 敌方 AI
  - PvP 竞技模式

**代码示例**：

```verse
DescribeRelationship(Attitude:team_attitude):string =
    case (Attitude):
        team_attitude.Friendly => "友军"
        team_attitude.Neutral => "中立"
        team_attitude.Hostile => "敌对"
```

---

## 代码示例

### 示例 1：游戏开始时的团队初始化

**场景**：在游戏开始时将所有玩家分配到红蓝两队

```verse
using { /Fortnite.com/Playspaces }
using { /Fortnite.com/Teams }
using { /Verse.org/Simulation }

team_initializer := class(creative_device):
    
    @editable
    var RedTeam:team = DefaultTeam
    
    @editable
    var BlueTeam:team = DefaultTeam
    
    OnBegin<override>()<suspends>:void =
        # 获取团队集合
        TeamCollection := GetPlayspace().GetTeamCollection()
        
        # 获取所有玩家
        AllPlayers := GetPlayspace().GetPlayers()
        
        # 交替分配到红蓝队
        for (Player : AllPlayers, Index := 0..):
            PlayerAgent := agent[Player]
            
            TargetTeam := if (Mod[Index, 2] = 0) then RedTeam else BlueTeam
            
            if (TeamCollection.AddToTeam[PlayerAgent, TargetTeam]):
                Print("{Player.GetDisplayName()} 加入 {TargetTeam}")
            else:
                Print("分配失败")
```

**要点**：

- 使用 `@editable` 在 UEFN 中配置团队
- 通过索引实现交替分配
- 处理分配失败情况

---

### 示例 2：基于团队的安全区域

**场景**：创建只有特定团队才能进入的区域

```verse
using { /Fortnite.com/Teams }
using { /Verse.org/Simulation }

team_safe_zone := class(creative_device):
    
    @editable
    var AllowedTeam:team = DefaultTeam
    
    @editable
    var ZoneTrigger:trigger_device = trigger_device{}
    
    OnBegin<override>()<suspends>:void =
        ZoneTrigger.TriggeredEvent.Subscribe(OnPlayerEnterZone)
    
    OnPlayerEnterZone(Agent:?agent):void =
        if:
            PlayerAgent := Agent?
            Player := player[PlayerAgent]
            TeamCollection := GetPlayspace().GetTeamCollection()
        then:
            # 检查玩家团队
            if (TeamCollection.IsOnTeam[PlayerAgent, AllowedTeam]):
                Print("{Player.GetDisplayName()} 进入安全区")
            else:
                # 不是允许的团队，传送出去
                Print("{Player.GetDisplayName()} 无权进入")
                # TeleportPlayer(Player, ExitLocation)
```

**要点**：

- 利用 `IsOnTeam` 的 `<decides>` 特性简化验证
- 结合触发器实现权限控制
- 可扩展为复杂的团队专属逻辑

---

### 示例 3：团队统计 UI

**场景**：实时显示各团队人数和关系

```verse
using { /Fortnite.com/Teams }
using { /Verse.org/Simulation }

team_stats_display := class(creative_device):
    
    OnBegin<override>()<suspends>:void =
        # 每 5 秒更新一次统计
        loop:
            UpdateTeamStats()
            Sleep(5.0)
    
    UpdateTeamStats():void =
        TeamCollection := GetPlayspace().GetTeamCollection()
        AllTeams := TeamCollection.GetTeams()
        
        Print("========== 团队统计 ==========")
        
        for (Team : AllTeams, Index := 0..):
            if (Members := TeamCollection.GetAgents[Team]):
                Print("团队 {Index + 1}: {Members.Length} 名成员")
                
                # 统计玩家和 AI
                PlayerCount := 0
                for (Member : Members):
                    if (player[Member]):
                        set PlayerCount = PlayerCount + 1
                
                AICount := Members.Length - PlayerCount
                Print("  └─ 玩家: {PlayerCount}, AI: {AICount}")
        
        Print("================================")
    
    # 显示团队关系矩阵
    ShowTeamRelations():void =
        TeamCollection := GetPlayspace().GetTeamCollection()
        AllTeams := TeamCollection.GetTeams()
        
        Print("团队关系矩阵:")
        for (Team1 : AllTeams, I := 0..):
            for (Team2 : AllTeams, J := 0..):
                if (Attitude := TeamCollection.GetTeamAttitude[Team1, Team2]):
                    RelationSymbol := case (Attitude):
                        team_attitude.Friendly => "🟢"
                        team_attitude.Neutral => "🟡"
                        team_attitude.Hostile => "🔴"
                    
                    Print("[{I},{J}] {RelationSymbol}")
```

**要点**：

- 使用循环定时更新
- 区分玩家和 AI 的统计
- 可视化团队关系矩阵

---

### 示例 4：AI 目标选择系统

**场景**：AI 根据团队关系选择攻击或协助目标

```verse
using { /Fortnite.com/AI }
using { /Fortnite.com/Teams }
using { /Verse.org/Simulation }

ai_team_behavior := class(creative_device):
    
    SelectTarget(AI:agent, PotentialTargets:[]agent):?agent =
        TeamCollection := GetPlayspace().GetTeamCollection()
        
        # 优先攻击敌对目标
        for (Target : PotentialTargets):
            if (Attitude := TeamCollection.GetTeamAttitude[AI, Target]):
                if (Attitude = team_attitude.Hostile):
                    return option{Target}
        
        return false
    
    ShouldAssist(AI:agent, Target:agent):logic =
        TeamCollection := GetPlayspace().GetTeamCollection()
        
        if (Attitude := TeamCollection.GetTeamAttitude[AI, Target]):
            return Attitude = team_attitude.Friendly
        else:
            return false
    
    GetAIBehavior(AI:agent, NearbyAgent:agent):string =
        TeamCollection := GetPlayspace().GetTeamCollection()
        
        if (Attitude := TeamCollection.GetTeamAttitude[AI, NearbyAgent]):
            case (Attitude):
                team_attitude.Friendly => "协助"
                team_attitude.Neutral => "忽略"
                team_attitude.Hostile => "攻击"
        else:
            return "观察"
```

**要点**：

- 基于团队关系的智能决策
- 可扩展为复杂的 AI 行为树
- 适用于 PvE 和混合模式

---

### 示例 5：动态团队切换系统

**场景**：玩家可以在游戏中切换团队（如换边功能）

```verse
using { /Fortnite.com/Teams }
using { /Verse.org/Simulation }

team_switcher := class(creative_device):
    
    @editable
    var Team1:team = DefaultTeam
    
    @editable
    var Team2:team = DefaultTeam
    
    @editable
    var SwitchButton:button_device = button_device{}
    
    OnBegin<override>()<suspends>:void =
        SwitchButton.InteractedWithEvent.Subscribe(OnPlayerInteract)
    
    OnPlayerInteract(Agent:agent):void =
        if:
            Player := player[Agent]
            TeamCollection := GetPlayspace().GetTeamCollection()
        then:
            # 获取当前团队
            if (CurrentTeam := TeamCollection.GetTeam[Agent]):
                # 切换到另一个团队
                NewTeam := if (CurrentTeam = Team1) then Team2 else Team1
                
                if (TeamCollection.AddToTeam[Agent, NewTeam]):
                    Print("{Player.GetDisplayName()} 从 {CurrentTeam} 切换到 {NewTeam}")
                else:
                    Print("切换失败")
            else:
                # 未分配团队，默认加入 Team1
                TeamCollection.AddToTeam[Agent, Team1]
                Print("{Player.GetDisplayName()} 加入 {Team1}")
```

**要点**：

- 通过 `AddToTeam` 自动处理旧团队移除
- 处理未分配团队的特殊情况
- 可扩展为冷却时间、条件限制等

---

## 常见误区澄清

### 误区 1：认为需要手动创建团队

**❌ 错误认知**：

```verse
# 错误：试图创建新团队
MyTeam := CreateTeam("红队")  # 不存在这种 API
```

**✅ 正确理解**：

- 团队必须在 UEFN 编辑器中预先创建
- 在设备属性中通过 `@editable` 引用团队
- 运行时无法动态创建新团队

**正确做法**：

```verse
team_manager := class(creative_device):
    @editable
    var RedTeam:team = DefaultTeam  # 在 UEFN 中配置
    
    OnBegin<override>()<suspends>:void =
        # 使用预设的团队
        TeamCollection := GetPlayspace().GetTeamCollection()
        # ...
```

---

### 误区 2：认为 Agent 可以同时属于多个团队

**❌ 错误认知**：

```verse
# 错误：试图让玩家同时加入多个团队
TeamCollection.AddToTeam[PlayerAgent, Team1]
TeamCollection.AddToTeam[PlayerAgent, Team2]  # 会覆盖 Team1
```

**✅ 正确理解**：

- 一个 Agent 同时只能属于一个团队
- `AddToTeam` 会隐式从旧团队移除
- 如需多重关系，需要自定义系统

**正确做法**：

```verse
# 如果需要切换团队
if (OldTeam := TeamCollection.GetTeam[PlayerAgent]):
    Print("自动离开旧团队: {OldTeam}")

TeamCollection.AddToTeam[PlayerAgent, NewTeam]
```

---

### 误区 3：混淆团队关系和游戏规则

**❌ 错误认知**：

- "设置为 Friendly 就自动禁止友军伤害"
- "Hostile 关系会让 AI 自动攻击"

**✅ 正确理解**：

- `team_attitude` 仅表示逻辑关系
- 具体行为需要游戏代码实现
- 友军伤害、AI 行为需要手动编写逻辑

**正确做法**：

```verse
# 需要手动实现友军伤害判断
OnPlayerDamage(Attacker:player, Victim:player):void =
    AttackerAgent := agent[Attacker]
    VictimAgent := agent[Victim]
    TeamCollection := GetPlayspace().GetTeamCollection()
    
    if (Attitude := TeamCollection.GetTeamAttitude[AttackerAgent, VictimAgent]):
        if (Attitude = team_attitude.Friendly):
            # 阻止友军伤害
            CancelDamage()
```

---

### 误区 4：忽略 `<decides>` 失败情况

**❌ 错误认知**：

```verse
# 危险：未处理失败情况
Team := TeamCollection.GetTeam[Agent]  # 如果 Agent 无团队会导致代码中断
```

**✅ 正确理解**：

- 所有标记 `<decides>` 的方法都可能失败
- 未处理会导致代码执行中断
- 必须使用 `if` 或 `for` 处理失败

**正确做法**：

```verse
# 方法 1：使用 if 语句
if (Team := TeamCollection.GetTeam[Agent]):
    Print("所属团队: {Team}")
else:
    Print("未分配团队")

# 方法 2：使用 for 循环（更简洁）
for (Team := TeamCollection.GetTeam[Agent]):
    Print("所属团队: {Team}")
```

---

### 误区 5：在错误的 Playspace 中操作

**❌ 错误认知**：

```verse
# 错误：使用错误的 playspace
GlobalTeamCollection := GetPlayspace().GetTeamCollection()

# 在另一个 playspace 的逻辑中使用
OtherPlayspaceLogic(GlobalTeamCollection)  # 可能导致错误
```

**✅ 正确理解**：

- 每个 `fort_playspace` 有独立的团队集合
- 不同 playspace 的团队不互通
- 必须在正确的上下文中获取团队集合

**正确做法**：

```verse
HandlePlayerInPlayspace(Player:player, Playspace:fort_playspace):void =
    # 从当前 playspace 获取团队集合
    LocalTeamCollection := Playspace.GetTeamCollection()
    
    PlayerAgent := agent[Player]
    if (Team := LocalTeamCollection.GetTeam[PlayerAgent]):
        Print("在此 playspace 的团队: {Team}")
```

---

## 最佳实践

### 1. 团队初始化模式

**推荐做法**：在游戏开始时集中处理团队分配

```verse
team_setup := class(creative_device):
    
    @editable
    var Teams:[]team = array{}
    
    OnBegin<override>()<suspends>:void =
        # 等待所有玩家加载
        Sleep(1.0)
        
        # 统一分配团队
        AssignPlayersToTeams()
    
    AssignPlayersToTeams():void =
        if (Teams.Length > 0):
            Playspace := GetPlayspace()
            TeamCollection := Playspace.GetTeamCollection()
            AllPlayers := Playspace.GetPlayers()
            
            for (Player : AllPlayers, Index := 0..):
                TeamIndex := Mod[Index, Teams.Length]
                Team := Teams[TeamIndex]
                PlayerAgent := agent[Player]
                
                TeamCollection.AddToTeam[PlayerAgent, Team]
```

**优点**：

- 集中管理，易于调试
- 支持任意数量团队
- 均衡分配

---

### 2. 团队权限验证模式

**推荐做法**：创建可复用的权限检查函数

```verse
team_utilities := class:
    
    # 检查玩家是否有团队权限
    HasTeamAccess<public>(Player:player, AllowedTeam:team, Playspace:fort_playspace):logic =
        TeamCollection := Playspace.GetTeamCollection()
        PlayerAgent := agent[Player]
        
        if (TeamCollection.IsOnTeam[PlayerAgent, AllowedTeam]):
            return true
        else:
            return false
    
    # 检查玩家是否在指定的任一团队中
    IsInAnyTeam<public>(Player:player, AllowedTeams:[]team, Playspace:fort_playspace):logic =
        TeamCollection := Playspace.GetTeamCollection()
        PlayerAgent := agent[Player]
        
        for (Team : AllowedTeams):
            if (TeamCollection.IsOnTeam[PlayerAgent, Team]):
                return true
        
        return false
```

**优点**：

- 代码复用
- 统一验证逻辑
- 易于维护

---

### 3. 团队事件通知模式

**推荐做法**：实现团队级别的事件系统

```verse
team_event_system := class(creative_device):
    
    # 向整个团队广播消息
    BroadcastToTeam(Team:team, Message:string):void =
        TeamCollection := GetPlayspace().GetTeamCollection()
        
        if (Members := TeamCollection.GetAgents[Team]):
            for (Member : Members):
                if (Player := player[Member]):
                    # 发送消息给玩家
                    ShowMessageToPlayer(Player, Message)
    
    # 触发团队事件（如团队得分）
    TriggerTeamEvent(Team:team, EventType:string):void =
        BroadcastToTeam(Team, "团队事件: {EventType}")
        
        # 可以扩展为其他逻辑
        # - 更新 UI
        # - 播放音效
        # - 触发特效
    
    ShowMessageToPlayer(Player:player, Message:string):void =
        # 实现消息显示逻辑
        Print("[{Player.GetDisplayName()}] {Message}")
```

**优点**：

- 团队级别的通信
- 支持群组操作
- 可扩展性强

---

### 4. 性能优化模式

**推荐做法**：缓存团队集合和常用数据

```verse
optimized_team_manager := class(creative_device):
    
    var TeamCollection:fort_team_collection = DefaultTeamCollection
    var CachedTeams:[]team = array{}
    var LastUpdateTime:float = 0.0
    
    OnBegin<override>()<suspends>:void =
        # 初始化缓存
        TeamCollection = GetPlayspace().GetTeamCollection()
        RefreshTeamCache()
    
    RefreshTeamCache():void =
        set CachedTeams = TeamCollection.GetTeams()
        # 记录更新时间（如果需要定期刷新）
        # set LastUpdateTime = GetGameTimeElapsed()
    
    # 使用缓存的团队列表
    PerformTeamOperation():void =
        for (Team : CachedTeams):
            # 使用缓存，避免重复调用 GetTeams()
            ProcessTeam(Team)
    
    ProcessTeam(Team:team):void =
        if (Members := TeamCollection.GetAgents[Team]):
            Print("团队成员数: {Members.Length}")
```

**优点**：

- 减少重复 API 调用
- 提升性能
- 适合频繁查询场景

---

### 5. 团队平衡检查模式

**推荐做法**：实时监控团队人数并自动平衡

```verse
team_balancer := class(creative_device):
    
    @editable
    var Teams:[]team = array{}
    
    @editable
    var MaxImbalance:int = 2  # 允许的最大人数差
    
    CheckAndBalance()<suspends>:void =
        loop:
            Sleep(10.0)  # 每 10 秒检查一次
            
            if (NeedsBalancing[]):
                BalanceTeams()
    
    NeedsBalancing():logic =
        TeamCollection := GetPlayspace().GetTeamCollection()
        TeamSizes:[]int = array{}
        
        for (Team : Teams):
            if (Members := TeamCollection.GetAgents[Team]):
                set TeamSizes = TeamSizes + array{Members.Length}
        
        if (TeamSizes.Length > 0):
            MaxSize := GetMax(TeamSizes)
            MinSize := GetMin(TeamSizes)
            
            return (MaxSize - MinSize) > MaxImbalance
        
        return false
    
    BalanceTeams():void =
        # 实现平衡逻辑
        Print("执行团队平衡...")
    
    GetMax(Numbers:[]int):int =
        if (Numbers.Length > 0):
            Max:= Numbers[0]
            for (Number : Numbers):
                if (Number > Max):
                    set Max = Number
            return Max
        return 0
    
    GetMin(Numbers:[]int):int =
        if (Numbers.Length > 0):
            Min := Numbers[0]
            for (Number : Numbers):
                if (Number < Min):
                    set Min = Number
            return Min
        return 0
```

**优点**：

- 自动维护游戏公平性
- 可配置的平衡策略
- 适合竞技游戏

---

### 6. 团队状态追踪模式

**推荐做法**：维护团队状态的完整记录

```verse
team_state_tracker := class(creative_device):
    
    var TeamStates:[]tuple(team, int, float) = array{}  # (Team, Score, LastUpdateTime)
    
    TrackTeamState(Team:team, Score:int):void =
        CurrentTime := 0.0  # GetGameTimeElapsed()
        NewState := (Team, Score, CurrentTime)
        
        # 更新或添加状态
        UpdateTeamState(NewState)
    
    UpdateTeamState(NewState:tuple(team, int, float)):void =
        TargetTeam := NewState(0)
        
        # 查找并更新现有状态
        for (State : TeamStates, Index := 0..):
            if (State(0) = TargetTeam):
                # 找到了，更新
                # set TeamStates[Index] = NewState
                return
        
        # 没找到，添加新状态
        set TeamStates = TeamStates + array{NewState}
    
    GetTeamScore(Team:team):int =
        for (State : TeamStates):
            if (State(0) = Team):
                return State(1)
        
        return 0
```

**优点**：

- 集中状态管理
- 支持历史记录
- 便于数据分析

---

## 参考资源

### 官方文档

- **Verse API Digest** - `Core/skills/programming/verseDev/shared/api-digests/Fortnite.digest.verse.md`
  - Teams 模块位于第 12104-12151 行

### 相关 API 模块

- **`/Fortnite.com/Playspaces`** - 提供 `GetTeamCollection()` 方法
  - 参考：`api-modules-list.md`
- **`/Verse.org/Simulation`** - 提供 `agent` 和 `team` 类型
  - 参考：`Verse.digest.verse.md`

### 相关概念文档

- **API 模块能力调研报告** - `Core/skills/programming/verseDev/shared/references/api-modules-research.md`
- **API 模块清单** - `Core/skills/programming/verseDev/shared/references/api-modules-list.md`

### 最佳实践参考

- **SceneGraph 框架指南** - `scenegraph-framework-guide.md`
  - 虽然针对 SceneGraph，但架构思想可借鉴
- **Verse 失败机制** - `verse-failure-mechanisms.md`
  - 理解 `<decides>` 机制的最佳参考

---

## 附录：快速参考表

### API 方法速查

| 方法 | 用途 | 返回类型 | 可能失败 |
|------|------|---------|---------|
| `GetTeams()` | 获取所有团队 | `[]team` | ❌ |
| `AddToTeam()` | 添加成员到团队 | `void` | ✅ |
| `IsOnTeam()` | 检查成员是否在团队 | `void` | ✅ |
| `GetAgents()` | 获取团队成员 | `[]agent` | ✅ |
| `GetTeam()` | 获取成员所属团队 | `team` | ✅ |
| `GetTeamAttitude(team, team)` | 获取团队关系 | `team_attitude` | ✅ |
| `GetTeamAttitude(agent, agent)` | 获取成员关系 | `team_attitude` | ✅ |

### 团队关系速查

| 关系类型 | 枚举值 | 典型行为 |
|---------|--------|---------|
| 友好 | `team_attitude.Friendly` | 同队、协作、不能伤害 |
| 中立 | `team_attitude.Neutral` | 无关系、不攻击、不协作 |
| 敌对 | `team_attitude.Hostile` | 对立、竞争、可伤害 |

### 常用模式速查

| 模式 | 代码片段 |
|------|---------|
| 获取团队集合 | `TeamCollection := GetPlayspace().GetTeamCollection()` |
| Agent 转换 | `PlayerAgent := agent[Player]` |
| 检查团队 | `TeamCollection.IsOnTeam[Agent, Team]` |
| 获取团队 | `if (Team := TeamCollection.GetTeam[Agent]) then ...` |
| 遍历成员 | `if (Members := TeamCollection.GetAgents[Team]) then for (M : Members) ...` |

---

**文档版本**：v1.0  
**生成日期**：2026-01-04  
**维护者**：UEFN/Verse Development Team
