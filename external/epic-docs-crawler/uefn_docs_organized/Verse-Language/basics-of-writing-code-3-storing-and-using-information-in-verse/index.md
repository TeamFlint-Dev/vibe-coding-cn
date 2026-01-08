# Lesson 3: Storing and Using Information

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/basics-of-writing-code-3-storing-and-using-information-in-verse>
> **爬取时间**: 2025-12-26T23:09:53.888901

---

In Lesson 2, you saw some of the more common **types** and the **operations** and **values** associated with them. It's time to start learning how to use these types and values in your code.

The **values** that expressions use are sometimes referred to as **information** or **data**. Programs need data to know what to do, and there are different ways to store the data, or values.

There are also different kinds of data.

## Mutable and Immutable

**Mutable** means capable of changing. Think of a mutant — someone whose DNA code has changed, or mutated.

Waves along the shore are mutable, and change constantly.

[![Waves along the shore are mutable, and change constantly](https://dev.epicgames.com/community/api/documentation/image/ddea64cb-fdc8-414f-a9a9-399b833d75e6?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/ddea64cb-fdc8-414f-a9a9-399b833d75e6?resizing_type=fit)

When something is **immutable**, it cannot be changed. If you don't think about earthquakes, tidal waves, explosions or erosion, the cliff overlooking the beach is immutable.

[![The cliff overlooking the beach is immutable](https://dev.epicgames.com/community/api/documentation/image/b8c3a8fc-5b7e-40ea-a54e-74f838972cca?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/b8c3a8fc-5b7e-40ea-a54e-74f838972cca?resizing_type=fit)

But what does this have to do with code?

When a value cannot be changed while the program is running, it is **immutable**. If the value changes while the program is running based on input from somewhere else, the value is **mutable**.

Verse comes with **built-in** types that support the basic operations that most programs need in order to run. These built-in types are the foundation for using **variables** and **constants** in Verse.

## Variables and Constants

In programming, you use **variables** and **constants** to store values that your program uses.

When the program needs data to determine what happens next, the computer's calculations and decisions are based on the values stored in the variables and constants in the code.

Although the term **variable** is sometimes used generically to include both variables and constants, there is one important difference: **variables can change their values** while a program is running, but **constant values cannot be changed** while the program is running. In other words, the value for a **variable is mutable**, while the value for a **constant is immutable**.

### Syntax for Variables and Constants

The syntax for a **variable** is:

[![var name : type = value](https://dev.epicgames.com/community/api/documentation/image/e1cd385f-a0b7-4bd9-a67a-f114527ac370?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/e1cd385f-a0b7-4bd9-a67a-f114527ac370?resizing_type=fit)

The `var` at the beginning of the line shows that it's a variable.

The basic syntax for a **constant** is:

[![name : type = value](https://dev.epicgames.com/community/api/documentation/image/ab554251-adde-441f-8849-0ac283ec79b2?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/ab554251-adde-441f-8849-0ac283ec79b2?resizing_type=fit)

Note that the **only** difference in syntax for a variable and a constant is that `var` is removed for a constant but included for a variable.

Now to unbox what this syntax says:

|  |  |
| --- | --- |
| `name` | The `name` is a **unique name** the programmer gives to this variable or constant.  Remember that `var` is not part of the name, but only indicates that it is a variable, and not a constant. When you want to refer to this variable in the program, the **name** is what you'll use. |
| `type` | **Type** explains what can be done with the value in this variable.  Note that a colon **:** separates the name and type. |
| `value` | For a constant, this value will remain, well, constant. For a variable, this is the value that the variable starts with, although it can change (vary) during program execution. This is the **initial value**.  Note that a **`=`** separates the type and its value.  Setting an initial value for a variable is optional, but it’s good practice to do so.  Setting the value is required for a constant. |

### Identifier

An **identifier** is the **unique name** a programmer gives to an expression.

The words **identifier** and **name** are synonymous.

### Naming Rules and Conventions

There are rules for naming things in Verse. When creating variables and constants, keep these naming rules in mind:

- As much as possible, give your variables (and other expressions) names that **indicate what they do**.
- It's good practice to name your variables in a consistent way that will make your code easier to read by others (and easier for you to remember!).
- The first character in the identifier must be either a letter or the underscore (\_) character.
- Characters past the first character must be letters, numbers, or the underscore character. You can also have more than one underscore in the name, or even two or more underscores together.
- Neither variable nor constant identifiers can contain spaces.
- **Verse is case sensitive**, so it's important to be consistent in your capitalization. If you're not, this will cause errors in your code.

For a full guide on naming conventions in Verse, check out the [Verse Code Style Guide](https://dev.epicgames.com/documentation/en-us/fortnite/verse-code-style-guide-in-unreal-editor-for-fortnite).

### Declaring a Variable

Each variable or constant has three basic parts: an **identifier** (the name), the **type** of value it can store, and the **value** itself.

```verse
var name : type = value
```

[![Coins for help catching a mouse](https://dev.epicgames.com/community/api/documentation/image/fb578d76-634f-49ce-8bb5-97c5672073a3?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/fb578d76-634f-49ce-8bb5-97c5672073a3?resizing_type=fit)

In Verse, you create a variable by **declaring** it. To declare it, the variable must have all three parts: the identifier, the type, and the value.

### Initialization

Setting an **initial value** to a constant (or any other expression) is called **initialization**. Initializing is required when you **declare** a variable or constant.

With the `: =` **operator**, you can initialize values in a constant or variable.

Note that with this operator, the **name** goes before the **`:`**, the **type** goes between the **`:`** and the **`=`**, and the **value** comes after the `=`.

```verse
var Coins : int = 500
```

### Using Constants Effectively

When you have a value that shows up in multiple places in your code, and that never changes, it's smart to use a constant.

Remember literals from [Lesson 2](learn-code-basics-2-basic-programming-components-in-verse#literals)? A **literal is a value that never changes**. Ideally, you should use literals sparingly.

For example, if your game lets the player buy a mousetrap with one hundred coins, you could write the **literal (unchanging)** value 100 into the program wherever the code subtracts from `Coins` when the player buys a mousetrap — **or** (and this is so much better!) you could declare and use a constant, like `CoinsPerMousetrap`, that holds the value **100**.

```verse
CoinsPerMousetrap : int = 100
```

[![Mouse caught in a trap](https://dev.epicgames.com/community/api/documentation/image/0028dc26-945d-44e2-88e0-0a77a1ab606b?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/0028dc26-945d-44e2-88e0-0a77a1ab606b?resizing_type=fit)

Using constants this way makes your code easier to read for both you and your teammates, in case someone returns later to modify some code that hasn't been touched in a long time.

Your code will also be easier for other programmers to understand when you use **well-named constants** instead of unexplained literal values.

Another advantage of using constants this way is that if you decided to modify a value, such as how much a mousetrap should cost, you would only have to update the constant, not every single instance where that value is used.

Use clear names for your constants when possible. The example above, `CoinsPerMousetrap` clearly represents a constant for the number of coins the player will spend to buy a mousetrap.

**When you have a value that will not be changing, store that value with a constant.**

### Assigning a Value to a Variable

Unlike constants, variable values can be changed while the program is running.

Constants save you from having to enter the same value over and over, but what’s the advantage of using a variable?

Well, sometimes you want to be able to change a value based on some other input.

For example, when the player buys a mousetrap, you might use this line of code to subtract the number of coins the player spends on a mousetrap from the total number of coins the player has:

```verse
set Coins = Coins - CoinsPerMousetrap
```

[![Cat with coins buying mousetrap](https://dev.epicgames.com/community/api/documentation/image/810f6fff-5a2a-4448-ab97-ef27e8be6a99?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/810f6fff-5a2a-4448-ab97-ef27e8be6a99?resizing_type=fit)

Let's break this line of code down:

The first part, `set`, is a **keyword** built into Verse. The keyword `set` can be used to change a variable’s value, so this line of code is saying that `Coins` can be changed to equal the value of `Coins` minus `CoinsPerMousetrap`.

This change of value using `set` can only be done with a variable. You cannot use `set` with a constant.

Both `Coins` and `CoinsPerMousetrap` in this case would be **identifiers** for **expressions** that already exist in the program.

## Summary

- **Variables** and **constants** are both used for **storing values**.
- The primary difference between the two is that the value for a constant can’t be changed while the program is running, but the variable value can.
- Variables and constants are expressions that **produce results** when **evaluated**.
- Variables and constants are **declared** in Verse. This is done by giving the expression a unique name or **identifier**, a **type**, and a **value**.
- When you set an initial value to an expression, this is called **initialization**.

## Practice Time

[![Lesson 3: Practice Time!](https://dev.epicgames.com/community/api/documentation/image/15eba8e2-7ca7-47f8-941a-0c6e0f17b5f4?resizing_type=fit&width=640&height=640)

Lesson 3: Practice Time!

Practice working with constants and variables.](<https://dev.epicgames.com/documentation/en-us/fortnite/basics-of-writing-code-3-practice-time-in-verse>)
