# Marketplace module

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/fortnitedotcom/marketplace
> **爬取时间**: 2025-12-26T23:25:57.254144

---

- [`Fortnite.com`](/documentation/en-us/fortnite/verse-api/fortnitedotcom)
- **`Marketplace`**

## Classes and Structs

| Name | Description |
| --- | --- |
| [`offer_interactable_component`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/marketplace/offer_interactable_component) |  |
| [`price_vbucks`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/marketplace/price_vbucks) |  |
| [`price_dimension`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/marketplace/price_dimension) |  |
| [`entitlement`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/marketplace/entitlement) | An entitlement that is tracked by the commerce system.   - A player may only have one `entitlement` if the entitlement is not consumable. - A player may have `MaxCount` of a consumable entitlement. - Your derived type must be  to be used by the purchase system. - If the entitlement you are selling gives players a meaningful advantage in your island, you must set ConsequentialToGameplay to true. |
| [`offer`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/marketplace/offer) | Offers are used to sell entitlements to players. See `entitlement_offer` and `bundle_offer` classes for more information. |
| [`entitlement_offer`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/marketplace/entitlement_offer) | An `entitlement_offer` allows an individual `entitlement` to be purchased. |
| [`bundle_offer`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/marketplace/bundle_offer) | A `bundle_offer` allows you to bundle multiple other `offer`s into a single purchasable `offer`. |
| [`entitlement_change(t)`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/marketplace/entitlement_change/entitlement_change(t)) | Entitlements that have changed in quantity. This will also include entitlement changes triggered by moderation, refunds and other commerce operations. |

## Functions

| Name | Description |
| --- | --- |
| [`MakePriceVBucks`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/marketplace/makepricevbucks) |  |
| [`GetPriceVBucks`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/marketplace/getpricevbucks) |  |
| [`RestrictPaidRandomItems`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/marketplace/restrictpaidrandomitems) | Informs if usage of paid random items is restricted for `Player` due to platform, territory, age, or user configuration restrictions. |
| [`RestrictDirectPromptsToPurchase`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/marketplace/restrictdirectpromptstopurchase) | Informs if usage of direct prompts to purchase is restricted for `Player`. |
| [`BuyOffer`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/marketplace/buyoffer) | Displays the Epic purchase UI to the player to purchase the `Offer`. Returns true if an offer was purchased. |
| [`GrantEntitlement`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/marketplace/grantentitlement) | Grant an entitlement directly to `Player`. This function does not gate granting entitlements based on EntitlementDisclosures. Entitlements are always granted assuming they match the MaxCount requirement. |
| [`GetPurchasedEntitlements`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/marketplace/getpurchasedentitlements) | Get all available `entitlement`s for `Player`, along with the number of those `entitlement`s. This includes finding `entitlement`s of derived types. Calling GetPurchasedEntitlements(Player, entitlement) will suspend forever. |
| [`entitlement_change`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/marketplace/entitlement_change) | Entitlements that have changed in quantity. This will also include entitlement changes triggered by moderation, refunds and other commerce operations. |
| [`GetEntitlementsChangedEvent`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/marketplace/getentitlementschangedevent) | Used to listen for entitlement change events during a game session. Runtime error if `entitlement` is used directly. |
| [`ConsumeEntitlement`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/marketplace/consumeentitlement) | Consumes a consumable `entitlement`. Fails if:   - The `entitlement` is not consumable. - The `Player` does not own requested `Count` of `entitlement`. |
| [`ShowOffersDialog`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/marketplace/showoffersdialog) | Shows the Epic provided store front contain the specified `Offers`. |
