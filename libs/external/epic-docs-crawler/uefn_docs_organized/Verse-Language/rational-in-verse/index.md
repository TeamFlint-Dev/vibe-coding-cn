# Rational

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/rational-in-verse
> **爬取时间**: 2025-12-26T23:50:16.016916

---

Three major numeric [types](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#type) are supported in Verse: [int](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary), used for [integers](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#integer), [float](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary), used for [floating-point numbers](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#floating-point-number), and `rational`, used for [rational numbers](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#rational-number).

The [operations](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#operation) supported for the `rational` type are currently limited to these [built-in](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#built-in-type) operations:

```verse
Ceil(:rational):int

Floor(:rational):int
```

However, rational will likely show up often in error messages. For example:

```verse
Z:int = X / Y
```

This will [fail](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary) the [type checker](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#type-checker) with a message that indicates that `rational` is not a subtype of `int`.

See [Int](https://dev.epicgames.com/documentation/en-us/fortnite/int-in-verse) for more information on math operations and rational types.
