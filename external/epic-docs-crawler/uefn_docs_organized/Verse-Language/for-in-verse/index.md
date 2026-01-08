# For

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/for-in-verse>
> **爬取时间**: 2025-12-26T23:51:40.059578

---

The `for` [expressions](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#expression), sometimes called **for loops**, are the same as [loop expressions](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#loop), except that `for` expressions iterate over a bounded number of items. This means the number of iterations is known before the `for` loop is executed, and decisions on when to exit the loop are automated for you.

The [Pulse Trigger device](https://dev.epicgames.com/documentation/en-us/fortnite/using-pulse-trigger-devices-in-fortnite-creative) is an example of a `for` loop with bounded iterations when you set the Pulse Trigger device **Looping** setting to a number. The Pulse Trigger's pulse repeats as many times as specified by the device Looping setting.

[![Using Verse to program the Pulse Trigger Device in UEFN](https://dev.epicgames.com/community/api/documentation/image/e8bba150-d9a5-406a-95f4-5bf2d21f8cf1?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/e8bba150-d9a5-406a-95f4-5bf2d21f8cf1?resizing_type=fit)

In this example, two [Trigger devices](https://dev.epicgames.com/documentation/en-us/fortnite/using-trigger-devices-in-fortnite-creative) are in the Pulse Trigger's path. When the Pulse Trigger's pulse reaches a Trigger device, the device sends a signal to display text on one of the Billboard devices and repeats three times.

As code, this example could look like:

```verse
for (X := 0..2):
    TriggerDevice1.Transmit()
    TriggerDevice2.Transmit()
```

The `for` expression contains two parts:

- **Iteration specification**: The expressions within the parentheses and the first expression must be a [generator](https://dev.epicgames.com/documentation/en-us/fortnite/for-in-verse). In this example, it is `(X := 0..2)`.
- **Body**: The expressions after the parentheses. In this example, that is the two lines with `Transmit()`.

[![For flow diagram in Verse](https://dev.epicgames.com/community/api/documentation/image/034ae3a9-328b-4cfe-9bd2-eb497681d6d0?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/034ae3a9-328b-4cfe-9bd2-eb497681d6d0?resizing_type=fit)

## Generator

A generator produces a sequence of [values](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#value), one at a time, and gives the value a name. In this example, the generator is `X := 0..2`, so each iteration of the loop, the generator produces the next value and gives the value the name X. When the generator reaches the end of the sequence, the `for` loop ends. This decision flow of checking if the loop variable has a valid value is built into the `for` expression.
Generators only support [ranges](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#range-expression), [arrays](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary), and [maps](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary).

### Iterating over a Range

The [range](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#range-expression) [type](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#type) represents a series of integers; for example, `0..3`, and `Min..Max`.

The start of the range is the first value in the expression — for example `0` — and the end of the range is the value following `..` in the expression — for example, `3`. The range contains all the integers between, and including, the start and end values. For example, the range expression `0..3` contains the numbers `0`, `1`, `2`, and `3`.
Range expressions only support [int](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary) values, and can only be used in [for](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#for-expression), [sync](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary), [race](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary), and [rush](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary) expressions.

```verse
for (Number := 0 .. 3):
    Log("{Number}")
```

The result will add four lines to the log containing the numbers `0`, `1`, `2`, and `3`.

A `for` expression can return the results from each iteration in an [array](array-in-verse). In the following example, `Numbers` is an [immutable](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#immutable) array with the `int` values `-1` to `-10`.

```verse
Numbers := for (Number := 1..10):
    -Number
```

### Iterating over an Array or a Map

Iterations over arrays and maps can be just the values, or the [key-value pair](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#key-value-pair) for maps and the index-value pair for arrays.

In this case, only the values of the array are used, and `Values` is an immutable array with the `int` values `2`, `3`, and `5`.

```verse
Values := for (X : array{1, 2, 4}):
    X+1
```

The same can be done with a map, and `Values` is, in this case, an immutable array with the int values `3,7`.

```verse
Values :=  for  (X := map{ 1=>3,  0=>7 }):
    X
```

The `X->Y` pattern can be used to deconstruct an index-value or key-value pair. The index (or key) is bound to the left part (`X`) and the value is bound to to the right part (`Y`).
An example of Index-value pairs from an array, `Values` is an immutable array with the `int` values `1`, `3`, and `6`.

```verse
Values := for ( X -> Y : array{1, 2, 4}) :
    X + Y
```

An example of Index-value pairs from a map, `Values` is an immutable array with the `int` values `4`, and `7`.

```verse
Values  :=  for ( X->Y := map{ 1=>3,  0=>7 }):
    X + Y
```

## Filter

You can add [failable expressions](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#failable-expression) to the `for` expression to filter out values from the generator. If the filter fails, then there's no result for that iteration, and `for` skips to the next value produced by the generator.

For example, the filter `Num <> 0` is added to the `for` expression to exclude `0` from the returned results.

```verse
NoZero := for (Number := -5..5, Number <> 0):
    Number
```

[Syntactically](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#syntax), this is the same as:

```verse
expression0
for (Item : Collection, test-arg-block):
    expression1
expression2
```

[![For with Condition diagram in Verse](https://dev.epicgames.com/community/api/documentation/image/41cee192-8819-460e-8e9d-45104bff665e?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/41cee192-8819-460e-8e9d-45104bff665e?resizing_type=fit)

## Definition

You can also add named expressions to the iteration [specification](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary), and the name can be used in both the iteration specification and the [body](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#body).

```verse
Values := for ( X := 1..5; Y:=SomeFunction(X); Y < 10):
    Y
```

Result: an array with at most 5 items where all values are less than 10.

## Nested For

You can [nest](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#nested) a `for` loop inside another `for` loop. There are two ways to do this:

- **Single For Expression:** Specified by multiple generators. The result is a one-dimensional array.
- **Multiple For Expressions:** Separate `for` blocks. The result is a multidimensional array.

The sections below describe these further.

### Single For Expression

You can have multiple loops in a single `for` expression by adding more generators. The result of a single `for` expression with multiple generators is a one-dimensional array.

In this example, `Values` is an immutable array with the `int` values `13`, `14`, `23` and `24`.

```verse
Values := for(X:=1..2, Y:=3..4):
        X * 10 + Y
```

Semantically, this is the same as:

```verse
expression0
for (Item : Collection, Item2 : Collection2):
    expression1
expression2
```

[![Nested For flow diagram in Verse](https://dev.epicgames.com/community/api/documentation/image/1c7c335a-c404-4a83-a255-bb05831b7f86?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/1c7c335a-c404-4a83-a255-bb05831b7f86?resizing_type=fit)

### Multiple For Expressions

You can also nest a `for` expression in another for-loop body. Since one `for` expression returns a one-dimensional array, nesting a `for` expression returns a two-dimensional array.

In this case, `Values` is an immutable array with two immutable `int` arrays. The first array contains the values `13`, and `14`, and the second array contains `23` and `24`. This can be written as `array{ array{13, 14}, array{23, 24} }`.

```verse
Values := for ( X := 1..2 ):
    for (Y := 3..4):
        X * 10 + Y
```

## Failure

If anything fails inside the iteration specification, then any changes due to that iteration will be [rolled back](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#rollback).

```verse
for(X := 1..5; S := IncrementSomeVariable(); X < 3):
    X
```

The result of this `for` expression is `array{1,2}`, with only two calls to `IncrementSomeVariable` after the evaluation of the **for** loop because the other calls were rolled back when the filter `X < 3` failed.
