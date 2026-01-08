# Lesson 9: Failure and Control Flow

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/basics-of-writing-code-9-failure-and-control-flow-in-verse>
> **爬取时间**: 2025-12-26T23:09:05.300447

---

Failure can be scary, but it’s an important part of programming. You can use failure to learn how to debug, find the limits of a program, or quickly see what **not** to do!

## It’s Okay To Fail

In Verse, **failure** means something specific. It doesn’t always mean that something didn’t work. It’s a way to control what your program does.

Remember in [Lesson 4](https://dev.epicgames.com/documentation/en-us/uefn/basics-of-writing-code-4-writing-simple-code-in-verse) when you learned that you could write code to ask a **yes** or **no** question?

```verse
var Tired: logic = false
var WhatToWatch: string = “nothing”

if (Tired?):
    set WhatToWatch = “your eyelids”
else:
    set WhatToWatch = “cartoons”

Print(“You should watch {WhatToWatch}”)

# You should watch cartoons
```

The code asking the question is written as a **failable expression**. In the example above, `Tired?` is a failable expression.

Failable expressions are used to avoid errors that could make your program stop working altogether. For example, you may know that division by zero is impossible. If you tried to do this in your code, it could crash! But the following Verse code will run just fine.

```verse
if (5/0):
    Print("Whoa!")
else:
    Print("You can't do that!")
```

To avoid these kinds of errors, Verse requires that you write failable expressions in a **failure context**. Failure contexts give failable expressions a safe place to fail. In the example above, `5/0` was the failable expression, and `if()` was the failure context. Read on to learn more about both of these Verse concepts.

[![](https://dev.epicgames.com/community/api/documentation/image/d86094da-d020-491e-9c65-0d25792d27df?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/d86094da-d020-491e-9c65-0d25792d27df?resizing_type=fit)

## Failable Expressions

There are many ways to write failable expressions in Verse. If an expression is asking a yes or no question, it’s probably failable.

Here are some types of questions that failable expressions ask:

- Are these two variables greater than, less than, or equal to each other?
- Is this variable set to `true`?
- Is this variable set to a value?
- Does this expression cause an error?

If the answer to any of these questions is **yes**, the expression **succeeds**. If the answer is **no**, the expression **fails**. What happens after a success or failure depends on how you write your code.

### Comparison Expressions

**Comparison expressions**, which use comparison operators like `<` (less than), `>` (greater than), or `<>` (not equal), are failable. In the following example, `5 < 4` is a failable expression that will fail:

```verse
if (5 < 4):
    Print(“This will never print.”)
```

The expression `5 < 4` is like asking “is 5 less than 4?”. The answer is **no**, the expression fails, and the code block (indented under the `if` expression) **does not** run.

Let’s look at this next example, and the failable expression `MousetrapsSet <> MiceCaught`. It is asking “Are the values of MousetrapsSet and MiceCaught not equal?”.

```verse
MousetrapsSet := 3
MiceCaught := 0

if (MousetrapsSet<>MiceCaught):
    Print(“Need more cheese!”)
```

This time, the answer to the question is **yes** because `MousetrapsSet` is 3 and `MiceCaught` is 0, so the expression succeeds and the code block **does** run.

### Decision Expressions

Decision expressions, which use the operators `and`, `or`, and `not`, are failable. In the following example, `MousetrapsForSale > 0 and Coins >= MousetrapCost` is a failable expression that will succeed because `MousetrapsForSale` is 5 (greater than 0), `Coins` is 30 and `MousetrapCost` is 20 (30 is greater than 20). Both of the expressions succeed on their own, so the whole expression succeeds.

```verse
MousetrapsForSale := 5
MousetrapCost := 20
Coins := 30

if (MousetrapsForSale > 0 and Coins >= MousetrapCost):
    Print(“You can buy mouse traps.”)
```

### Query Expressions

Query expressions are also failable. They use the `?` operator to check certain values, such as checking if a `logic` value is `true`. In the following example, `MousetrapStoreOpen?` is a failable expression that will fail because `MousetrapStoreOpen` is `false`.

```verse
var MousetrapStoreOpen : logic = false

if (MousetrapStoreOpen?):
    Print(“Come on in!”)
```

## Failure Contexts

In all the code examples above, the `if` expression was the failure context for the failable expressions contained within the `()`. Failure contexts give failable expressions a safe place to fail because they determine what happens in the case of a failure.

You already know from a previous lesson that when an expression in an `if` fails, the code within the `if` code block does not run.

Because `if` creates a failure context, you can put as many failable expressions in its code block as you want. If any of those expressions fail, the earlier expressions in the code block will be undone, or **rolled back**.

There is another way you can write `if` expressions without using the `()`. It’s more useful if you need to write a lot of expressions. Here’s an example:

```verse
MousetrapsSet:int = 5
var MiceCaught:int = 0
var BreakTime:logic = false

if:
    MousetrapsSet > 0
    set BreakTime = true
    MiceCaught > 0

if (BreakTime?):
    Print("Take a break!")
else:
    Print("Catch some mice!")
```

All expressions in a failure context do not have to be failable, but at least one does. In the example above, `set BreakTime = true` is not failable, but the other expressions are.

In the above code, every expression indented under `if` is inside the failure context. All three expressions will execute.

- `MousetrapsSet > 0` will succeed.
- The expression `set BreakTime = true` will execute. It is not failable so there is no failure check.
- However, `MiceCaught > 0` will fail.

Since there was a failure, every expression in the `if` code block will be rolled back, including `set BreakTime = true`. It will be like that code never ran at all. If you run this code, you will see that “Catch some mice!” is printed.

When programming, you’ll see that a lot of code only works if other code runs successfully. This is another reason why failure contexts are so useful. If you group dependent code into failure contexts, you can avoid some common bugs. Remember the code you used in Lesson 4 to decide whether to go to the movies? Now that you’ve decided to go with your friends, you need to get them their tickets, drinks, and snacks!

```verse
var Drinks:int = 4
var Snacks:int = 4
var Tickets:int = 3
var FriendsAvailable:int = 4

if:
    Drinks >= FriendsAvailable
    set Drinks -= FriendsAvailable
    Snacks >= FriendsAvailable
    set Snacks -= FriendsAvailable
    Tickets >= FriendsAvailable
    set Tickets -= FriendsAvailable

 Print("Drinks Left: { Drinks }")
 Print("Snacks Left: { Snacks }")
 Print("Tickets Left: { Tickets }")
```

The operator `-=` is a shortcut for combining **subtraction** and **assignment**. In the above example, `set Tickets -= FriendsAvailable` is equivalent to `set Tickets = Tickets - FriendsAvailable`. This also works with addition (`+=`), multiplication (`*=`), and division (`/=`).

You have enough drinks and snacks for your available friends, but not enough tickets. That means you and all your friends can’t see the movie. You might write some code to handle that situation, but you probably don’t want to give out your drinks and snacks.

Luckily, when the expression `Tickets >= FriendsAvailable` runs, it will fail and all the code in the `if` block will roll back. That means that the `Drinks` and `Snacks` variables will both go back to having the value `4`.

## Summary

- In Verse, **failure** is a way to control your program.
- **Failure expressions** can either succeed or fail, and they must be written in a failure context. What happens after a success or failure depends on how your code is written.
- **Failure contexts** give failure expressions a safe place to fail. Any failure within a failure context causes all the code within that context to **roll back**, as though it never ran.

## Practice Time

[![Lesson 9: Practice Time!](https://dev.epicgames.com/community/api/documentation/image/fcc46b69-bd24-4ce0-af92-2ca6b6800c72?resizing_type=fit&width=640&height=640)

Lesson 9: Practice Time!

Practice using failable expressions and failure contexts.](<https://dev.epicgames.com/documentation/en-us/fortnite/basics-of-writing-code-9-practice-time-in-verse>)
