# client_id class

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/unrealenginedotcom/webapi/client_id
> **爬取时间**: 2025-12-27T01:16:27.735174

---

Usage:
Licensed users create a derived version of `client_id` in their module.
The Verse class path for your derived `client_id` is then used as the
configuration key in your backend service to map to your endpoint.

WARNING: do not make your derived `client_id` class public. This object
type is your private key to your backend.

Example:
my\_client\_id := class(client\_id)
MyClient := MakeClient(my\_client\_id)

|  |  |
| --- | --- |
| Verse `using` statement | `using { /UnrealEngine.com/WebAPI }` |

## Members

This class has no members.
