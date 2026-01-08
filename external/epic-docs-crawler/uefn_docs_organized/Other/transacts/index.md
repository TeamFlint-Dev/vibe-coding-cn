# transacts

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/transacts>
> **爬取时间**: 2025-12-27T02:21:35.000515

---

When a [function](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#function) has the `transacts` [effect](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#effect), it means the function can read and write data, but those actions can be [rolled back](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#rollback) if the function also has the [decides](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#decides) effect. This effect is an [exclusive effect](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#exclusiveeffect).

A function with no exclusive effect specified, can read and write data, but cannot be rolled back.
