# 子类型与超类型 (Subtyping and Supertyping)

## 概述

子类型系统允许一个类型作为另一个类型的特化版本，支持多态性和代码复用。Verse 使用 `subtype` 和 `supertype` 关系定义类型层级。

**一句话定义**：子类型是更具体的类型，可以在期望超类型的地方使用；超类型是更通用的类型。

**适用场景**：
- 类继承层级（class subclassing）
- 接口实现（interface implementation）
- 泛型约束（generic constraints）
- 类型安全的向上/向下转换

## 语法规范

### 完整语法格式

```verse
# 类继承（subclass）
derived_class := class(base_class):
    # 派生类成员

# 接口定义
my_interface := interface:
    Method() : void

# 类实现接口
my_class := class(my_interface):
    Method<override>() : void = ...

# 泛型约束（要求子类型）
Function<T>(Value : T where T:subtype(base_type)) : T = ...

# 类型向下转换（failable）
if (DerivedInstance := BaseInstance[derived_type]):
    # 使用 DerivedInstance

# Where 子句中的子类型约束
Function(Value : t where t:subtype(comparable)) : void = ...
```

### 关键词与符号说明

| 关键词/符号 | 说明 | 示例 |
|------------|------|------|
| `class(BaseType)` | 类继承 | `derived := class(base):` |
| `subtype(T)` | 子类型约束 | `where t:subtype(comparable)` |
| `supertype(T)` | 超类型约束 | `where t:supertype(entity)` |
| `<override>` | 覆盖基类方法 | `Method<override>()` |
| `<abstract>` | 抽象方法/类 | `<abstract> Method()` |
| `<concrete>` | 具体类（可实例化） | `class<concrete>:` |
| `[Type]` | 类型向下转换 | `Base[derived_type]` |

## 示例代码

### 最小示例

```verse
# 基类
animal := class:
    Name : string
    
    MakeSound<public>() : void =
        Print("Some sound")

# 派生类
dog := class(animal):
    Breed : string
    
    MakeSound<override><public>() : void =
        Print("Woof!")

# 使用
MyDog := dog{Name := "Buddy", Breed := "Golden"}
MyDog.MakeSound()  # 输出 "Woof!"
```

### 常见用法

```verse
# 场景 1: 类继承层级

# 基类
entity := class:
    ID : int
    Position : vector3
    
    Update<public>() : void =
        # 默认实现

# 中间类
character := class(entity):
    Health : int
    MaxHealth : int
    
    TakeDamage<public>(Amount : int) : void =
        set Health -= Amount

# 具体类
player := class(character):
    PlayerName : string
    Score : int
    
    Update<override><public>() : void =
        # 玩家特定更新
        Print("Updating player {PlayerName}")

# 使用继承关系
MyPlayer := player{
    ID := 1
    Position := vector3{X:=0.0, Y:=0.0, Z:=0.0}
    Health := 100
    MaxHealth := 100
    PlayerName := "Alice"
    Score := 0
}

# 场景 2: 接口定义与实现

# 接口
updatable := interface:
    Update() : void

damageable := interface:
    TakeDamage(Amount : int) : void
    GetHealth() : int

# 实现接口
game_object := class(updatable, damageable):
    var Health : int = 100
    
    Update<override>() : void =
        Print("Updating game object")
    
    TakeDamage<override>(Amount : int) : void =
        set Health -= Amount
    
    GetHealth<override>() : int =
        Health

# 场景 3: 多态性

# 基类数组
var Entities : []entity = array{}

# 添加不同类型的实体
set Entities = Entities + array{
    entity{ID := 1, Position := vector3{...}}
    character{ID := 2, Position := vector3{...}, Health := 100, MaxHealth := 100}
    player{...}
}

# 统一调用基类方法
for (Entity : Entities):
    Entity.Update()  # 调用相应的实现

# 场景 4: 类型向下转换

ProcessEntity(Entity : entity) : void =
    # 尝试转换为 player
    if (Player := Entity[player]):
        Print("Processing player: {Player.PlayerName}")
        # 使用 player 特定的成员
        Player.Score += 10
    else if (Character := Entity[character]):
        Print("Processing character")
        Character.TakeDamage(5)
    else:
        Print("Processing generic entity")

# 场景 5: 泛型约束使用子类型

# 只接受 entity 的子类型
ProcessEntities<T>(Entities : []T where T:subtype(entity)) : void =
    for (Entity : Entities):
        Entity.Update()  # 安全调用，因为 T 是 entity 的子类型

# 调用
ProcessEntities(array{MyPlayer, AnotherCharacter})

# 场景 6: Comparable 约束

# 排序函数（需要可比较的类型）
Sort<T>(Array : []T where T:subtype(comparable)) : []T =
    # 简化的排序实现
    # 可以使用 <, >, = 操作符
    Array  # 实际需要排序算法

Numbers := array{3, 1, 4, 1, 5}
Sorted := Sort(Numbers)  # int 是 comparable
```

