# UnrealEngine.com/WebAPI 模块深度调研报告

## 1. 模块概述

### 1.1 模块用途

`/UnrealEngine.com/WebAPI` 模块提供了 Verse 语言中与外部 Web 服务进行 HTTP 通信的能力。该模块允许 UEFN 开发者在 Fortnite Creative 游戏中发起 HTTP GET 请求，从外部后端服务获取数据，实现游戏内容与外部系统的集成。

### 1.2 设计理念

WebAPI 模块采用**基于客户端标识的安全架构**设计：

- **安全隔离**: 通过 `client_id` 类的派生机制，确保每个客户端拥有独立的身份标识
- **类型安全**: 利用 Verse 的类型系统，在编译时进行类型检查，防止错误的 API 调用
- **异步优先**: 所有网络请求均为异步操作（`<suspends>` 效果），避免阻塞游戏主线程
- **最小化接口**: 当前仅提供 GET 请求，保持 API 简洁，降低使用复杂度

### 1.3 适用场景

该模块适用于以下 Web API 集成场景：

| 场景类型 | 具体应用 | 使用示例 |
|---------|---------|---------|
| **数据获取** | 从外部服务器获取游戏配置、排行榜数据 | 实时获取比赛排名 |
| **内容更新** | 动态加载游戏内容、活动信息 | 加载每日任务列表 |
| **玩家数据** | 查询玩家统计、成就信息 | 显示玩家历史战绩 |
| **第三方集成** | 与外部系统（如数据库、CMS）交互 | 从 CMS 获取新闻内容 |

**重要限制**: 该模块仅支持**持有授权许可的用户**使用，需要在后端服务中配置相应的端点映射。

---

## 2. 核心类/接口清单

WebAPI 模块包含 **4 个核心类** 和 **1 个工厂函数**，按功能分类如下：

### 2.1 身份标识类

#### client_id

**类型**: 抽象基类（需派生使用）

**用途**: 作为客户端身份的唯一标识符，派生类的 Verse 类路径将被用作后端服务的配置键

**完整签名**:

```verse
client_id<native><public> := class<abstract><computes>
```

**关键特性**:
- `<abstract>`: 不能直接实例化，必须创建派生类
- `<computes>`: 无副作用的计算效果
- 无数据成员和方法

---

### 2.2 客户端通信类

#### client

**类型**: 最终类（不可继承）

**用途**: 实际执行 HTTP 请求的客户端对象

**完整签名**:

```verse
client<native><public> := class<final><computes><internal>
```

**方法列表**:

| 方法名 | 签名 | 说明 |
|-------|------|------|
| `Get` | `Get<public><native>(Path:[]char)<transacts><suspends><no_rollback>:response` | 发起 HTTP GET 请求 |

**关键特性**:
- `<final>`: 密封类，不可被继承
- `<internal>`: 内部实现，由 `MakeClient` 工厂函数创建
- 包含异步网络通信逻辑

---

### 2.3 响应处理类

#### response

**类型**: 基础响应类

**用途**: 表示 HTTP 响应的抽象基类

**完整签名**:

```verse
response<native><public> := class<internal>
```

**关键特性**:
- 无数据成员和方法（作为多态基类）
- 由 `client.Get` 方法返回

#### body_response

**类型**: 带响应体的响应类（继承自 `response`）

**用途**: 表示包含响应体的 HTTP 响应

**完整签名**:

```verse
body_response<native><public> := class<internal>(response)
```

**方法列表**:

| 方法名 | 签名 | 说明 |
|-------|------|------|
| `GetBody` | `GetBody<public><native>()<computes>:[]char` | 获取响应体的文本内容 |

**继承关系**:

```
response (基类)
    └── body_response (派生类)
```

---

### 2.4 工厂函数

#### MakeClient

**类型**: 公共工厂函数

**用途**: 根据 `client_id` 创建 `client` 实例

**完整签名**:

```verse
MakeClient<native><public>(ClientId:client_id)<converges>:client
```

**参数**:
- `ClientId`: 派生的客户端标识类实例

**返回值**:
- `client`: 配置好的客户端实例

