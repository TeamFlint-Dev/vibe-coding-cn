# In-Island Transactions Overview

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/in-island-transactions-overview-in-fortnite
> **爬取时间**: 2025-12-27T00:00:03.813655

---

This feature is currently experimental. This means that you can use the feature for testing and feedback, but with the understanding that the feature may change before full release. You cannot publish an island that contains an experimental feature.

**In-island transactions** provide a way for you to sell items, gameplay properties, or assets for [V-Bucks](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-glossary#v-bucks).

[![](https://dev.epicgames.com/community/api/documentation/image/00fa36e9-994d-4520-a747-3ad5cb73dd5f?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/00fa36e9-994d-4520-a747-3ad5cb73dd5f?resizing_type=fit)

## Entitlements in Verse (Items) and Offers

When creating items or assets to sell on your island, you define them as entitlements in Verse. 
**Entitlement** refers specifically to the functions and tools (Verse and UEFN) used to create items or assets that can be offered to players.

|  |  |  |
| --- | --- | --- |
| **Category** | **Description** | **Example** |
| **Durable** | An item players can buy once, and that doesn't expire over time. | An upgraded shovel. |
| **Consumable** | An item that depletes when used in-game. | Seed packets. |
| **Paid Area** | An offer that provides access to an area behind a paywall. | A farmers market where a player can take the produce they grow and sell it. |

When an item is offered to players for a price, this is referred to as an entitlement offer in Verse. An entitlement offer is a single item available at a defined price. When more than one item is offered for a single price, this is a [bundle offer](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-glossary#bundle-offer) in Verse. The exchange of an offer for V-Bucks is a **transaction**, and these transactions take place on your island.

The basic workflow is:

- Using Verse, create one or more items that you'll sell. These can be items (for example, seed packs or shovels for a farming island) or access to an area that sits behind a paywall.
- Determine how you want to sell your items. This can be as individual offers, or bundled offers.
- Configure the prices and relevant information for your offers.
- Sell your items on your island, either as individual items or through a storefront. You can use the default storefront UI or build custom UI.
- Review and manage items and offers in UEFN and the Creator Portal.

To learn more, see **[Creating Items and Offers](https://dev.epicgames.com/documentation/en-us/fortnite/creating-items-and-offers-in-fortnite)**.

## Paid Random Items

A **[paid random item](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-glossary#paid-random-item)** is a random reward players purchase or redeem in-game. The random item can be a **single offer** or a **bundle offer**.

Parents can restrict whether their child can spend V-Bucks (or content purchased with V-Bucks) on paid random items.

When creating a paid random item:

- You must indicate which items are paid random items.
- You must list the percentage chance for items.

To learn more about setting up paid random items, see **[Creating Items and Offers](https://dev.epicgames.com/documentation/en-us/fortnite/creating-items-and-offers-in-fortnite)**. 
To learn more about restrictions and rules using paid random items, see **[In-Island Transactions Requirements](https://dev.epicgames.com/documentation/en-us/fortnite/in-island-transactions-restrictions-in-fortnite)**.

Paid random items are blocked for players in certain regions. For more information, see [In-Island Transactions Restrictions](https://dev.epicgames.com/documentation/en-us/fortnite/in-island-transactions-restrictions-in-fortnite).

## Defining Items are Consequential to Gameplay

Items that give players meaningful advantages for gameplay are considered **Consequential to Gameplay** and must be defined in Verse.

Advantages to gameplay can be direct or indirect:

- **Direct**: an item that increases a player’s gameplay progress rate, power, or capabilities
- **Indirect**: an item that grants access to gameplay where a player can acquire an item that meaningfully impacts how quickly they can progress

To learn more about consequential to gameplay items, see **[Creating Items and Offers](https://dev.epicgames.com/documentation/en-us/fortnite/creating-items-and-offers-in-fortnite)**.

## Monetization and Payouts

Epic manages and distributes a share of the payouts.

To determine the V-Bucks value in US dollars in a given month, we take all customer real-money spending to purchase V-Bucks (converted to US dollars), subtract platform and store fees (ranging from 12% on Epic Games Store to 30% on current consoles, and currently averaging 26%), and divide it by the total V-Bucks spent by players. So, 50% of V-Bucks value translates to ~37% of retail spending, and 100% of V-Bucks value translates to ~74%.

## Developer and Player Requirements

To publish your island with in-island transactions:

- You must be at least **18** years old to include in-game transactions on your island.
- You must be enrolled in the **[Island Creator Program](https://create.fortnite.com/enroll)**.
- You must indicate that your island includes **Digital Purchases** in the [IARC questionnaire.](https://dev.epicgames.com/documentation/en-us/fortnite/rating-screen-in-fortnite) .

If you are already enrolled in the Island Creator Program, you are required to agree to the updated agreements. The Engagement Payout Program Terms have been updated to the Fortnite Developer Terms and includes provisions addressing In-Island Transactions. The IPPP program terms have also been updated to address In-Island Transactions and requires resigning.

Players redeem V-Bucks for digital content. Reselling and trading content purchased with V-Bucks is not supported.

## Entitlements and Offer Technical Requirements

An entitlement has statically defined and immutable attributes such as **Name**, **description**, and **icon**.

In Verse, an entitlement is a sellable item, feature, or effect. An entitlement offer is a single item offered at a price. A bundle offer is two or more offers sold together for a single price.

- An entitlement offer can contain only one item.
- A bundle offer must contain two or more offers.
- Entitlements, entitlement offers, and bundle offers must each have their own clear titles and descriptions.
- Entitlement tags cannot exceed **100** words.
- The name of a product, offer, or bundle cannot exceed **50** characters.
- Description text cannot exceed 5**00** characters.
- Short description text cannot exceed **100** characters.
- Each entitlement or bundle offer is priced between **50** and **5000** **V-Bucks**. Pricing must be in increments of **50**.

To learn more, see **[Creating Items and Offers](https://dev.epicgames.com/documentation/en-us/fortnite/creating-items-and-offers-in-fortnite)**.

## Entitlement Catalog

Once the code is updated with the items you intend to sell, a **Entitlemen****t Catalog** becomes available in the editor. This is a list of all items added to the In-Island Transactions device.

To learn more about building a marketplace for your island, see **[Creating Items and Offers](https://dev.epicgames.com/documentation/en-us/fortnite/creating-items-and-offers-in-fortnite)**.

## Managing In-Island Transactions in the Creator Portal

Once your island is published, it becomes playable and searchable in Discover, and players can purchase your offers.

### Publishing

When you publish your island, your island will be reviewed in the moderation process as usual. Additionally you will be able to review your items and offers during the publishing flow.

In certain regions, you cannot directly prompt players under the age of 18 to purchase items in your island, which is outlined in the **[Fortnite Developer Rules](https://legal.epicgames.com/fortnite/developer-rules)** and [Restrictions](https://dev.epicgames.com/documentation/en-us/fortnite/in-island-transactions-restrictions-in-fortnite) documentation. Make sure to review all the rules and policies before submitting your island for moderation and publication.

### Creator Portal Project Management

The island’s [Project page](https://dev.epicgames.com/documentation/en-us/fortnite/managing-your-projects-in-fortnite-creative) includes a list of the items, offers, and bundle offers available. Each entitlement and offer provides:

- A name, description, and price of offers and bundle offers.
- Technical errors or potential errors with the item or offer.

To change the details for any item or offer, you need to go to UEFN and make the changes there, then resubmit for publication.

### Analytics

Once an island goes live, all in-island transactions generate reports, [analytics](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-glossary#analytics), and purchase data charts on an hourly basis. You can view this data in the Creator Portal through **Projects Analytics Integration**.

When players make purchases, this creates a new revenue stream in addition to [Engagement Payouts](https://legal.epicgames.com/fortnite/developer-terms). Reports for purchases and payouts are available in a metric called **Account Level Monetization Reporting**. These reports include:

- Purchases and  payouts
- Revenue breakdown in a monthly earnings report
- Aggregate earnings, with accumulated net fees

Team members can monitor the sales performance of purchases through the Creator Portal to see:

- Top selling items
- Lowest selling items
- Percentage change from prior release averages
- Total sales of the current release (Owner only)
- Average sales for prior releases (Owner only)

### Your Island in Discover

Fortnite is transparent about islands that use in-island transactions — islands that offer digital purchase options are clearly marked:

- Islands featuring in-island transactions include a **Contains in-game purchases** description on the island details page.
- Islands that make use of in-island transactions are clearly marked in Discover so players are aware that certain islands have in-game purchases available before they play.

## Frequently Asked Questions

#### What are the rules for what developers can and cannot sell in their islands?

See the full [Developer Rules](https://legal.epicgames.com/fortnite/developer-rules) (including section 4.4, ‘In-Island Transactions Rules’) and the In-Island Transactions Restrictions document for all the details.

#### Are there any regional restrictions for in-island transactions?

Yes, some regions—and platforms—have rules and restrictions about what in-island items you can offer and how you can offer them. To help you comply with the rules, we have APIs and guidelines for integrating transactions into your island. Check out the full Fortnite Developer Rules and the In-Island Transactions Restrictions document for more information. Ultimately, it is your responsibility as the developer to comply with all relevant regional rules and regulations.

#### Can all Fortnite developers add in-island transactions to islands?

Yes, all developers enrolled in the [Island Creator Program](https://create.fortnite.com/enroll?team=personal) are able to add in-island transactions to eligible Islands.

#### What islands are not eligible for in-island transactions?

Islands published through the [IP Partner Licensing Program](https://dev.epicgames.com/documentation/en-us/fortnite/game-collections-in-fortnite) are not currently eligible for in-island transactions.

#### What revenue will developers earn from players purchasing items in my islands?

Developers will ordinarily earn 50% of the V-Bucks value from sales in their islands, but from December 2025 through the end of 2026, the rate will be 100%.

#### How does Epic calculate the value of V-Bucks?

To determine the V-Bucks value in US dollars in a given month, we take all customer real-money spending to purchase V-Bucks (converted to US dollars), subtract platform and store fees (ranging from 12% on Epic Games Store to 30% on current consoles, and currently averaging 26%), and divide it by the total V-Bucks spent by players. So, 50% of V-Bucks value translates to ~37% of retail spending, and 100% of V-Bucks value translates to ~74%.

#### Why does the V-Bucks value fluctuate?

To determine the V-Bucks value in US dollars in a given month, we take all customer US dollar spending to purchase V-Bucks in dollars, subtract platform and store fees (ranging from 12% on Epic Games Store to 30% on current consoles), and divide it by the total V-Bucks spent by players. This value fluctuates over time based on a few factors including:

- Discounted or Earned V-Bucks: Players purchase and earn V-Bucks through things like Crew memberships and Battle Pass. This shifts the average value of V-Bucks in circulation.
- Purchase Mix: The cost of a V-Buck depends on which bundle a player buys.
- Foreign Exchange (“FX”) & Regional Pricing: Changes in FX and regional pricing may also cause fluctuations.

#### Does adding in-island transactions to an island impact engagement payouts?

No, the revenue you earn from in-island transactions does not impact engagement payouts. For more details on how engagement payouts work, including how the pool and your payout are calculated, see [Engagement Payout](https://dev.epicgames.com/documentation/fortnite/engagement-payout-in-fortnite-creative).

#### How will developers receive their earnings from in-island transactions?

Payouts from earnings generated by in-island transactions are calculated monthly and will be paid alongside the existing monthly engagement payouts which start thirty days after the close of the monthly period.

#### How are returns handled?

All in-island transactions are final sale. However, to help you manage any issues, you will be able to initiate bulk returns through the Creator Portal. You will need to specify which island, offer, and time window for the return, dating back up to 20 days. Epic will process these requests within five days.

#### What is the minimum and maximum V-Bucks price developers can set for items?

All items or bundles of items available for players to purchase using in-island transactions must be between 50 - 5000 V-Bucks, in increments of 50 V-Bucks.

#### Can items purchased in an island with in-island transactions be used in other islands?

Items purchased using in-island transactions can only be used in the island where they were purchased. All purchased cosmetic items in the Fortnite Item Shop—for example, outfits, emotes, music, and cars—will continue to work in all islands just as they do today. Please note that purchased items will not be usable outside of the Fortnite Ecosystem.

#### What data do developers receive about in-island transactions?

When publishing is available, new Creator Portal features will let you monitor the overall performance of your offers and the revenue from in-island transactions. New charts will offer insights such as total numbers of unique buyers, revenue reporting, and purchasing trends.

Monthly earnings reports will also include a new category for in-island transaction revenue, alongside engagement payouts.

To preserve player privacy and ensure no player-specific data are revealed, these charts/reports will show aggregate insights.

#### What is a durable item?

A durable item is an item that provides lasting access or functionality within the island it was purchased. For example, this could be a furniture item in a game that involves building a house.

#### What is a consumable item?

A consumable item is something that can be used up or spent during gameplay. Examples might be an arrow or a potion, or a bundle offer with a stack of arrows.

#### Are there updates to Parental Controls?

Yes, parents and guardians can use a new parental control to turn off their child’s ability to purchase paid random items. Parents will only see this setting if paid random items are available in their region.

#### Can a player gift an item they have purchased using in-island transactions to another player?

No, gifting of items purchased using in-island transactions between players is not allowed.

#### What do I need to do before I permanently unpublish my island?

You must stop in-island transactions at least 20 days before you permanently unpublish your island. If you don’t, all V-Bucks from in-island transactions made during the 20-day period prior to the island being unpublished will be returned to players, and those transactions will be removed from your pending payout calculation.

#### What happens if I unpublish my island with in-island transactions and republish later?

You will have 14 days to republish your island. After 14 days of being down, all V-Bucks from in-island transactions made during the 20 day period prior to the island being unpublished will be returned to players, and those transactions will be removed from your pending payout calculation. While your island is unpublished, your payouts from in-island transactions will be paused. If an Island is unpublished due to an issue introduced by Epic, you’ll have 14 days from the time Epic fixes the impacting issue to re-publish your island.