### 高级用法

```verse
# 场景 1: 抽象基类

# 抽象基类（不能实例化）
<abstract>
game_component := class:
    <abstract> Initialize() : void
    <abstract> Update(DeltaTime : float) : void
    <abstract> Shutdown() : void

# 具体实现
health_component := class<concrete>(game_component):
    var CurrentHealth : int = 100
    
    Initialize<override>() : void =
        set CurrentHealth = 100
        Print("Health component initialized")
    
    Update<override>(DeltaTime : float) : void =
        # 更新逻辑
        Print("Updating health")
    
    Shutdown<override>() : void =
        Print("Health component shutdown")

# 场景 2: 混合接口（Mixin 模式）

serializable := interface:
    Serialize() : string
    Deserialize(Data : string) : void

persistable := interface:
    Save() : void
    Load() : void

# 同时实现多个接口
save_data := class(serializable, persistable):
    var Data : string = ""
    
    Serialize<override>() : string =
        Data
    
    Deserialize<override>(Input : string) : void =
        set Data = Input
    
    Save<override>() : void =
        # 保存到持久存储
        SaveToDatabase(Serialize())
    
    Load<override>() : void =
        # 从持久存储加载
        LoadedData := LoadFromDatabase()
        Deserialize(LoadedData)

# 场景 3: 类型守卫模式

# 检查并转换类型
IsPlayer(Entity : entity) : logic =
    if (Entity[player]):
        true
    else:
        false

AsPlayer(Entity : entity) : ?player =
    if (Player := Entity[player]):
        option{Player}
    else:
        false

# 使用
for (Entity : Entities):
    if (IsPlayer(Entity)):
        if (Player := AsPlayer(Entity)?):
            ProcessPlayer(Player)

# 场景 4: 协变返回类型（如果 Verse 支持）

# 基类
factory<T> := class:
    Create() : T = ...

# 派生类可以返回更具体的类型
player_factory := class(factory(entity)):
    Create<override>() : player =  # 返回 player 而非 entity
        player{...}

# 场景 5: 访问者模式（双分派）

visitor := interface:
    VisitPlayer(P : player) : void
    VisitNPC(N : npc) : void

visitable := interface:
    Accept(V : visitor) : void

player := class(visitable):
    # ...
    Accept<override>(V : visitor) : void =
        V.VisitPlayer(Self)

npc := class(visitable):
    # ...
    Accept<override>(V : visitor) : void =
        V.VisitNPC(Self)

# 具体访问者
damage_visitor := class(visitor):
    Damage : int
    
    VisitPlayer<override>(P : player) : void =
        P.TakeDamage(Damage)
    
    VisitNPC<override>(N : npc) : void =
        N.TakeDamage(Damage * 2)  # NPC 受到双倍伤害

# 场景 6: 类型层级约束

# 要求类型在层级中间
ProcessMiddleLayer<T>(Value : T where 
    T:subtype(character),  # T 必须是 character 或其子类
    T:supertype(player))   # T 必须是 player 或其超类
: void =
    # T 只能是 character 或介于 character 和 player 之间的类型
    Value.TakeDamage(10)
```

## 常见错误与陷阱

### 1. 忘记使用 override

```verse
# ❌ 错误：覆盖基类方法必须标记 <override>
base := class:
    Method() : void = Print("Base")

derived := class(base):
    Method() : void = Print("Derived")  # 编译错误或警告

# ✅ 正确
derived := class(base):
    Method<override>() : void = Print("Derived")
```

### 2. 向下转换未处理失败

