# Void

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/void-in-verse
> **爬取时间**: 2025-12-26T23:49:51.840857

---

In addition to the standard [types](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#type) in Verse, there are some additional constructs that can be used the way you would use a type, but that technically are not types. `void` is one such construct.

When used as the [result](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#result) of a [function](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary), it indicates that the function can return any [value](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#value), but when [invoked](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#call), it will provide no particular result of interest.

Void takes any value and returns `false`. This allows the body of a function that returns void to implicitly yield any value, without having to be careful to convert the result of any last expression in a block.

For example:

```verse
Foo() : void = {}
```

This means that Foo [will succeed](https://dev.epicgames.com/documentation/en-us/fortnite/failure-in-verse), but will not return a value.

For example:

```verse
FirstInt(X:int, :void) : int = X
```

Technically, void can be thought of as a function defined as

```verse
void(:any) : true
```

When used as a type, you can think of it as being applied to whatever is assigned to the corresponding typed [identifier](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#identifier).

Using a function in a type position is only allowed for a `void` function. Functions used in this way are known as functors.
