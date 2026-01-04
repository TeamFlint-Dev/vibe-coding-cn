# WebAPI module

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/unrealenginedotcom/webapi
> **爬取时间**: 2025-12-26T23:26:02.735635

---

- [`UnrealEngine.com`](/documentation/en-us/fortnite/verse-api/unrealenginedotcom)
- **`WebAPI`**

## Classes and Structs

| Name | Description |
| --- | --- |
| [`client_id`](/documentation/en-us/fortnite/verse-api/unrealenginedotcom/webapi/client_id) | Usage: Licensed users create a derived version of `client_id` in their module. The Verse class path for your derived `client_id` is then used as the configuration key in your backend service to map to your endpoint.  WARNING: do not make your derived `client_id` class public. This object type is your private key to your backend.  Example: my\_client\_id := class(client\_id) MyClient := MakeClient(my\_client\_id) |
| [`client`](/documentation/en-us/fortnite/verse-api/unrealenginedotcom/webapi/client) |  |
| [`response`](/documentation/en-us/fortnite/verse-api/unrealenginedotcom/webapi/response) |  |
| [`body_response`](/documentation/en-us/fortnite/verse-api/unrealenginedotcom/webapi/body_response) |  |

## Functions

| Name | Description |
| --- | --- |
| [`MakeClient`](/documentation/en-us/fortnite/verse-api/unrealenginedotcom/webapi/makeclient) |  |