```verse
# ❌ 错误：类型转换是 failable
Entity : entity = ...
Player : player = Entity[player]  # 编译错误

# ✅ 正确：处理失败情况
if (Player := Entity[player]):
    # 使用 Player
else:
    # 转换失败
```

### 3. 循环继承

```verse
# ❌ 错误：循环依赖
class_a := class(class_b):
    # ...

class_b := class(class_a):  # 编译错误
    # ...

# ✅ 正确：线性继承层级
base := class:
    # ...

derived := class(base):
    # ...
```

### 4. 违反 Liskov 替换原则

```verse
# ⚠️ 危险：派生类改变基类契约
rectangle := class:
    Width : int
    Height : int
    
    SetDimensions(W : int, H : int) : void =
        set Width = W
        set Height = H

# 问题：正方形改变了 SetDimensions 的行为
square := class(rectangle):
    SetDimensions<override>(W : int, H : int) : void =
        set Width = W
        set Height = W  # 忽略 H，破坏契约
```

### 5. 过度使用继承

```verse
# ❌ 不推荐：深度继承层级
entity := class:
    # ...

character := class(entity):
    # ...

humanoid := class(character):
    # ...

player := class(humanoid):
    # ...

hero := class(player):
    # ...

# ✅ 推荐：优先组合而非继承
entity := class:
    var Components : []game_component = array{}
    # ...
```

## 与其他语言对比

| 特性 | Verse | TypeScript | C# | Rust | Java |
|------|-------|-----------|-----|------|------|
| **继承语法** | `class(base)` | `extends` | `: base` | ❌ (trait) | `extends` |
| **接口语法** | `interface` | `interface` | `interface` | `trait` | `interface` |
| **多重继承** | ❌ (多接口 ✅) | ❌ (多接口 ✅) | ❌ (多接口 ✅) | ❌ (多 trait ✅) | ❌ (多接口 ✅) |
| **抽象类** | `<abstract>` | `abstract` | `abstract` | ❌ | `abstract` |
| **覆盖标记** | `<override>` | ❌ | `override` | ❌ | `@Override` |
| **向下转换** | `[type]` | `as type` | `as type` | `downcast` | `(Type)` |
| **类型约束** | `subtype()` | `extends` | `where T :` | `where T:` | `extends` |

### 关键差异

1. **继承语法**：`class(base)` 类似函数调用，独特的语法。
2. **强制 override 标记**：提高代码清晰度和安全性。
3. **Failable 向下转换**：类型转换必须在失败上下文中，更安全。
4. **接口与类区分明确**：`interface` 和 `class` 是不同的关键词。
5. **Subtype 约束语法**：`where t:subtype(...)` 清晰表达约束。

## 编程 Agent 使用指南

### 生成代码时的最佳实践

1. **何时使用继承 vs 组合**

   ```
   决策树：
   需要代码复用？
   ├─ "是一个"关系？ → 继承
   │  └─ 例：player is-a character
   ├─ "有一个"关系？ → 组合
   │  └─ 例：player has-a weapon
   ├─ 需要多态行为？ → 继承或接口
   │  └─ 例：所有 entities 都可以 Update
   └─ 需要灵活组合？ → 组合/组件
      └─ 例：动态添加能力
   ```

2. **继承层级设计原则**

   ```verse
   # ✅ 推荐：浅层级（2-3 层）
   entity → character → player
   
   # ❌ 避免：深层级（> 3 层）
   entity → physical_object → movable_object → 
   character → humanoid → player → hero
   
   # ✅ 推荐：组合替代深层级
   player := class:
       var Movement : movement_component
       var Combat : combat_component
       var Inventory : inventory_component
   ```

3. **接口定义模式**

   ```verse
   # 小而专注的接口
   updatable := interface:
       Update(DeltaTime : float) : void
   
   renderable := interface:
       Render() : void
   
   collidable := interface:
       OnCollision(Other : entity) : void
   
   # 组合接口
   game_object := class(updatable, renderable, collidable):
       # 实现所有接口
   ```

4. **类型转换安全模式**

   ```verse
   # 模式 1: if 链
   ProcessEntity(Entity : entity) : void =
       if (Player := Entity[player]):
           ProcessPlayer(Player)
       else if (NPC := Entity[npc]):
           ProcessNPC(NPC)
       else:
           ProcessGenericEntity(Entity)
   
   # 模式 2: 辅助函数
   TryAsPlayer(Entity : entity) : ?player =
       if (Player := Entity[player]):
           option{Player}
       else:
           false
   
   # 模式 3: 类型守卫
   IsOfType<T>(Value : entity where T:subtype(entity)) : logic =
       if (Value[T]):
           true
       else:
           false
   ```

