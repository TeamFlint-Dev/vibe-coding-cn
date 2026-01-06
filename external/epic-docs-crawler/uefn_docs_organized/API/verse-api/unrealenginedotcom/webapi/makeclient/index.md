# MakeClient function

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/unrealenginedotcom/webapi/makeclient
> **爬取时间**: 2025-12-27T01:16:06.016272

---

|  |  |
| --- | --- |
| Verse `using` statement | `using { /UnrealEngine.com/WebAPI }` |

`MakeClient<public><native>(ClientId:client_id):`[`client`](/documentation/en-us/fortnite/verse-api/unrealenginedotcom/webapi/client)

## Parameters

`MakeClient` takes the following parameters:

| Name | Type | Description |
| --- | --- | --- |
| `ClientId` | `client_id` |  |

## Attributes, Specifiers, and Effects

### Specifiers

The following specifiers determine how you can interact with `MakeClient` in your programs. For the complete list of specifiers, see the [Specifiers Page](/documentation/en-us/fortnite/specifiers-and-attributes-in-verse).

| Specifier | Meaning |
| --- | --- |
| `public` | The identifier is universally accessible. You can use this on modules, classes, interfaces, structs, enums, methods, and data. |
| `native` | Indicates that the definition details of the element are implemented in C++. Verse definitions with the `native` specifier auto-generate C++ definitions that a developer can then fill out its implementation. You can use this specifier on classes, interfaces, enums, methods, and data. |
