# Lesson 5: Calling Functions

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/learn-code-basics-5-writing-reusable-code-in-verse
> **爬取时间**: 2025-12-27T00:31:25.337492

---

So far, you've learned how to create constants and variables to store and use values, and how to make decisions in code using the `if` expression and decision operators like `and` and `or`.

Now it's time to learn how to write code that you can easily reuse in your program.

Remember from [Lesson 2](https://dev.epicgames.com/documentation/en-us/fortnite/basics-of-writing-code-2-basic-programming-concepts-in-verse#expressions) that an **expression** is the smallest unit of code that produces a result? And that when an expression **executes** and outputs a value, that the value that it outputs is the **result**?

You can take advantage of this to make your code more efficient.

Expressions can be combined with other expressions to create **functions**, and functions can be used over and over in your code without having to rewrite what they do each time.

## Using Expressions in Functions

A **function** (also referred to as a **routine**) is reusable code that provides instructions for performing an action, or for creating an output based on input.

Functions are made up of combined **expressions**.

To define a function, you need:

- A unique name, or **identifier**.
- The **type** of information that will result.
- What the function will **do when it is called**.

This is the basic syntax for a function:

```verse
name() : type =
    codeblock
```

[![Code kitty paw pushing code to indent](https://dev.epicgames.com/community/api/documentation/image/abd4ae28-bf69-41f2-9365-ecebb40a45e1?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/abd4ae28-bf69-41f2-9365-ecebb40a45e1?resizing_type=fit)

You'll learn more about code blocks in the next lesson, but for now you just need to know that the code block is where you'll put the expressions you use to build your function.

## Functions and Function Calls

A **function** is basically a **sequence of expressions** that you have named.

A program uses a function by **calling** that function by its name. The call **invokes** (activates) that function. This is a **function call**.

What this means is that instead of repeating all of the expressions you put in a function over and over, you can group them together into the named function, then each time you call that function in the program, the computer will refer back to that function and execute the expressions in it.

For example, instead of `CoinsPerMousetrap` always having the value `100`, you could write code that would change the value by choosing a random value each time it runs.

[![Coins for helping catch a mouse](https://dev.epicgames.com/community/api/documentation/image/16643a48-7fa7-4a73-bf61-84d563dd8852?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/16643a48-7fa7-4a73-bf61-84d563dd8852?resizing_type=fit)

In the example below, the expression is set to generate a random number from one to ten using the expression `GetRandomInt(1, 10)`.

Here's how it breaks down:

|  |  |
| --- | --- |
| `GetRandomInt()` | This is a built-in function in Verse that means pretty much what it sounds like — it generates a random integer. |
| `1, 10` | Shows the numeric range it can generate in. If you were to use `20, 50`, it would generate a number from twenty to fifty. Note that the range goes inside the `()`, which is part of this expression's name. |

This is a **function call** because it tells the computer to call the function that gets a random integer in the range you set from 1 to 10.

When you want to use a **function** in your code, you can call the function by **name**. Each time you call `GetRandomInt()`, a new random number will be generated.

You could use this to randomly change the price of a mousetrap:

```verse
using { /Fortnite.com/Devices }
using { /Verse.org/Simulation }
using { /UnrealEngine.com/Temporary/Diagnostics }
using { /Verse.org/Random }

OnBegin<override>()<suspends> : void =
    # Initialize Coins to 500. Because it is a var, you can change it later.
    var Coins : int = 500

    # Initialize CoinsPerMousetrap with a random integer between 1 and 100
    CoinsPerMousetrap : int = GetRandomInt(1, 100)
    
    # Print the current value of Coins (500) to the log.
    Print("Coins starts at {Coins}.")

    # Decrease Coins by CoinsPerMousetrap, and print the new value to the log.
    set Coins = Coins - CoinsPerMousetrap
    Print("After buying one mousetrap, Coins is {Coins}.")
```

Notice how almost every line of code in the example above has a comment that explains what the code does. This is helpful both for you when you return to your code after some time has gone by, and for any other programmers who want to add to or modify the code you wrote.

### Methods

Remember back in [Lesson 2](https://dev.epicgames.com/documentation/en-us/fortnite/basics-of-writing-code-2-basic-programming-concepts-in-verse#types-and-values) when you learned about how a type defines which operations can be performed on values stored in a variable or constant? There are also other things that types do.

The same way that types have operations that belong to them, they also have functions that belong to them. These functions are known as **methods**, and must be called in a special way.

Instead of calling them by just writing their name (like `Print()` or `GetRandomInt()`) a **method call** must start with the name of a variable (or constant) followed by a `.`, then the name of the method. For example, calling the method `Pounce()` on a variable `Cat` would look like this:

```verse
Cat.Pounce()
```

[![Cat pounces](https://dev.epicgames.com/community/api/documentation/image/2ad9bfe1-578f-441d-9134-cec54307bb1e?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/2ad9bfe1-578f-441d-9134-cec54307bb1e?resizing_type=fit)

### Classes

A **class** is a template you can use to create things that have similar behaviors and properties. A class is a **composite** type, which means it is made up of a bundle of data from other types.

When you define a class, the data for that class can be **inherited** by any **subclasses**.

A method, then, is a function that's attached to a class. Because of this, not every method works with every type. The method has to be declared in the class definition for that type, or in a class that type inherits from. If this doesn't fully make sense yet, don't worry — this is just a quick introduction, and you'll get more on classes later.

## Summary

- A **function** is a named sequence of expressions that you can **reuse**.
- Functions are also known as **routines**.
- Functions save time and reduce errors because you don't have to repeatedly type (or maintain) multiple lines of the same code.
- When you reuse a function in a line of code, you do this with a **function call**.
- A **method** is a function that belongs to a certain type, and must be called on a variable or constant of that type.
- **Classes** are **composite** types that let you combine data from other types then share the behaviors and properties with **subclasses**

## Practice Time!

[![Lesson 5: Practice Time!](https://dev.epicgames.com/community/api/documentation/image/2bdb697c-07e8-40e3-a869-4a6289edadac?resizing_type=fit&width=640&height=640)

Lesson 5: Practice Time!

Ready to call some functions? Start!](https://dev.epicgames.com/documentation/en-us/fortnite/basics-of-writing-code-5-practice-time-in-verse)
