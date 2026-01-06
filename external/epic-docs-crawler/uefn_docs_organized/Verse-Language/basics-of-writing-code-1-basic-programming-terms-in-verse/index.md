# Lesson 1: Basic Programming Terms

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/basics-of-writing-code-1-basic-programming-terms-in-verse
> **爬取时间**: 2025-12-26T23:09:15.760762

---

Now that you know how to get into Verse using UEFN, the next step is to make sure you have a good understanding of basic programming terms.

This lesson starts with really basic stuff. Even if you know these terms already, take a minute to review them here. Sometimes a later lesson refers to something earlier, so it's good to have the context and continuity from one lesson to the next.

## What a Program Is

A **program** is a set of instructions that tells the computer how to do something. A program tells a computer how to **receive input** (information coming in) and **return output** (information going out).

[![A program tells a computer how to receive input (information coming in) and return output (information going out)](https://dev.epicgames.com/community/api/documentation/image/27309cd8-c751-401e-8747-bdbdda51ad70?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/27309cd8-c751-401e-8747-bdbdda51ad70?resizing_type=fit)

### Verse

**Verse** is a programming language that's designed with video games and simulations in mind. This makes it well suited for game-specific needs.

### What Verse Programs Do

**A Verse program solves problems**.

But computers are very literal. Like a contract with a genie, you get exactly what you ask for. **Exactly**.

Errors occur when a programmer **assumes** what will happen instead of giving precise instructions.

[![Computers are very literal. Like a contract with a genie, you get exactly what you ask for](https://dev.epicgames.com/community/api/documentation/image/e0e76ab0-4675-4a07-ac9e-93c72e6f02de?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/e0e76ab0-4675-4a07-ac9e-93c72e6f02de?resizing_type=fit)

### Compiling

Programs are written so **humans understand** them. But a computer needs that program translated into something the **computer understands**.

[![Programs are for humans, but computers need the programs translated into their language](https://dev.epicgames.com/community/api/documentation/image/9bc20ad2-1c2f-483c-a992-30a8e0724c05?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/9bc20ad2-1c2f-483c-a992-30a8e0724c05?resizing_type=fit)

This is done with a **compiler** that converts or **compiles** the program from **human-readable language** to **machine language**.

### Algorithms

An **algorithm** is a set of instructions written to solve a problem or accomplish a task. Think of it as a model for how the program should work.

[![An algorithm is a set of instructions  written to solve a problem or accomplish a task](https://dev.epicgames.com/community/api/documentation/image/4dba02c2-d2a9-46c7-bb3b-664a45fe6d38?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/4dba02c2-d2a9-46c7-bb3b-664a45fe6d38?resizing_type=fit)

Time to feed the cat? That cat-feeding algorithm might be:

- Get a can of cat food from the shelf.
- Grab the cat’s bowl and put it on the counter.
- Place a spoon next to the bowl.
- Open the can of cat food.
- Spoon it into the cat’s bowl.
- Place the bowl where the cat can reach it.
- Wait 12 hours, then repeat.

Any of these steps out of sequence could result in an unfed cat. In order, they provide the result of a happy, fed cat.

[![Cat has been fed!](https://dev.epicgames.com/community/api/documentation/image/213ae0d4-342b-4947-abfa-6d55398c456b?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/213ae0d4-342b-4947-abfa-6d55398c456b?resizing_type=fit)

*Cat has been fed!*

When you have an algorithm that repeats, it's called a **loop**.

[![An algorithm that repeats is called a loop](https://dev.epicgames.com/community/api/documentation/image/c0a1f8ea-a1b7-4fc8-a547-d4e18073a754?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/c0a1f8ea-a1b7-4fc8-a547-d4e18073a754?resizing_type=fit)

Cat is fed twice a day, every day. This process is on a loop, and will keep running until something stops it. (If the process fails, the cat will produce a report — a loud, verbal report.)

In Fortnite Creative, when you build game mechanics with devices, you’re setting up algorithms. How can a player reach the game’s objective? Which device will forward the gameplay? What device will block it? What happens if the wrong device is used, or used in the wrong sequence?

Verse programming is a great way to create your game mechanics by converting algorithms into instructions that the computer can understand. Once you “learn the lyrics”, the tune will be fast and fun — and you’ll have a chance to create mechanics that aren’t available in Fortnite Creative!

### Testing an Algorithm

Thirsty? Let's see how an algorithm works in real life.

1. Write out an algorithm for making a nice cup of tea or coffee.
2. Follow your algorithm precisely to brew that drink.
3. When the tea is brewed and you’ve tasted it, did you find that it’s good to drink?
4. If it is, your algorithm is done.
5. If it isn’t, you’ll need to debug your steps to find out what step was missed or done incorrectly, then,
6. **Iterate** (repeat with one or more design changes) again and again until you get that perfect cup.

[![Algorithmic tea](https://dev.epicgames.com/community/api/documentation/image/93a40ffd-c39f-48fd-90aa-918f8c63181f?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/93a40ffd-c39f-48fd-90aa-918f8c63181f?resizing_type=fit)

## Source Code and Machine Code

**Source code**, or **code** for short, is the program written by a programmer. It's called **source code** because it's the version of the program as it was written — it's the **source** of the program.
**Machine code** is what you get when a program is **compiled** into something the computer can understand.

[![Programs are for humans, but computers need the programs translated into their language](https://dev.epicgames.com/community/api/documentation/image/062ee5a4-9bc4-436a-9b1c-818b9235b393?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/062ee5a4-9bc4-436a-9b1c-818b9235b393?resizing_type=fit)

**Code** and **program** are used interchangeably, and **programmers** are sometimes called **coders**.

### Execution

When a computer performs the steps in a program, it **runs** or **executes** that program. Where the code does not execute as expected, or when it fails to compile, there are **errors** in your code.

## Errors in Code

There are two ways errors in code can show up:

- **Compiler errors** — where the code fails to compile into language the computer can understand.
- **Bugs** — where the code compiles successfully, but the program doesn't run as expected.

### Compiler Errors

The most common cause of **compiler errors** is incorrect **syntax**. (We'll talk about **bugs** a little later.)
Every programming language follows a precise set of rules called **syntax**. (These rules can vary from one program to another, but these lessons focus on Verse syntax.)

**Syntax is how words and symbols are combined** so the compiler can understand and compile the programmer’s instructions.

Syntax covers the words and symbols you can use in your code, and how they need to be arranged for the compiler to successfully compile.

In English, **subject (noun) | verb** is standard syntax, with the subject first and the verb following. The sentence **"Kitty sleeps"** follows these syntax rules. But if you say **"Sleeps kitty"**, someone else might wonder what you were talking about. This is even more true in programming. Remember the contract with the genie at the beginning of this lesson?

[![Remember the contract with the genie?](https://dev.epicgames.com/community/api/documentation/image/2898feef-b079-443e-b70a-370a27627522?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/2898feef-b079-443e-b70a-370a27627522?resizing_type=fit)

*Remember the contract with the genie?*

**Verse code is case sensitive.** What this means is that if something should be capitalized and isn't, or if it shouldn't be capitalized but is, Verse will treat this as an error in the syntax and your code won't compile. It's also important to use spaces the way they're shown in syntax.

| An Expression With Correct Syntax | The Same Expression With Incorrect Syntax |
| --- | --- |
| `Print("Hello, world!")` | `Print("Hello, World!"` |

There's a compiler error in the second example because it's missing a closing `)`.

Errors in syntax are **compiler errors** because they prevent code from compiling successfully.

### Bugs

Bugs are what happens when the program executes but does something weird or unexpected.

While syntax is about words and symbols and how they are arranged, **semantics** is about what those lines of code actually **mean**.

For example, in English, a basic sentence takes a subject and a verb. The subject is **who or what**, and the verb is what the subject (a noun) is **doing or being**.

**Subject (noun) | verb** (the syntax) doesn’t communicate the meaning **Kitty sleeps** (the semantics).

[![Kitty sleeps](https://dev.epicgames.com/community/api/documentation/image/93c1729d-751b-40e5-a67b-baa6c6402d98?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/93c1729d-751b-40e5-a67b-baa6c6402d98?resizing_type=fit)

And an error in your code's **meaning** can produce a **bug**.

| A Correct Expression | The Same Expression with a Bug |
| --- | --- |
| ```verse # If at least one mouse is caught, you win if (MiceCaught > 0):     Print("Win!") else:     Print("Lose!") ``` | ```verse # If at least one mouse is caught, you win if (MiceCaught > 1):     Print("Win!") else:     Print("Lose!") ``` |

There's a bug in the second example because `MiceCaught` has to be greater than `1` for the `Print(“Win!”)` expression to be executed.

Another way of looking at this is based on what happens when the program executes. Is the result what you expected? Or did something go wrong?

In the example above on the right, the player doesn't win by catching a mouse because the code says that you have to catch greater than one mouse to win. If there is only one mouse to be caught, there will never be a win condition. So while the program would compile correctly, the result would not be what you (or the player) would want.

## Summary

- A **program** tells the computer how to do something by determining how it can **input** and **output** information.
- A computer is very **literal**, and does exactly what you tell it to do — even when you tell it the wrong thing.
- A program has to be **compiled** from human language to computer language.
- An **algorithm** is a kind of model that shows how a program should work.
- **Source code** is what humans can read and write. **Machine code** is what computers can understand and **execute**.
- **Semantics** is what the code means.
- **Syntax** is the set of rules for writing code.
- **Compiler errors** are errors that prevent a program from compiling.
- **Bugs** are when the code compiles successfully, but the program doesn't run as expected.

## Practice Time!

[![Lesson 1: Practice Time!](https://dev.epicgames.com/community/api/documentation/image/c06998da-abd6-436c-aa93-21e70e2a26fe?resizing_type=fit&width=640&height=640)

Lesson 1: Practice Time!

Practice writing algorithms until you're comfortable with how they work.](https://dev.epicgames.com/documentation/en-us/fortnite/basics-of-writing-code-1-practice-time-in-verse)
