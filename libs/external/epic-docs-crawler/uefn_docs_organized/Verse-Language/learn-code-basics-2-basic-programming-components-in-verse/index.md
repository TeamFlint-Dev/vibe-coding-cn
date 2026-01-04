# Lesson 2: Basic Programming Components

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/learn-code-basics-2-basic-programming-components-in-verse
> **爬取时间**: 2025-12-27T00:31:35.085600

---

Ready for another plate of programming knowledge? Things are about to get a little more tasty!

## What Goes into Code

### Expressions

An **expression** is the smallest unit of code that produces a result. For example, `1+2` is an expression that gives an output of `3` when the program runs.

```verse
Print("{1 + 2}")
```

`Print` is a built-in function that tells the program to display whatever you put into the parentheses. In this case, `"{1 + 2}"` tells the program to calculate what 1 + 2 equals, and the sum will be printed when you open the log.

### Values

A **value** is the information your program uses to operate. Examples of values are numbers or text.

### Results

When an expression executes, then outputs a value, that value is a **result**.

### Evaluation

To **evaluate** is to execute an expression in order to produce a value. Note that **evaluate** and **value** come from the same root word.

### Operators

An **operator** is a symbol that represents an **operation** like addition (**+**), or greater than (**>**).

[![One cat plus one cat is greater than one mouse](https://dev.epicgames.com/community/api/documentation/image/319f6e4b-d5a3-41eb-ac02-7604c668d983?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/319f6e4b-d5a3-41eb-ac02-7604c668d983?resizing_type=fit)

*One cat plus one cat is greater than one mouse.*

## Parts of an Expression

You learned earlier that **an expression is the smallest unit of code that produces a result**.

To expand this further, **an expression is a combination of operations and values that outputs a result when evaluated**.

Here's how you can use what's called an `if .. else` expression.

```verse
if (MiceCaught > 0):
    Print("Win!")
else:
    Print("Lose!")
```

The result is “Win!” or “Lose!”.

[![If mice caught, then win!](https://dev.epicgames.com/community/api/documentation/image/2834c1cc-e87d-42e4-a2f8-38ea20a547e4?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/2834c1cc-e87d-42e4-a2f8-38ea20a547e4?resizing_type=fit)

This means that **if** one or more mice are caught, the player wins — or **else**, no mice are caught and the player loses.

### Keywords

Some words are built into the Verse language, and have very specific actions attached to them. These are called **keywords**.

In the example above, `if` is a **keyword** that means a condition must be met (if one mouse is caught…). The other keyword, `else`, means that if the condition is not met, there’s a different result.

Verse uses keywords to make writing a program easier because so much information on what a program should do is packed into each one.

Keywords are **reserved** in Verse for their specific built-in uses, so you can't use these words to name other things. More on this in the next lesson!

### Operations

An **operation** is an action or process that can be performed on data. These operations are represented by **symbols**, called **operators**. The data, such as numbers, that an operator performs operations on are called **operands**.

[![An operation has operators and operands](https://dev.epicgames.com/community/api/documentation/image/6374fa3b-01ca-47c4-a68c-5e41e1281fea?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/6374fa3b-01ca-47c4-a68c-5e41e1281fea?resizing_type=fit)

Examples of operators include:

| Operator | What it does |
| --- | --- |
| **Addition** `+` | The **+** operator adds two number values together. |
| **Subtraction** `-` | The **-** operator subtracts the second number from the first. |
| **Multiplication** `*` | The **\*** multiplies two numbers together. |
| **Division** `/` | The **/** operator divides the first number by the second number. |
| **Equality** `=` | The **=** operator checks to see if two things are equal. For example:  ```verse if (MiceCaught = MiceInArea):     Nap() else:     LookForMice() ``` |
| **Query** `?` | The **?**  checks if a specific type of value is true. |

There are more operators than these, but this is a good place to start!

### Types and Values

So far, you've learned that a value is information that the program needs to do something, and that operations can be performed on this information (data).

The **type** says what kind of operation the program can do on a stored value.

Each type has specific **operations** associated with it, and those operations require specific kinds of **values**.

There are many different types, but below are the most common ones.

| Type | What It Does | Values |
| --- | --- | --- |
| `logic` | This value type can only be **true or false**. It can’t be anything in between, and it can’t be both. If you’ve ever heard of Boolean logic (on/off or 0/1), this is the Verse equivalent. | true / false |
| `int` | An **integer** is a **whole number** (not a fraction), and `int` is short for integer. So `int` means the values for this type must be whole numbers (positive or negative). Examples of integers are 1, -30, or 777.  For fractional numbers, you'd use a `float`. | Whole numbers |
| `float` | This type is for values that are not integers, such as **fractions**. For example, 1.25 would take a `float` type. It’s called a float because it uses a decimal point that is not in a fixed position, but instead can "float" (move) to wherever it's needed in a string of numbers.  For example, the following numbers are all floats: 10.25, 1.375, 12.0.  Note that 12.0 represents a whole number value. All integers can be expressed as float values — 1 would be 1.0, and 777 would be 777.0 — but floats cannot be expressed as ints unless they are integers. | Numbers with decimal points |
| `string` | This type is for any kind of **text**. This can be letters, numbers, punctuation, spaces, and even emojis. 😻 For example, in [Modify and Run Your First Verse Program](run-your-first-verse-program-in-unreal-editor-for-fortnite), the line of code that reads `Print("Hello, world!")` says to print a string that says "Hello, world!". | Letters, numbers, punctuation, spaces, emojis |

### Literals

A **literal** is an unchanging value in the Verse programming language, like a number or another character. You would only want to use a literal when you know that the value will never change.

For example, with the **logic** type, there are two literals possible, **true** and **false**, because their values don't change. True is always true. False is always false.

You'll learn more about literals and how to use them in the next lesson.

## Summary

- When code is **executed** (run), **expressions** in the code are **evaluated**.
- The evaluation produces a **result**.
- **Keywords** are special words in Verse that have very specific actions attached to them.
- A **value** is information a program uses to do something.
- The **type** says what kind of operation the program can do with a value.
- **Literals** are values that don't change.

## Practice Time!

[![Lesson 2: Practice Time!](https://dev.epicgames.com/community/api/documentation/image/2d9d14dc-2c80-460c-bd67-38f67036ccb3?resizing_type=fit&width=640&height=640)

Lesson 2: Practice Time!

Time to write some simple code using Verse.](https://dev.epicgames.com/documentation/en-us/fortnite/basics-of-writing-code-2-practice-time-in-verse)
