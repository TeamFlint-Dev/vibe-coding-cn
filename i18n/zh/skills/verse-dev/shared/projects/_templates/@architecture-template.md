# 项目模板 - 架构蓝图

> 复制此模板到新项目文件夹

---

## 项目信息

- **项目名称**: [名称]
- **游戏类型**: [类型]
- **创建时间**: [timestamp]

---

## Entity 层级结构

```
game_manager (根Entity)
├── player_manager
│   └── player_entity[]
├── enemy_manager
│   └── enemy_entity[]
├── level_manager
│   └── level_entity
└── ui_manager
    └── hud_entity
```

---

## Component 清单

| Entity | 组件 | 职责 |
|--------|------|------|
| player_entity | health_component | 生命值管理 |
| player_entity | movement_component | 移动控制 |
| enemy_entity | ai_component | AI行为 |

---

## 事件流

```
[事件A] → [组件B] → [事件C]
```

---

## 扩展点

- [ ] 预留接口1
- [ ] 预留接口2

---

*最后更新: [timestamp]*
