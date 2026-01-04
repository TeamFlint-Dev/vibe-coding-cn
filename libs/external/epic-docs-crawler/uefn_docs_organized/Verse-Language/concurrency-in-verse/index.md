# Time Flow and Concurrency

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/concurrency-in-verse
> **爬取时间**: 2025-12-27T02:14:03.913903

---

An important aspect of games and [simulations](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#simulation) is specifying the order and overlap of operations that take time. Need two or two hundred monsters all acting simultaneously? Planning a swarm of robots that can march in (or out of) step? Thinking about a fleet of spaceships that invade over time?

**Time-flow control** is at the heart of the Verse programming language, and this is accomplished with [concurrent](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#concurrent) [expressions](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#expression).

You could say that time flow is a type of flow control, but where [control flow](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary) is about the order in which a computer executes instructions based on the order of expressions in the program, time flow controls the execution in time, not sequence, based on how concurrency expressions are used.

Time flow is another way of saying **concurrency**.

[![Concurrency Overview](https://dev.epicgames.com/community/api/documentation/image/e834f299-3480-4d17-9600-6341e2946d6b?resizing_type=fit&width=640&height=640)

Concurrency Overview

See how concurrency expressions impact time flow in Verse.](https://dev.epicgames.com/documentation/en-us/fortnite/concurrency-overview-in-verse)[![Sync](https://dev.epicgames.com/community/api/documentation/image/9ba1826a-b201-4038-af5b-0105b7ea4c10?resizing_type=fit&width=640&height=640)

Sync

Run two or more async expressions concurrently using a sync expression.](https://dev.epicgames.com/documentation/en-us/fortnite/sync-in-verse)[![Race](https://dev.epicgames.com/community/api/documentation/image/aa1dd2a9-2d46-4914-936e-7eb0042b6d35?resizing_type=fit&width=640&height=640)

Race

Use a race expression to run two or more async expressions concurrently and cancel whichever expressions don't finish first.](https://dev.epicgames.com/documentation/en-us/fortnite/race-in-verse)[![Rush](https://dev.epicgames.com/community/api/documentation/image/ba1418f3-63e7-42f8-8675-258499237e40?resizing_type=fit&width=640&height=640)

Rush

Use a rush expression to run two or more async expressions without canceling the slower expressions.](https://dev.epicgames.com/documentation/en-us/fortnite/rush-in-verse)[![Branch](https://dev.epicgames.com/community/api/documentation/image/ede0d9d1-e32a-43f2-8155-b9589af76511?resizing_type=fit&width=640&height=640)

Branch

Use a branch expression to start one or more async expressions, then immediately execute following expressions.](https://dev.epicgames.com/documentation/en-us/fortnite/branch-in-verse)[![Spawn](https://dev.epicgames.com/community/api/documentation/image/11356685-ec9c-4d2e-915b-2ba1fa031ab1?resizing_type=fit&width=640&height=640)

Spawn

Use a spawn expression to start one async expression in any context, then immediately execute the following expressions.](https://dev.epicgames.com/documentation/en-us/fortnite/spawn-in-verse)[![Task](https://dev.epicgames.com/community/api/documentation/image/42be92c5-579f-4bdb-b209-8a602247b59c?resizing_type=fit&width=640&height=640)

Task

A task is an object that represents the state of a currently-executing async function.](https://dev.epicgames.com/documentation/en-us/fortnite/task-in-verse)
