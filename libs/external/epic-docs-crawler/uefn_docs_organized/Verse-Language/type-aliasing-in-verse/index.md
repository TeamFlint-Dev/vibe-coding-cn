# Type Aliasing

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/type-aliasing-in-verse
> **爬取时间**: 2025-12-26T23:50:00.547238

---

Verse supports giving a type another name that can be used to refer to the same underlying type. This is known as a **type alias**. The syntax is similar to [constant](/documentation/en-us/fortnite/verse-glossary#constant) [initialization](/documentation/en-us/fortnite/verse-glossary#initialize) as it is basically the same thing, but using [types](/documentation/en-us/fortnite/verse-glossary#type) instead of [values](/documentation/en-us/fortnite/verse-glossary#value).

For example, to give an alias to `float` the following [syntax](/documentation/en-us/fortnite/verse-glossary#syntax) could be used:

```verse
number := float
Copy full snippet
```

You can use this to shorten some type signatures. For example, instead of the code below,

```verse
|  |  |
| --- | --- |
|  | RotateInts(X : tuple(int, int, int)) : tuple(int, int, int) = |
|  | ( X(3), X(1), X(2)) |

Copy full snippet
```

an alias could be introduced for tuple, like this:

```verse
|  |  |
| --- | --- |
|  | int_triple := tuple(int, int, int) |
|  | RotateInts(X : int_triple) : int_triple = |
|  | (X(3), X(1), X(2)) |

Copy full snippet
```

This is particularly useful in combination with function types. For example,

```verse
|  |  |
| --- | --- |
|  | int_predicate := type{_(:int)<transacts><decides> : void} |
|  | Filter(X : []int, F : int_predicate) : []int = |
|  | for (Y : X, F[Y]): |
|  | Y |

Copy full snippet
```

Note that Verse does not currently support [parametric type](/documentation/en-us/fortnite/verse-glossary#parametric-type) aliases.

For example,

```verse
predicate(t : type) := type{_(:t)<transacts><decides> : void}
Copy full snippet
```

is not supported.
