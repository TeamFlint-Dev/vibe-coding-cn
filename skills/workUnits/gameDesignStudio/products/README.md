# 产品 (Products)

这里存放实际产出的游戏设计方案及审查报告。

---

## 目录结构

```
products/
├── designs/          # 设计方案
└── reviews/          # 审查报告
```

---

## 设计方案 (Designs)

每个设计方案一个子目录或文件：

```
designs/
├── {feature-name}/
│   ├── feeling-definition.md    # Phase 1: 感受定义
│   ├── design-plan.md            # Phase 2: 设计方案
│   ├── narrative-wrap.md         # Phase 3: 叙事包裹
│   ├── improvements.md           # Phase 4: 改进记录
│   └── final-design.md           # 最终设计文档
```

---

## 审查报告 (Reviews)

Guardian 的审查报告：

```
reviews/
├── {feature-name}/
│   ├── phase1-review.md         # Phase 1 审查反馈
│   ├── phase2-review.md         # Phase 2 审查报告
│   └── phase4-final-review.md   # Phase 4 最终审查
```

---

## 产品 vs 资产

| 类型 | 说明 | 位置 |
|------|------|------|
| **产品** | 具体的设计方案 | `products/` |
| **资产** | 可复用的模式和方法 | `skills/`, `reports/` |

产品是针对特定功能/特性的设计。资产是从产品中提炼的可复用知识。
