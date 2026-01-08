# Sync

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/sync-in-verse>
> **爬取时间**: 2025-12-27T02:08:25.122257

---

`sync`

 In a `sync` [expression](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#expression), all expressions in the sync [block](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#codeblock) run [concurrently](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#concurrent) and must complete before the sync expression yields control back. `sync` is a [structured concurrency](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#structuredconcurrency) expression.

You can use the `sync` [expression](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#expression) to run two or more [async](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#async) expressions at the same time. For example:

```verse
# All three async functions effectively start at the same time
Results = sync:
    AsyncFunction1()  # task 1
    AsyncFunction2()  # task 2
    AsyncFunction3()  # task 3
# Called after all three tasks complete (regardless of order)
MyLog.Print("Done with list of results: {Results}")
```

The following code shows the syntax for the `sync` expression with an accompanying diagram that shows the [execution](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#execution) flow of the expressions.

```verse
expression0
sync:
    slow-expression
    mid-expression
    fast-expression
expression1
```

[![Diagram showing the execution flow of the sync expression](https://dev.epicgames.com/community/api/documentation/image/a13230b9-92e9-4dfd-9a50-590d5c1a1548?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/a13230b9-92e9-4dfd-9a50-590d5c1a1548?resizing_type=fit)

## Sync Expression Use

|  |  |
| --- | --- |
| **Where you can use a `sync` expression** | [Async contexts](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#async-context) |
| **Invocation time of the `sync` expression** | Async |
| **Requirements for `sync` code block** | The body of the `sync` expression must have at least two expressions that are async; otherwise, you have no need to run the expressions simultaneously. |
| **What the `sync` expression does** | Executes all expressions in its [code block](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#code-block) concurrently and waits for them all to finish before executing the next expression after the `sync`. |
| **When the `sync` expression completes** | When all the expressions in the `sync` code block have completed. |
| **When the next expression after `sync` starts** | When all the expressions in the `sync` code block have completed. |
| **Result of the `sync` expression** | Its [result](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#result) is a [tuple](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary) of results from each expression in the order that the top-level expressions were specified. The result [types](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#type) of the expressions can be of any type, and each tuple element will have the type of its corresponding expression. |

At least two [top-level expressions](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#top-level-expression) must be async.

```verse
sync:
    AsyncFunction1()
    MyLog.Print("Second top level expression")
    AsyncFunction2()
    MyLog.Print("Third top level expression")

sync:
    AsyncFunction1()
    # Error: expected at least two top-level expressions
```

Top-level expressions can be compound expressions, such as [nested](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#nested) [code blocks](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#code-block):

```verse
# sync may also have compound expressions
# with each top-level expression its own task
sync:
    block: # task 1
        # Evaluated in serial order
        AsyncFunction1a()
        AsyncFunction1b()
    block: # task 2
        AsyncFunction2a()
        AsyncFunction2b()
        AsyncFunction2c()
    AsyncFunction3() # task 3

# AsyncFunction1a(), AsyncFunction2a() and AsyncFunction3() all start essentially at the same time
```

Since tuples can be used as [self-splatting](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary) [arguments](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#argument), `sync` expressions can be used directly as arguments since they have a tuple result. This allows async arguments to evaluate simultaneously, and the function they are being passed to is called when all the expressions in the sync code block are completed.

```verse
# All three coroutine arguments start their evaluation at the same time
DoStuff(sync{AsyncFunctionArg1(); AsyncFunctionArg2(); AsyncFunctionArg3()})

# Not every argument needs to be async - a minimum of two justifies the use of sync
DoOtherStuff(sync{AsyncFunctionArg1(); 42; AsyncFunctionArg2(); AsyncFunctionArg3()})
```
