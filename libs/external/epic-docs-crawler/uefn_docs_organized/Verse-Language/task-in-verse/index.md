# Task

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/task-in-verse
> **爬取时间**: 2025-12-27T02:08:11.741269

---

A **task** is an [object](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#object) used to represent the state of a currently-[executing](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#execute) [async](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#async) [function](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary). Task objects are used to identify where an async function is [suspended](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#suspends), and the [values](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#value) of [local](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#local) [variables](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary) at that suspend point.

Tasks execute concurrently in a cooperatively multitasked environment.

A task can be durational, based on a [lifespan](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#lifespan) of one or more updates before it completes.

Tasks can be sequential, overlapped, staggered, and so on, in any logical order.

The sequence and overlapping flow of tasks is specified through the use of [structured](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#structured-concurrency) or [unstructured concurrency](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#unstructured-concurrency) [expressions](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#expression).

Each task can be concurrently arranged sequentially, overlapped, staggered, and so on, in any logical order of time. Internally, a task could have a [caller](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#call) (or even several callers), and zero or more dependent sub-tasks that form a [call graph](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#call-graph) (as opposed to a [call stack](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#call-stack)).

A task is similar to a [thread](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#thread), but has the advantage over threads in that [context switching](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#context-switch) between tasks does not involve any system calls, expensive context-state saving, or processor-blocking calls, and a processor can be 100% utilized). You don’t need synchronization such as [mutexes](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#mutex) or [semaphores](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#semaphore) to guard critical sections, and there is no need for support from the operating system.

The `task(t:type)` class allows direct programmatic querying and manipulation of tasks in an unstructured manner, though it is generally recommended that tasks be manipulated through structured concurrency expressions for greater clarity, power and efficiency.

Currently, the only exposed function for `task` is `Await()`, which waits until the current task has completed. This essentially anchors a task and adds a caller for it to return to at the call point.

```verse
spawn{AsyncFunction3()}

# Get task to query / give commands to
# starts and continues independently
Task2 := spawn{Player.MoveTo(Target1)}

Sleep(1.5) # Wait 1.5 Seconds
MyLog.Print("1.5 Seconds into Move_to()")

Task2.Await() # wait until MoveTo() completed
Wait(0.5)     # Wait 0.5 Seconds
# Explicit start and wait until completed
# Task1 could still be running
Target1.MoveTo(Target2)
```

Similar to the example above, the one below uses structured concurrency expressions:

```verse
sync:
    AsyncFunction3()  # Task 1
    block:
        Player.MoveTo(Target1)  # Task 2
        Sleep(0.5)  # Wait 0.5 Seconds
        Target1.MoveTo(Target2)
    block:  # Task 3
        Sleep(1.5)  # Wait 1.5 Seconds
        MyLog.Print("1.5 Seconds into Move_to()")
```
