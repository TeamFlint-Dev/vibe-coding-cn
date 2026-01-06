# Expressions

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/expressions-in-verse
> **爬取时间**: 2025-12-27T00:02:00.887570

---

An [expression](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#expression) is the smallest unit of code that has a [result](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#result) when [evaluated](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#evaluate). In Verse everything is an expression, which means everything evaluates to a [value](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#value).

An example is an `if ... else` expression, which in Verse evaluates to a value that depends on the content of
the expression [blocks](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#code-block). The following code evaluates to a [string](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary) value, containing either “Big!” or “Small!” depending on whether `MyNumber` was greater than 5:

```verse
if (MyNumber > 5):
    “Big!”
else
    “Small!”
```

This means you can use an `if ... else` directly as input to functions instead of storing a [result](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#result) and using that result as input.

While this example is simple, there are contexts where this becomes more powerful. For example, [loops](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#loop) evaluate to arrays of values, so you can quickly create new arrays based on existing ones.

In the following code, `MyArray` will contain all the values from `NumberArray` that are less than 5.

```verse
MyArray : []int = for(Number := NumberArray, Number < 5):
    Number
```

## Failable Expressions

A **failable expression** is an expression that may succeed and produce a value, or fail and return no value. Failable expressions can only be executed in a [failure context](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#failure-context) because that context will define what happens in the event that the expression fails.

Examples of failable expressions include indexing into an [array](https://dev.epicgames.com/documentation/en-us/fortnite/array-in-verse) because an invalid index will fail, and using [operators](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#operator) such as comparing two values. For more on failable expressions in Verse, see [Failure](https://dev.epicgames.com/documentation/en-us/fortnite/failure-in-verse).

## List of Expressions in Verse

The following table describes the different kinds of expressions in Verse. Follow the links to learn more about each expression.

| Expression | Description | Is the Expression Failable? |
| --- | --- | --- |
| Literals | A [literal](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#literal) is a fixed value in your code, such as a number or a character. In Verse, there are literals for the following [types](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#type):   - `logic` - `int` - `float` - `string` - `option` - `enum` |  |
| Function Calls | A [function call](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#function-call) is an expression, and can have two forms: `FunctionName()` and `FunctionName[]`. The result type of the function call expression is defined in the function signature. Refer to [Function](https://dev.epicgames.com/documentation/en-us/fortnite/functions-in-verse) for more details. | Only when the function call has the form `FunctionName[]`, and the function definition has the `<decides>` specifier. |
| Comparison | A [comparison expression](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#comparison-expression) compares two things using one of the comparison operators:   - `<` - `>` - `<=` - `>=` - `<>` - `=`   Refer to [Operators](https://dev.epicgames.com/documentation/en-us/fortnite/operators-in-verse) for more details. | Yes |
| Assignment | An [assignment expression](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#assignment-expression) stores a value at a [mutable](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#mutable) location, such as when [initializing](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#initialize) a [constant](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#constant) or changing the value of a [variable](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary). Refer to [Variables and Constants](https://dev.epicgames.com/documentation/en-us/fortnite/constants-and-variables-in-verse) for more details. |  |
| Math | A math expression performs computations using the operators:   - `+` - `-` - `*` - `/`   All of these operators also have assignment variants that can be used with pointers. Refer to [Operators](https://dev.epicgames.com/documentation/en-us/fortnite/operators-in-verse) for more details. | Only for integer division. |
| Decision | A decision expression uses the operators `not`, `and`, and `or` to give you control over the success and failure decision flow. Refer to [Operators](https://dev.epicgames.com/documentation/en-us/fortnite/operators-in-verse) for more details. | Yes |
| Query | A query expression uses the operator `?` and checks whether a logic or option value is `true`. Otherwise, the expression fails. Refer to [Operators](https://dev.epicgames.com/documentation/en-us/fortnite/operators-in-verse) for more details. | Yes |
| Class and Struct Instantiation | Creating an instance of a `class` or `struct` is an expression. Refer to [Class](https://dev.epicgames.com/documentation/en-us/fortnite/class-in-verse) and [Struct](https://dev.epicgames.com/documentation/en-us/fortnite/struct-in-verse). |  |
| Control Flow | Control flow is the order in which a computer executes instructions. You can use expressions such as `if` and `loop` to change that flow. Some control flow expressions, such as `loop`, only return `void` and so may not be useful everywhere you can use an expression. The following are control flow expressions in Verse:   - `if` - `case` - `for` - `loop` - `sync` - `race` - `rush` - `branch` - `spawn`   Refer to [Control Flow](https://dev.epicgames.com/documentation/en-us/fortnite/control-flow-in-verse) for more details. |  |
| Array | An array is a [container](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#container) where you can store elements of the same type. The elements of an array are in the order you insert them into the array, and you can access the elements by their position in the array, called their [index](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#index). For more info, see [Array](https://dev.epicgames.com/documentation/en-us/fortnite/array-in-verse). | Only when indexing into an array. |
| Tuple | A tuple is a container where you can store elements of one or more types. The elements of a tuple are in the order you insert them into the tuple and you can access the elements by their position in the tuple, called their index.. For more info, see [Tuple](https://dev.epicgames.com/documentation/en-us/fortnite/tuple-in-verse) . |  |
| Map | A map is a container where you can store values associated with another value, called [key-value pairs](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#key-value-pair). Key-value pairs can be any combination of types as long as the key type is comparable. The elements of a map are in the order you insert the key-value pairs into the map, and you can access the elements by their unique keys. For more info, see [Map](https://dev.epicgames.com/documentation/en-us/fortnite/map-in-verse). |  |
| Option | An option is a container that can have one or no value of a type. For more info, see [Option](https://dev.epicgames.com/documentation/en-us/fortnite/option-in-verse). |  |
| Range | Range expressions contain all the numbers between and including the two specified values with `..` between, for example `1..5`. Range expressions can only be used in some places, such as in `for` expressions. See [Range](https://dev.epicgames.com/documentation/en-us/fortnite/range-in-verse) for more details. |  |
