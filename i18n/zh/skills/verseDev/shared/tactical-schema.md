# Tactical Schema - 战术手册结构化定义

> **版本**: 1.0.0  
> **更新日期**: 2025-12-29  
> **用途**: 定义编码Agent和评审Agent的结构化上报格式，以及根源存储格式

---

## 概述

所有参与循环的Agent必须遵循本Schema输出结构化数据，以便 `verse-tactician` 进行归并和手册维护。

---

## 1. 编码Agent错误上报格式

### JSON Schema

```json
{
  "$schema": "http://json-schema.org/draft-07/schema#",
  "type": "object",
  "required": ["task_id", "agent", "errors", "should_update_handbook"],
  "properties": {
    "task_id": {
      "type": "string",
      "description": "当前任务ID，格式: REQ-YYYYMMDD-NNN"
    },
    "agent": {
      "type": "string",
      "const": "coding",
      "description": "固定值，标识为编码Agent"
    },
    "compile_attempts": {
      "type": "integer",
      "description": "编译尝试次数"
    },
    "compile_success": {
      "type": "boolean",
      "description": "最终是否编译成功"
    },
    "errors": {
      "type": "array",
      "items": {
        "$ref": "#/definitions/CodingError"
      }
    },
    "should_update_handbook": {
      "type": "boolean",
      "description": "是否需要更新战术手册（无错误或API/需求相关时可为false）"
    }
  },
  "definitions": {
    "CodingError": {
      "type": "object",
      "required": ["error_code", "message", "severity"],
      "properties": {
        "error_code": {
          "type": "string",
          "description": "错误码，如 VERSE-001, COMPILE-ERR-042"
        },
        "message": {
          "type": "string",
          "description": "错误描述"
        },
        "file": {
          "type": "string",
          "description": "出错文件路径"
        },
        "line": {
          "type": "integer",
          "description": "出错行号"
        },
        "suspected_root_cause": {
          "type": "string",
          "description": "编码Agent推测的根源原因"
        },
        "severity": {
          "type": "string",
          "enum": ["critical", "warning", "info"],
          "description": "严重程度"
        },
        "is_api_related": {
          "type": "boolean",
          "default": false,
          "description": "是否与底层API限制相关（不可修复）"
        },
        "is_requirement_related": {
          "type": "boolean",
          "default": false,
          "description": "是否与需求定义相关（需求问题而非代码问题）"
        }
      }
    }
  }
}
```

### 示例

```json
{
  "task_id": "REQ-20251229-001",
  "agent": "coding",
  "compile_attempts": 2,
  "compile_success": true,
  "errors": [
    {
      "error_code": "VERSE-TYPE-001",
      "message": "Type mismatch: expected 'int' but got 'float'",
      "file": "tower_component.verse",
      "line": 42,
      "suspected_root_cause": "伤害计算函数返回值类型不匹配",
      "severity": "critical",
      "is_api_related": false,
      "is_requirement_related": false
    }
  ],
  "should_update_handbook": true
}
```

---

## 2. 评审Agent反馈格式

### JSON Schema

```json
{
  "$schema": "http://json-schema.org/draft-07/schema#",
  "type": "object",
  "required": ["task_id", "agent", "verdict", "score", "issues", "should_update_handbook"],
  "properties": {
    "task_id": {
      "type": "string",
      "description": "当前任务ID"
    },
    "agent": {
      "type": "string",
      "enum": ["reviewer-utility", "reviewer-framework", "reviewer-quality"],
      "description": "评审Agent类型"
    },
    "verdict": {
      "type": "string",
      "enum": ["approve", "reject"],
      "description": "评审结论"
    },
    "score": {
      "type": "integer",
      "minimum": 1,
      "maximum": 10,
      "description": "评分（1-10）"
    },
    "issues": {
      "type": "array",
      "items": {
        "$ref": "#/definitions/ReviewIssue"
      }
    },
    "summary": {
      "type": "string",
      "description": "评审摘要（一句话）"
    },
    "should_update_handbook": {
      "type": "boolean",
      "description": "是否需要更新战术手册"
    }
  },
  "definitions": {
    "ReviewIssue": {
      "type": "object",
      "required": ["category", "severity", "description"],
      "properties": {
        "category": {
          "type": "string",
          "enum": ["实用性", "框架", "质量"],
          "description": "问题分类"
        },
        "subcategory": {
          "type": "string",
          "description": "细分类别，如 '边界处理'、'事件方向'、'命名规范'"
        },
        "severity": {
          "type": "string",
          "enum": ["critical", "warning", "info"],
          "description": "严重程度"
        },
        "description": {
          "type": "string",
          "description": "问题描述"
        },
        "location": {
          "type": "string",
          "description": "问题位置（文件:行号 或 函数名）"
        },
        "suggested_fix": {
          "type": "string",
          "description": "建议的修复方式"
        },
        "root_cause_hint": {
          "type": "string",
          "description": "推测的根源原因（供Tactician归并用）"
        }
      }
    }
  }
}
```

### 示例

```json
{
  "task_id": "REQ-20251229-001",
  "agent": "reviewer-framework",
  "verdict": "reject",
  "score": 5,
  "issues": [
    {
      "category": "框架",
      "subcategory": "事件方向",
      "severity": "critical",
      "description": "子组件使用了 SendDown 向父级广播，违反事件流向规范",
      "location": "tower_component.verse:87",
      "suggested_fix": "改用 SendUp 向父级报告",
      "root_cause_hint": "事件传播方向混淆"
    }
  ],
  "summary": "事件流向违规，需修复后重新评审",
  "should_update_handbook": true
}
```

---

## 3. 根源存储格式

### JSON Schema

