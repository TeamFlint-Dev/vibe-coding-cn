# Tuple

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/tuple-in-verse
> **爬取时间**: 2025-12-26T23:51:01.850864

---

A tuple is a grouping of two or more [expressions](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#expression) that is treated as a single expression.

The elements of a tuple are in the order you insert them into the tuple, and you can access the elements by their position in the tuple, called their index. Because the expressions in a tuple are grouped, they can be treated as a single expression.

The word tuple is a back formation from quadruple, quintuple, sextuple, and so on. Compare to [array](https://dev.epicgames.com/documentation/en-us/fortnite/array-in-verse).

A tuple [literal](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#literal) has multiple expressions between `()`, with the [elements](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#element) separated by commas:

```verse
(1, 2, 3)
```

The order of the elements in a tuple is important. The following tuple is different than the previous tuple example:

```verse
(3, 2, 1)
```

The same expression can also be in multiple positions in a tuple:

```verse
("Help me Rhonda", "Help", "Help me Rhonda")
```

Tuple expressions can be of any [type](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#type), and can contain mixed types (unlike [arrays](array-in-verse) which can only have elements of one type):

```verse
(1, 2.0, "three")
```

Tuples can even contain other tuples:

```verse
(1, (10, 20.0, "thirty"), "three")
```

If you are familiar with these terms, a tuple is like:

- An unnamed data structure with unnamed ordered elements
- A fixed-size array where each element can be a different type

Tuples are especially useful for:

- Returning multiple values from a function.
- A simple in-place grouping that is more concise than the overhead of making a fully-described, reusable data structure (such as a [struct](https://dev.epicgames.com/documentation/en-us/fortnite/struct-in-verse) or [class](https://dev.epicgames.com/documentation/en-us/fortnite/class-in-verse)).

## Specifying a Variable with a Tuple Type

To specify the type of variable as a tuple, the `tuple` prefix is used before comma-separated types enclosed in `()`:

```verse
MyTupleInts : tuple(int, int, int) = (1, 2, 3)
MyTupleMixed : tuple(int, float, string) = (1, 2.0, "three")
MyTupleNested : tuple(int, tuple(int, float, string), string) = (1, (10, 20.0, "thirty"), "three")
```

Tuple types can also be [inferred](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#infer):

```verse
MyTupleInts   := (1, 2, 3)
MyTupleMixed  := (1, 2.0, "three")
MyTupleNested := (1, (10, 20.0, "thirty"), "three")
```

Tuple type [specifiers](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary) can be used in data [members](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#member) and [function type signatures](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#function-signature) for parameters or a [return](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#return) Type:

```verse
ExampleFunction(Param1 : tuple(string, int), Param2 : tuple(int, string)) : tuple(string, int) =
    # Using parameter as result
    Param1
```

## Tuple Element Access

The elements of a tuple can be accessed with a non-failing, zero-based [index](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#index) [operator](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#operator) that takes an integer. The index operator cannot fail (unlike an array index operator `[index]` which can fail) because the compiler always knows the number of elements of any tuples and so any out-of-bounds index will be a [compile-time](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#compile-time) error:

```verse
MyTuple := (1, 2.0, "three")

MyNestedTuple := (1, (10, 20.0, "thirty"), "three")

var MyInt: int = MyTuple(0)
var MyFloat: float = MyTuple(1)
var MyString: string = MyTuple(2)

Print("My variables: {MyInt}, {MyFloat}, {MyString}")

Print("My nested tuple element: {MyNestedTuple(1)(2)}")
```

## Tuple Array Coercion

Tuples can be passed wherever an array is expected, provided that the type of the tuple elements are all of the same type as the array. Arrays cannot be passed where a tuple is expected.

## Tuple Expansion

A tuple passed as a single element to a function will be as though that function were called with each of that tuple's elements separately. This is called **tuple expansion** or [splatting](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary).

```verse
F(Arg1 : int, Arg2 : string) : void =
    DoStuff(Arg1, Arg2)

G() : void =
    MyTuple := (1, "two")
    F(MyTuple(0), MyTuple(1))  # Accessing elements
    F(MyTuple)                 # Tuple expansion
```

The `sync` [structured concurrency](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#structured-concurrency) expression has a tuple [result](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#result) that allows several [arguments](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#argument) that [evaluate](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#evaluate) over time to be evaluated simultaneously. For more information, see [Concurrency](https://dev.epicgames.com/documentation/en-us/fortnite/time-flow-and-concurrency-in-verse).

## Persistable Type

A tuple is persistable if every element type in the tuple is persistable. When a tuple is persistable, it means that you can use them in your module-scoped `weak_map` variables and have their values persist across game sessions. For more details on persistence in Verse, check out [Using Persistable Data in Verse](https://dev.epicgames.com/documentation/en-us/fortnite/using-persistable-data-in-verse).