**关键特性**:
- `<converges>`: 保证函数会完成执行（无无限循环风险）

---

## 3. 关键 API 详解

### 3.1 MakeClient 函数

**功能**: 创建配置好的 HTTP 客户端实例

**方法签名**:

```verse
MakeClient<native><public>(ClientId:client_id)<converges>:client
```

**参数说明**:

| 参数名 | 类型 | 必需 | 说明 |
|-------|------|------|------|
| `ClientId` | `client_id` | 是 | 派生的客户端标识类实例，用于后端服务端点映射 |

**返回值**:
- **类型**: `client`
- **含义**: 已配置的 HTTP 客户端对象，可用于发起 GET 请求

**使用限制**:
- `ClientId` 必须是 `client_id` 的派生类实例
- 派生类的 Verse 类路径需在后端服务中预先配置

**注意事项**:
- 该函数不会抛出异常，始终返回有效的 `client` 实例
- 实际的端点映射由后端服务控制，前端无法验证配置是否正确

---

### 3.2 client.Get 方法

**功能**: 发起异步 HTTP GET 请求

**方法签名**:

```verse
Get<public><native>(Path:[]char)<transacts><suspends><no_rollback>:response
```

**参数说明**:

| 参数名 | 类型 | 必需 | 说明 |
|-------|------|------|------|
| `Path` | `[]char` (字符串) | 是 | 请求路径，相对于后端配置的基础 URL |

**返回值**:
- **类型**: `response`（可能是 `body_response` 的实例）
- **含义**: HTTP 响应对象，包含响应数据

**效果说明**:

| 效果 | 含义 | 影响 |
|------|------|------|
| `<transacts>` | 可回滚事务 | 允许在失败上下文中使用 |
| `<suspends>` | 异步挂起 | 函数会暂停等待网络响应，不阻塞主线程 |
| `<no_rollback>` | 不可撤销 | 一旦执行无法撤销（网络请求已发出） |

**使用限制**:
- 仅支持 GET 方法，不支持 POST、PUT、DELETE 等
- `Path` 参数不能包含查询参数（需在后端处理）
- 请求超时时间由底层实现控制，无法在 Verse 层面配置

**注意事项**:
- 必须在 `async` 上下文中调用（因为有 `<suspends>` 效果）
- 网络请求可能失败（超时、连接错误等），需要适当的错误处理
- 返回的 `response` 对象需要类型转换为 `body_response` 才能获取响应体

---

### 3.3 body_response.GetBody 方法

**功能**: 获取 HTTP 响应的文本内容

**方法签名**:

```verse
GetBody<public><native>()<computes>:[]char
```

**参数说明**:
- 该方法不接受任何参数

**返回值**:
- **类型**: `[]char` (字符串)
- **含义**: HTTP 响应体的完整文本内容

**效果说明**:

| 效果 | 含义 | 影响 |
|------|------|------|
| `<computes>` | 纯计算函数 | 无副作用，相同输入产生相同输出 |

**使用限制**:
- 必须在 `body_response` 实例上调用
- 仅返回文本内容，二进制数据需要额外处理
- 响应体大小受底层实现限制（过大可能导致性能问题）

**注意事项**:
- 返回的字符串可能需要进一步解析（如 JSON）
- 如果响应体为空，返回空字符串 `""`
- 该方法是同步的，不会引起额外的网络请求

---

## 4. 代码示例

### 4.1 基础 GET 请求示例

**场景**: 从服务器获取简单的文本数据

```verse
using { /UnrealEngine.com/WebAPI }
using { /Verse.org/Simulation }

# 步骤 1: 定义私有的客户端标识类
# 注意: 使用 <internal> 而非 <public>，保护客户端密钥
my_game_client_id<internal> := class<final><computes>(client_id)

# 步骤 2: 创建客户端实例
MyGameClient<internal> : client = MakeClient(my_game_client_id{})

# 步骤 3: 异步获取数据的函数
FetchServerMessage<public>()<suspends>:void =
    # 发起 GET 请求（Path 为相对路径）
    Response := MyGameClient.Get("/api/message")
    
    # 将基类 response 转换为 body_response
    if (BodyResponse := body_response[Response]):
        # 获取响应体文本
        MessageText := BodyResponse.GetBody()
        Print("服务器消息: {MessageText}")
    else:
        Print("响应不包含内容")
```

