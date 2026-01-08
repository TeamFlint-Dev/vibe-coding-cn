# Race

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/race-in-verse>
> **爬取时间**: 2025-12-27T00:19:51.614666

---

The `race` [expression](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#expression) is used to run a [block](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#code-block) of two or more [async](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#async) expressions concurrently (simultaneously). When the fastest expression completes, it “wins the race”. Any remaining “losing” expressions are canceled, then any expression that follows the `race` is [evaluated](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#evaluate).

```verse
set WinnerResult = race:
    # All three async functions start at the same time
    AsyncFunctionLongTime()
    AsyncFunctionShortTime()  # This will win and its result is used
    AsyncFunctionMediumTime()
# Next expression is called after the fastest async function completes
# / when the fastest/shortest async function task (AsyncFunctionShortTime()) completes
# and all other async function tasks (AsyncFunctionLongTime(), AsyncFunctionMediumTime()) are canceled.
NextExpression(WinnerResult)
```

The following code shows the [syntax](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#syntax) for the `race` expression.

```verse
expression0
race:
    slow-expression
    mid-expression
    fast-expression
expression1
```

The diagram below shows the [execution](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#execute) flow of the expressions.

## Race Expression Use

|  |  |
| --- | --- |
| **Where you can use a `race` expression** | [Async contexts](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#async-context) |
| **Invocation time of the `race` expression** | Async |
| **Requirements for `race` code block** | The body of the `race` expression must have at least two expressions, and all the expressions must be async. |
| **What the `race` expression does** | Similar to `sync`, but cancels all but the “winning” [subexpression](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#subexpression). If any other expressions complete at the same simulation time as the earlier expression, the first (earlier) expression “wins” and breaks any tie. Any “losing” expression tasks are canceled. |
| **When the `race` expression completes** | The `race` is completed when the “winning” expression in the code block has completed. This refers to the fastest, shortest length, first completed, or least amount of time to complete. |
| **When the next expression after `race` starts** | Any expression that follows the `race` expression is started once the first expression finishes. |
| **Result of the `race` expression** | The result of a `race` is the result of the first completed expression. The result [type](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#type) is the most common compatible type of all expressions in the code block. |

This might seem simple, but `race` is one of the most useful and powerful expressions in the Verse arsenal. It is key to stopping other arbitrarily complex async code in a structured fashion — a form of early exit. It does this in a very clean way by keeping whatever tests are needed to determine when to stop separated from the code that is to be stopped.

- Any async expression can be canceled.
- Some async expressions, such as an endless `loop` or `Sleep(Inf)` will never complete. The only way they can be stopped is to [cancel](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#canceled) them. This can be a strong strategy when paired with one or more `race` expressions.
- Async expressions will not have a [result](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#result) if they are canceled, so any variable or other expression that depends on a canceled async expression would not be [bound](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#bind).

Need to stop some complex behavior after some amount of time or after some complex sequence of events trigger? Without `race`, you would normally need to sprinkle tests, such as [polling](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#polling) all throughout your complex behavior. With `race`, you only need to add all stop conditions as sibling subexpressions to the complex behavior.

```verse
race:
    ComplexBehavior() # Could be simple or as complex as a whole game
    Sleep(60.0)       # Timeout after one minute
    EventTrigger()    # Some other arbitrary test that can be used to stop
```

A `race` result can be used to determine which [subexpression](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#subexpression) finished first, or won the race.

```verse
# Adding a unique result to subexpressions so it can
# be used to determine which subexpression won
Winner := race:
    block:        # task 1
        AsyncFunction1()
        1
    block:        # task 2
        AsyncFunction2a()
        AsyncFunction2b()
        AsyncFunction2c()
        2
    loop:         # task 3
        # endless loop which could never win
        AsyncFunction3()
        3

MyLog.Print("The winning subexpression was: {Winner}")
```
