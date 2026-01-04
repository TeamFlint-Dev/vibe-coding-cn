# Concurrency Overview

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/concurrency-overview-in-verse
> **爬取时间**: 2025-12-26T23:50:48.143831

---

An [expression](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#expression) in Verse can be either **immediate** or **async**. This describes the time an expression can take to [evaluate](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#evaluate) relative to [simulation updates](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#simulation-update).

Think of a simulation update as when a new [frame](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#frame) is shown.

There are cases when multiple simulation updates can occur before a new frame, such as if an online game goes out of sync with the server.

| immediate | async |
| --- | --- |
| An **immediate** expression evaluates with no delay, meaning that the evaluation will complete within the current simulation update. | An **async** expression has the possibility of taking time to evaluate, but doesn’t necessarily have to. An async expression may or may not complete in the current simulation update, or in a later one. |

## Async Contexts

Async expressions can be used in any Verse code that has an [async context](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#async-context).

An [async context](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#async-context) is the [body](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#body) of a [function](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#function-verse) that has the [suspends effect](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#suspends) [specifier](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary). The `suspends` effect indicates that async functions can suspend and cooperatively transfer control to other concurrent expressions at various points over several [simulation](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#simulation) updates before they complete.

The `OnBegin()` function in a Verse device is a common async function used as a starting point for async code.

Calling an async function has the same [syntax](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#syntax) as calling an immediate function:

```verse
OnBegin<override>()<suspends> : void =
    HideAllPlatforms()

HideAllPlatforms()<suspends> : void =
    for (Platform : Platforms):
        Platform.Hide()
        Sleep(Delay)
```

Like any other expression, an async expression can have a [result](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#result). The result of an async expression is only available once it has completed.

```verse
# Npc is undefined until it is bound after MoveToNearestNPC() completes which may be several frames into the future
Npc := Player.MoveToNearestNPC()

#Only called after MoveToNearestNPC() completes
Print("Moved to {Npc}")
```

Any code block that is within an async context (inside the body of an async function) may have any mix of immediate and async expressions.

- If any expressions in a code block are async, then the whole code block is considered to be async.
- If all expressions in a code block are immediate, then the whole code block is considered to be immediate.

All the expressions in the example below are async expressions, so the overall code block is async:

```verse
Sleep(2.0)  # waits 2 seconds
Boss.TauntEmote() # waits until TauntEmote() completes
Player.MoveToNearestNPC() # waits until MoveToNearestNPC() completes
```

All the expressions in the example below are immediate expressions, so the overall code block is immediate:

```verse
Print("Reset after explosion")
Platform.Show()
set SecondsUntilExplosion = 12.0
```

The expressions in the example below are a mix of async and immediate expressions, so the overall code block is async:

```verse
Print("Started")
var Seconds := 1.0
Sleep(Seconds)

Print("Waited {Second} seconds")
set Second += 1.0
Sleep(Seconds)

Print("Waited {Second} seconds")
set Second += 1.0
Sleep(Seconds)

Print("Waited {Second} seconds")
```

Immediate expressions stick together on their own. All adjacent immediate (non-async) expressions are considered to be [atomic](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#atomic) — their code is guaranteed to run without interruption within the same update, and without [preemption](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#preemption) or [context switching](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#context-switch). It is as though such code had an automatic [mutual-exclusion](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#mutual-exclusion) [primitive](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#primitive-type) wrapped around them.

So from the code example above, these immediate expressions are treated atomically:

```verse
# These two expressions are always kept together
Print("Started")
var Seconds := 1.0

Sleep(Seconds)

# These two expressions are always kept together
Print("Waited {Second} seconds")
set Second += 1.0

Sleep(Seconds)

# These two expressions are always kept together
Print("Waited {Second} seconds")
set Second += 1.0

Sleep(Seconds)

Print("Waited {Second} seconds")
```

Like any other code block, the last expression in an async code block is used as a [result](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#result).

## Concurrency Expressions

Verse uses **concurrency expressions** to determine whether [expressions](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#expression) [execute](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#execute) concurrently (at the same time), or in sequence, one after another. An async expression is executed or [invoked](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#call) over time, so these concurrency expressions can be especially useful when you’re using async expressions.

## Structured Concurrency

An async expression will block other expressions from executing if it takes a long time to execute. For example, using `Sleep(90.0)` will cause the program to wait 90 seconds, blocking the next expression until `Sleep(90.0)` is fully executed.

[Structured concurrency](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#structured-concurrency) expressions are used to specify async logical time flow, and to modify the blocking nature of async expressions with a [lifespan](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#lifetime) that is logically constrained to a specific [async context scope](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#async-context) (such as an async function [body](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#body)).

This is similar to structured flow control such as `block`, `if`, `for`, and `loop` that constrain to their associated [scope](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#scope).

Verse async expressions do not use the `yield` and `await` [primitives](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#primitive-type) used by async implementations in other languages. The same mechanisms are accomplished by using Verse concurrency expressions and internal mechanisms.

For more on structured concurrency, see [Sync](https://dev.epicgames.com/documentation/en-us/fortnite/sync-in-verse),
[Race](https://dev.epicgames.com/documentation/en-us/fortnite/race-in-verse), [Rush](https://dev.epicgames.com/documentation/en-us/fortnite/rush-in-verse), and [Branch](https://dev.epicgames.com/documentation/en-us/fortnite/branch-in-verse).

## Unstructured Concurrency

There is only one unstructured concurrency expression — [spawn](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#spawn-expression). This expression has a lifespan that is not logically constrained to a specific async context scope, but that potentially can extend beyond the scope where it was executed.

Unstructured concurrency is like an emergency escape hatch — you shouldn't use it on a regular basis although sometimes it is your best and only option.

Structured concurrency expressions (`sync`, `race`, `rush` and `branch`) should be used before unstructured concurrency (`spawn`) expressions whenever possible.

For more on unstructured concurrency, see [Spawn](https://dev.epicgames.com/documentation/en-us/fortnite/spawn-in-verse).

## Tasks for Tracking Currently Executing Async Expressions

An async expression has a task associated with it.

A **task** is an [object](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#object) that represents an async function that has started to execute, but has [suspended](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#suspends) to allow another task to complete.

The task can be used to check the status of an async expression and to cancel the async expression, if desired.

For more on tasks, see [Task](https://dev.epicgames.com/documentation/en-us/fortnite/task-in-verse).
