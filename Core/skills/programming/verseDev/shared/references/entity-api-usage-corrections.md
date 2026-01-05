# Entity API 使用错误全面纠正

> **错误级别**: 🔴🔴 严重 - Entity API 使用完全错误
> **创建日期**: 2026-01-05
> **纠正原因**: 使用了不存在的 GetOwner 方法，GetComponent 语法错误

---

## 🔴🔴 严重错误: Entity API 使用错误

###  错误 1: GetOwner 方法不存在

**❌ 错误代码** (文档中大量使用):
```verse
if (Owner := GetOwner[entity]):
    # ...
```

**问题**:
- `GetOwner` 方法**不存在于任何官方 API**
- `component` 类没有 `GetOwner` 方法

**✅ 正确用法** (官方 API):
```verse
# component 有 Entity 属性（property，不是方法）
OwnerEntity := Entity  # 直接访问属性

# 或者在需要判断的地方
# Entity 属性总是存在，不需要 if 判断
```

**官方 API 定义**:
```verse
component<native><public> := class<abstract>:
    # The parent entity of this component.
    Entity<native><public>: entity  # 这是属性，不是方法！
```

---

### 错误 2: GetComponent 语法错误

**❌ 错误代码**:
```verse
if (Mesh := Owner.GetComponent[mesh_component]()):
    # 使用了方括号 [type]
```

**✅ 正确用法**:
```verse
# GetComponent 使用圆括号传递类型参数
if (Mesh := Entity.GetComponent(mesh_component)):
    # Mesh 现在是 mesh_component 类型
```

**官方 API 定义**:
```verse
# GetComponent 的签名
GetComponent<native><final><public>(
    component_type: castable_subtype(component)
)<reads><decides>: component_type
```

---

## 所有需要修正的模式

### 模式 1: 组件内访问 Owner Entity

**❌ 错误**:
```verse
if (Owner := GetOwner[entity]):
    Overlaps := Owner.FindOverlapHits()
```

**✅ 正确**:
```verse
# 直接使用 Entity 属性
Overlaps := Entity.FindOverlapHits()

# 如果需要赋值
OwnerEntity := Entity
Overlaps := OwnerEntity.FindOverlapHits()
```

### 模式 2: 获取其他组件

**❌ 错误**:
```verse
if (Owner := GetOwner[entity]):
    if (Mesh := Owner.GetComponent[mesh_component]()):
        # ...
```

**✅ 正确**:
```verse
# 一步到位
if (Mesh := Entity.GetComponent(mesh_component)):
    # Mesh 是 mesh_component 类型
    Mesh.EntityEnteredEvent.Subscribe(Handler)
```

### 模式 3: 发送事件

**❌ 错误**:
```verse
if (Owner := GetOwner[entity]):
    Event := my_event{Data := value}
    Owner.SendDown(Event)
```

**✅ 正确**:
```verse
# 直接使用 Entity
Event := my_event{Data := value}
Entity.SendDown(Event)
```

---

## 完整的正确示例

### 继承式检测器

```verse
player_trigger_mesh := class(mesh_component):
    var PlayersInside<private>:[]agent = array{}
    
    OnBeginSimulation<override>()<suspends>:void =
        Sleep(0.0)
        
        # 订阅自己的事件（继承的）
        EntityEnteredEvent.Subscribe(OnEntityEntered)
        EntityExitedEvent.Subscribe(OnEntityExited)
    
    OnEntityEntered(HitEntity:entity):void =
        if (Player := agent[HitEntity]):
            set PlayersInside += array{Player}
            
            # 发送事件 - 直接使用 Entity 属性
            Event := player_entered_event{Player := Player}
            Entity.SendDown(Event)
```

### 订阅式检测器

```verse
player_detection_logic := class(component):
    var PlayersInZone<private>:[]agent = array{}
    
    OnBeginSimulation<override>()<suspends>:void =
        Sleep(0.0)
        
        # 正确：直接使用 Entity 属性获取组件
        if (Mesh := Entity.GetComponent(mesh_component)):
            Mesh.EntityEnteredEvent.Subscribe(HandleEntityEntered)
            Mesh.EntityExitedEvent.Subscribe(HandleEntityExited)
    
    HandleEntityEntered(HitEntity:entity):void =
        if (Player := agent[HitEntity]):
            set PlayersInZone += array{Player}
            
            # 发送事件
            Event := player_entered_event{Player := Player}
            Entity.SendDown(Event)
```

---

## 需要全局替换的内容

| 错误用法 | 正确用法 |
|---------|---------|
| `if (Owner := GetOwner[entity]):` | 直接使用 `Entity` 属性 |
| `GetOwner[entity]` | `Entity` |
| `Owner.GetComponent[mesh_component]()` | `Entity.GetComponent(mesh_component)` |
| `Owner.FindOverlapHits()` | `Entity.FindOverlapHits()` |
| `Owner.SendDown(Event)` | `Entity.SendDown(Event)` |
| `Owner.SendUp(Event)` | `Entity.SendUp(Event)` |
| `Owner.AddComponents(...)` | `Entity.AddComponents(...)` |
| `Owner.GetEntities()` | `Entity.GetEntities()` |

---

## 受影响的文档

所有文档都需要修正：
1. `player-detection-tracking-implementation-guide.md`
2. `player-detection-advanced-patterns.md`
3. `player-detection-api-corrections.md` (已有错误)

---

## 验证方法

已创建 Verse 验证文件:
- `verse-validation/player_detection_corrected.verse`

包含使用正确 API 的完整示例代码。

---

**纠正日期**: 2026-01-05
**来源**: `Verse.digest.verse.md` 官方 API 定义
