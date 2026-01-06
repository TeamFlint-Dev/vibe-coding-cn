# Block

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/block-in-verse
> **爬取时间**: 2025-12-26T23:52:57.404569

---

Since Verse requires an [identifier](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#identifier) before a [code block](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#code-block), `block` expressions are how you [nest](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#nested) code blocks, and `block` expressions behave similarly to [code blocks](code-blocks-in-verse).

As with code blocks, `block` introduces a new nested [scope](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#scope) [body](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#body), constraining the [lifetimes](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#lifetime) of any [variables](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary) created in the `block` in a way that they cannot be used outside of the `block`.

```verse
expression0
block:
    expression1
    expression2
expression3
```

[![`block` Diagram](https://dev.epicgames.com/community/api/documentation/image/b6d91ee8-eb30-4874-99bc-c16281a67cd5?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/b6d91ee8-eb30-4874-99bc-c16281a67cd5?resizing_type=fit)

Unless there is an early exit, the `block` expression uses the last expression executed in the block as its result. For example, if the last expression in the block is `Example : int = 6` then the `block` expression has `6` as a result.