**关键要点**:
- `my_game_client_id` 使用 `<internal>` 修饰符，避免暴露客户端密钥
- `MakeClient` 使用结构体字面量 `{}` 创建 `client_id` 实例
- 使用类型转换 `body_response[Response]` 判断响应是否包含内容
- 所有网络操作在异步上下文中执行

---

### 4.2 获取 JSON 数据并解析

**场景**: 从服务器获取 JSON 格式的玩家数据

```verse
using { /UnrealEngine.com/WebAPI }
using { /UnrealEngine.com/JSON }
using { /Verse.org/Simulation }

# 定义客户端标识
player_data_client_id<internal> := class<final><computes>(client_id)
PlayerDataClient<internal> : client = MakeClient(player_data_client_id{})

# 玩家数据结构（示例）
player_stats := struct:
    Name : string
    Score : int
    Level : int

# 获取并解析玩家数据
FetchPlayerStats<public>(PlayerID:string)<suspends>:?player_stats =
    # 构建请求路径
    RequestPath := "/api/players/{PlayerID}/stats"
    
    # 发起请求
    Response := PlayerDataClient.Get(RequestPath)
    
    # 检查响应
    if (BodyResponse := body_response[Response]):
        # 获取 JSON 字符串
        JsonText := BodyResponse.GetBody()
        
        # 解析 JSON（需要使用 JSON 模块的功能）
        # 注意: 这里展示概念，实际 JSON 解析需参考 UnrealEngine.com/JSON 模块
        Print("收到 JSON 数据: {JsonText}")
        
        # TODO: 使用 JSON 模块解析为 player_stats 结构
        # 返回解析后的数据或失败（?player_stats 表示可选类型）
        return false  # 示例中返回失败
    else:
        Print("无法获取玩家数据")
        return false
```

**关键要点**:
- 路径中可以包含动态参数（如 `{PlayerID}`），通过字符串拼接实现
- JSON 解析需要配合 `/UnrealEngine.com/JSON` 模块使用
- 使用 `?player_stats` 可选类型表示可能失败的操作
- 实际项目中需要完善错误处理和 JSON 解析逻辑

---

### 4.3 带错误处理的请求示例

**场景**: 健壮的网络请求，包含超时和错误处理

```verse
using { /UnrealEngine.com/WebAPI }
using { /Verse.org/Simulation }
using { /Verse.org/Concurrency }

# 定义客户端
api_client_id<internal> := class<final><computes>(client_id)
APIClient<internal> : client = MakeClient(api_client_id{})

# 带超时和重试的请求函数
FetchWithRetry<public>(Path:string, MaxRetries:int)<suspends>:?string =
    var Attempts : int = 0
    
    loop:
        set Attempts += 1
        Print("尝试第 {Attempts} 次请求...")
        
        # 使用 race 实现超时控制（概念示例）
        # 注意: 实际超时处理需要使用 Verse 的并发原语
        Response := APIClient.Get(Path)
        
        if (BodyResponse := body_response[Response]):
            ResponseText := BodyResponse.GetBody()
            
            # 检查响应是否有效（非空）
            if (ResponseText.Length > 0):
                Print("请求成功！")
                return option{ResponseText}
            else:
                Print("响应为空")
        
        # 判断是否继续重试
        if (Attempts >= MaxRetries):
            Print("达到最大重试次数，请求失败")
            break
        
        # 等待后重试（简化示例，实际需要 Sleep 函数）
        Print("等待后重试...")
    
    return false  # 所有重试均失败

# 使用示例
TestFetch<public>()<suspends>:void =
    if (Result := FetchWithRetry("/api/config", 3)):
        Print("获取到配置: {Result}")
    else:
        Print("无法获取配置")
```

**关键要点**:
- 使用 `loop` 和 `break` 实现重试逻辑
- 检查响应体长度判断数据有效性
- 使用 `?string` 可选类型明确表示可能失败
- 实际项目中需要添加延迟和更精细的错误分类

