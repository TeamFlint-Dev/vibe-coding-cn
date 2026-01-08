# decides

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/decides>
> **爬取时间**: 2025-12-27T02:21:26.535859

---

An [effect](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#effect) that indicates that the [function](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#function) can [fail](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#fail), and that [calling](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#call) this function is a [failable expression](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#failableexpression). Function [definitions](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#definition) with the decides effect must also have the [transacts](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#transacts) effect, which means the actions performed by this function can be [rolled back](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#rollback) as though the actions were never performed if there's a failure anywhere in the function.
