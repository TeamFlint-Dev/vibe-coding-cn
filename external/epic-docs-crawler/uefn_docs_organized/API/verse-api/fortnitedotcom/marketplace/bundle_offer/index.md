# bundle_offer class

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/fortnitedotcom/marketplace/bundle_offer>
> **爬取时间**: 2025-12-27T01:14:48.652184

---

A `bundle_offer` allows you to bundle multiple other `offer`s into a single purchasable `offer`.

|  |  |
| --- | --- |
| Verse `using` statement | `using { /Fortnite.com/Marketplace }` |

## Inheritance Hierarchy

This class is derived from `offer`.

| Name | Description |
| --- | --- |
| [`offer`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/marketplace/offer) | Offers are used to sell entitlements to players. See `entitlement_offer` and `bundle_offer` classes for more information. |

## Members

This class has both data members and functions.

### Data

| Data Member Name | Type | Description |
| --- | --- | --- |
| `Offers` | `[](offer, int)` |  |
| `Price` | `price_dimension` |  |

### Functions

| Function Name | Description |
| --- | --- |
| [`GetMinPurchaseAge`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/marketplace/offer/getminpurchaseage) | Override this method to restrict availability of an offer in certain regions and minimum ages.  Parameters: CountryCode: ISO-3166-1 A-2 code for the country, dependent territories, or special area of geographical interest SubdivisionCode: ISO-3166-2 code (excluding Country Code portion) for the subdivision within a country, dependent territory, or special area of geographical interest. If subdivision information is unavailable for players in a region SubdivisionCode will be an empty string. PlatformFamily: Android, iOS, macOS, Nintendo, PlayStation, Windows, Xbox, Luna, GeForceNow  Returns: Fails if sale of this offer should not be allowed in this (CountryCode, SubdivisionCode) Minimum age of purchase in this (CountryCode, SubdivisionCode). If minimum age is higher than the highest available age by region the offer will not be made |
