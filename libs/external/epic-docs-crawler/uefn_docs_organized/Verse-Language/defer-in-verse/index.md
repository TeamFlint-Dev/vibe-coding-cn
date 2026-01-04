# Defer

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/defer-in-verse
> **爬取时间**: 2025-12-27T00:20:55.720607

---

The `defer` [expression](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#expression) delays the execution of code until the current [scope](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#scope) exits. You can use the `defer` expression to handle cleanup tasks like resetting [variables](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary). Even when there is an early exit (such as `return` or [break](https://dev.epicgames.com/documentation/en-us/fortnite/loop-and-break-in-verse)) from the current scope, the expressions in a `defer` block will run as long as `defer` is encountered before the exit.

The following code shows how to use `defer` to reset a variable to zero while still using that same variable as a [return](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#return) value. In this [function](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary), `RoundScore` is returned and the expressions in the `defer` block run immediately after.

This means you do not need to create a temporary variable to save the value of `RoundScore` before it gets reset to zero.

```verse
OnRoundEnd<public>() : void =
var ScoreThisRound : int = AddRoundScoreToTotalScore()
Print("Points scored this round: {ScoreThisRound}")

<# Adds RoundScore to TotalScore and resets RoundScore to 0.
Returns the RoundScore added. #>
AddRoundScoreToTotalScore<public>() : int =
        defer:
                set RoundScore = 0
                UpdateUI()
        set TotalScore += RoundScore
        return RoundScore
```

## Defer Expression Use

You can use a `defer` expression within any sequential [code block](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#code-block) such as a [block](https://dev.epicgames.com/documentation/en-us/fortnite/block-in-verse), [loop](https://dev.epicgames.com/documentation/en-us/fortnite/loop-and-break-in-verse), [for](https://dev.epicgames.com/documentation/en-us/fortnite/for-in-verse), [if](https://dev.epicgames.com/documentation/en-us/fortnite/if-in-verse), [branch](https://dev.epicgames.com/documentation/en-us/fortnite/branch-in-verse), or even another `defer`.

Expressions within a `defer` block must be [immediate](https://dev.epicgames.com/documentation/en-us/fortnite/concurrency-overview-in-verse) (and not [async](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#async)) — with one exception. Async expressions can still be used within a `defer` if they are made immediate by using:

- [spawn](https://dev.epicgames.com/documentation/en-us/fortnite/spawn-in-verse)
- `branch` (if the `defer` is within an async block such as in a coroutine)

A `defer` has no result, and cannot be used as an argument or an assignment value.

| defer | defer before an exit |
| --- | --- |
| ```verse expression0 defer:     expression1     expression2 expression3 ``` | ```verse name() : type =     expression0     defer:         expression1         expression2     return expression3 ``` |
| [Control flow diagram of defer expression](https://dev.epicgames.com/community/api/documentation/image/a76a2d37-b182-4bb7-b9da-cf9670129b14?resizing_type=fit)  *Click image to enlarge.* | [Control flow diagram of defer expression](https://dev.epicgames.com/community/api/documentation/image/69115a53-915d-4aa8-b54a-2afa133ff173?resizing_type=fit)  *Click image to enlarge.* |

A `defer` expression will only execute if it is encountered before an early exit occurs.

| defer with early return | defer with a canceled async expression |
| --- | --- |
| ```verse expression0 if (conditions):     return defer:     expression1 expression2 ``` | ```verse expression0 race:     block: # canceled during slow-async-expression         slow-async-expression         defer:             expression1         expression2      block: # finishes first          fast-async-expression          defer: ``` |
| [Control flow diagram of defer expression with early exit](https://dev.epicgames.com/community/api/documentation/image/80402e62-9f9b-45df-9dee-dee2bfb36cf9?resizing_type=fit)  *Click image to enlarge.* | [Control flow diagram of defer expression with canceled concurrent task](https://dev.epicgames.com/community/api/documentation/image/d7cbd348-628c-4004-9260-38bb7bae0172?resizing_type=fit)  *Click image to enlarge.* |

Multiple `defer` expressions appearing in the same scope accumulate. The order they are executed is the reverse order they are encountered — first-in-last-out (FILO) order. Since the last encountered `defer` in a given scope is executed first, expressions inside that last encountered `defer` can refer to context (such as variables) that will be cleaned up by other `defer` expressions that were encountered earlier and executed later.

Verse does not have [deterministic destruction](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#deterministic-destruction), but `defer` allows behavior similar to [RAII](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#raii) to ensure cleanup.

| Multiple defer expressions in a code block | Multiple defer expressions in different code blocks |
| --- | --- |
| ```verse expression0 defer:     expression1 expression2 defer:     expression3 expression4 ``` | ```verse expression0 if (conditions):     expression1     defer:         expression2     expression3 expression4 defer:     expression5 expression6 ``` |
| [Control flow diagram of multiple defer expressions](https://dev.epicgames.com/community/api/documentation/image/b650d15e-c5e6-4054-8204-cbeda1330427?resizing_type=fit)  *Click image to enlarge.* | [Control flow diagram of multiple defer expressions in different code blocks](https://dev.epicgames.com/community/api/documentation/image/426f93cb-56a5-4f4f-bf60-93ee1a9d7db3?resizing_type=fit)  *Click image to enlarge.* |

Exiting early is allowed within a `defer` block as long as the exit does not transfer control outside the scope of the `defer`. For example, using a loop with `break` is allowed within a `defer`, but that `break` must keep the code execution within the `defer` block. It cannot refer to a `loop` outside of the `defer` block.

Any variables that have been encountered in the outer [nesting](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#nested) scope of a `defer` can be used within that `defer` expression.

Remember that `defer` runs last at the time of scope exit. This means that it uses whatever the state of the program is (including variable values) at that time, not at the time when the `defer` is encountered. The code below will print `10` because `defer` runs immediately after `MyScore` is set to `10`.

```verse
var MyScore = 5
defer: 
	Print(MyScore)
set MyScore = 10
```

Using a `defer` expression as the last expression within a scope is the same as not using it at all. For example, these two sets of expressions will run in exactly the same order, so `defer` is not needed:

| Without defer | With defer |
| --- | --- |
| ```verse expression0 expression1 expression2 ``` | ```verse expression0 expression1 defer:     expression2 ``` |
