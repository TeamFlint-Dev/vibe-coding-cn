# In-Island Transactions Restrictions

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/in-island-transactions-restrictions-in-fortnite>
> **爬取时间**: 2025-12-27T00:33:21.879331

---

This feature is currently experimental. This means that you can use the feature for testing and feedback, but with the understanding that the feature may change before full release. You cannot publish an island that contains an experimental feature.

Some regions and platforms have rules and restrictions about what in-island items you can offer and how you can offer them. This document includes some additional information to help you get started. Please see [Fortnite Island Developer Rules](https://legal.epicgames.com/en-US/fortnite/developer-rules), and [FAQ](https://dev.epicgames.com/documentation/en-us/fortnite/in-island-transactions-overview-in-fortnite) for more information.

Epic is providing the below for information purposes only. Epic is not providing legal advice and the information contained within is not legal advice. As the developer, it is your responsibility to comply with all relevant laws and Epic policies. You should consult a legal advisor when determining how and when the law applies to the content you publish in Fortnite.

## Paid Random Items

In addition to your responsibility to comply with laws, you must comply with certain restrictions that apply when offering Paid Random Items. Failure to utilize the functions described below will constitute a violation of Epic policies.

### Offers using Purchase API

When offering Paid Random Items for V-Bucks, you must have the `PaidRandomItem` value set to `true` for the item. This will permit Epic to restrict your Paid Random Items in accordance with the restrictions below.

### Offers using Verse

When offering Paid Random Items redeemable with other paid in-island items, you must use the `RestrictPaidRandomItems` function. This requires you, as the developer, to input the restrictions within your code.

As required by local law, Paid Random Items are restricted in the following areas:

- Singapore
- Qatar
- Australia
- Netherlands
- Belgium
- United Kingdom (U18)
- [Brazil](https://www.planalto.gov.br/ccivil_03/_ato2023-2026/2025/lei/L15211.htm)
  (U18, effective March  2026)

Beginning March 2026, you will also be restricted from offering paid random items to players in Brazil in islands that are aimed at players under 18 or likely to be accessible by them.

Finally, in addition to using the appropriate APIs, you must disclose the actual numerical odds of what the player may receive before the player makes a purchase. For example, if you offer a health potion pack that has a random chance of granting either 5, 10 or 50 potions, you must disclose the odds of their potential award before purchase (e.g., 60% chance of granting 5 potions, 30% chance of granting 10 potions, and 10% chance of granting 50 potions).

## Direct Prompts to Purchase

In your offers, you must ensure the language you use relating to transactions is not misleading or overtly pressuring. In addition, you must not pressure or directly prompt a minor (for this restriction, players under 18 unless specified to the contrary below) to make a purchase or to ask their parents to make a purchase for the minor.

If your offer language or other messaging in your game outside of the offer — for example, by using a command like “buy” or “order” at the start of a sentence, uses all capital letters or an exclamation point when making a prompt—such as "BUY NOW"!—it’s likely considered a direct prompt and may have age and location restrictions.

Below are some examples of language that is prohibited, and in contrast, some acceptable examples.

| Unacceptable Examples | Acceptable Examples |
| --- | --- |
| Buy Now! | Available now! |
| Grab it! | Available for purchase! |
| Upgrade!/Play!/Try!/Unlock! (when a purchase is required) | See [developer name] Shop for details! |
| Buy one get one for free! | If you buy one, you’ll get one for free! |

If offers or messaging in your island include a direct prompt to purchase, you must use the `RestrictDirectPromptsToPurchase` function. This per-player function will indicate if you need to restrict the offer or messaging from appearing for that player. `RestrictDirectPromptsToPurchase` will return `true` for players in the regions listed below:

If your offer includes a direct prompt to purchase, you must use the `RestrictDirectPromptsToPurchase` function which will restrict the offer from appearing in the regions listed below:

|  |  |  |
| --- | --- | --- |
| Austria | France (under 17) | Netherlands |
| Belgium | Germany | Poland |
| Bulgaria | Greece | Portugal |
| Canada (under 13) | Hungary | Romania |
| Croatia | Ireland | Slovakia |
| Cyprus | Italy | Slovenia |
| Czechia (Czech Republic) | Latvia | Spain |
| Denmark | Lithuania | Sweden |
| Estonia | Luxembourg | United Kingdom (under 16) |
| Finland | Malta |  |

  Here’s an example of how to use `RestrictDirectPromptsToPurchase` to limit offers to the appropriate players:

```verse
if (RestrictDirectPromptsToPurchase[Player1]):
       # Player is unable to receive direct prompts to purchase.
       ShowAvailableNowMessageToPlayer(Player1)
    else:
       # Player is able to receive direct prompts to purchase.
       ShowBuyNowMessageToPlayer(Player1)
```

## In-Island Item Bundles

### Brazil

Brazil has certain restrictions on offering bundles. For offers available to players in Brazil, if an in-island item is sold as part of a bundle, it generally must also be made available for purchase as an individual item, unless there’s a commercial reason or necessity to do so.

For example, it is likely reasonable to sell one dozen eggs together or a pair of shoes together and not sell one egg or one shoe separately. However, requiring a player to buy seven different sweaters together and not selling each sweater individually is likely not reasonable and would be prohibited. You should consult a legal advisor when determining how and when this law applies to the content you publish for Brazilian players.

## Additional Optional Restrictions on Purchases

You may choose to place additional restrictions on where your offers are surfaced and who can view them.  As displayed in the example below, you may decide to prohibit sales of certain items from players in Antarctica or players that are under 18 years old in Antarctica.  You may do so by using the `GetMinPurchaseAge` function.  This function permits you to add restrictions - it technically impossible for you to circumvent already existing and built-in restrictions.

`GetMinPurchaseAge` is a `<computes>` function that allows a developer to use a player’s country, subdivision, and platform to determine where and how an offer can be made. This player information is provided to the developer anonymously and the function prevents the developer from saving any information on any individual player.  A developer identifies the desired country, subdivision, and platform of the player, and using `GetMinPurchaseAge` makes a yes/no call or returns a minimum age for that country, subdivision, and platform combination.  This allows a developer to specify their offers with needed information while also not providing the developer with individual player information.

In the Purchase API, the `ShowOffersDialog` and `BuyOffer` functions apply logic to determine if the offer is appropriate to sell to a player.  You may optionally add restrictions logic when crafting an offer by overriding the logic using `GetMinPurchaseAge`.

Below you will find an example of how to further limit offers with the `GetMinPurchaseAge` function:

```verse
basic_sword_offer<public> := class(entitlement_offer):
    # Offer name, description, etc...

    EntitlementType<override>:concrete_subtype(entitlement) = Entitlements.basic_sword

    GetMinPurchaseAge<override>(CountryCode:string, SubdivisionCode:string, PlatformFamily:string)<decides><computes>:int =
        # A Hypothetical example where you only want to sell swords to people who don't live in Antarctica
        CountryCode <> "AQ"
        return 0
```