---

### 4.4 多个客户端并发请求

**场景**: 同时从多个端点获取数据

```verse
using { /UnrealEngine.com/WebAPI }
using { /Verse.org/Simulation }
using { /Verse.org/Concurrency }

# 定义多个客户端
config_client_id<internal> := class<final><computes>(client_id)
leaderboard_client_id<internal> := class<final><computes>(client_id)

ConfigClient<internal> : client = MakeClient(config_client_id{})
LeaderboardClient<internal> : client = MakeClient(leaderboard_client_id{})

# 并发获取多个数据源
FetchGameData<public>()<suspends>:void =
    # 并发启动两个请求
    # 使用 sync 等待所有任务完成（概念示例）
    sync:
        # 任务 1: 获取配置
        block:
            ConfigResponse := ConfigClient.Get("/api/config")
            if (BodyResponse := body_response[ConfigResponse]):
                ConfigData := BodyResponse.GetBody()
                Print("配置数据: {ConfigData}")
        
        # 任务 2: 获取排行榜
        block:
            LeaderboardResponse := LeaderboardClient.Get("/api/leaderboard/top10")
            if (BodyResponse := body_response[LeaderboardResponse]):
                LeaderboardData := BodyResponse.GetBody()
                Print("排行榜数据: {LeaderboardData}")
    
    Print("所有数据加载完成")
```

**关键要点**:
- 使用不同的 `client_id` 派生类管理多个后端端点
- 通过 `sync` 和 `block` 实现并发请求（提高性能）
- 每个客户端可以独立配置不同的后端服务
- 并发请求需要注意资源竞争和同步问题

---

### 4.5 游戏中实际应用示例

**场景**: 在游戏开始时加载每日挑战数据

```verse
using { /UnrealEngine.com/WebAPI }
using { /Fortnite.com/Game }
using { /Verse.org/Simulation }

# 每日挑战客户端
daily_challenge_client_id<internal> := class<final><computes>(client_id)
DailyChallengeClient<internal> : client = MakeClient(daily_challenge_client_id{})

# 游戏管理器设备
game_manager_device := class<concrete>(creative_device):
    
    # 游戏开始时调用
    OnBegin<override>()<suspends>:void =
        Print("游戏开始，加载每日挑战...")
        LoadDailyChallenges()
    
    # 加载每日挑战
    LoadDailyChallenges<private>()<suspends>:void =
        # 获取今日日期（简化示例）
        Today := "2026-01-04"
        
        # 请求每日挑战数据
        Response := DailyChallengeClient.Get("/api/challenges/daily?date={Today}")
        
        if (BodyResponse := body_response[Response]):
            ChallengeData := BodyResponse.GetBody()
            
            # 解析并应用挑战配置（实际需要 JSON 解析）
            Print("今日挑战: {ChallengeData}")
            
            # TODO: 解析 JSON 并配置游戏规则
            ApplyChallengeRules(ChallengeData)
        else:
            Print("无法加载每日挑战，使用默认配置")
            UseDefaultChallenges()
    
    # 应用挑战规则（占位函数）
    ApplyChallengeRules<private>(Data:string):void =
        Print("应用挑战规则...")
    
    # 使用默认挑战（占位函数）
    UseDefaultChallenges<private>():void =
        Print("使用默认挑战配置")
```

**关键要点**:
- 在 `creative_device` 的 `OnBegin` 生命周期中发起请求
- 异步加载不会阻塞游戏启动
- 提供降级方案（默认配置）处理网络失败情况
- 将网络逻辑封装在私有方法中，保持代码组织清晰

---

## 5. 常见误区澄清

### 5.1 误区：WebAPI 可以发送 POST/PUT/DELETE 请求

**错误理解**: 认为 WebAPI 模块支持完整的 RESTful API 操作。

**正确理解**: 
- **当前版本仅支持 HTTP GET 请求**
- `client` 类只提供 `Get` 方法，没有 `Post`、`Put`、`Delete` 等方法
- 需要修改数据的操作应在后端服务中通过 GET 请求触发（不符合 REST 规范但可行）

