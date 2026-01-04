# Range

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/range-in-verse
> **爬取时间**: 2025-12-26T23:51:27.474586

---

The [range](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#range-expression) [type](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#type) represents a series of [integers](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#integer), for example `0..3`, and `Min..Max`.

The start of the range is the first [value](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#value) in the expression, for example `0`, and the end of the range is the value following `..` in the expression, for example `3`. The range contains all the integers between, and including, the start and end values. For example, the range expression `0..3` contains the numbers `0`, `1`, `2`, and `3`.

[![Range diagram](https://dev.epicgames.com/community/api/documentation/image/490a9ad5-03ec-404d-a5bd-e5b8ccece35d?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/490a9ad5-03ec-404d-a5bd-e5b8ccece35d?resizing_type=fit)

Range expressions only support [int](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary) values, and can only be used in [for](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#for-expression), [sync](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary), [race](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary), and [rush](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary) expressions.

For example:

```verse
for (Index := 0..5):
    Print("{Index}")
```
