# Control Flow

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/control-flow-in-verse>
> **爬取时间**: 2025-12-27T00:02:12.847897

---

Code is generally [executed](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#execute) line by line, in the order the [expressions](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#expression) appear. This is called **sequential execution**. You can, however, change the order in which expressions are executed by using **control flow** expressions.

For example, you can make decisions about what expressions to execute next using [if](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#if-expression) and [case](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#case-expression) expressions, or repeat a sequence of expressions more than once with [loop](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#loop) and [for](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#for-expression). The following pages describe these expressions in detail, and include examples of how to use them.

[![Profile](https://dev.epicgames.com/community/api/documentation/image/372fefe1-e839-42c4-9ad3-4f0aa2f958e6?resizing_type=fit&width=640&height=640)

Profile

Learn how to instrument your code to measure performance.](<https://dev.epicgames.com/documentation/en-us/fortnite/profile-in-verse)[![Block>](<https://dev.epicgames.com/community/api/documentation/image/9b599e90-da80-4c69-b755-137eedd63ce7?resizing_type=fit&width=640&height=640>)

Block

The block expression is how you nest code blocks, and behaves similarly to the general code blocks.](<https://dev.epicgames.com/documentation/en-us/fortnite/block-in-verse)[![If>](<https://dev.epicgames.com/community/api/documentation/image/9a09b0b9-0e2a-4101-840f-a701f5a5fe65?resizing_type=fit&width=640&height=640>)

If

The if expression is how you make a decision, based on one or more conditions, about what expressions should be executed next.](<https://dev.epicgames.com/documentation/en-us/fortnite/if-in-verse)[![Case>](<https://dev.epicgames.com/community/api/documentation/image/fd443a7a-f3b5-4331-9e27-6ab01a50d608?resizing_type=fit&width=640&height=640>)

Case

The case expression is how you make a decision, from a list of choices, about what expressions should be executed next.](<https://dev.epicgames.com/documentation/en-us/fortnite/case-in-verse)[![Loop> and Break](<https://dev.epicgames.com/community/api/documentation/image/6d19d425-47dd-427c-b8b1-53789a4582cc?resizing_type=fit&width=640&height=640>)

Loop and Break

The loop expression repeats the expressions in its code block. End the loop with either a break or return.](<https://dev.epicgames.com/documentation/en-us/fortnite/loop-and-break-in-verse)[![For>](<https://dev.epicgames.com/community/api/documentation/image/9a4304ce-5b66-4eb9-8010-dc83d0f8abf3?resizing_type=fit&width=640&height=640>)

For

The for expression iterates over a bounded number of items and repeats the expressions in its code block the same number of times.](<https://dev.epicgames.com/documentation/en-us/fortnite/for-in-verse)[![Defer>](<https://dev.epicgames.com/community/api/documentation/image/fa418148-d656-4c6c-af16-6622094e8b6f?resizing_type=fit&width=640&height=640>)

Defer

Use the defer expression to execute code just before exiting the current scope.](<https://dev.epicgames.com/documentation/en-us/fortnite/defer-in-verse>)

Verse has more expressions you can use to change the **time flow** of a program by executing expressions simultaneously. For more details, see [Concurrency](https://dev.epicgames.com/documentation/en-us/fortnite/time-flow-and-concurrency-in-verse).