**推荐做法**:
- 将写操作设计为触发器：`GET /api/trigger/action?id=123`
- 或者等待 Epic 未来可能添加的 POST 支持

---

### 5.2 误区：client_id 应该设为 public 方便重用

**错误理解**: 将 `client_id` 派生类设为 `<public>`，认为这样可以在多个模块中共享。

**正确理解**:
- **client_id 派生类必须使用 `<internal>` 或更严格的访问控制**
- Verse 类路径作为后端服务的配置键，**相当于私钥**
- 公开 `client_id` 会暴露后端端点映射，可能导致安全问题

**官方警告**:
> WARNING: do not make your derived `client_id` class public. This object type is your private key to your backend.

**推荐做法**:
```verse
# ✅ 正确：使用 internal
my_client_id<internal> := class<final><computes>(client_id)

# ❌ 错误：使用 public
# my_client_id<public> := class<final><computes>(client_id)
```

---

### 5.3 误区：Get 方法的 Path 参数可以是完整 URL

**错误理解**: 认为可以直接传入 `https://example.com/api/data` 作为 `Path` 参数。

**正确理解**:
- `Path` 参数是**相对路径**，不应包含协议和域名
- 实际的基础 URL 由后端服务根据 `client_id` 的类路径配置
- 前端无法控制请求的目标服务器

**示例对比**:
```verse
# ✅ 正确：相对路径
Response := MyClient.Get("/api/users/123")

# ❌ 错误：完整 URL（会导致不可预期的行为）
# Response := MyClient.Get("https://api.example.com/users/123")
```

---

### 5.4 误区：response 和 body_response 是相同类型

**错误理解**: 直接在 `response` 对象上调用 `GetBody()` 方法。

**正确理解**:
- `response` 是基类，**没有 `GetBody` 方法**
- `body_response` 是派生类，继承自 `response` 并添加了 `GetBody` 方法
- 需要进行类型转换才能访问 `GetBody`

**示例对比**:
```verse
Response := MyClient.Get("/api/data")

# ❌ 错误：直接调用（编译错误）
# Body := Response.GetBody()

# ✅ 正确：先类型转换
if (BodyResponse := body_response[Response]):
    Body := BodyResponse.GetBody()
```

---

### 5.5 误区：WebAPI 请求是同步阻塞的

**错误理解**: 认为 `Get` 方法会阻塞游戏主线程直到响应返回。

**正确理解**:
- `Get` 方法具有 `<suspends>` 效果，是**异步非阻塞**的
- 调用 `Get` 时，当前协程会挂起，但不影响其他游戏逻辑
- 必须在 `<suspends>` 上下文（如 `OnBegin`）中调用

**影响**:
```verse
# ✅ 正确：在 suspends 上下文中
OnBegin<override>()<suspends>:void =
    Response := MyClient.Get("/api/data")  # 异步等待，不阻塞主线程
    # ...

# ❌ 错误：在非 suspends 上下文中（编译错误）
# SomeFunction():void =
#     Response := MyClient.Get("/api/data")  # 编译失败！
```

---

## 6. 最佳实践

### 6.1 推荐的使用模式

#### 模式 1：单例客户端模式

**适用场景**: 整个游戏只需要访问一个后端服务

```verse
# 在模块级定义全局客户端
my_api_client_id<internal> := class<final><computes>(client_id)
GlobalAPIClient<internal> : client = MakeClient(my_api_client_id{})

# 在各个设备中复用
my_device := class(creative_device):
    FetchData<private>()<suspends>:void =
        Response := GlobalAPIClient.Get("/api/data")
        # ...
```

**优点**:
- 避免重复创建客户端
- 集中管理 API 配置
- 降低内存开销

---

#### 模式 2：工厂模式封装

**适用场景**: 需要统一处理错误、日志、重试逻辑

