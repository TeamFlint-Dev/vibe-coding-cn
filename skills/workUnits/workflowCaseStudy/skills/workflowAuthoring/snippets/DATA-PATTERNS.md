# 数据模式代码片段

> **用途**: repo-memory、数据预加载、持久化模式  
> **来源**: workflowAuthoring Skill

---

## 1. Repo-memory 基础配置

```yaml
tools:
  repo-memory:
    branch-name: memory/default
    file-glob: "**"
```

**读取**:
```markdown
Read from:
- `/tmp/gh-aw/repo-memory-default/memory/default/your-file.json`
```

**写入**:
```markdown
Save to:
- `/tmp/gh-aw/repo-memory-default/memory/default/your-file.json`
```

---

## 2. 工作流专属 Memory

```yaml
tools:
  repo-memory:
    branch-name: memory/my-workflow
    file-glob: "**"
```

**文件路径模板**:
```
/tmp/gh-aw/repo-memory-my-workflow/memory/my-workflow/
├── latest.json           # 最新运行状态
├── processed-items.json  # 已处理项（去重）
└── history/
    └── YYYY-MM-DD.json   # 历史记录
```

---

## 3. 数据预加载模式

```markdown
## Data Pre-Loading

Before analysis, fetch all relevant data:

### Step 1: Load Current State
Read from repo-memory:
- `/tmp/gh-aw/repo-memory-default/.../metrics/latest.json`
- `/tmp/gh-aw/repo-memory-default/.../processed-items.json`

### Step 2: Query Fresh Data
Use GitHub API to get:
- Open issues with label X
- Recent PRs
- Workflow runs

### Step 3: Compute Delta
Compare fresh data against processed-items to identify new items.
```

---

## 4. 去重模式

```markdown
## Deduplication

### Read Processed Items
```json
// /tmp/.../processed-items.json
{
  "items": ["item-id-1", "item-id-2", "item-id-3"],
  "last_updated": "2026-01-08T00:00:00Z"
}
```

### Process New Items Only
For each discovered item:
1. Check if item.id exists in processed_items
2. If YES → skip
3. If NO → process and add to list

### Save Updated List
After processing, save updated processed-items.json
```

---

## 5. Metrics 收集模式

```markdown
## Metrics Storage

### Daily Snapshot
Save to: `metrics/daily/YYYY-MM-DD.json`
```json
{
  "timestamp": "2026-01-08T00:00:00Z",
  "workflow_runs": {
    "workflow-a": { "total": 10, "success": 9, "rate": 0.9 },
    "workflow-b": { "total": 5, "success": 5, "rate": 1.0 }
  }
}
```

### Latest Pointer
Save to: `metrics/latest.json`
Copy of most recent daily snapshot for quick access.

### Consumer Pattern
Read from `metrics/latest.json` instead of querying API.
```

---

## 6. Cursor/Checkpoint 模式

```markdown
## Cursor Pattern

### Purpose
Track processing progress for resumable operations.

### Structure
```json
// cursor.json
{
  "last_processed_id": "item-456",
  "last_run_timestamp": "2026-01-08T00:00:00Z",
  "next_page_token": "abc123",
  "status": "in_progress"
}
```

### Usage
1. Read cursor at start
2. Resume from last_processed_id
3. Update cursor after each batch
4. Set status = "completed" when done
```

---

## 7. 跨工作流共享数据

```markdown
## Cross-Workflow Data Sharing

### Writer Workflow (Collector)
Save to shared location:
- `memory/shared/metrics/latest.json`
- `memory/shared/alerts.md`

### Reader Workflows (Consumers)
Read from same location:
- `memory/shared/metrics/latest.json`
- `memory/shared/alerts.md`

### Coordination Notes
Use `memory/shared/coordination.md` for cross-agent communication:
```markdown
## Last Updated: 2026-01-08T00:00:00Z

### Active Alerts
- [Alert 1 description]

### Handled Items
- item-123: Handled by workflow-a
- item-456: Handled by workflow-b
```
```

---

## 8. 文件系统知识库模式

```yaml
tools:
  repo-memory:
    branch-name: memory/knowledge
    file-glob: "**/*.md"
```

```markdown
## Knowledge Base Structure

```
memory/knowledge/
├── topics/
│   ├── topic-a.md
│   └── topic-b.md
├── examples/
│   ├── example-1.md
│   └── example-2.md
└── index.md
```

### Search Pattern
1. Read index.md for overview
2. Navigate to relevant topic
3. Find examples if needed

### Update Pattern
1. Create/update topic file
2. Update index.md with new entry
```

---

## 9. 多层级 Memory 结构

```yaml
memory-paths:  # Campaign 配置
  - "memory/campaigns/my-campaign/**"
  - "memory/worker-1/**"
  - "memory/worker-2/**"
```

```markdown
## Memory Hierarchy

```
memory/
├── campaigns/
│   └── my-campaign/
│       ├── cursor.json        # Orchestrator 状态
│       └── metrics/
│           └── weekly.json    # 聚合 metrics
├── worker-1/
│   ├── latest.md             # Worker 1 最新运行
│   └── processed.json        # Worker 1 已处理项
└── worker-2/
    ├── latest.md             # Worker 2 最新运行
    └── processed.json        # Worker 2 已处理项
```
```

---

## 10. 临时文件模式

```markdown
## Temporary Files

For intermediate processing, use in-memory or temp files:

### Pattern
1. Create temp file: `/tmp/processing-<uuid>.json`
2. Process data
3. Move final result to repo-memory
4. Clean up temp file

### Note
Temp files don't persist across workflow runs.
Use repo-memory for persistent storage.
```
