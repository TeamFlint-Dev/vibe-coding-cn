# Functions

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/functions-in-verse
> **爬取时间**: 2025-12-27T00:02:07.802475

---

A [function](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary) is reusable code that provides instructions for performing an action, such as `Dance()` or `Sleep()`, and produces different outputs based on the input you provide.

Functions provide [abstraction](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#abstraction) for behaviors, which means that these reusable functions hide the implementation details that aren't relevant for other parts of your code and that you don't need to see.

Let's use ordering food from a menu as an example for functions and abstraction. The function for ordering food could look something like this:

```verse
OrderFood(MenuItem : string) : food = {...}
```

When you order food at a restaurant, you tell the waiter which dish on the menu you want,`OrderFood("Ramen")`. You don't know how the restaurant will prepare your dish, but you expect to receive something that's considered a `food` after ordering. Other customers can order different dishes from the menu and also expect to receive their food.

This is why functions are useful - you only need to define these instructions in one place - in this case, defining what should happen when someone orders food. You can then reuse the function in different contexts - such as for every customer in the restaurant who orders off the food menu.

The sections below describe how to [create a function](https://dev.epicgames.com/documentation/en-us/fortnite/functions-in-verse), and how to [use a function](https://dev.epicgames.com/documentation/en-us/fortnite/functions-in-verse) once it's defined.

## Defining Functions

The **function signature** [declares](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary) the function name ([identifier](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#identifier)), and the **input** ([parameters](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#parameter)) and **output** ([result](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#result)) of the function.

Verse functions can also have [specifiers](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary), which specify how to use or implement a function.

The **function** [body](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#body) is a [block of code](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#code-block) that defines what the function does when it's called.

The sections below explain these concepts in more detail.

Function [syntax](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#syntax) looks like:

```verse
Identifier(parameter1 : type, parameter2 : type) <specifier> : type = {}
```

[![Diagram of Verse function syntax](https://dev.epicgames.com/community/api/documentation/image/cdb7a3c8-a37d-4f0c-9058-965d06230118?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/cdb7a3c8-a37d-4f0c-9058-965d06230118?resizing_type=fit)

### Parameters

A [parameter](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#parameter) is an input [variable](variables-in-verse) declared in a [function signature](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#function-signature) and used in the body of the function. When you [call a function](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#call), you must assign [values](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#value) to the parameters, if there are any. The assigned values are called [arguments](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#argument) to the function.

A function can have no parameters - for example, `Sleep()` - or as many parameters as you need. You declare a parameter in the function signature by specifying an identifier and [type](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#type) between the parentheses `()`. If you have multiple parameters, they must be separated by commas `,`.

For example:

```verse
Example(Parameter1 : int, Parameter2 : string) : string = {}
```

All of the following are valid:

```verse
Foo():void = {}

Bar(X:int):int = X

Baz(X:int, ?Y:int, ?Z:int = 0) = X + Y + Z
```

The syntax `?Y:int` defines a named argument with the name `Y` of type `int`.

The syntax `?Z:int = 0` defines a named argument named `Z` of type `int` that is not required to be provided when the function is called, but uses `0` as its value if it is not provided.

### Result

The **result** is the output of a function when that function is called. The [return](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#return) type specifies what type of value you can expect from the function if it successfully executes.

If you don't want your function to have a result, you can set the return type to [void](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary). Functions with `void` as the return type always return the value `false`, even when you specify a result expression in the function body.

### Specifiers

In addition to **specifiers** on the function that describe the behavior of the defined function, there can be specifiers on the identifier (the name) of the function. For example:

```verse
Foo<public>(X:int)<decides>:int = X > 0
```

This example defines a function named `Foo` that is publicly accessible and has the `decides` effect. Specifiers after the parameter list and before the return type describe [semantics](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#semantics) of the function, and contribute to the type of the resulting function. Specifiers on the name of the function only indicate behavior related to the name of the defined function, such as its visibility.

### Function Body

The **function body** is the [block of code](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#code-block) that defines what the function does. The function uses any parameters that you define in the function signature of the function body to create a result.

A function automatically returns the value produced by the last executed expression.

For example:

```verse
Foo()<decides>:void = {}

Bar():int =
    if (Foo[]):
        1
    else:
        2
```

The function `Bar()` returns either `1` or `2`, depending on whether `Foo[]` fails.

To force the return of a particular value (and the immediate exit of the function), use the `return` expression.

For example:

```verse
Minimum(X:int, Y:int):int =
  if (X < Y):
    return X
  return Y
```

The expression `return X` will exit the function `Minimum`, returning the value contained in `X` to the caller of the function. Note that if explicit `return` expressions are not used here, the function will return the last executed expression by default. This would result in the value of `Y` always returning, thereby potentially giving an incorrect result.

### Effects

[Effects](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#effect) on a function describe additional behaviors that can be taken by the function when called. Specifically, the `decides` effect on a function indicates that the function could fail in a way that the caller might need to [handle](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#handler) (or propagate to its caller by also being marked as `decides`).

For example:

```verse
Fail()<decides>:void = false?
```

This defines a function that always fails. Any caller would need to handle or propagate the failure. Note the syntax: the effect is described as a specifier on the function. The type of a function with such an effect can be made to closely resemble the definition of the function via the type macro:

```verse
type{_()<decides>void}
```

Functions with the `decides` effect can also return a value should the function succeed.

For example:

```verse
First(Array:[]t, F(:t)<transacts><decides>:void where t:type)<transacts><decides>:t =
  var ReturnOption:?t = false
  for (Element : Array, F[Element], not ReturnOption?):
    set ReturnOption = option{Element}
  ReturnOption?
```

This function determines the first array value that results in a successful execution of the provided `decides` function. This function uses an `option` type to hold our return value and decide whether the function succeeds or fails since explicit `return` statements from within a failure context are not allowed.

You can combine failure with `for` expressions as well. A `decides` function with a failure expression inside the `for` expression succeeds only if every iteration of the `for` expression succeeds.

For example:

```verse
All(Array:[]t, F(:t)<transacts><decides>:void where t:type)<transacts><decides>:void =
  for (Element : Array):
    F[Element]
```

This function succeeds only if all elements of `Array` result in a success for the function `F`. If any input from `Array` results in failure for the function `F`, the function `All` results in failure.

You can also use combine failure with a `for` expression to filter an input based on which inputs result in success or failure.

For example:

```verse
Filter(Array:[]t, F(:t)<transacts><decides>:void where t:type)<transacts>:[]t =
  for (Element : Array, F[Element]):
    Element
```

This function returns an array containing only the elements from `Array` that result in success of the function `F`.

## Calling Functions

A function call is an [expression](expressions-in-verse) that evaluates (known as calling or invoking) a function.

There are two forms for function calls in Verse:

1. `FunctionName(Arguments)`: This form requires that the function call succeeds and can be used in any context.
2. `FunctionName[Arguments]`: This form means that the function call can fail. To use this form, the function must be defined with the specifier `<decides>` and called in a failure context.

Invocation is performed by using parentheses if the function does not have the `decides` effect. For example:

```verse
Foo()
Bar(1)
Baz(1, ?Y := 2)
Baz(3, ?Y := 4, ?Z := 5)
Baz(6, ?Z := 7, ?Y := 8)
```

Note how named arguments, for example `?Y:int`, are passed by referring to the name prepended by `?` and providing a value to the right of `:=`. Note also that the named argument `?Z` is optional. Importantly, the order of the named arguments at the call site is irrelevant except for any side effect that may occur while producing the value for the named argument.

To [invoke](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#call) a function that has the `decides` effect, square brackets should be used. This allows array indexing, which incurs the `decides` effect, to follow similar syntax to functions marked with the `decides` effect. For example:

```verse
Foo()<decides>:void = {}

Bar():int =
    if (Foo[]):
        1
    else:
        2
```

## Tuple Unpacking

A function that accepts multiple arguments is indistinguishable when invoked from a function that accepts a single [tuple](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary) argument with elements of the same types as the multiple arguments. The lack of distinction when invoked also applies to the type of each function - they have the same type.

For example:

```verse
Second(:any, X:t where t:type):t = X
```

This is equivalent to:

```verse
Second(X:tuple(any, t) where t:type):t = X(1)
```

Both can be invoked as:

```verse
X := 1
Y := 2
Second(X, Y)
```

or

```verse
X:tuple(int, int) = (1, 2)
Second(X)
```

Both satisfy the type `type{_(:any, :t where t:type):t}`.

## The Function Type

A function's type is made up of its parameter type (potentially defined as an unpacked tuple), its effect, and its result type. For example:

```verse
type{_(:type1, :type2)<effect1>:type3}
```

This is the type of a function that takes two arguments of `type1` and `type2` (or equivalently, one argument of type `tuple(type1, type2)`), produces effect `effect1`, and returns a value of type `type3`.

## Overloading

Multiple functions can share the same name as long as there are no arguments that would satisfy more than one such function. This is known as **overloading**.

For example:

```verse
Next(X:int):int = X + 1

Next(X:float):float = X + 1

int_list := class:
    Head:int
    Tail:?int_list = false

Next(X:int_list)<decides>:int_list = X.Tail?
```

There is no overlap in what arguments any of these functions accept. The correct function to invoke can be resolved unambiguously by the types provided. For example:

```verse
Next(0)
Next(0.0)
Next(int_list{Head := 0, Tail := int_list{Head := 1}})
```

However, the following is disallowed:

```verse
First(X:int, :any):int = X

First(X:[]int)<decides>int = X[0]
```

This is because tuple and array have a subtyping relationship: array is a supertype of tuple when the array's base type is a supertype of all of the tuple's element types. For example:

```verse
X := (1, 2)
First(X)
```

In this example. the call to `First` can be satisfied by either definition of `First`. In the case of classes and interfaces, no overloading can occur, as a class may later be modified to implement an interface or two classes may be changed to have an inheritance relationship. Instead, method overriding should be used. For example,

```verse
as_int := interface:
    AsInt():int

ToInt(X:as_int):int = X.AsInt()

thing1 := class(as_int):
    AsInt():int = 1

thing2 := class(as_int):
    AsInt():int = 2

Main()<decides>:void =
    X := thing1{}
    ToInt(X) = 1
    Y := thing2{}
    ToInt(Y) = 2
```

A function that is part of a [class](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary) definition is called a [method](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#method), and has additional functionality. Refer to [Class](class-in-verse) to learn more about methods after you're familiar with functions in Verse.