```verse
# API 工具模块
api_util := module:
    # 内部客户端
    util_client_id<internal> := class<final><computes>(client_id)
    UtilClient<internal> : client = MakeClient(util_client_id{})
    
    # 封装的 GET 方法
    SafeGet<public>(Path:string)<suspends>:?string =
        Response := UtilClient.Get(Path)
        
        if (BodyResponse := body_response[Response]):
            Body := BodyResponse.GetBody()
            
            # 统一日志
            Print("[API] GET {Path} -> 成功 ({Body.Length} 字符)")
            
            return option{Body}
        else:
            # 统一错误处理
            Print("[API] GET {Path} -> 失败")
            return false

# 使用示例
MyDevice := class(creative_device):
    LoadConfig<private>()<suspends>:void =
        if (Config := api_util.SafeGet("/api/config")):
            # 使用配置
            ApplyConfig(Config)
```

**优点**:
- 统一的错误处理和日志
- 隐藏底层实现细节
- 易于添加中间件逻辑（如缓存）

---

#### 模式 3：响应缓存模式

**适用场景**: 频繁请求但数据变化不频繁的场景

```verse
# 简单缓存实现（概念示例）
cached_api := class:
    var Cache : [string]string = map{}  # 路径 -> 响应体
    
    api_client_id<internal> := class<final><computes>(client_id)
    APIClient<internal> : client = MakeClient(api_client_id{})
    
    # 带缓存的 GET
    GetWithCache<public>(Path:string, UseCache:logic)<suspends>:?string =
        # 检查缓存
        if (UseCache):
            if (CachedValue := Cache[Path]):
                Print("[缓存命中] {Path}")
                return option{CachedValue}
        
        # 发起请求
        Response := APIClient.Get(Path)
        
        if (BodyResponse := body_response[Response]):
            Body := BodyResponse.GetBody()
            
            # 更新缓存
            set Cache = Cache[Path] -> Body
            
            return option{Body}
        
        return false
```

**优点**:
- 减少不必要的网络请求
- 提高响应速度
- 降低后端负载

**注意**: 需要合理设置缓存过期策略

---

### 6.2 性能优化建议

#### 优化 1：延迟加载非关键数据

**原则**: 不要在游戏启动时一次性加载所有数据

```verse
game_manager := class(creative_device):
    OnBegin<override>()<suspends>:void =
        # ✅ 仅加载关键数据
        LoadEssentialConfig()
    
    OnPlayerJoin(Player:player):void =
        # ✅ 玩家加入时再加载个人数据
        spawn{LoadPlayerData(Player)}
    
    LoadEssentialConfig<private>()<suspends>:void =
        # 游戏规则等关键配置
        pass
    
    LoadPlayerData<private>(Player:player)<suspends>:void =
        # 玩家统计、成就等非关键数据
        pass
```

---

#### 优化 2：并发请求提高吞吐量

**原则**: 独立的数据源应并发获取

```verse
LoadAllData<private>()<suspends>:void =
    sync:
        # 同时发起多个请求
        block:
            LoadConfig()
        block:
            LoadLeaderboard()
        block:
            LoadEvents()
    
    # 所有数据加载完成后继续
    Print("数据加载完成")
```

---

#### 优化 3：批量请求减少往返次数

**原则**: 设计后端 API 支持批量查询

```verse
# ❌ 低效：循环发起多个请求
for (PlayerID : PlayerIDs):
    Response := APIClient.Get("/api/player/{PlayerID}")
    # ...

# ✅ 高效：一次请求获取多个玩家数据
PlayerIDsParam := Join(PlayerIDs, ",")  # "1,2,3,4,5"
Response := APIClient.Get("/api/players?ids={PlayerIDsParam}")
# 返回: [{"id":1,...}, {"id":2,...}, ...]
```

---

### 6.3 与其他模块的配合使用

#### 配合 UnrealEngine.com/JSON 模块

**用途**: 解析 JSON 格式的 API 响应

```verse
using { /UnrealEngine.com/WebAPI }
using { /UnrealEngine.com/JSON }

ParseJsonResponse<private>(JsonText:string):?map{string, string} =
    # 使用 JSON 模块解析（示例，具体 API 需参考 JSON 模块文档）
    # TODO: 调用 JSON 模块的解析函数
    # ParsedData := JSON.Parse(JsonText)
    # return ParsedData
    return false
```

---

#### 配合 Verse.org/Simulation 模块

**用途**: 在游戏模拟中使用 WebAPI 数据

