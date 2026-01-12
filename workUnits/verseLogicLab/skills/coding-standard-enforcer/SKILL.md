# Coding Standard Enforcer - 编码标准执行器

> **职责**: 编码规范、编译验证、错误修复策略  
> **使用阶段**: Phase 2 - Implementation Path（编码和验证）

---

## 📖 概述

Coding Standard Enforcer 确保所有代码符合高质量标准。它的三大职责：

1. **编码规范** - 统一的代码风格和最佳实践
2. **编译验证** - 强制使用 `analyze.sh` 验证代码
3. **错误修复** - 系统化的错误诊断和修复流程

---

## 📏 编码规范

### 1. 命名规范

#### 模块命名
```verse
# ✅ 好 - 驼峰命名，清晰描述
RpgHealthSystem<public> := module:

# ❌ 坏 - 下划线或不清晰
rpg_health<public> := module:
Utils<public> := module:
```

#### 函数命名
```verse
# ✅ 好 - 动词开头，描述行为
CalculateDamage<public>(...)<computes>:float
CheckAlive<public>(...)<decides>:void
ApplyHealing<public>(...)<computes>:health_state

# ❌ 坏 - 名词或不清晰
Damage<public>(...)
IsOrNot<public>(...)
DoIt<public>(...)
```

#### 变量和参数命名
```verse
# ✅ 好 - 清晰、具体
CurrentHealth:float
MaxDamage:float
TargetPosition:vector3

# ❌ 坏 - 模糊、缩写
HP:float
Dmg:float
Pos:vector3
```

#### 类型命名
```verse
# ✅ 好 - 小写下划线，结构类型后缀
health_state<public> := struct<computes>:...
damage_result<public> := struct<computes>:...

# ❌ 坏 - 驼峰或无后缀
HealthState<public> := struct<computes>:...
health<public> := struct<computes>:...
```

### 2. 代码结构规范

#### 模块结构模板
```verse
# [模块名称] - [一句话描述]
# 功能：[详细功能说明]

using { /Verse.org/Simulation }
using { /Verse.org/Random }

ModuleName<public> := module:
    
    # ========== 数据结构 ==========
    
    data_type<public> := struct<computes>:
        Field1<public>:type = default_value
        Field2<public>:type = default_value
    
    # ========== 工具函数 ==========
    
    HelperFunction<private>(...)<computes>:return_type =
        ...
    
    # ========== 核心逻辑 ==========
    
    MainFunction<public>(...)<computes>:return_type =
        ...
```

#### 分段规范
- 使用 `# ====== 标题 ======` 分隔不同功能段
- 顺序：数据结构 → 工具函数 → 核心逻辑
- 每段内按功能相关性组织

### 3. 注释规范

#### 模块头部注释
```verse
# RPG 生命值系统模块
# 功能：生命回复、最大生命值上限、治疗溢出逻辑
# 依赖：/Verse.org/Simulation
# 更新：2026-01-12
```

#### 函数注释
```verse
# 计算带护盾的伤害分配
# 参数：
#   CurrentHP - 当前生命值
#   Shield - 当前护盾值
#   Damage - 伤害量
# 返回：(新生命值, 新护盾值)
CalculateDamageWithShield<public>(CurrentHP:float, Shield:float, Damage:float)<computes>:tuple(float, float) =
    ...
```

#### 行内注释
```verse
# 优先消耗护盾
ShieldDmg := Min(Shield, ClampedDmg)
RemainingDmg := ClampedDmg - ShieldDmg  # 剩余伤害打到生命值
```

### 4. 类型和效果规范

#### 类型签名
```verse
# ✅ 好 - 明确的类型签名
Calculate<public>(A:float, B:float)<computes>:float = ...

# ❌ 坏 - 依赖类型推断
Calculate<public>(A, B) = ...
```

#### 效果标注

| 效果 | 使用场景 | 示例 |
|------|----------|------|
| `<computes>` | 纯计算，无副作用，不会失败 | `Add(A:float, B:float)<computes>:float` |
| `<decides>` | 条件判断，可能失败 | `CheckPositive(X:float)<decides>:void` |
| `<transacts>` | 事务性操作，修改状态 | `UpdateState(var State:state)<transacts>:void` |

```verse
# ✅ 好 - 正确使用效果
GetPercent<public>(Current:float, Max:float)<computes>:float =
    if (Max > 0.0): Current / Max else: 0.0

CheckAlive<public>(HP:float)<decides>:void =
    HP > 0.0

# ❌ 坏 - 缺少效果标注
GetPercent<public>(Current:float, Max:float):float = ...
```

### 5. 格式规范

#### 缩进
- 使用 **4 空格** 缩进
- 不使用 Tab

#### 行长度
- 最大 **120 字符**
- 超长时换行并缩进

#### 空行
- 函数之间：1-2 个空行
- 代码段之间：1 个空行
- 模块段落之间：2 个空行

#### 运算符间距
```verse
# ✅ 好
Result := A + B * C
Value := if (X > 0.0): X else: 0.0

# ❌ 坏
Result:=A+B*C
Value:=if(X>0.0):X else:0.0
```

---

## 🔍 编译验证流程

### Step 1: 编写代码

按照编码规范完成代码编写。

### Step 2: 运行分析工具

**命令**:
```bash
cd verseProject
./analyze.sh --format agent
```

**期望输出（成功）**:
```
Analyzing Verse code...
VERSE_ANALYSIS:44:0:0
VERSE_ANALYSIS_END

✅ Analysis completed successfully!
```

**解读**:
- `44` - 分析的文件数
- `0` - 错误数（必须为 0）
- `0` - 警告数（应尽量为 0）

### Step 3: 处理错误

