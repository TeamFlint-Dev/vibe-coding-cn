# Branch

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/branch-in-verse
> **爬取时间**: 2025-12-27T00:40:43.337243

---

A `branch` [expression](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#expression) starts a [block](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#code-block) of one or more [async](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#async) subexpressions, and any expression that follows after is executed immediately, without waiting for the `branch` expressions to complete.

You can use `branch` essentially to treat any async block of code as though it were [fire-and-forget](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#fire-and-forget) immediate, but it still must be [called](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#call) within an [async context](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#async-context).

```verse
branch:
    # This block continues until completed
    AsyncFunction1()    # Starts effectively the same time as AsyncFunction3()
    Method1()  # Block can be mixed with immediate expressions
    AsyncFunction2()
AsyncFunction3()  # Starts effectively the same time as AsyncFunction1()
# If branch block task is still running when AsyncFunction3 completes
# then any remaining branch task is canceled
```

The following code shows the [syntax](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#syntax) for the `branch` expression.

```verse
expression0
branch:
    slow-expression
    mid-expression
    fast-expression
expression1
```

The diagram below shows the [execution](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#execute) flow of the expressions.

[![Diagram showing the execution flow of the branch expression](https://dev.epicgames.com/community/api/documentation/image/dbcd7d32-7c1d-413a-9f7f-a2de0b9b520e?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/dbcd7d32-7c1d-413a-9f7f-a2de0b9b520e?resizing_type=fit)

It is similar to the [unstructured concurrency](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#unstructured-concurrency) [spawn expression](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#spawn-expression), but `branch` allows for any arbitrary block of code, and is only permissible within, and bounded by, an enclosing async context. Because of this, `branch` is preferred over `spawn` whenever possible.

## Branch Expression Use

|  |  |
| --- | --- |
| **Where you can use a `branch` expression** | [Async contexts](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#async-context) |
| **Invocation time of the `branch` expression** | Immediate |
| **Requirements for `branch` code block** | The `branch` expression must have at least one async expression. |
| **What the `branch` expression does** | The body of the `branch` expression is started as soon as it is encountered. The body of the branch expression continues to evaluate until the code block completes or the enclosing async context completes — whichever occurs first — at which point the `branch` code block task is canceled. |
| **When the `branch` expression completes** | The `branch` expression completes immediately. |
| **When the next expression after `branch` starts** | Any expression that follows the `branch` expression is started immediately. |
| **Result of the `branch` expression** | A `branch` expression has no result, so its result type is `void`. |

A `branch` expression may not currently be used in the body of an iteration expression such as `loop` or `for`. If it must be used then wrap it in an async function and have the iteration expression call that function.
