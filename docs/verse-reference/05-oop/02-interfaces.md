# 接口与实现 (Interfaces and Implementation)

> **参考来源**: [Verse 官方文档 - Interface](https://dev.epicgames.com/documentation/en-us/fortnite/interface-in-verse)

## 概述

在 Verse 中，接口（interface）类型为如何与任何实现该接口的类进行交互提供了契约。接口本身不能被实例化，但类可以继承接口并实现其方法。

**核心特性**：
- 接口定义方法签名，但不提供实现
- 类可以实现多个接口
- 接口可以继承其他接口（接口组合）
- 类似于抽象类，但不允许部分实现或字段定义

**接口 vs 抽象类**：
| 特性 | 接口 | 抽象类 |
|------|------|--------|
| 方法实现 | 不允许 | 允许部分实现 |
| 字段 | 不允许 | 允许 |
| 多继承 | 支持 | 不支持 |
| 实例化 | 不可以 | 不可以 |

## 语法规范

### 接口定义语法

```verse
接口名 := interface():
    方法名(参数列表)<效果修饰符> : 返回类型
```

### 实现接口的类定义

```verse
类名 := class(接口名):
    # 实现接口方法时必须添加 <override> 修饰符
    方法名<override>(参数列表)<效果修饰符> : 返回类型 =
        实现代码
```

### 多接口继承

```verse
类名 := class(接口1, 接口2, 接口3):
    方法1<override>() : 返回类型 = ...
    方法2<override>() : 返回类型 = ...
```

### 接口继承接口

```verse
子接口 := interface(父接口):
    新方法() : 返回类型
```

## 示例代码

### 最小示例

```verse
# 定义一个可骑乘的接口
rideable := interface():
    Mount()<decides> : void
    Dismount()<decides> : void

# 实现接口的类
bicycle := class(rideable):
    Mount<override>()<decides> : void =
        # 实现骑上自行车的逻辑
        ...
    
    Dismount<override>()<decides> : void =
        # 实现下自行车的逻辑
        ...
```

**要点**：
- 接口方法使用 `<decides>` 效果修饰符
- 实现时必须添加 `<override>`
- 效果修饰符必须与接口声明一致

### 常见用法

#### 1. 接口组合（接口继承接口）

```verse
# 基础接口
moveable := interface():
    MoveForward() : void

# 扩展接口
rideable := interface(moveable):
    Mount()<decides> : void
    Dismount()<decides> : void

# 实现扩展接口的类必须实现所有方法
horse := class(rideable):
    # 来自 moveable 接口
    MoveForward<override>() : void =
        ...
    
    # 来自 rideable 接口
    Mount<override>()<decides> : void =
        ...
    
    Dismount<override>()<decides> : void =
        ...
```

**说明**：
- `rideable` 继承了 `moveable` 的所有方法
- 实现 `rideable` 的类需要实现两个接口的所有方法

#### 2. 类继承类和接口

类可以同时继承一个类和多个接口：

```verse
# 基础接口
moveable := interface():
    MoveForward() : void

# 可骑乘接口
rideable := interface(moveable):
    Mount()<decides> : void
    Dismount()<decides> : void

# 基础类
horse := class(moveable):
    MoveForward<override>() : void =
        # 马的移动逻辑
        ...

# 带鞍的马（继承 horse 类，实现 rideable 接口）
saddle_horse := class(horse, rideable):
    # 从 horse 继承了 MoveForward 的实现
    
    # 实现 rideable 接口的方法
    Mount<override>()<decides> : void =
        ...
    
    Dismount<override>()<decides> : void =
        ...
```

**继承顺序规则**：
1. 最多只能继承一个类（必须放在第一位）
2. 可以继承任意数量的接口
3. 语法：`class(父类, 接口1, 接口2, ...)`

#### 3. 多接口实现

一个类可以实现多个独立的接口：

```verse
# 可锁定接口
lockable := interface():
    Lock() : void
    Unlock() : void

# 可骑乘接口
rideable := interface():
    Mount()<decides> : void
    Dismount()<decides> : void

# 可移动接口
moveable := interface():
    MoveForward() : void

# 自行车实现多个接口
bicycle := class(rideable, lockable):
    # 实现 rideable 接口
    Mount<override>()<decides> : void =
        ...
    
    Dismount<override>()<decides> : void =
        ...
    
    # 实现 lockable 接口
    Lock<override>() : void =
        ...
    
    Unlock<override>() : void =
        ...
    
    # 实现 moveable 接口（通过 rideable 继承）
    MoveForward<override>() : void =
        ...
```

### 高级用法

#### 1. 接口作为类型约束

接口可以用作函数参数类型，实现多态：

```verse
rideable := interface():
    Mount()<decides> : void
    Dismount()<decides> : void

# 函数接受任何实现 rideable 的对象
StartRiding(Vehicle:rideable)<decides>:void =
    Vehicle.Mount()  # 调用具体实现
    Log("Started riding!")

# 可以传入不同的实现
MyBike := bicycle{...}
MyHorse := saddle_horse{...}

StartRiding(MyBike)   # 有效
StartRiding(MyHorse)  # 有效
```

#### 2. 接口层次结构设计

```verse
# 顶层接口：基础能力
entity := interface():
    GetID() : string

# 中层接口：可交互
interactable := interface(entity):
    Interact(Player:player)<decides> : void

# 底层接口：可收集
collectible := interface(interactable):
    Collect(Player:player)<transacts> : void
    GetValue() : int

# 实现完整层次的类
coin := class(collectible):
    ID : string
    Value : int = 10
    
    GetID<override>() : string = ID
    
    Interact<override>(Player:player)<decides> : void =
        Print("Press E to collect")
    
    Collect<override>(Player:player)<transacts> : void =
        # 收集硬币的逻辑
        ...
    
    GetValue<override>() : int = Value
```

#### 3. 接口与泛型结合

```verse
# 通用容器接口
container(ItemType:type) := interface():
    Add(Item:ItemType)<transacts> : void
    Remove(Item:ItemType)<transacts><decides> : void
    GetCount() : int

# 实现背包
inventory := class(container(item)):
    Items : []item = array{}
    
    Add<override>(Item:item)<transacts> : void =
        set Items = Items + array{Item}
    
    Remove<override>(Item:item)<transacts><decides> : void =
        if (Index := Items.Find(Item)):
            set Items = Items.RemoveAt(Index)
    
    GetCount<override>() : int = Items.Length
```

## 常见错误与陷阱

### 1. 忘记添加 override 修饰符

```verse
rideable := interface():
    Mount()<decides> : void

# ❌ 错误：缺少 <override>
bicycle := class(rideable):
    Mount()<decides> : void =  # 编译错误！
        ...

# ✅ 正确
bicycle := class(rideable):
    Mount<override>()<decides> : void =
        ...
```

### 2. 效果修饰符不匹配

```verse
rideable := interface():
    Mount()<decides> : void  # 接口声明 <decides>

# ❌ 错误：效果修饰符必须一致
bicycle := class(rideable):
    Mount<override>()<transacts> : void =  # 错误！
        ...

# ✅ 正确：可以是子类型效果
bicycle := class(rideable):
    Mount<override>()<decides> : void =
        ...
```

### 3. 尝试在接口中定义字段

```verse
# ❌ 错误：接口不能有字段
rideable := interface():
    Name : string  # 编译错误！
    Mount()<decides> : void
```

### 4. 实现接口时遗漏方法

```verse
rideable := interface():
    Mount()<decides> : void
    Dismount()<decides> : void

# ❌ 错误：只实现了一个方法
bicycle := class(rideable):
    Mount<override>()<decides> : void =
        ...
    # 缺少 Dismount 的实现！
```

### 5. 多继承时的类位置错误

```verse
moveable := interface():
    MoveForward() : void

horse := class():
    ...

# ❌ 错误：类必须在第一位
saddle_horse := class(moveable, horse):  # 错误顺序
    ...

# ✅ 正确
saddle_horse := class(horse, moveable):
    ...
```

## 与其他语言对比

| 特性 | Verse | Java | C# | Go | TypeScript |
|------|-------|------|----|----|-----------|
| 接口定义 | `interface()` | `interface` | `interface` | `interface` | `interface` |
| 多接口实现 | ✅ | ✅ | ✅ | ✅ | ✅ |
| 接口继承 | ✅ | ✅ | ✅ | ✅ (嵌入) | ✅ |
| 默认方法 | ❌ | ✅ (Java 8+) | ✅ | ❌ | ❌ |
| 字段 | ❌ | ❌ | ❌ | ❌ | ❌ |
| Override 关键字 | `<override>` | `@Override` | `override` | 隐式 | 隐式 |

**Verse 的特点**：
- 明确的 `<override>` 修饰符（类似 Java 的注解）
- 接口方法可以有效果修饰符（`<decides>`, `<transacts>` 等）
- 不支持默认方法实现（更纯粹的接口定义）

## 编程 Agent 使用指南

### 设计接口时的决策树

```
需要定义行为契约？
├─ 是 → 需要部分实现？
│      ├─ 是 → 使用抽象类
│      └─ 否 → 使用接口
│
└─ 否 → 使用具体类
```

### 接口设计检查清单

1. **职责单一性**
   - [ ] 接口是否只定义一组相关的行为？
   - [ ] 方法是否都围绕同一个概念？

2. **方法设计**
   - [ ] 方法签名是否清晰？
   - [ ] 效果修饰符是否正确？
   - [ ] 参数和返回值类型是否合适？

3. **继承关系**
   - [ ] 接口继承是否符合"is-a"关系？
   - [ ] 继承层次是否过深（建议不超过 3 层）？

4. **命名规范**
   - [ ] 接口名是否体现能力或特征（如 `rideable`, `lockable`）？
   - [ ] 方法名是否符合约定（动词开头）？

### 实现接口的代码审查要点

1. **完整性检查**
   - [ ] 是否实现了所有接口方法？
   - [ ] 是否实现了继承的接口的所有方法？

2. **修饰符检查**
   - [ ] 所有实现方法都有 `<override>` 修饰符？
   - [ ] 效果修饰符与接口声明一致？

3. **类型安全**
   - [ ] 参数类型是否兼容（可以是超类型）？
   - [ ] 返回类型是否兼容（可以是子类型）？

### 重构模式

#### 1. 提取接口

当多个不相关的类有相同行为时：

```verse
# 之前：重复的方法
class1 := class:
    DoAction() : void = ...

class2 := class:
    DoAction() : void = ...

# 之后：提取接口
actionable := interface():
    DoAction() : void

class1 := class(actionable):
    DoAction<override>() : void = ...

class2 := class(actionable):
    DoAction<override>() : void = ...
```

#### 2. 接口分离

当接口过大时，拆分为多个小接口：

```verse
# 之前：大接口
vehicle := interface():
    Start() : void
    Stop() : void
    Lock() : void
    Unlock() : void

# 之后：拆分
operable := interface():
    Start() : void
    Stop() : void

lockable := interface():
    Lock() : void
    Unlock() : void

car := class(operable, lockable):
    ...
```

#### 3. 接口组合

将相关接口组合成新接口：

```verse
# 基础接口
damageable := interface():
    TakeDamage(Amount:int) : void

healable := interface():
    Heal(Amount:int) : void

# 组合接口
living := interface(damageable, healable):
    GetHealth() : int

player := class(living):
    TakeDamage<override>(Amount:int) : void = ...
    Heal<override>(Amount:int) : void = ...
    GetHealth<override>() : int = ...
```

### 性能考虑

- **接口调用开销**：接口方法调用可能有轻微的虚函数调用开销
- **类型检查**：运行时类型检查（如果需要）会有额外开销
- **接口数量**：实现过多接口可能增加类的复杂度

### 最佳实践

1. **保持接口小而专注**：一个接口应该只定义一组相关的行为
2. **使用描述性名称**：接口名应该清楚地表达能力（如 `-able` 后缀）
3. **避免过深的继承**：接口继承层次不宜过深
4. **文档化契约**：清楚说明接口方法的前置条件和后置条件
5. **考虑向后兼容**：发布后的接口不应轻易修改

---

**相关文档**：
- [01-class-definition.md](./01-class-definition.md) - 类定义与构造
- [03-inheritance.md](./03-inheritance.md) - 继承与覆盖
- [04-access-control.md](./04-access-control.md) - 访问控制
