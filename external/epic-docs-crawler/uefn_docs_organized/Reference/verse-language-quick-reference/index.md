# Verse Language Quick Reference

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/verse-language-quick-reference>
> **爬取时间**: 2025-12-26T22:55:14.470362

---

Use this document as a quick reference for all the features of the Verse programming language and its syntax. Follow the links to learn more.

## Expressions

An **expression** is the smallest unit of code that produces a value when evaluated. An example is an `if ... else` expression, which in Verse evaluates to a value that depends on the content of the expression blocks.

The following code evaluates to a [string](https://dev.epicgames.com/documentation/en-us/fortnite/verse-language-quick-reference) value that contains either `"Big!"` or `"Small!"`, depending on whether `MyNumber` was greater than 5:

```verse
if (MyNumber > 5):
    "Big!"
else:
    "Small!"
```

## Code Comments

A **code comment** explains something about the code, or the programmer's reason for why something is programmed the way it is. When the program runs, code comments are ignored.

|  |  |
| --- | --- |
| ```verse 1+2 # Hello``` | **single-line comment:** Anything that appears between `#` and the end of line is part of the code comment. |
| ```verse 1<# inline comment #>+2``` | **inline block comment:** Anything that appears between `<#` and `#>` is part of the code comment. Inline block comments can be between expressions on a single line and don’t change the expressions. |
| ```verse DoThis() <# And they can run multiple long lines #> DoThat()``` | **multi-line block comment:** Anything that appears between `<#` and `#>` is part of the code comment. Multi-line block comments can span multiple lines. |
| ```verse <# Block comments nest <# like this #> #>``` | **nested block comment:** Anything that appears between `<#` and `#>` is part of the code comment, and they can nest. This can be useful if you want to comment out some expressions in a line for testing and debugging without changing an existing code comment. |
| ```verse <#>     Here is a long     description spanning     multiple lines. DoThis() # This expression is not part of the indented comment``` | **indented comment:** Anything that appears on new lines after `<#>` and is indented four spaces over is part of the code comment. The first line that isn’t indented four spaces over is not part of the code comment and ends the code comment. |

## Constants and Variables

**Constants** and **variables** can store information, or **values**, that your program uses, and associate these values with a name. The name is the **identifier**.

To create your own variable or constant, you need to tell Verse about it. This is called a **declaration**. Specifying an initial value, called **initialization**, is optional for variables (though recommended), but required for constants.

You can change the value of a variable at any time. This is formally called **assignment**, because you are assigning a value to the variable, but is also sometimes called **setting the variable**.

|  |  |  |
| --- | --- | --- |
| ```verse name : type = value``` | **Creating a constant:** A constant’s value cannot be changed while the program is running. You create a constant by specifying its name, type, and value. | [Creating a constant in Verse](https://dev.epicgames.com/community/api/documentation/image/a886c383-af74-46aa-a83c-18cce9a11f0a?resizing_type=fit)  *Click image to enlarge.* |
| ```verse var name : type = value``` | **Creating a variable:** A variable’s value can be changed while the program is running. You create a variable by adding the keyword `var` before the name, and you must specify its name, type, and (optionally) its initial value. | [Creating a variable in Verse](https://dev.epicgames.com/community/api/documentation/image/2e59b257-2a5e-481d-b41a-1a2bd0d7777d?resizing_type=fit)  *Click image to enlarge.* |
| ```verse set name = value``` | **Changing a variable’s value:** You can change a variable’s value while the program is running by using the keyword `set =`. | [Setting a variable in Verse](https://dev.epicgames.com/community/api/documentation/image/ad58654a-bd3d-4a62-8b27-256cffd09f85?resizing_type=fit)  *Click image to enlarge.* |

## Types

Verse is a **statically-typed** programming language, which means a type is assigned to every identifier.

There are instances where the type is not explicitly required, such as when creating a constant in a function. In the example `MyConstant := 0`, the type for `MyConstant` is inferred because the value 0 is assigned to it.

## Common Types

Verse has built-in types that support the fundamental operations most programs need to perform. You can create your own types by combining these into larger structures, but these common types are important to understand as the foundation for using variables and constants in Verse.

|  |  |
| --- | --- |
| ```verse TargetLocked : logic = false``` | **logic:** A `logic` in Verse is the type for Boolean values, which means `logic` can only be two possible values: `true` and `false`. To learn more about the `logic` type, see [Logic](https://dev.epicgames.com/documentation/en-us/fortnite/logic-in-verse). |
| ```verse AnswerToTheQuestion : int = 42``` | **int:** An `int` in Verse can contain a positive number, a negative number, or zero, and has no fractional component. Integer values can be between the following values, inclusive:   - **Min:** -9,223,372,036,854,775,808 - **Max:** 9,223,372,036,854,775,807   To learn more about the `int` type, see [Int](https://dev.epicgames.com/documentation/en-us/fortnite/int-in-verse). |
| ```verse MyScore : float = 100.0``` | **float:** A `float` in Verse can contain a positive or negative number that has a decimal point, zero, or the value `NaN` (Not a Number). Floating-point values can be between the following values, inclusive:   - **Min:** -2^1023 \* (1 + (1 - 2^(-52))) - **Max:** -2^1023 \* (1 + (1 - 2^(-52)))   To learn more about the `float` type, see [Float](https://dev.epicgames.com/documentation/en-us/fortnite/float-in-verse). |
| ```verse # The winning player's name: WinningPlayerName : string = "Player One"  # Build a message announcing the winner. Announcement : string = "...And the winner is: {WinningPlayerName}!"``` | **string:** A `string` in Verse can contain letters, numbers, punctuation, spaces, and emojis 🐈. A string containing no characters "" is called an empty string.  You can inject the result of an expression into a string using {} within the "". This is called **string interpolation**.  To learn more about the `string` type, see [String](https://dev.epicgames.com/documentation/en-us/fortnite/string-in-verse). |
| ```verse # The winning player's name: PlayerName<localizes> : message = "Player One"  # Build a message announcing the winner. Announcement<localizes>(WinningPlayerName : string) : message = "...And the winner is: {WinningPlayerName}"  Billboard.SetText(Announcement("Player One"))``` | **message:** A `message` in Verse can contain locale-independent text. When you initialize a `message` variable with a `string` value, that string is the default text and language for the message. The [localizes specifier](https://dev.epicgames.com/documentation/en-us/fortnite/verse-language-quick-reference) is required when defining a new `message` to produce localizable text.  You can turn the text into a displayable string at runtime by using the `Localize()` function, which formats the text according to your current locale.  Currently, the only text that can be returned by the `Localize()` function is the default text you provided when creating the message. |
| ```verse Localize(Announcement("Player One"))``` | **locale:** This type represents in what context a `message` value should be localized. This affects the language of text and how numbers are represented, that are common to the locale.  Currently, the `locale` type is not fully implemented, so the `Localize()` function will only return the default text you provided when creating the message. |
| ```verse if (MaxQuiversYouCanBuy : int = Floor(Coins / CoinsPerQuiver)):     MaxArrowsYouCanBuy : int = MaxQuiversYouCanBuy * ArrowsPerQuiver``` | **rational:** The `rational` type is the result of integer division, and can only be used as an argument to the following functions:   - `Floor()`: Rounds the rational value down to the closest integer. - `Ceil()`: Rounds the rational value up to the closest integer.   To learn more about the `rational` type, see [Rational](https://dev.epicgames.com/documentation/en-us/fortnite/rational-in-verse). |
| ```verse var MyScore : int = 100  IncreaseScore() : void =     Points : int = 10      set MyScore = MyScore + Points      Print("After you scored, MyScore is {MyScore}.")``` | **void:** The `void` type is useful in the following scenarios:   - As a return type of a function, indicating that the result of the function is not useful. - As the type for constants or function parameters, indicating that the value is not useful. For example, use void for constants or function parameters when overriding a function definition.   To learn more about the `void` type, see [Void](https://dev.epicgames.com/documentation/en-us/fortnite/void-in-verse). |
| ```verse FunctionTakingAnything(Argument : any):void = {}  Main() : void =     FunctionTakingAnything(1)     FunctionTakingAnything("2")     FunctionTakingAnything(array{3.0})     FunctionTakingAnything(FunctionTakingAnything)``` | **any:** The `any` type is the supertype of all types. To learn more about the `any` type, see [Any](https://dev.epicgames.com/documentation/en-us/fortnite/any-in-verse). |
| ```verse Filter(Array : []t, Element : comparable where t : subtype(comparable)) : []t =     for (OtherElement : Array; OtherElement = Element):         OtherElement``` | **comparable:** The `comparable` type has the requirement that any value of this type can be compared for equality to any other value of this type. The `comparable` type is the supertype of all types that can be compared for equality. To learn more about the `comparable` type, see [Comparable](https://dev.epicgames.com/documentation/en-us/fortnite/comparable-in-verse). |

To learn more about common types in Verse, see [Common Types](https://dev.epicgames.com/documentation/en-us/fortnite/common-types-in-verse).

## Container Types

You can store multiple values together by using a **container type**. Verse has a number of container types to store values in. To learn more about container types in Verse, see [Container Types](https://dev.epicgames.com/documentation/en-us/fortnite/container-types-in-verse).

### Option

The `option` type can contain one value or can be empty.

In the following example, `MaybeANumber` is an optional integer `?int` that contains no value. A new value for `MaybeANumber` is then set to `42`.

```verse
var MaybeANumber : ?int = false # unset optional value
set MaybeANumber := option{42} # assigned the value 42
```

[![Creating an option variable in Verse](https://dev.epicgames.com/community/api/documentation/image/c4adff8a-04c8-46cc-beaf-ae55b41dd7d6?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/c4adff8a-04c8-46cc-beaf-ae55b41dd7d6?resizing_type=fit)

*Click image to enlarge.*

|  |  |
| --- | --- |
| ```verse MaybeANumber : ?int = option{42} # initialized as 42  MaybeAnotherNumber : ?int = false # unset optional value``` | **Creating an option:** You can initialize an option with one of the following:   - **No value:** Assign `false` to the option to mark it as unset. - **Initial value:** Use the keyword `option` followed by `{}`, and an expression between the `{}`. If the expression fails, the option will be unset and have the value `false`.   Specify the type by adding `?` before the type of value expected to be stored in the option. For example `?int`. |
| ```verse if (Number := MaybeANumber?):     Number # if MaybeANumber is not empty, then its value is stored in Number for you to use.``` | **Accessing an element in an option:** Use the query operator `?` with the option, such as `MaybeANumber?`. Accessing the value stored in an option is a [failable expression](https://dev.epicgames.com/documentation/en-us/fortnite/verse-language-quick-reference) because there might not be a value in the option, and so must be used in a [failure context](https://dev.epicgames.com/documentation/en-us/fortnite/verse-language-quick-reference). |

The following is an example of using an option type to save a reference to a spawned player and, when a player is spawned, to have the trigger device react:

```verse
my_device := class<concrete>(creative_device):
    var SavedPlayer : ?player = false # unset optional value

    @editable
    PlayerSpawn : player_spawner_device = player_spawner_device{}

    @editable
    Trigger : trigger_device = trigger_device{}

    OnBegin<override>() : void =
        PlayerSpawn.PlayerSpawnedEvent.Subscribe(OnPlayerSpawned)

    OnPlayerSpawned(Player : player) : void =
        set SavedPlayer = option{Player}
        if (TriggerPlayer := SavedPlayer?):
            Trigger.Trigger(TriggerPlayer)
```

### Range

The **range** expression contains all the numbers in a specified range, and can only be used in specific expressions, such as the [for](https://dev.epicgames.com/documentation/en-us/fortnite/verse-language-quick-reference#for) expression. Range values can only be integers.

[![Creating a range in Verse](https://dev.epicgames.com/community/api/documentation/image/2997c353-0bee-47a6-a716-91fd03e3d170?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/2997c353-0bee-47a6-a716-91fd03e3d170?resizing_type=fit)

*Click image to enlarge.*

|  |  |
| --- | --- |
| ```verse 0..5``` | **Creating a range:** The start of the range is the first value in the expression, and the end of the range is the value following `..` in the expression. The range contains all the integers between the start and end values, inclusive. |
| ```verse for (Number := 0..5):    Number``` | **Iterating over a range:** You can use the `for` expression to iterate through the sequence of numbers. For more, see [for](https://dev.epicgames.com/documentation/en-us/fortnite/verse-language-quick-reference#for). |

For more info, see [Range](https://dev.epicgames.com/documentation/en-us/fortnite/range-in-verse).

### Array

An **array** is a container where you can store elements of the same type, and access the elements by their position, called their index, in the array. The first index in the array is 0, and the last index is one less than the number of elements in the array.

```verse
Players : []player = array{Player1, Player2}
```

[![Creating an array in Verse](https://dev.epicgames.com/community/api/documentation/image/7910c17f-4908-4ef7-a496-b16b44098436?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/7910c17f-4908-4ef7-a496-b16b44098436?resizing_type=fit)

*Click image to enlarge.*

|  |  |
| --- | --- |
| ```verse ExampleArray : []int = array{10, 20, 30, 40, 50}``` | **Creating an array:** Use the keyword `array` followed by `{}`. If you want to specify initial elements in the array, add the expressions between the `{}`, separated by `,`. Specify the type by adding `[]` before the type of value expected to be stored in the array, for example `[]int`. |
| ```verse if (Element := ExampleArray[0]):     Element``` | **Accessing an element in an array:** Use `[]` with the index of the element you want to access, such as `ExampleArray[0]`. Accessing the value stored in an array is a [failable expression](https://dev.epicgames.com/documentation/en-us/fortnite/verse-language-quick-reference) because there might not be an element at that index, and so it must be used in a [failure context](https://dev.epicgames.com/documentation/en-us/fortnite/verse-language-quick-reference). |
| ```verse var ExampleArray : []int = array{20, 21, 22} if (set ExampleArray[1] = 77) {}``` | **Changing an element in an array:** You can change the value stored in an array variable at an index by using the keyword `set =`. |
| ```verse for (Item : ExampleArray):    Item  for (Index -> Item : ExampleArray):     Print("{Item} in ExampleArray at index {Index}")``` | **Iterating over an array:** You can access every element in an array, in order, from first to last, using the [for](https://dev.epicgames.com/documentation/en-us/fortnite/verse-language-quick-reference#for) expression. With the `for` expression, you can get the element with the syntax `(Item : ExampleArray)`, or the element and its index with the syntax `(Index -> Item : ExampleArray)`. |
| ```verse ExampleArray.Length``` | **Getting the number of elements in an array:** Use `.Length` on the array, and its result will be the number of elements in the array. |
| ```verse # Array1 is an array of integers Array1 : []int = array{10, 11, 12}  # Array2 is an array variable of integers var Array2 : []int = array{20, 21, 22}  # After Array2 is updated in the next line, its elements are [10, 11, 12, 20, 21, 22, 5, 31] set Array2 = Array1 + Array2 + array{5, 31}``` | **Concatenating arrays:** You can merge arrays together by using the `+` operator. |

For more info, see [Array](https://dev.epicgames.com/documentation/en-us/fortnite/array-in-verse).

### Tuple

A **tuple** is a grouping of two or more expressions treated as a single expression. The order of the elements in the expression is important. The same expression can be in multiple locations in a tuple. Tuple expressions can be of any type, and can have mixed types (unlike [arrays](https://dev.epicgames.com/documentation/en-us/fortnite/verse-language-quick-reference#array) which can only have elements of one type).

Tuples are especially useful when:

- Returning multiple values from a function.
- Passing multiple values to a function.
- In-place grouping is more concise than the overhead of making a reusable data structure (such as a [struct](https://dev.epicgames.com/documentation/en-us/fortnite/verse-language-quick-reference#struct) or [class](https://dev.epicgames.com/documentation/en-us/fortnite/verse-language-quick-reference#class)).

  ```verse
        ExampleTuple : tuple(int, float, string) = (1, 2.0, "three")
  ```

[![Creating a tuple in Verse](https://dev.epicgames.com/community/api/documentation/image/d65fb548-567e-4a82-a717-06d9e57663ec?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/d65fb548-567e-4a82-a717-06d9e57663ec?resizing_type=fit)

*Click image to enlarge.*

|  |  |
| --- | --- |
| ```verse ExampleTuple : tuple(int, float, string) = (1, 2.0, "three")``` | **Creating a tuple:** Use `()` and specify two or more elements, separated by `,`. Specify the type by using the keyword `tuple` followed by `()`, with each element’s type explicitly specified between the `()`. For example, `tuple(int, float, string)`. |
|  | **Accessing an element in a tuple:** Use `()` with the index of the element you want to access, such as `ExampleTuple(0)`. Accessing the value stored in a tuple is not a [failable expression](https://dev.epicgames.com/documentation/en-us/fortnite/verse-language-quick-reference). |
|  | **Tuple expansion:** When you use a tuple as an argument to a function instead of specifying each individual argument, the function will be called with each element in the tuple used as an argument in the order they’re specified in the tuple. |
|  | **Tuple array coercion:** Tuples can be passed wherever an array is expected, provided that the types of the tuple elements are all of the same type as the array. Arrays cannot be passed where a tuple is expected. |

For more info, see [Tuple](https://dev.epicgames.com/documentation/en-us/fortnite/tuple-in-verse).

### Map

A map is a container where you can store values associated with another value, called key-value pairs, and access the elements by their unique keys.

```verse
WordCount : [string]int = map {"apple" => 11, "pear" => 7}
```

[![Creating a map in Verse](https://dev.epicgames.com/community/api/documentation/image/7532b1cd-1d18-49ee-aefa-797c9bb48cb2?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/7532b1cd-1d18-49ee-aefa-797c9bb48cb2?resizing_type=fit)

*Click image to enlarge.*

|  |  |
| --- | --- |
|  | **Creating a map:** Use the keyword `map` followed by `{}`. If you want to specify initial elements in the map, add the key-value pairs between the `{}`, separated by `,`. Specify the type by adding `[key-type]`, where key-type is the type used for the keys before the type of value expected to be stored in the map. For example, `[string]int`. |
|  | **Accessing an element in a map:** Use `[]` with the key of the element you want to access, such as `ExampleMap[Key]`. |
|  | **Iterating over a map:** You can access every element in a map, in order, from first element inserted to last, using the [for](https://dev.epicgames.com/documentation/en-us/fortnite/verse-language-quick-reference#for) expression. With the `for` expression, you can get the element with the syntax `(Value : ExampleMap)`, or the element and its key with the syntax `(Key -> Value: ExampleMap)`. |
|  | **Getting the number of key-value pairs in a map:** Use `.Length` on the map and its result will be the number of elements in the map. |

For more info, see [Map](https://dev.epicgames.com/documentation/en-us/fortnite/map-in-verse).

## Composite Types

A **composite type** is any type that can be made up of fields and elements (usually named) of primitive or other types. Composite types usually have a fixed number of fields or elements for its lifespan. For more info, see [Composite Types](https://dev.epicgames.com/documentation/en-us/fortnite/composite-types-in-verse).

### Enum

Enum is short for **enumeration**, which means to name or list a series of things, called **enumerators**. This is a type in Verse that can be used for things like days of the week or compass directions.

[![Creating an enum in Verse](https://dev.epicgames.com/community/api/documentation/image/8797a3c7-b982-462f-a856-863e2e3944ce?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/8797a3c7-b982-462f-a856-863e2e3944ce?resizing_type=fit)

*Click image to enlarge.*

|  |  |
| --- | --- |
|  | **Creating an enum:** Use the keyword `enum` followed by `{}`. If you want to specify initial elements in the enum, add the enumerators between the `{}`, separated by `,`. |
|  | **Accessing an enumerator:** Use `.` on the enum, followed by the enumerator you want to use. For example `direction.Up`. |

### Struct

Struct is short for **structure**, and is a way to group several related variables together. The variables can be of any type.

[![Creating a new struct in Verse](https://dev.epicgames.com/community/api/documentation/image/3c51cb32-3b88-4448-a375-579732ac458e?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/3c51cb32-3b88-4448-a375-579732ac458e?resizing_type=fit)

*Click image to enlarge.*

[![Instantiating a struct in Verse](https://dev.epicgames.com/community/api/documentation/image/cd9a338d-7a7e-473f-a564-ed94643cb029?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/cd9a338d-7a7e-473f-a564-ed94643cb029?resizing_type=fit)

*Click image to enlarge.*

|  |  |
| --- | --- |
|  | **Creating a struct:** Use the keyword `struct` followed by a [code block](https://dev.epicgames.com/documentation/en-us/fortnite/verse-language-quick-reference). Definitions in the struct’s code block define the fields of the struct. |
|  | **Instantiating a struct:** You can construct an instance of a struct from an **archetype**. An archetype defines the values of a struct’s fields. |
|  | **Accessing fields on a struct:** You can access a struct’s fields to get their value by adding `.` between the struct instance and the field name. |

### Class

A **class** is a template for creating objects with similar behaviors and properties (variables and methods), and must be instantiated to create an object with real values. Classes are hierarchical, which means that a class can inherit information from its parent (superclass) and share its information with its children (subclasses). A class can be a custom type defined by the user.

[![Creating a new class in Verse](https://dev.epicgames.com/community/api/documentation/image/5b481141-ca18-458e-b8ce-8f7a9e22e17e?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/5b481141-ca18-458e-b8ce-8f7a9e22e17e?resizing_type=fit)

*Click image to enlarge.*

[![Instantiating a class in Verse](https://dev.epicgames.com/community/api/documentation/image/f5de7def-58b1-4606-b254-26d4a083c3c1?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/f5de7def-58b1-4606-b254-26d4a083c3c1?resizing_type=fit)

*Click image to enlarge.*

|  |  |
| --- | --- |
|  | **Creating a class:** Definitions that are nested inside a class define fields of the class. Functions defined as fields of a class are also called methods. |
|  | **Instantiating a class:** You can construct an instance of the class using the class name followed by `{}` (the **archetype**). An archetype defines the values of a class's fields. |
|  | **Accessing fields on a class:** You can access a class’s fields to get their value by adding `.` between the class instance and the field name. |
|  | **Accessing methods on a class:** You can access a class’s methods to call them by adding `.` between the class instance and the method name. |
|  | **Self:** You can use `Self` in a class method to refer to the instance of the class that the method was called on. You can refer to other fields of the instance the method was called on without using `Self`, but if you need to refer to the instance as a whole, you must use `Self`. |

There are also specifiers that are unique to classes and that change their behavior. See [Class Specifiers](https://dev.epicgames.com/documentation/en-us/fortnite/verse-language-quick-reference) for details.

To learn more about classes, see [Class](https://dev.epicgames.com/documentation/en-us/fortnite/class-in-verse).

### Subclass

A **subclass** is a class that extends the definition of another class by adding or modifying the fields and methods of the other class (called the **superclass**).

[![Creating a new subclass in Verse](https://dev.epicgames.com/community/api/documentation/image/53d6bfbf-8dd1-418f-a433-015cb4191eb0?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/53d6bfbf-8dd1-418f-a433-015cb4191eb0?resizing_type=fit)

*Click image to enlarge.*

|  |  |
| --- | --- |
|  | **Creating a subclass:** Specify a class as a subclass of another class by adding the other class between the `()` in `class()`. |
|  | **Overriding fields on the superclass:** You can change the values of a field that’s defined in the superclass for the subclass only by adding the `<override>` specifier to the field name. |
|  | **Overriding methods on the superclass:** [INCLUDE:#overriding\_methods\_on\_superclass\_description] |
|  | **Super:** Similar to `Self`, you can use `(super:)` to access the superclass's implementations of fields and methods. To be able to use `(super:)`, the field or method must be implemented in the superclass definition. |

For more info, see [Subclass](https://dev.epicgames.com/documentation/en-us/fortnite/subclass-in-verse).

### Constructor

A constructor is a special function that creates an instance of the class that it’s associated with. It can be used to set initial values for the new object.

|  |  |
| --- | --- |
|  | **Defining a constructor for a class:** You can add a constructor for a class by adding the `<constructor>` specifier on the function name. Instead of specifying a return type on the function, the function is assigned the class name followed by any initialization of fields. A class can have more than one constructor. |
|  | **Adding variables and executing code in the constructor:** You can execute expressions within a constructor with the [block](https://dev.epicgames.com/documentation/en-us/fortnite/verse-language-quick-reference#block) expression, and introduce new variables with the keyword `let`. |
|  | **Calling other constructors in a constructor:** You can call other constructors from a constructor. You can also call constructors for the superclass of the class from a constructor of the class as long as all fields are initialized. When a constructor calls another constructor and both constructors initialize fields, only the values provided to the first constructor are used for the fields. The order of evaluation for expressions between the two constructors will be in the order the expressions are written (as far as side effects are concerned), but only the values provided to the first constructor are used. |

### Interface

The interface type provides a contract for how to interact with any class that implements the interface. An interface cannot be instantiated, but a class can inherit from the interface and implement its methods. An interface is similar to an abstract class, except it does not allow partial implementation or fields as part of the definition.

[![Creating an interface in Verse](https://dev.epicgames.com/community/api/documentation/image/f05b4acd-cdf3-4027-aca9-34ec5552b716?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/f05b4acd-cdf3-4027-aca9-34ec5552b716?resizing_type=fit)

*Click image to enlarge.*

[![Implementing an interface in Verse](https://dev.epicgames.com/community/api/documentation/image/92101195-56e4-44fe-8ee0-149871ed88fb?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/92101195-56e4-44fe-8ee0-149871ed88fb?resizing_type=fit)

*Click image to enlarge.*

|  |  |
| --- | --- |
|  | **Creating an interface:** You define an interface similarly to a class, except with the `interface` keyword. In the definition, you can specify the methods associated with the interface. |
|  | **Extending an interface:** An interface can extend the definition of another interface by specifying the interface to extend between the `()` in `interface()`. |
|  | **Implementing an interface:** You can implement an interface with a class by specifying the interface between the `()` in `class()`. The class must override and implement each method defined in the interface. |
|  | **Implementing multiple interfaces:** A class can implement multiple interfaces. The interfaces are separated by `,` between the `()` in `class()`. |
|  | **Inheriting from an interface and another class:** A class can implement an interface and be a subclass of another class. The interface and superclass are separated by `,` between the `()` in `class()`. |

For more info, see [Interface](https://dev.epicgames.com/documentation/en-us/fortnite/interface-in-verse).

## Working with Types

Verse provides a few ways to make working with types easier.

|  |  |
| --- | --- |
|  | **Type aliasing:** You can give a type a different name in your code and reference the type by that new name. The syntax is similar to constant initialization. You can also give a type alias to a function type. For more information, see [Type Aliasing](https://dev.epicgames.com/documentation/en-us/fortnite/type-aliasing-in-verse). |
|  | **Parametric type as explicit type arguments:** Verse supports parametric types (types expected as arguments). This only works with classes and functions. For more information, see [Parametric Types](https://dev.epicgames.com/documentation/en-us/fortnite/parametric-types-in-verse). |
|  | **Parametric type as implicit type arguments to functions:** The reason to use implicit parametric types with functions is that it allows you to write code that is invariant of a particular type once, rather than for each type the function is used with. For more information, see [Parametric Types](https://dev.epicgames.com/documentation/en-us/fortnite/parametric-types-in-verse). |
|  | **Type macro:** Verse has a special construct that can be used to get the type of an arbitrary expression. It can be used anywhere a type can be used. For more information, see [Type Macro](https://dev.epicgames.com/documentation/en-us/fortnite/type-macro-in-verse). |
|  | **subtype:** You can use `subtype` to give a constraint on a type variable. It requires that the type that may replace a type variable that is a subtype of the argument to subtype. Anything that may replace `t` in a call to `Filter` must be a subtype of `comparable`. |

For more information, see [Working with Verse Types](https://dev.epicgames.com/documentation/en-us/fortnite/working-with-types-in-verse).

## Operators

Operators are special functions defined in the Verse programming language that perform actions, such as math operations, on their operands.

When multiple operators are used in the same expression, they are evaluated in the order of highest to lowest precedence. If there are operators with the same precedence in the same expression, they are evaluated left to right.

The table below lists all built-in operators in Verse, in order from highest to lowest precedence.

| Operator | Description | Operator Format | Operator Precedence | Example |
| --- | --- | --- | --- | --- |
| Query `?` | The `?` operator checks if a `logic` value is `true`. See [Query](https://dev.epicgames.com/documentation/en-us/fortnite/operators-in-verse#query) for more details. | Postfix | 9 | `TargetLocked?` |
| Not `not` | The `not` operator negates the success or failure of an expression. See [Not](https://dev.epicgames.com/documentation/en-us/fortnite/operators-in-verse) for more details. | Prefix | 8 | `not TargetLocked?` |
| Positive `+` | You can use the `+` operator as a prefix to a number to help align your code visually, but it won't change the value of the number. See [Math](https://dev.epicgames.com/documentation/en-us/fortnite/operators-in-verse#math) for more details. | Prefix | 8 | `+1` |
| Negative `-` | You can use the operator `-` as a prefix to a number to negate the number value. See [Math](https://dev.epicgames.com/documentation/en-us/fortnite/operators-in-verse#math) for more details. | Prefix | 8 | `-1` |
| Multiplication `*` | The `*` multiplies two number values together. See [Math](https://dev.epicgames.com/documentation/en-us/fortnite/operators-in-verse#math) for more details. | Infix | 7 | `2 * 3` |
| Division `/` | The `/` operator divides the first number operand by the second number operand. Integer division is failable. See [Math](https://dev.epicgames.com/documentation/en-us/fortnite/operators-in-verse#math) for more details. | Infix | 7 | `6 / 3` |
| Addition `+` | The + operator adds two number values together. When used with strings and arrays, the two values are concatenated. See [Math](https://dev.epicgames.com/documentation/en-us/fortnite/operators-in-verse#math) for more details. | Infix | 6 | `2 + 3` |
| Subtraction `-` | The `-` operator subtracts the second number operand from the first operand. See [Math](https://dev.epicgames.com/documentation/en-us/fortnite/operators-in-verse#math) for more details. | Infix | 6 | `2 - 3` |
| Addition assignment `+=` | With this operator, you can combine addition and assignment in the same operation to update a variable's value. See [Math](https://dev.epicgames.com/documentation/en-us/fortnite/operators-in-verse#math) for more details. | Infix | 5 | `set VariableName += 1` |
| Subtraction assignment `-=` | With this operator, you can combine subtraction and assignment in the same operation to update a variable's value. See [Math](https://dev.epicgames.com/documentation/en-us/fortnite/operators-in-verse#math) for more details. | Infix | 5 | `set VariableName -= 1` |
| Multiplication assignment `*=` | With this operator, you can combine multiplication and assignment in the same operation to update a variable's value. See [Math](https://dev.epicgames.com/documentation/en-us/fortnite/operators-in-verse#math) for more details. | Infix | 5 | `set VariableName *= 1` |
| Division assignment `/=` | With this operator, you can combine division and assignment in the same operation to update a variable's value, unless the variable is an integer. See [Math](https://dev.epicgames.com/documentation/en-us/fortnite/operators-in-verse#math) for more details. | Infix | 5 | `set VariableName /= 2` |
| Equal to `=` | The `=` operator succeeds when the left operand is equal to the right operand. Fails otherwise. See [Comparison](https://dev.epicgames.com/documentation/en-us/fortnite/operators-in-verse#comparison) for more details. | Infix | 4 | `MyScore = HighScore` |
| Not equal to `<>` | The `<>` operator succeeds when the left operand is not equal to the right operand. Fails otherwise. See [Comparison](https://dev.epicgames.com/documentation/en-us/fortnite/operators-in-verse#comparison) for more details. | Infix | 4 | `MyScore <> HighScore` |
| Less than `<` | The `<` operator succeeds when the left operand is less than the right operand. Fails otherwise. See [Comparison](https://dev.epicgames.com/documentation/en-us/fortnite/operators-in-verse#comparison) for more details. | Infix | 4 | `MyScore < HighScore` |
| Less than or equal to `<=` | The `<=` operator succeeds when the left operand is less than or equal to the right operand. Fails otherwise. See [Comparison](https://dev.epicgames.com/documentation/en-us/fortnite/operators-in-verse#comparison) for more details. | Infix | 4 | `Score <= HighScore` |
| Greater than `>` | The `>` operator succeeds when the left operand is greater than the right operand. Fails otherwise. See [Comparison](https://dev.epicgames.com/documentation/en-us/fortnite/operators-in-verse#comparison) for more details. | Infix | 4 | `MyScore > HighScore` |
| Greater than or equal to `>=` | The `>=` operator succeeds when the left operand is greater than or equal to the right operand. Fails otherwise. See [Comparison](https://dev.epicgames.com/documentation/en-us/fortnite/operators-in-verse#comparison) for more details. | Infix | 4 | `MyScore >= HighScore` |
| And `and` | The `and` operator succeeds only when all the operands succeed. See [And / Or Operators](https://dev.epicgames.com/documentation/en-us/fortnite/operators-in-verse) for more details. | Infix | 3 | `Value1 and Value2` |
| Or `or` | The `or` operator succeeds if at least one of the operands succeeds. See [And / Or Operators](https://dev.epicgames.com/documentation/en-us/fortnite/operators-in-verse) for more details. | Infix | 2 | `Value1 or Value2` |
| Variable and constant initialization `: =` | With this operator, you can store values in a constant or variable. See [Constants and Variables](https://dev.epicgames.com/documentation/en-us/fortnite/constants-and-variables-in-verse) for more details. | Infix | 1 | `ConstantName := 5` |
| Variable assignment `set =` | With this operator, you can update the values stored in a variable. See [Constants and Variables](https://dev.epicgames.com/documentation/en-us/fortnite/constants-and-variables-in-verse) for more details. | Infix | 1 | `set VariableName = 5` |

For more, see [Operators](https://dev.epicgames.com/documentation/en-us/fortnite/operators-in-verse).

## Grouping

You can change the order in which operators are evaluated by **grouping** expressions with `()`. For example, `(1+2)*3` and `1+(2*3)` don't evaluate to the same value because the expressions grouped in () would be evaluated first.

The following example shows how to use grouping to calculate an in-game explosion that scales its damage based on the distance from the player, but where the player's armor can reduce the total damage:

```verse
BaseDamage : float = 100.0
Armor : float = 15.0
DistanceScaling : float = Max(1.0, Pow(PlayerDistance, 2.0))
ExplosionDamage : float = Max(0.0, (BaseDamage / DistanceScaling) - Armor)
```

See [Grouping](https://dev.epicgames.com/documentation/en-us/fortnite/grouping-in-verse) for more details.

## Code blocks

A **code block** is a group of zero or more expressions, and introduces a new scoped body. A code block must follow an identifier. This could be a function identifier, or a control flow identifier like [if](https://dev.epicgames.com/documentation/en-us/fortnite/verse-language-quick-reference#if) and [for](https://dev.epicgames.com/documentation/en-us/fortnite/verse-language-quick-reference#for), for example.

|  |  |
| --- | --- |
|  | **Spaced:** Begins with `:`, and each new line in the code block is uniformly indented four spaces. |
|  | **Multi-line braced:** Enclosed by `{}`, with each expression on a new line. |
|  | **Single-line braced:** Enclosed by `{}`, with each expression separated by `;`. |

It's also possible to use `;` to put more than one expression on a line. In a format that has each expression on a new line, the `{}` characters don't have to be on their own lines.

The last expression in a code block is the result of the code block. In the following example, the `if` expression code block results in either `false`, if `IsLightOn?` succeeds, or `true`, if `IsLightOn?` fails. The `logic` result is then stored in `NewLightState`.

```verse
NewLightState :=
    if (IsLightOn?):
        Light.TurnOff()
        false
    else:
        Light.TurnOn()
        true
```

For more information, see [Code Blocks](https://dev.epicgames.com/documentation/en-us/fortnite/code-blocks-in-verse).

## Scope

**Scope** refers to the code within a Verse program where the association of an identifier (name) to a value is valid, and where that identifier can be used to refer to the value.

For example, any constants or variables that you create within a code block exist only in the context of that code block. This means that the lifetime of objects is limited to the scope they're created in, and they cannot be used outside of that code block.

The following example shows how to calculate the maximum number of arrows that can be bought using the number of coins the player has. The constant `MaxArrowsYouCanBuy` is created within the `if` block, so the scope is limited to the `if` block. When the constant `MaxArrowsYouCanBuy` is used in the print string, it produces an error because the name `MaxArrowsYouCanBuy` doesn't exist in the scope outside of that `if` expression.

```verse
CoinsPerQuiver : int = 100
ArrowsPerQuiver : int = 15
var Coins : int = 225

if (MaxQuiversYouCanBuy : int = Floor(Coins / CoinsPerQuiver)):
    MaxArrowsYouCanBuy : int = MaxQuiversYouCanBuy * ArrowsPerQuiver

Print("You can buy at most {MaxArrowsYouCanBuy} arrows with your coins.") # Error: Unknown identifier MaxArrowsYouCanBuy
```

[![Scope visualization](https://dev.epicgames.com/community/api/documentation/image/f4f00152-4d89-45ce-be4b-8322567a100a?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/f4f00152-4d89-45ce-be4b-8322567a100a?resizing_type=fit)

*Click image to enlarge.*

Verse doesn't support reusing an identifier even if it's declared in a different scope, unless you qualify the identifier by adding `(qualifying_scope:)` before the identifier, where `qualifying_scope` is the name of an identifier's module, class, or interface. Whenever you define and use the identifier, you must also add the qualifier to the identifier.

## Functions

A **function** is a named sequence of expressions that you can reuse. A function provides instructions for performing an action or creating an output based on input.

### Function Definitions

To define your own function, you must provide three key parts: a unique name (identifier), the type of information you can expect as its result, and what the function will do when you call it.
The following is the basic syntax for a function:

```verse
name() : type =
    codeblock
```

- **The name() and type separated by a colon:** This is the **function signature**, which is how you must call and use the function, and the value that must be returned by the function is of the type you provide. This format is similar to how you create constants except for the () after the name, which mimics how you call the function in your code.
- **The function code block:** You define what the function will do when it's called by providing `=codeblock`, where `codeblock` is any sequence of one or more expressions. Whenever you call the function, the expressions in the code block are executed.

[![Creating a function in Verse](https://dev.epicgames.com/community/api/documentation/image/d13c37e5-9ce5-4bf3-a487-2924d179c1c2?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/d13c37e5-9ce5-4bf3-a487-2924d179c1c2?resizing_type=fit)

*Click image to enlarge.*

### Function Results

When your function has a return type specified, the function body must produce a result of that type or the code won't compile.

|  |  |
| --- | --- |
|  | **Last expression returned with a value:** By default, the last expression in the function’s code block is the result of the function and whose value must match the return type of the function. |
|  | **Explicit return with a value:** You can also explicitly define what the function will return using `return` followed by a value, such as `return HighScore`. The `return` expression exits the function immediately, even if there are more expressions after it in the code block. |

When you create a function that doesn't need to produce a result, you can set the function's return type to [void](https://dev.epicgames.com/documentation/en-us/fortnite/verse-language-quick-reference), which means the function is not expected to produce a useful result and so the last expression in the function’s code block can be of any type.

You can exit a function whose return type is `void` by using the `return` expression by itself. This expression exits the function immediately, even if there are more expressions after it in the code block.

### Function Parameters

Input to a function is defined using **parameters**. A parameter is a constant that's declared in the function signature between the parentheses that you can then use in the body of the function.

The following is the syntax for a function with two parameters:

```verse
name(parameter1name : type, parameter2name : type) : type =
    codeblock
```

[![Creating a function with parameters in Verse](https://dev.epicgames.com/community/api/documentation/image/9bbaf988-00e3-4aef-a438-c49f24d0fdfc?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/9bbaf988-00e3-4aef-a438-c49f24d0fdfc?resizing_type=fit)

*Click image to enlarge.*

In the following example, the function `IncreaseScore()` has one integer parameter named `Points`, which the function uses to increase the value of `MyScore`:

```verse
var MyScore : int = 100

IncreaseScore(Points : int) : void =
    # Increase MyScore by Points.
    set MyScore = MyScore + Points
```

### Function Calls

When you want to use the named sequence of expressions (the function) in your code, you will call the function by name, like `GetRandomInt(1, 10)`, which returns a random integer between 1 and 10, inclusive.

There are two ways to call a function depending on whether the function call is failable:

|  |  |
| --- | --- |
|  | **Non-failable function call:** A function call that can’t fail has the form `FunctionName()`. |
|  | **Failable function call:** A failable function call has the form `FunctionName[]`. A function is marked as failable when its definition has the [decides](https://dev.epicgames.com/documentation/en-us/fortnite/verse-language-quick-reference) specifier. |

### Function Arguments

When you call a function that expects parameters, you must assign values to the parameters, just as you need to assign values to constants to be able to use them. The assigned values are called **arguments** to the function.

The following is the syntax for calling a function with two arguments:

```verse
name(parameter1name := value, parameter2name := value)
```

In the following example, the function `IncreaseScore()` is called three times, with different arguments each time (10, 5, and 20), to increase the value of `MyScore`:

```verse
# After this call, MyScore is 110
IncreaseScore(Points := 10)

# After this call, MyScore is 115
IncreaseScore(Points := 5)

# After this call, MyScore is 135
IncreaseScore(Points := 20)
```

### Extension Methods

Extension methods are a type of function that act like members of an existing class or type, but do not require the creation of a new type or subclass.

The following shows how to create an extension method for arrays of type `int`. The method adds all the numbers in the array and returns the total.

```verse
    # Sum extension method for type []int
    (Arr : []int).Sum<public>() : int =
        var Total : int = 0
        for (Number : Arr):
            set Total = Total + Number
        return Total
```

The method can then be called on any array of type `int`.

```verse
    SumTotal := array{4, 3, 7}.Sum()
    Print("The SumTotal is { SumTotal }")

    # "The SumTotal is 14"
```

## Failure

Unlike other programming languages that use the Boolean values true and false to change the flow of a program, Verse uses expressions that can either succeed or fail. These expressions are called **failable expressions**, and can only be executed in a **failure context**.

### Failable Expressions

A failable expression is an expression that can either succeed and produce a value, or fail and produce no value.

The following list includes all of the failable expressions in Verse:

|  |  |
| --- | --- |
|  | **Function calls:** Only when the function call has the form `FunctionName[]`, and the function definition has the [decides](https://dev.epicgames.com/documentation/en-us/fortnite/verse-language-quick-reference) specifier. |
|  | **Comparison:** A comparison expression compares two things using one of the comparison operators. For more information, see [operators](https://dev.epicgames.com/documentation/en-us/fortnite/verse-language-quick-reference#operators). |
|  | **Integer division:** For integers, the division operator `/` is failable, and the result is a `rational` type if it succeeds. For more information, see [operators](https://dev.epicgames.com/documentation/en-us/fortnite/verse-language-quick-reference#operators). |
|  | **Decision:** A decision expression uses the operators `not`, `and`, or `or` to give you control over the success and failure decision flow. For more information, see [operators](https://dev.epicgames.com/documentation/en-us/fortnite/verse-language-quick-reference#operators). |
|  | **Query:** A query expression uses the operator `?` and checks whether a `logic` or `option` value is `true`. Otherwise, the expression fails. For more information, see [operators](https://dev.epicgames.com/documentation/en-us/fortnite/verse-language-quick-reference#operators). |
|  | **Accessing an element in an array:** Accessing the value stored in an array is a [failable expression](https://dev.epicgames.com/documentation/en-us/fortnite/verse-language-quick-reference) because there might not be an element at that index, and so must be used in a [failure context](https://dev.epicgames.com/documentation/en-us/fortnite/verse-language-quick-reference). For more details, see [array](https://dev.epicgames.com/documentation/en-us/fortnite/verse-language-quick-reference#array). |

### Failure Contexts

A failure context is a context where it is allowable to execute failable expressions. The context defines what happens if the expression fails. Any failure within a failure context will cause the entire context to fail.

A failure context allows nested expressions to be failure expressions, such as function arguments or expressions in a [block](https://dev.epicgames.com/documentation/en-us/fortnite/verse-language-quick-reference#block) expression.

The following list includes all of the failure contexts in Verse:

|  |  |
| --- | --- |
|  | The condition in `if` expressions. |
|  | The iteration expressions and filter expressions in `for` expressions. |
|  | The body of a function that has the `decides` effect specifier. |
|  | The operand for the `not` operator. |
|  | The left operand for the `or` operator. |
|  | Initializing a variable that has the `option` type. |

### Speculative Execution

A useful aspect of failure contexts in Verse is that they are a form of **speculative execution**, meaning that you can try out actions without committing them. When an expression succeeds, the effects of the expression are committed, such as changing the value of a variable. If the expression fails, the effects of the expression are rolled back, as though the expression never happened.

This way, you can execute a series of actions that accumulate changes, but those actions will be undone if they fail anywhere in the failure context.

To make this work, all functions called in the failure context must have the `transacts` effect specifier.

## Specifiers

Specifiers in Verse describe behavior related to semantics, and can be added to identifiers and certain keywords. Specifier syntax uses `<` and `>`, with the keyword in between, such as `IsPuzzleSolved()<decides><transacts> : void`.

The following sections describe all of the specifiers in Verse and when you can use them.

### Effect Specifiers

Effects in Verse indicate categories of behavior that a function is allowed to exhibit. You can add effect specifiers to:

- The () after the name in a function definition: `name()<specifier> : type = codeblock`.
- The `class` keyword: `name := class<specifier>():`.

Effect specifiers are divided into two categories:

- **Exclusive:** You can have only one or none of the exclusive effect specifiers added to a function or the `class` keyword. If no exclusive effect specifier is added, the default effect is `no_rollback`.
- **Additive:** You can add all, some, or none of the additive effect specifiers to a function or the `class` keyword.

| Example | Effect |
| --- | --- |
|  | **no\_rollback:** This is the default effect when no exclusive effect is specified. The `no_rollback` effect indicates that any actions performed by the function cannot be undone and so the function cannot be used in a failure context. This effect cannot be manually specified. |
| **Exclusive Effects** |  |
|  | **transacts:** This effect indicates that any actions performed by the function can be rolled back. The transacts effect is required any time a mutable variable (`var`) is written. You’ll be notified when you compile your code if the `transacts` effect was added to a function that can’t be rolled back. Note that this check is not done for functions with the `native` specifier. |
|  | **varies:** This effect indicates that the same input to the function may not always produce the same output. The `varies` effect also indicates that the behavior of the function is not guaranteed to stay the same with new versions of its containing package. |
|  | **computes:** This effect requires that the function has no side effects, and is not guaranteed to complete. There’s an unchecked requirement that the function, when provided with the same arguments, produces the same result. Any function that doesn’t have the [native](https://dev.epicgames.com/documentation/en-us/fortnite/verse-language-quick-reference) specifier that would otherwise have the `converges` effect is a good example of using the `computes` effect. |
|  | **converges:** This effect guarantees that not only is there no side effect from the execution of the related function, but that the function definitely completes (does not infinitely recurse). This effect can only appear in functions that have the [native](https://dev.epicgames.com/documentation/en-us/fortnite/verse-language-quick-reference) specifer, but this isn’t checked by the compiler. Code that is used to provide default values of class or values for global variables are required to have this effect. The functions `sin()`, `cos()`, and `tan()` are examples of functions that have the `converges` effect. |
| **Additive Effects** |  |
|  | **decides:** Indicates that the function can fail, and that calling this function is a [failable expression](https://dev.epicgames.com/documentation/en-us/fortnite/verse-language-quick-reference). Function definitions with the `decides` effect must also have the `transacts` effect, which means the actions performed by this function can be rolled back (as if the actions were never performed), if there’s a failure anywhere in the function. |
|  | **suspends:** Indicates that the function is async. Creates an async context for the body of the function. |

In all cases, calling a function that has a specific effect will require the caller to have that effect as well.

### Access Specifiers

Access specifiers define what can interact with a member and how. Access specifiers can be applied to the following:

- The identifier for a member: `name<specifier> : type = value`
- The keyword `var` for a member: `var<specifier> name : type = value`

### Class Specifiers

Class specifiers define certain characteristics of classes or their members, such as whether you can create a subclass of a class.

|  |  |
| --- | --- |
|  | **abstract:** When a class or a class method has the abstract specifier, you cannot create an instance of the class. Abstract classes are intended to be used as a superclass with partial implementation or as a common interface. This is useful when it doesn't make sense to have instances of a superclass but you don't want to duplicate properties and behaviors across similar classes. |
|  | **concrete:** When a class has the concrete specifier, it must be possible to construct it with an empty archetype, which means that every field of the class must have a default value. Every subclass of a concrete class is implicitly concrete. A concrete class can only inherit directly from an abstract class if both classes are defined in the same module. |
|  | **unique:** The unique specifier can be applied to a class to make it a unique class. To construct an instance of a unique class, Verse allocates a unique identity for the resulting instance. This allows instances of unique classes to be compared for equality by comparing their identities. Classes without the unique specifier don't have any such identity, and so can only be compared for equality based on the values of their fields. This means that unique classes can be compared with the = and <> operators, and are subtypes of the comparable type. |

### Implementation Specifiers

It’s not possible to use implementation specifiers when writing code, but you will see them when looking at the UEFN APIs.

|  |  |
| --- | --- |
|  | **native\_callable:** Indicates that an instance method is both native (implemented in C++) and may be called by other C++ code. You can see this specifier used on an instance method. This specifier doesn’t propagate to subclasses and so you don’t need to add it to a definition when overriding a method that has this specifier. |

## Localization Specifier

You must use the `localizes` specifier when you're defining a new message. Specifically, this is when the variable has the [message type](https://dev.epicgames.com/documentation/en-us/fortnite/verse-language-quick-reference) and you're initializing the variable with a [string value](https://dev.epicgames.com/documentation/en-us/fortnite/verse-language-quick-reference).

```verse
# The winning player's name:
PlayerName<localizes> : message = "Player One"
```

```verse
# Build a message announcing the winner.
Announcement<localizes>(WinningPlayerName : string) : message = "...And the winner is: {WinningPlayerName}"

Billboard.SetText(Announcement("Player One"))
```

You don't need to use the `localizes` specifier when initializing a member value with an already-created message because the `localizes` specifier is only for defining new messages.

```verse
PlayerOne<localizes> : message = "Player One"

# The winning player's name:
PlayerName : message = PlayerOne
```

## Attributes

Attributes in Verse describe behavior that is used outside of the Verse language (unlike [specifiers](https://dev.epicgames.com/documentation/en-us/fortnite/verse-language-quick-reference#specifiers), which describe Verse semantics). Attributes can be added on the line of code before definitions.

Attribute syntax uses `@` followed by the keyword.

## Control Flow

Control flow is the order in which a computer executes instructions. Verse has different expressions you can use to control the flow of your program.

### Block

Since Verse requires an identifier before a code block, `block` expressions are how you nest code blocks. A nested code block behaves similarly to a code block. As with code blocks, a `block` expression introduces a new nested scope body.

| block |
| --- |
| **Result:** Last expression in the `block` code block. In this example, the result of the `block` expression is the result of `expression2`. |

For more info, see [Block](https://dev.epicgames.com/documentation/en-us/fortnite/block-in-verse).

### If

With the `if` expression, you can make decisions that change the flow of the program. As with other programming languages, the Verse `if` expression supports conditional execution, but in Verse, the conditions use success and [failure](https://dev.epicgames.com/documentation/en-us/fortnite/failure-in-verse) to drive the decision.

| if | if ... then |
| --- | --- |
| **Result:** Last expression in the `if` code block. In this example, the result of the `if` expression is the result of `expression1`. | **Result:** Last expression in the `if` code block. In this example, the result of the `if` expression is the result of `expression1`. |

| if ... else | if ... else if ... else |
| --- | --- |

In the following example, the `if` expression code block results in either `false`, if `IsLightOn?` succeeds, or `true`, if `IsLightOn?` fails. The `logic` result is then stored in `NewLightState`.

```verse
NewLightState :=
    if (IsLightOn?):
        Light.TurnOff()
        false
    else:
        Light.TurnOn()
        true
```

A useful case for the `if` expression in Verse is that you can try out [failable expressions](https://dev.epicgames.com/documentation/en-us/fortnite/verse-language-quick-reference) and if they fail, the actions roll back as if they never happened. For more details on this feature, see [Speculative Execution](https://dev.epicgames.com/documentation/en-us/fortnite/verse-language-quick-reference).

For more info, see [If](https://dev.epicgames.com/documentation/en-us/fortnite/if-in-verse).

### Case

With `case` expressions, you can control the flow of a program from a list of choices. The case statement in Verse allows testing one value against multiple possible values (as though you’re using =), and running code based on which one matches.

| case |
| --- |

For more info, see [Case](https://dev.epicgames.com/documentation/en-us/fortnite/case-in-verse).

### Loop

With the `loop` expression, the expressions in the loop block are repeated for every iteration of the loop.

| loop |
| --- |
| **Result:** The result of a `loop` expression is [void](https://dev.epicgames.com/documentation/en-us/fortnite/verse-language-quick-reference), which means it doesn’t produce a useful result. |

In the following example, a platform appears and disappears every `ToggleDelay` seconds for as long as the game runs.

```verse
loop:
    Sleep(ToggleDelay) # Sleep(ToggleDelay) waits for ToggleDelay seconds before proceeding to the next instruction.
    Platform.Hide()
    Sleep(ToggleDelay)
    Platform.Show() # The loop restarts immediately, calling Sleep(ToggleDelay) again.
```

For more info, see [Loop](https://dev.epicgames.com/documentation/en-us/fortnite/loop-and-break-in-verse).

### Stopping Loops

A loop block will repeat forever, so to stop the loop, you can either exit the loop with `break`, or with a function’s [return expression](https://dev.epicgames.com/documentation/en-us/fortnite/verse-language-quick-reference).

| loop and break | loop and return |
| --- | --- |
| **Result:** The result of a `loop` expression is [void](https://dev.epicgames.com/documentation/en-us/fortnite/verse-language-quick-reference), which means it doesn’t produce a useful result. | **Result:** The result of a `loop` expression is [void](https://dev.epicgames.com/documentation/en-us/fortnite/verse-language-quick-reference), which means it doesn’t produce a useful result. |

| nested loop and break |
| --- |
| **Result:** The result of a `loop` expression is [void](https://dev.epicgames.com/documentation/en-us/fortnite/verse-language-quick-reference), which means it doesn’t produce a useful result. |

For more info, see [Loop and Break](https://dev.epicgames.com/documentation/en-us/fortnite/loop-and-break-in-verse).

### For

A `for` expression, sometimes called a **for loop**, is the same as a loop expression, except that `for` expressions use a **generator** to produce a sequence of values one at a time and give each value a name.

For example, the expression `for(Value : 1..3)` produces the sequence 1, 2, 3, and each number in the sequence is given the name `Value` for each iteration, so the `for` loop runs three times.

The `for` expression contains two parts:

- **Iteration specification:** The expressions within the parentheses. The first expression must be a generator, but the other expressions can be a constant initialization or a filter.
- **Body:** The expressions in the code block after the parentheses.

| for | for with a filter |
| --- | --- |
| **Result:** The result of a `for` expression is an array containing the result of each iteration’s code block. | **Result:** The result of a `for` expression is an array containing the result of each iteration’s code block. |

| for with multiple generators | nested for blocks |
| --- | --- |
| **Result:** The result of a `for` expression is an array containing the result of each iteration’s code block. | **Result:** The result of a `for` expression that has a nested `for` expression is an array containing the array of results of each iteration from the inner loop’s code block. |

For more info, see [For](https://dev.epicgames.com/documentation/en-us/fortnite/for-in-verse).

### Defer

A `defer` expression executes just before transferring program control outside of the scope that the `defer` expression appears in, including any result expression, such as in a `return`. It doesn’t matter how the program control is transferred.

| defer | defer before an exit |
| --- | --- |
| **Result:** The `defer` expression has no result. | **Result:** The `defer` expression has no result. |

A `defer` expression will not execute if an early exit occurs before the defer is encountered.

| defer with early return | defer with a canceled concurrent task |
| --- | --- |
| **Result:** The `defer` expression has no result. | **Result:** The `defer` expression has no result. |

Multiple `defer` expressions appearing in the same scope accumulate. The order they are executed is the reverse order they are encountered — first-in-last-out (FILO) order. Since the last encountered `defer` in a given scope is executed first, expressions inside that last encountered `defer` can refer to context that will be cleaned up by other earlier encountered and later executed `defer` expressions.

| Multiple defer expressions in a code block | Multiple defer expressions in different code blocks |
| --- | --- |
| **Result:** The `defer` expression has no result. | **Result:** The `defer` expression has no result. |

## Time Flow and Concurrency

Time-flow control is at the heart of the Verse programming language, and this is accomplished with [concurrent](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#concurrent) [expressions](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#expression). To learn more about what concurrency is, see [Concurrency Overview](https://dev.epicgames.com/documentation/en-us/fortnite/concurrency-overview-in-verse).

### Structured Concurrency

[Structured concurrency](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#structured-concurrency) expressions are used to specify asynchronous time flow, and to modify the blocking nature of async expressions with a [lifespan](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#lifespan) that is constrained to a specific [async context scope](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#async-context) (such as an async function body).

This is similar to structured control flow such as `block`, `if`, `for`, and `loop` that constrain to their associated scopes.

| sync | branch |
| --- | --- |
| Executes all expressions in its code block concurrently and waits for them all to finish before executing the next expression after the `sync`. | The body of the `branch` expression is started as soon as it is encountered. The body of the branch expression continues to evaluate until the code block completes or the enclosing async context completes — whichever occurs first — at which point the `branch` code block task is canceled. |
| **Result:** The [result](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#result) of a `sync` expression is a [tuple](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary) of results from each expression in the order that the top-level expressions were specified. The result types of the expressions can be of any type, and each tuple element will have the type of its corresponding expression. | **Result:** A `branch` expression has no result, so its result type is `void`. |

| race | rush |
| --- | --- |
| Similar to `sync`, but cancels all but the "winning" [subexpression](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#subexpression). If any other expressions complete at the same simulation time as the earlier expression, the first (earlier) expression "wins" and breaks any tie. Any "losing" expression tasks are canceled. | Similar to `race`, but expressions that complete after the first expression finishes continue to execute. If any expressions effectively complete at the same simulation update, then the earlier encountered expression that completes breaks any tie. Any incomplete expressions continue to evaluate until they complete, or until the enclosing async context completes, at which point, any remaining losing expressions are canceled — whichever occurs first. |
| **Result:** The result of a `race` expression is the result of the first completed expression. The result type is the most common compatible type of all expressions in the code block. | **Result:** The result of a `rush` expression is the result of the first completed expression. The result type is the most common compatible type of all expressions in the code block. |

### Unstructured Concurrency

Unstructured concurrency expressions — of which spawn is the only one — has a lifespan not constrained to a specific async context scope — potentially extending beyond the scope where it was executed.

| spawn |
| --- |
| The body of a `spawn` creates an async context like the body of an async function. However, only a single async function call is allowed within the `spawn` body. The async function of the `spawn` is started as soon as it is encountered, and evaluates as much as possible until it encounters something suspending or blocking. The spawned async function continues to evaluate until it completes without any further connection to the location where it was spawned. |
| **Result:** A `spawn` has a task result (`task(type)`). |

### Task

A task is an object used to represent the state of a currently-executing async function. Task objects are used to identify where an async function is suspended, and the values of local variables at that suspend point.

```verse
# Get task to query / give commands to
# starts and continues independently
Task2 := spawn{Player.MoveTo(Target1)}
Task2.Await() # wait until MoveTo() completed
```

## Modules and Paths

A Verse module is an atomic unit of code that can be redistributed and depended upon, and can evolve over time without breaking dependencies. You can import a module into your Verse file to use code definitions from other Verse files.

|  |  |
| --- | --- |
|  | **using:** To be able to use the contents of a Verse module, you must specify the module by its path. |
|  | **module:** Outside of modules introduced by folders in a project, modules can be introduced within a **.verse** file using the `module` keyword. |

For more info, see [Modules and Paths](https://dev.epicgames.com/documentation/en-us/fortnite/modules-and-paths-in-verse).
