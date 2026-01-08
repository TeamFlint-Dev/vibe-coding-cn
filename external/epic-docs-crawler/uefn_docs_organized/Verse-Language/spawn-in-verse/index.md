# Spawn

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/spawn-in-verse>
> **爬取时间**: 2025-12-27T00:20:16.797847

---

The `spawn` [expression](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#expression) starts one [async](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#async) [function invocation](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#function-call), and any expression that follows the `spawn` is [executed](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#execute) immediately while the started async function task continues independently until it completes.

```verse
# Continues until completed without blocking
spawn{AsyncFunction1()}  # Started at same time as expression0
expression0         # Started at same time as AsyncFunction1()
```

The following code shows the [syntax](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#syntax) for the `spawn` expression.

```verse
expression0
spawn{ expression1 }
expression2
```

The diagram below shows the execution flow of the expressions.

[![Diagram showing the execution flow of the spawn expression](https://dev.epicgames.com/community/api/documentation/image/94bf77dc-351c-439e-8d43-6a75a0820f8d?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/94bf77dc-351c-439e-8d43-6a75a0820f8d?resizing_type=fit)

While similar to [branch](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#branch-expression), the `spawn` body is limited to a single async function call. It is also allowed outside of an [async context](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#async-context), so it can be called within both non-async and async functions.

A `spawn` expression should be treated like an emergency escape hatch, while `branch` should be used in place of `spawn` whenever possible.

## Spawn Expression Use

|  |  |
| --- | --- |
| **Where you can use a `spawn` expression** | Any context. |
| **Invocation time of the `spawn` expression** | Immediate. |
| **Requirements for `spawn` code block** | The body of the `spawn` expression is started as soon as it is encountered. It must have at least one async expression. |
| **What the `spawn` expression does** | The body of a `spawn` creates an async context like the body of an async function. However, only a single async function call is allowed within the `spawn` body. The async function of the `spawn` is started as soon as it is encountered, and evaluates as much as possible until it encounters something [suspending](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#suspends) or blocking. The spawned async function continues to evaluate until it completes without any further connection to the location where it was spawned. |
| **When the `spawn` expression completes** | The `spawn` expression completes immediately. |
| **When the next expression after `spawn` starts** | Any next expression that follows the `spawn` expression is started immediately. |
| **Result of the `spawn` expression** | A `spawn` has a [task](task-in-verse) result. |