5. **泛型约束使用**

   ```verse
   # 清晰的约束
   ProcessComparable<T>(A : T, B : T where T:subtype(comparable)) : T =
       if (A > B):
           A
       else:
           B
   
   # 多重约束（如果支持）
   ProcessSerializable<T>(Value : T where 
       T:subtype(serializable),
       T:subtype(persistable)
   ) : void =
       Value.Save()
   ```

### 常见任务代码模板

#### 实体系统

```verse
# 基础实体
game_entity := class:
    ID : int
    var Position : vector3
    var IsActive : logic = true
    
    Update<public>(DeltaTime : float) : void =
        # 默认实现

# 可破坏实体
destructible := class(game_entity):
    var Health : int
    var MaxHealth : int
    
    TakeDamage<public>(Amount : int) : void =
        set Health -= Amount
        if (Health <= 0):
            OnDestroyed()
    
    OnDestroyed<public>() : void =
        set IsActive = false

# 玩家
player := class(destructible):
    PlayerName : string
    var Score : int = 0
    
    Update<override><public>(DeltaTime : float) : void =
        # 玩家特定逻辑
        HandleInput(DeltaTime)
    
    OnDestroyed<override><public>() : void =
        Print("Player {PlayerName} destroyed!")
        Respawn()
    
    Respawn<public>() : void =
        set Health = MaxHealth
        set IsActive = true
```

#### 组件系统

```verse
# 组件接口
component := interface:
    Initialize() : void
    Update(DeltaTime : float) : void
    Shutdown() : void

# 具体组件
movement_component := class<concrete>(component):
    var Speed : float = 5.0
    
    Initialize<override>() : void = ...
    Update<override>(DeltaTime : float) : void = ...
    Shutdown<override>() : void = ...

# 实体使用组件
entity := class:
    var Components : []component = array{}
    
    AddComponent(Comp : component) : void =
        Comp.Initialize()
        set Components = Components + array{Comp}
    
    UpdateAllComponents(DeltaTime : float) : void =
        for (Comp : Components):
            Comp.Update(DeltaTime)
```

#### 工厂模式

```verse
# 产品接口
weapon := interface:
    GetDamage() : int
    Attack() : void

# 具体产品
sword := class<concrete>(weapon):
    Damage : int = 10
    
    GetDamage<override>() : int = Damage
    Attack<override>() : void =
        Print("Sword attack!")

bow := class<concrete>(weapon):
    Damage : int = 8
    
    GetDamage<override>() : int = Damage
    Attack<override>() : void =
        Print("Bow attack!")

# 工厂
weapon_factory := class:
    CreateWeapon(Type : weapon_type) : weapon =
        if (Type = weapon_type.Sword):
            sword{}
        else if (Type = weapon_type.Bow):
            bow{}
        else:
            sword{}  # 默认

weapon_type := enum:
    Sword
    Bow
```

## 最佳实践总结

### ✅ DO（推荐）

- 优先使用组合而非深度继承
- 总是标记 `<override>`
- 使用接口定义契约
- 处理类型转换失败情况
- 保持继承层级浅（≤3 层）
- 遵循 Liskov 替换原则

### ❌ DON'T（避免）

- 过度使用继承
- 创建深度继承层级
- 忘记 override 标记
- 假设向下转换总是成功
- 在派生类中改变基类契约
- 使用继承仅为代码复用

## 参考资源

- [Verse 官方文档 - Class](https://dev.epicgames.com/documentation/en-us/fortnite/class-in-verse)
- [Verse 官方文档 - Subclass](https://dev.epicgames.com/documentation/en-us/fortnite/subclass-in-verse)
- [Verse 官方文档 - Interface](https://dev.epicgames.com/documentation/en-us/fortnite/interface-in-verse)
- [Verse 官方文档 - Parametric Types](https://dev.epicgames.com/documentation/en-us/fortnite/parametric-types-in-verse)
- [Verse 语言参考](https://dev.epicgames.com/documentation/en-us/uefn/verse-language-reference)
