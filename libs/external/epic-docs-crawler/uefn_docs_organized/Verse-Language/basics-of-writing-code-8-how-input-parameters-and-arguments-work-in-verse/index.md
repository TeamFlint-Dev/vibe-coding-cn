# Lesson 8: How Input, Parameters, and Arguments Work

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/basics-of-writing-code-8-how-input-parameters-and-arguments-work-in-verse
> **爬取时间**: 2025-12-26T23:10:21.059209

---

**Input** is information added to a program and used by code to make changes.

The function examples given in the previous lesson didn’t need any input:

```verse
GetNumberOfMousetrapsYouCanAfford() : int
```

You know this because the **parentheses** `()` in the function signature above are empty.

## Parameters

You can define the **input** a function needs by adding a **parameter** to the function signature.

**A parameter is a constant that’s declared in the function signature between the parentheses**. When a parameter is set, you can use it in the **body** of the function.

The syntax for a function that includes a parameter looks like this:

```verse
name(parameter : type) : type =
	codeblock
```

In the following example, `CoinsPerMousetrap` is now a parameter for the function `BuyMousetrap()`:

```verse
var Coins : int = 500

BuyMousetrap(CoinsPerMousetrap : int) : void =
    set Coins = Coins - CoinsPerMousetrap
    Print("Mousetrap bought! You have {Coins} coins left.")
```

What this code is saying is:

- You have a variable called `Coins` with a starting integer value of 500: `var Coins : int = 500`.
- The function called `BuyMousetrap()` takes a parameter of `CoinsPerMousetrap`. However, you don't want this function to return a value, so the type is `void`.

## Arguments

When you call a function that expects parameters, you've got to assign values to the parameters, the same way you assign values to constants.

These assigned values for functions are called **arguments** to the function.

To call the `BuyMousetrap()` function, you do so by adding an argument inside the parentheses. There are a few ways to do this.

For example:

- You could use `BuyMousetrap(CoinsPerMousetrap := 10)`, which mimics how you define the parameters for the function. The 10 is an argument to the function, and changes the value of the result.
- Remember literals from Lesson 2 and Lesson 3? You could also use a **literal value** of the same type as the parameter.
- A third way is to use a previously declared variable or constant as your argument. You can call the function using different values for the argument and get different results.

  ```verse
        var Coins : int = 500
        # After this call, Coins is 490
        BuyMousetrap(CoinsPerMousetrap := 10)
  		
        # After this call, Coins is 485
        BuyMousetrap(5)
  		
        CoinsPerMouseTrap : int = 20
        # After this call, Coins is 465
        BuyMousetrap(CoinsPerMousetrap)
  ```

[![](https://dev.epicgames.com/community/api/documentation/image/eae9e558-b370-4dc8-ba2e-0898d5039665?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/eae9e558-b370-4dc8-ba2e-0898d5039665?resizing_type=fit)

## Multiple Parameters

You can define as many parameters to the function as you want as long as you separate the parameters with commas.

The syntax for a function with two parameters looks like this:

```verse
name(parameter : type, parameter : type) : type =
    codeblock
```

When you call the function, you'll need to separate the arguments with commas again, which mimics how you define the parameters to the function.

## Summary

- A **parameter** is a constant that's declared in the function signature. It’s inside parentheses.
- An **argument** is the value assigned to the constant used in the parameter for that function.
- You have to **separate multiple parameters** in a single function with commas.

## Practice Time!

[![Lesson 8: Practice Time!](https://dev.epicgames.com/community/api/documentation/image/8e575311-aff8-46f3-8fc3-ed3ee354236e?resizing_type=fit&width=640&height=640)

Lesson 8: Practice Time!

Practice setting parameters and arguments for functions.](https://dev.epicgames.com/documentation/en-us/fortnite/basics-of-writing-code-8-practice-time-in-verse)