如果有错误，输出格式：
```
VERSE_ANALYSIS:44:2:0
path/to/file.verse:10:5:10:20:error:3588:Ambiguous identifier 'Calculate'...
path/to/file.verse:25:8:25:15:error:3201:Type mismatch: expected 'float', got 'int'
VERSE_ANALYSIS_END

❌ Analysis found issues (exit code: 1)
```

**错误格式**:
```
文件路径:行:列:行:列:error:错误代码:错误信息
```

### Step 4: 修复错误

参考下面的"常见错误和修复"章节。

### Step 5: 重新验证

修复后重新运行 `analyze.sh`，直到 `错误数 = 0`。

---

## 🐛 常见错误和修复

### 错误 1: Ambiguous identifier（标识符歧义）

**错误信息**:
```
error:3588:Ambiguous identifier 'Calculate'
```

**原因**: 多个模块定义了同名标识符，使用时未指定模块。

**修复**:
```verse
# ❌ 坏
Result := Calculate(A, B)

# ✅ 好
Result := MyModule.Calculate(A, B)
```

---

### 错误 2: Type mismatch（类型不匹配）

**错误信息**:
```
error:3201:Type mismatch: expected 'float', got 'int'
```

**原因**: 类型不兼容。

**修复**:
```verse
# ❌ 坏
Value:int = 10
Result:float = Value  # int → float 需要显式转换

# ✅ 好
Value:int = 10
Result:float = Float(Value)
```

---

### 错误 3: Effect mismatch（效果不匹配）

**错误信息**:
```
error:3405:Cannot call <transacts> function from <computes> context
```

**原因**: 在纯计算函数中调用了有副作用的函数。

**修复**:
```verse
# ❌ 坏
Calculate<public>()<computes>:float =
    UpdateState()  # <transacts> 函数
    ...

# ✅ 好 - 调整效果链
Calculate<public>()<transacts>:float =
    UpdateState()
    ...

# 或者 - 移除副作用
Calculate<public>()<computes>:float =
    # 不调用 UpdateState
    ...
```

---

### 错误 4: Undefined identifier（未定义标识符）

**错误信息**:
```
error:3001:Undefined identifier 'UnknownFunction'
```

**原因**: 使用了未定义或未导入的标识符。

**修复**:
```verse
# ❌ 坏
Result := UnknownFunction()

# ✅ 好 - 添加 using 语句
using { /Path/To/Module }
Result := Module.UnknownFunction()
```

---

### 错误 5: Incorrect effect（效果错误）

**错误信息**:
```
error:3407:<decides> function must return void
```

**原因**: `<decides>` 函数必须返回 `void`。

**修复**:
```verse
# ❌ 坏
CheckPositive<public>(X:float)<decides>:bool =
    X > 0.0

# ✅ 好
CheckPositive<public>(X:float)<decides>:void =
    X > 0.0
```

---

## 📋 验证清单

### 编码前
- [ ] 阅读现有类似模块，理解代码风格
- [ ] 确定模块名称和组织结构
- [ ] 规划函数接口和效果

### 编码中
- [ ] 遵循命名规范
- [ ] 添加充分的注释
- [ ] 正确标注类型和效果
- [ ] 使用 Clamp/Min/Max 保护边界

### 编码后
- [ ] 运行 `analyze.sh`
- [ ] 修复所有错误
- [ ] 处理所有警告（尽量）
- [ ] 检查代码格式（缩进、空行、行长度）

---

## 🎯 最佳实践

### DO（应该做）
- ✅ **及早验证** - 不要等到写完所有代码才验证
- ✅ **增量开发** - 写一个函数，验证一次
- ✅ **记录错误** - 遇到新错误记录到 `knowledge/COMPILATION_LESSONS.json`
- ✅ **学习模式** - 从错误中总结规律

### DON'T（不应该做）
- ❌ **跳过验证** - 未验证的代码不能提交
- ❌ **忽略警告** - 警告可能是潜在 bug
- ❌ **猜测修复** - 理解错误原因再修复
- ❌ **批量修复** - 一次只修复一个错误

---

## 🔄 迭代流程

```
编写代码 → 运行 analyze.sh
    ↓
有错误？
    ├─ 是 → 分析错误 → 修复 → 返回验证
    └─ 否 → 检查警告 → 优化（可选）→ 完成
```

---

## 📝 错误记录模板

遇到新的或棘手的错误时，记录到 `knowledge/COMPILATION_LESSONS.json`：

```json
{
  "error": "完整的错误信息",
  "context": "什么情况下发生的",
  "solution": "如何修复的",
  "prevention": "如何预防",
  "date": "2026-01-12"
}
```

---

## 🛠️ 工具和技巧

### 技巧 1: 分而治之

大文件有多个错误时：

1. 注释掉大部分代码
2. 只保留一小部分
3. 修复这部分的错误
4. 逐步取消注释，重复验证

### 技巧 2: 二分查找

不确定哪行代码导致错误时：

1. 注释掉一半代码
2. 验证错误是否消失
3. 逐步缩小范围

### 技巧 3: 最小复现

创建最小的可复现案例：

```verse
# 原始复杂代码（有错误）
ComplexFunction := ...

# 最小复现
MinimalCase := module:
    Test() = 
        ... # 只包含触发错误的最少代码
```

---

## 📚 参考资料

### 代码风格参考
- `verseProject/source/library/logicModules/characterAndStateUtils/RpgHealth.verse`
- `verseProject/source/library/logicModules/characterAndStateUtils/RpgAttributes.verse`

### 工具文档
- `verseProject/ANALYSIS-TOOL-REFERENCE.md` - 分析工具详细说明
- `verseProject/analyze.sh` - 分析脚本源代码

---

**记住**：编译器是你的朋友，不是敌人。每个错误都是学习机会，每次验证都是质量保证。