```verse
using { /UnrealEngine.com/WebAPI }
using { /Verse.org/Simulation }

UpdateGameStateFromAPI<public>()<suspends>:void =
    Response := APIClient.Get("/api/gamestate")
    
    if (BodyResponse := body_response[Response]):
        StateData := BodyResponse.GetBody()
        
        # 更新游戏模拟状态
        # 例如：修改玩家属性、游戏规则等
        ApplyGameState(StateData)
```

---

#### 配合 Fortnite.com/Devices 模块

**用途**: 根据 API 数据动态配置游戏设备

```verse
using { /UnrealEngine.com/WebAPI }
using { /Fortnite.com/Devices }

ConfigureDevicesFromAPI<private>()<suspends>:void =
    Response := APIClient.Get("/api/device-config")
    
    if (BodyResponse := body_response[Response]):
        ConfigData := BodyResponse.GetBody()
        
        # 根据配置调整设备参数
        # 例如：设置出生点位置、道具刷新率等
        ApplyDeviceConfig(ConfigData)
```

---

## 7. 参考资源

### 7.1 官方文档链接

- **WebAPI 模块主页**: [https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/unrealenginedotcom/webapi](https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/unrealenginedotcom/webapi)
- **client_id 类**: [https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/unrealenginedotcom/webapi/client_id](https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/unrealenginedotcom/webapi/client_id)
- **client 类**: [https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/unrealenginedotcom/webapi/client](https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/unrealenginedotcom/webapi/client)
- **response 类**: [https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/unrealenginedotcom/webapi/response](https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/unrealenginedotcom/webapi/response)
- **body_response 类**: [https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/unrealenginedotcom/webapi/body_response](https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/unrealenginedotcom/webapi/body_response)
- **MakeClient 函数**: [https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/unrealenginedotcom/webapi/makeclient](https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/unrealenginedotcom/webapi/makeclient)
- **Get 方法**: [https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/unrealenginedotcom/webapi/client/get](https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/unrealenginedotcom/webapi/client/get)

### 7.2 相关 API 模块引用

#### 同命名空间模块

- **UnrealEngine.com/JSON**: JSON 数据解析，配合 WebAPI 处理 JSON 响应
- **UnrealEngine.com/Itemization**: 物品系统，可从 API 加载物品配置

#### 相关 Verse.org 模块

- **Verse.org/Simulation**: 游戏模拟层，WebAPI 数据用于更新模拟状态
- **Verse.org/Concurrency**: 并发控制，用于管理多个并发 API 请求

#### 相关 Fortnite.com 模块

- **Fortnite.com/Devices**: 设备系统，根据 API 配置设备参数
- **Fortnite.com/Game**: 游戏逻辑，集成 API 数据到游戏流程

### 7.3 本地参考文件

- **API Digest**: `skills/verseDev/shared/api-digests/UnrealEngine.digest.verse.md` (行 304-327)
- **模块列表**: `skills/verseDev/shared/references/api-modules-list.md`
- **能力调研**: `skills/verseDev/shared/references/api-modules-research.md`

---

## 附录：完整 API 定义

以下是从 API Digest 提取的完整 WebAPI 模块定义：

```verse
WebAPI<public> := module:
    # Usage:
    #     Licensed users create a derived version of `client_id` in their module.
    #     The Verse class path for your derived `client_id` is then used as the 
    #     configuration key in your backend service to map to your endpoint.
    # 
    #     WARNING: do not make your derived `client_id` class public. This object
    #     type is your private key to your backend.
    # 
    # Example:
    #     my_client_id<internal> := class<final><computes>(client_id)
    #     MyClient<internal> := MakeClient(my_client_id)
    client_id<native><public> := class<abstract><computes>:

    client<native><public> := class<final><computes><internal>:
        Get<native><public>(Path:string)<suspends>:response

    response<native><public> := class<internal>:

    body_response<native><public> := class<internal>(response):
        GetBody<native><public>()<computes>:string

    MakeClient<native><public>(ClientId:client_id)<converges>:client
```

---

**文档版本**: v1.0  
**最后更新**: 2026-01-04  
**API 版本**: Fortnite+Release-39.11-CL-49242330
