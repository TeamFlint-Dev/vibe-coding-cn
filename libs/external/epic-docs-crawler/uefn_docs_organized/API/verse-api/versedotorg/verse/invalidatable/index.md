# invalidatable interface

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/versedotorg/verse/invalidatable
> **爬取时间**: 2025-12-27T01:31:46.518469

---

Implemented by classes whose instances can become invalid at runtime.

|  |  |
| --- | --- |
| Verse `using` statement | `using { /Verse.org/Verse }` |

## Exposed Interfaces

This interface exposes the following interfaces:

| Name | Description |
| --- | --- |
| [`disposable`](/documentation/en-us/fortnite/verse-api/versedotorg/verse/disposable) | Implemented by classes whose instances have limited lifetimes. |

## Members

This interface has functions, but no data members.

### Functions

| Function Name | Description |
| --- | --- |
| [`IsValid`](/documentation/en-us/fortnite/verse-api/versedotorg/verse/invalidatable/isvalid) | Succeeds if this object is still valid. |
