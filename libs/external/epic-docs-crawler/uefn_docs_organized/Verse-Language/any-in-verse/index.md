# Any

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/any-in-verse
> **爬取时间**: 2025-12-26T23:51:34.033286

---

Verse has a special [type](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#type), `any`, that is the supertype of all types (all other types are subtypes of `any`). Because of this, `any` supports very few [operations](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#operation), as all other types must be able to provide the same functionality that `any` provides.

For example, if `any` were to define a comparison operation (which it doesn't), then all other types would also have to define a comparison operation (which they don't).

There is very little that you can do with an `any` type. but it's good to be aware of this type as it may come up when writing code that produces an error.

But there are ways that you can use `any`:

```verse
Letters := enum:
    A
    B
    C

letter := class:
    Value : char

    Main(Arg : int) : void =
        X := if (Arg > 0)
            Letters.A
        else
            letter{Value := 'D'}
```

In the code example above, `X` is given the type `any`, as that is the lowest supertype of both `Letters` and `letter`.

More usefully, `any` can be used as the type for a [parameter](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#parameter) to a function that is ignored (but might be required as an argument for a [method](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#method) of an implemented interface).

For example:

```verse
FirstInt(X:int, :any) : int = X
```

The second argument to `FirstInt` is ignored, and can be of `any` type, so it is given the `any` type. `FirstInt` can be more generally written using [parametric types](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#parametric-type). For example:

```verse
First(X:t, :any where t:type) : t = X
```
