# offer class

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/fortnitedotcom/marketplace/offer
> **爬取时间**: 2025-12-27T01:15:37.701332

---

Offers are used to sell entitlements to players. See `entitlement_offer` and `bundle_offer` classes for more information.

|  |  |
| --- | --- |
| Verse `using` statement | `using { /Fortnite.com/Marketplace }` |

## Exposed Interfaces

This class exposes the following interfaces:

| Name | Description |
| --- | --- |
| [`has_icon`](/documentation/en-us/fortnite/verse-api/versedotorg/assets/has_icon) | Interface that provides an icon. |
| [`has_description`](/documentation/en-us/fortnite/verse-api/versedotorg/presentation/has_description) | Interface that provides descriptive names or text. |

## Members

This class has both data members and functions.

### Data

| Data Member Name | Type | Description |
| --- | --- | --- |
| `Price` | `price_dimension` |  |

### Functions

| Function Name | Description |
| --- | --- |
| [`GetMinPurchaseAge`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/marketplace/offer/getminpurchaseage) | Override this method to restrict availability of an offer in certain regions and minimum ages.  Parameters: CountryCode: ISO-3166-1 A-2 code for the country, dependent territories, or special area of geographical interest SubdivisionCode: ISO-3166-2 code (excluding Country Code portion) for the subdivision within a country, dependent territory, or special area of geographical interest. If subdivision information is unavailable for players in a region SubdivisionCode will be an empty string. PlatformFamily: Android, iOS, macOS, Nintendo, PlayStation, Windows, Xbox, Luna, GeForceNow  Returns: Fails if sale of this offer should not be allowed in this (CountryCode, SubdivisionCode) Minimum age of purchase in this (CountryCode, SubdivisionCode). If minimum age is higher than the highest available age by region the offer will not be made |
