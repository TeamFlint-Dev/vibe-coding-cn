# Lesson 7: Specifying the Result of a Function

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/basics-of-writing-code-7-specifying-the-result-of-a-function-in-verse>
> **爬取时间**: 2025-12-26T23:09:46.987837

---

Functions can perform actions. One thing a function can do is to give you back a value when you call it. This value is the **result**.

For example, when you call `GetRandomInt(1, 10)`, you expect to get a random integer between 1 and 10.

To change the **type of value** that you want from your function, you would change the type in the **function signature**. For example:

```verse
GetNumberOfMousetrapsYouCanAfford() : int
```

In this example, `GetNumberOfMousetrapsYouCanAfford()` has the return type `int`, so whenever you call `GetNumberOfMousetrapsYouCanAfford()` in your code, you can expect it to return an integer.

```verse
GetNumberOfMousetrapsYouCanAfford() : float
```

On the other hand, if you changed the type to `float`, it would return a different kind of value.

When your function has a return type specified, the function **body (code block)** has to produce a result that matches that type. If it doesn’t, the code won't compile — which means you have a compiler error. Ready to learn how to avoid this?

## Results and Returns

The **result** is the value that a function **returns** when it **executes (runs)**.

[Lesson 2](https://dev.epicgames.com/documentation/en-us/fortnite/basics-of-writing-code-2-basic-programming-concepts-in-verse#keywords) covered **keywords**, which are special words that are built into Verse, and that have very specific actions attached to them.

In Verse, **return** is also a **keyword** that tells a function to provide the value that results from the expression that follows the return keyword.

```verse
MyFunction() : int =
    return 5

OnBegin<override>()<suspend> : void =
   MyFunction() # result is 5
```

In the example above, this code will **return** a value of `5` when `MyFunction()` is called.

Leaving out `return` won't break your function, but it's good practice to explicitly include `return`. If you want to know more about this, see [Functions](https://dev.epicgames.com/documentation/en-us/fortnite/functions-in-verse).

### Early Returns

When your program executes a `return` expression, the program will **exit** out of the function code block immediately. This means that if you place the `return` expression before other code, the code that follows won't execute. This can be useful for exiting a function early when a specified condition is met.

The following function updates the `Coins` variable based on `CoinsPerMouseTrap`. However, the `Coins` variable must be set to a positive value to buy a mousetrap. If `Coins` is negative, the function prints an error message and immediately returns, because there’s no reason to run the rest of the code in the function body.

In fact, without return, the function would incorrectly decrease the value of `Coins` and never indicate that `Coins` was negative.

```verse
var Coins : int = -10
CoinsPerMousetrap : int = 100

BuyMousetrap() : void = 
    if (Coins < 0):
        Print("Error: Coins set to negative value")
        return
    set Coins = Coins - CoinsPerMousetrap
    Print(“Mousetrap bought! You have {Coins} coins left.”)
```

[![](https://dev.epicgames.com/community/api/documentation/image/c421ede3-b39c-449d-8d9d-5e596106e3d0?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/c421ede3-b39c-449d-8d9d-5e596106e3d0?resizing_type=fit)

Exiting a function early with `return` can introduce bugs, so it’s important to use it carefully. For example, since `return` will run before `Print(“Mousetrap bought! You have {Coins} coins left.”)` in the following code, the function will never print the new value of `Coins`.

```verse
var Coins : int = 500
CoinsPerMousetrap : int = 100

BuyMousetrap() : void = 
    if (Coins < 0):
        Print("Error: Coins set to negative value")
        return
    set Coins = Coins - CoinsPerMousetrap
    return
    Print("Mousetrap bought! You have {Coins} coins left.")
```

If you have an early `return` in your code, your code will still compile, but Visual Studio Code will warn you that the expressions after the `return` will not run.

### Void for Functions with No Useful Result

Sometimes you want a result; sometimes you don't.

If you remember types from [Lesson 2](https://dev.epicgames.com/documentation/en-us/fortnite/basics-of-writing-code-2-basic-programming-concepts-in-verse#types-and-values), then you might also remember that each type needs a particular kind of value. The list below is a very short list. Verse uses lots of types, but these are the most common, and are the foundation for using variables and constants.

| Type | What It Does | Values |
| --- | --- | --- |
| `logic` | This value type can only be true or false. | true / false |
| `int` | An integer is a whole number (not a fraction), and `int` is short for integer. | Whole numbers |
| `float` | This type is for values that are not integers, such as fractions. | Numbers with decimal points |
| `string` | This type is for any kind of text. This can be letters, numbers, punctuation, spaces, and even emojis. 😻 | Letters, numbers, punctuation, spaces, emojis |

When you create a function that doesn’t need to produce a result, you can set the function return type to `void`.

This means the last expression in the code block can produce a result of any type without generating a compiler error because the type for the function is set to **void**.

You can still use the `return` keyword for functions that have a void type — you just don’t need to provide a value with the `return` keyword.

## Summary

- The **result** is what you get back from a function when you call it.
- In a code block, the last expression will produce the **result**.
- To change the type of **value** in a function, you would change the **type** in the **function signature**.
- **Return** is a keyword that tells the function to provide the value that results from the expression following it.
- An **early return** is when the keyword return is used in a code block before the end of the block. This will cause the program to **exit** that code block immediately, without running the rest of the code in the block.
- **Void** is a type that says that the value of the function won't be used anywhere else. Or maybe it says it's just not worth bothering with. You can use void as the type for a function that doesn't need to produce a result.

## Practice Time

[![Lesson 7: Practice Time!](https://dev.epicgames.com/community/api/documentation/image/d52e97e5-9441-4b12-a72f-f58b36d330f2?resizing_type=fit&width=640&height=640)

Lesson 7: Practice Time!

Practice writing functions that return a result.](<https://dev.epicgames.com/documentation/en-us/fortnite/basics-of-writing-code-7-practice-time-in-verse>)
