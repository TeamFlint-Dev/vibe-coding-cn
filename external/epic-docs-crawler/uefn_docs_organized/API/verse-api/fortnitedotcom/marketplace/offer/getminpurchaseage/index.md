# GetMinPurchaseAge function

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/fortnitedotcom/marketplace/offer/getminpurchaseage>
> **爬取时间**: 2025-12-27T05:03:49.016298

---

Override this method to restrict availability of an offer in certain regions and minimum ages.

Parameters:
CountryCode: ISO-3166-1 A-2 code for the country, dependent territories, or special
area of geographical interest
SubdivisionCode: ISO-3166-2 code (excluding Country Code portion) for the subdivision
within a country, dependent territory, or special area of geographical interest.
If subdivision information is unavailable for players in a region SubdivisionCode
will be an empty string.
PlatformFamily: Android, iOS, macOS, Nintendo, PlayStation, Windows, Xbox, Luna, GeForceNow

Returns:
Fails if sale of this offer should not be allowed in this (CountryCode, SubdivisionCode)
Minimum age of purchase in this (CountryCode, SubdivisionCode).
If minimum age is higher than the highest available age by region the offer will not be made

|  |  |
| --- | --- |
| Verse `using` statement | `using { /Fortnite.com/Marketplace }` |

`GetMinPurchaseAge<public><native_callable>(CountryCode:[]char, SubdivisionCode:[]char, PlatformFamily:[]char)<computes><decides>:int`

## Parameters

`GetMinPurchaseAge` takes the following parameters:

| Name | Type | Description |
| --- | --- | --- |
| `CountryCode` | `[]char` |  |
| `SubdivisionCode` | `[]char` |  |
| `PlatformFamily` | `[]char` |  |

## Attributes, Specifiers, and Effects

### Specifiers

The following specifiers determine how you can interact with `GetMinPurchaseAge` in your programs. For the complete list of specifiers, see the [Specifiers Page](/documentation/en-us/fortnite/specifiers-and-attributes-in-verse).

| Specifier | Meaning |
| --- | --- |
| `public` | The identifier is universally accessible. You can use this on modules, classes, interfaces, structs, enums, methods, and data. |
| `native_callable` | Indicates that an instance method is both native (implemented in C++) and may be called by other C++ code. You can see this specifier used on an instance method. This specifier doesn't propagate to subclasses and so you don't need to add it to a definition when overriding a method that has this specifier. |

### Effects

The following effects determine how `GetMinPurchaseAge` behaves in your programs. For the complete list of effects, see the Effect Specifers section of the [Specifiers Page](/documentation/en-us/fortnite/specifiers-and-attributes-in-verse).

| Effect | Meaning |
| --- | --- |
| `computes` | This effect requires that the function has no side effects, and is not guaranteed to complete. There's an unchecked requirement that the function, when provided with the same arguments, produces the same result. Any function that doesn't have the `native` specifier that would otherwise have the `converges` effect is a good example of using the `computes` effect. |
| `decides` | Indicates that the function can fail, and that calling this function is a [failable expression](/documentation/en-us/fortnite/failure-in-verse#failableexpression). Function definitions with the `decides` effect must also have the `transacts` effect, which means the actions performed by this function can be rolled back (as if the actions were never performed), if there's a failure anywhere in the function. |
