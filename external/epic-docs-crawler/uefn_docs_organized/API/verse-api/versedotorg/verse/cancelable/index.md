# cancelable interface

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/versedotorg/verse/cancelable>
> **爬取时间**: 2025-12-27T01:30:34.092281

---

Implemented by classes that allow users to cancel an operation. For example, calling `subscribable.Subscribe` with a callback returns a `cancelable` object. Calling `Cancel` on the return object unsubscribes the callback.

|  |  |
| --- | --- |
| Verse `using` statement | `using { /Verse.org/Verse }` |

## Members

This interface has functions, but no data members.

### Functions

| Function Name | Description |
| --- | --- |
| [`Cancel`](/documentation/en-us/fortnite/verse-api/versedotorg/verse/cancelable/cancel) | Prevents any current or future work from completing. |