```json
{
  "$schema": "http://json-schema.org/draft-07/schema#",
  "type": "object",
  "required": ["root_cause_id", "category", "description", "fix_pattern", "occurrence_count"],
  "properties": {
    "root_cause_id": {
      "type": "string",
      "pattern": "^RC-[A-Z]+-[0-9]{3}$",
      "description": "根源ID，格式: RC-{类别缩写}-{序号}"
    },
    "category": {
      "type": "string",
      "enum": ["compile", "framework", "api", "logic", "utility", "quality"],
      "description": "根源类别"
    },
    "subcategory": {
      "type": "string",
      "description": "细分类别"
    },
    "description": {
      "type": "string",
      "description": "根源描述（简洁明确）"
    },
    "symptoms": {
      "type": "array",
      "items": { "type": "string" },
      "description": "典型症状/错误消息关键词"
    },
    "fix_pattern": {
      "type": "string",
      "description": "修复模式（通用解决方案）"
    },
    "code_example": {
      "type": "object",
      "properties": {
        "wrong": { "type": "string", "description": "错误示例" },
        "correct": { "type": "string", "description": "正确示例" }
      }
    },
    "occurrence_count": {
      "type": "integer",
      "minimum": 1,
      "description": "累计出现次数"
    },
    "last_seen": {
      "type": "string",
      "format": "date",
      "description": "最近一次触发日期"
    },
    "example_refs": {
      "type": "array",
      "items": { "type": "string" },
      "maxItems": 5,
      "description": "关联的错误实例ID（最多5个典型案例）"
    },
    "related_skills": {
      "type": "array",
      "items": { "type": "string" },
      "description": "关联的Skill名称"
    }
  }
}
```

### 示例

```json
{
  "root_cause_id": "RC-FRM-001",
  "category": "framework",
  "subcategory": "事件方向",
  "description": "事件传播方向混淆：子组件误用SendDown向父级广播",
  "symptoms": [
    "SendDown in child component",
    "事件未被父级接收",
    "event not propagating"
  ],
  "fix_pattern": "子向父使用SendUp，父向子使用SendDown，点对点使用SendDirect",
  "code_example": {
    "wrong": "Owner.SendDown(my_event{})",
    "correct": "Owner.SendUp(my_event{})"
  },
  "occurrence_count": 7,
  "last_seen": "2025-12-29",
  "example_refs": [
    "ERR-20251228-003",
    "ERR-20251229-001"
  ],
  "related_skills": [
    "verse-component",
    "verse-event-flow"
  ]
}
```

---

## 4. 手册文件结构

### 全局索引 (tactical-overview.json)

```json
{
  "version": "1.0.0",
  "last_updated": "2025-12-29",
  "high_frequency_roots": [
    // Top 20 高频根源（count >= 5）
  ],
  "skill_handbooks": {
    "verse-component": "verse-component/tactical-handbook.json",
    "verse-event-flow": "verse-event-flow/tactical-handbook.json",
    "verse-helpers": "verse-helpers/tactical-handbook.json"
    // ...
  },
  "review_patterns": "shared/review-patterns.json",
  "low_frequency_pool": "shared/tactical-lowfreq.json"
}
```

### 各Skill独立手册 (tactical-handbook.json)

```json
{
  "skill": "verse-component",
  "version": "1.0.0",
  "last_updated": "2025-12-29",
  "root_causes": [
    // 该层相关的根源列表
  ]
}
```

### 评审根源库 (review-patterns.json)

```json
{
  "version": "1.0.0",
  "last_updated": "2025-12-29",
  "utility_patterns": [],
  "framework_patterns": [],
  "quality_patterns": []
}
```

### 低频根源池 (tactical-lowfreq.json)

```json
{
  "version": "1.0.0",
  "last_updated": "2025-12-29",
  "roots": [
    // count <= 3 的根源
  ]
}
```

---

## 5. 相似度匹配规则

Tactician 使用以下规则判断新错误是否归并到已有根源：

### 5.1 精确匹配（优先级1）

- **错误码完全相同** → 直接归并
- 例：`VERSE-TYPE-001` == `VERSE-TYPE-001` → 归并

### 5.2 症状匹配（优先级2）

- **症状关键词匹配度 >= 80%** → 建议归并
- 匹配算法：`intersection(new_symptoms, existing_symptoms) / union(...) >= 0.8`

### 5.3 根源描述相似（优先级3）

- **Agent推测的 `root_cause_hint` 与已有 `description` 语义相似** → 建议归并
- 需要 Tactician 确认

### 5.4 无匹配

- 以上均不满足 → 创建新根源
- 新根源 `occurrence_count = 1`

---

## 6. 频率分级

| 级别 | 条件 | 存储位置 | 注入优先级 |
|------|------|----------|------------|
| 高频 | count >= 5 | `tactical-overview.json` + 各Skill手册 | 始终注入 |
| 中频 | 3 < count < 5 | 各Skill手册 | 按需注入 |
| 低频 | count <= 3 | `tactical-lowfreq.json` | 不注入（可检索） |

---

## 7. Git版本控制

战术手册使用Git版本控制：

```bash
# 每次更新后自动commit
git add shared/tactical-*.json */tactical-handbook.json
git commit -m "tactician: +N roots, ~M merged, task=$TASK_ID"

# 回滚错误归并
git log --oneline  # 查找commit
git revert $COMMIT_ID
```

---

## 相关文件

- [verse-tactician/SKILL.md](../verse-tactician/SKILL.md) - 战术手册维护Agent
- [verse-agent-loop/SKILL.md](../verse-agent-loop/SKILL.md) - 循环控制器
- [verse-code-auditor/SKILL.md](../verse-code-auditor/SKILL.md) - 代码审计（需遵循评审格式）
