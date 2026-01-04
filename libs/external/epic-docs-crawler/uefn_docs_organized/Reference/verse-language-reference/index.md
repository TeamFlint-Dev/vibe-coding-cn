# Verse Language Reference

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/verse-language-reference
> **爬取时间**: 2025-12-26T22:57:17.994609

---

These pages describe the Verse programming language and its [syntax](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#syntax). Spend time getting familiar with the language, then use these pages as reference.

If this is your first time using Verse, or if you're learning programming for the first time, make sure to check out [Programming with Verse](https://dev.epicgames.com/documentation/en-us/fortnite/programming-with-verse-in-unreal-editor-for-fortnite) to help you get started. You'll also find a useful [onboarding guide](https://dev.epicgames.com/documentation/en-us/fortnite/onboarding-guide-to-programming-with-verse-in-unreal-editor-for-fortnite).

## What Is Verse?

**Verse** is a programming language developed by **Epic Games** that you can use to create your own gameplay in **Unreal Editor for Fortnite**, including customizing your devices for **Fortnite Creative**.

Verse’s **primary** design goals:

- **Simple** enough to learn as a first-time programmer.
- **General** enough for writing any kind of code and data.
- **Productive** in the context of building, iterating, and shipping a project in a team setting, and integrating code and content.
- **Statically verified** to catch as many categories of runtime problems as possible at compile time.
- **Performant** for writing real-time, open-world, multiplayer games.
- **Complete** so that every feature of the language supports programmer abstraction over that feature.
- **Timeless** — built for the needs of today, and for foreseeable future needs, without being rooted in the past artifacts of other languages.

The design goals above informed key features of the Verse programming language:

- **Strongly typed** to minimize opportunities for uncaught errors in development or deployment and support [static checking](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#static-checking).
- **Multi-paradigm** to use the best of [functional programming](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#functional-programming), [object-oriented programming](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#object-oriented-programming), and [imperative programming](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#imperative-programming), such as being as [deterministic](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#deterministic) as possible. One example of this is that data is [immutable](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#immutable) by default, and given the same code and data, results will always be exactly the same.
- There is no distinction between [statements](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#statement) and [expressions](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#expression). In Verse, **everything is an expression**, which means that everything has a [result](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#result).
- **Failure is control flow**. Instead of using true / false values to [change the flow](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary) of your program (such as with decision points), Verse uses [failable expressions](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary), which produce a value if they succeed or don’t if they fail. Failable expressions can only be executed in **failure contexts**, such as [if expressions](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#if-expression).
- The ability to do **speculative execution** within [failure contexts](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#failure-context), meaning you can try out actions without [committing](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#commit) them. When an expression succeeds, the effects of the expression are **committed**, but if the expression fails, the effects of the expression are [rolled back](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#rollback) as though the expression never happened. This way, you can [execute](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#execute) a series of actions that accumulate changes, but those actions will be undone if a failure occurs in the failure context.
- \*\*[Concurrency](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#concurrent) at the language level so you don’t need to rely on system-level [threads](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#thread) across multiple processors to perform actions simultaneously. You can author time flow the same as you do [control flow](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary) by using built-in concurrency expressions in the language.

Epic Games is continuing to develop the Verse programming language and add more features. For Verse code that you write today, you can expect Verse to provide backward compatibility and continue to work with future updates to the language.

## Explore the Language

Use the following pages as a reference for the Verse programming language.

[![Verse Language Version 1 Updates and Deprecations](https://dev.epicgames.com/community/api/documentation/image/74fe9ce0-2ca4-4360-8679-f18abeaab8d9?resizing_type=fit&width=640&height=640)

Verse Language Version 1 Updates and Deprecations

Learn about the new updates and deprecations in Version 1 of the Verse Language.](https://dev.epicgames.com/documentation/en-us/fortnite/verse-language-version-updates-and-deprecations-in-verse)[![Expressions](https://dev.epicgames.com/community/api/documentation/image/c37faf69-530a-43bf-bc8a-9d9e8ae260d0?resizing_type=fit&width=640&height=640)

Expressions

Everything in Verse is an expression and has a result. This page describes all the kinds of expressions in Verse.](https://dev.epicgames.com/documentation/en-us/fortnite/expressions-in-verse)[![Comments](https://dev.epicgames.com/community/api/documentation/image/3fec29ad-e436-4aa3-8e8d-26b10fdda562?resizing_type=fit&width=640&height=640)

Comments

A code comment explains something about the code. Comments are ignored when the program runs.](https://dev.epicgames.com/documentation/en-us/fortnite/comments-in-verse)[![Constants and Variables](https://dev.epicgames.com/community/api/documentation/image/23053a8e-7fc5-4131-bc0d-28e88b7dad3d?resizing_type=fit&width=640&height=640)

Constants and Variables

Variables and constants can store information, or values, that your program uses.](https://dev.epicgames.com/documentation/en-us/fortnite/constants-and-variables-in-verse)[![Common Types](https://dev.epicgames.com/community/api/documentation/image/d8ac2b0a-4d2e-47b1-be34-e7bd6bcf7cde?resizing_type=fit&width=640&height=640)

Common Types

Common types support the fundamental operations that most programs use.](https://dev.epicgames.com/documentation/en-us/fortnite/common-types-in-verse)[![Operators](https://dev.epicgames.com/community/api/documentation/image/dcf71d76-d3d9-41ff-b196-19e867d763d5?resizing_type=fit&width=640&height=640)

Operators

Operators are special functions defined in the Verse programming language to perform actions such as the math operations for addition and multiplication.](https://dev.epicgames.com/documentation/en-us/fortnite/operators-in-verse)[![Grouping](https://dev.epicgames.com/community/api/documentation/image/d4453034-a816-4d50-aaed-2f2840873125?resizing_type=fit&width=640&height=640)

Grouping

Group your Verse expressions to specify order of evaluation and improve readability.](https://dev.epicgames.com/documentation/en-us/fortnite/grouping-in-verse)[![Code Blocks](https://dev.epicgames.com/community/api/documentation/image/8a8bdd39-bdc6-4c79-b8a1-f6eccb39ffd5?resizing_type=fit&width=640&height=640)

Code Blocks

A code block is a group of expressions, and introduces a new scope for variables and constants.](https://dev.epicgames.com/documentation/en-us/fortnite/code-blocks-in-verse)[![Functions](https://dev.epicgames.com/community/api/documentation/image/0c83b436-73b1-4dd5-b00c-d00ff6658148?resizing_type=fit&width=640&height=640)

Functions

A function is reusable code that performs an action and produces different outputs based on the input you provide.](https://dev.epicgames.com/documentation/en-us/fortnite/functions-in-verse)[![Failure](https://dev.epicgames.com/community/api/documentation/image/9b230be0-e11f-4d9a-9ec2-5cfb50717c23?resizing_type=fit&width=640&height=640)

Failure

Failure is a way to control the sequence in which a program performs actions, called the control flow.](https://dev.epicgames.com/documentation/en-us/fortnite/failure-in-verse)[![Specifiers and Attributes](https://dev.epicgames.com/community/api/documentation/image/f5c11710-244a-4045-93be-f57a7d56fec8?resizing_type=fit&width=640&height=640)

Specifiers and Attributes

Learn about specifiers and attributes, and how to apply additional semantics and behavior to your Verse code.](https://dev.epicgames.com/documentation/en-us/fortnite/specifiers-and-attributes-in-verse)[![Control Flow](https://dev.epicgames.com/community/api/documentation/image/0c7e1ed5-bf97-429e-8557-1b6d1ec988a0?resizing_type=fit&width=640&height=640)

Control Flow

Control flow is the order in which a computer executes instructions. Verse has a number of ways to change the control flow of your program.](https://dev.epicgames.com/documentation/en-us/fortnite/control-flow-in-verse)[![Time Flow and Concurrency](https://dev.epicgames.com/community/api/documentation/image/020f3cee-64f2-4f7e-a621-0669587ece6b?resizing_type=fit&width=640&height=640)

Time Flow and Concurrency

You can author time flow the way you author control flow, by executing expressions simultaneously using built-in concurrency expressions in Verse.](https://dev.epicgames.com/documentation/en-us/fortnite/time-flow-and-concurrency-in-verse)[![Container Types](https://dev.epicgames.com/community/api/documentation/image/667df748-426b-44fb-922f-0cf7325e3b36?resizing_type=fit&width=640&height=640)

Container Types

Store multiple values together by using a container type.](https://dev.epicgames.com/documentation/en-us/fortnite/container-types-in-verse)[![Composite Types](https://dev.epicgames.com/community/api/documentation/image/adfe87ed-f5d8-4d82-8427-184efdb595d1?resizing_type=fit&width=640&height=640)

Composite Types

Create your own unique type from a composite type.](https://dev.epicgames.com/documentation/en-us/fortnite/composite-types-in-verse)[![Working with Verse Types](https://dev.epicgames.com/community/api/documentation/image/01a0e3be-c7d8-4216-b4b3-07274f36e940?resizing_type=fit&width=640&height=640)

Working with Verse Types

Learn how to do more with types in Verse.](https://dev.epicgames.com/documentation/en-us/fortnite/working-with-types-in-verse)[![Modules and Paths](https://dev.epicgames.com/community/api/documentation/image/ce72dfe2-d51b-4cdd-b338-b7137cea0f58?resizing_type=fit&width=640&height=640)

Modules and Paths

A Verse module is an atomic unit of code that can be redistributed and depended upon, and that you can import into your Verse file to use code definitions from other Verse files.](https://dev.epicgames.com/documentation/en-us/fortnite/modules-and-paths-in-verse)
