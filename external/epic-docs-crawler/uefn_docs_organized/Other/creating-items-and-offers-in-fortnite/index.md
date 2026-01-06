# Creating Items and Offers

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/creating-items-and-offers-in-fortnite
> **爬取时间**: 2025-12-26T23:59:12.989067

---

This feature is currently experimental. This means that you can use the feature for testing and feedback, but with the understanding that the feature may change before full release. You cannot publish an island that contains an experimental feature.

In-island transactions provide a way for you to market items, offers and bundle offers on your island using Verse.

In this guide, you’ll learn how to set up your own items, offers, and bundle offers. Using the [Marketplace module](https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/fortnitedotcom/marketplace) in the Verse API, you’ll then handle the sale of in-game items.

## Items

Items are defined in Verse as entitlements and fall into two categories: **consumable items**, which are removed from the player inventory on use, and **durable items**, which the player can keep using without the item being removed from inventory.

Every Verse entitlement has the following properties:

- **Name**: The entitlement name of up to 50 characters
- **Description**: The long description displayed with the entitlement of up to 500 characters.
- **ShortDescription**: A short description that summarizes the entitlement in a smaller dialog box of up to 100 characters.
- **Icon**: An image of the entitlement.

If your entitlement is a **paid random item**, you must include accurate numerical odds of what the player may receive in the description. For more information, see [Paid Random Items](https://dev.epicgames.com/documentation/en-us/fortnite/creating-items-and-offers-in-fortnite#paid-random-items-nbsp).

A Verse entitlement can also have the following optional properties:

- **MaxCount**: The maximum number of that entitlement that the player can own at any one time.
- **Consumable**: If set to **true**, the entitlement can be consumed which reduces the total number of uses. If **false**, the entitlement is a permanent item and will not be consumed on use
- **PaidArea**: If set to **true**, the entitlement provides access to an area behind a paywall.
- **PaidRandomItem**: If set to **true**, these entitlements are purchased or redeemed with content to obtain a random reward.
- **ConsequentialToGameplay**: If set to **true**, the item provides a meaningful advantage in your island. See [Consequential to Gameplay](https://dev.epicgames.com/documentation/en-us/fortnite/creating-items-and-offers-in-fortnite#consequential-to-gameplay) for more details.

### Creating a Consumable Entitlement in Verse

Entitlements are defined in Verse, derived from the entitlemen**t [base class](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-glossary#base-class)**. The following snippet demonstrates the creation of a consumable item. In this example, you will create corn seeds as your consumable item. An icon of the seeds is included below for you to use.

```verse
# The base entitlement you should define for ALL of your entitlements in your experience.
my_island_entitlement := class<abstract><castable>(entitlement){}

CornSeedPacket<public> := module:
    Name<public><localizes> : message = "Corn seed pack"
    Description<public><localizes> : message = "A pack of corn seeds. Opening a pack yields 10 corn seeds for planting."
    ShortDescription<public><localizes> : message = "Contains 10 corn seeds for planting."

cornseedpacket<public> := class<concrete>(my_island_entitlement):
    var Name<override>:message = CornSeedPacket.Name
    var Description<override>:message = CornSeedPacket.Description
    var ShortDescription<override>:message = CornSeedPacket.ShortDescription
    var Icon<override>:texture = # path to your texture here.
    MaxCount<override>:int= 10
    Consumable<override>:logic = true
    PaidRandomItem<override>:logic = false
    PaidArea<override>:logic = false
    ConsequentialToGameplay<override>:logic = true
```

[![A packet of corn seeds.](https://dev.epicgames.com/community/api/documentation/image/18041532-6cb5-4082-9d31-6722d1357d49?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/18041532-6cb5-4082-9d31-6722d1357d49?resizing_type=fit)

Corn Seed Packet

When you create an entitlement, you must include a path to a valid icon texture for your Verse code to successfully compile. Take the corn seed packet and other icons included in this guide as a freebie!

Make sure that your entitlement icons use a [square power-of-two texture](https://dev.epicgames.com/documentation/en-us/fortnite/resizing-textures-in-unreal-editor-for-fortnite) for the best quality images in your storefront. For information on how to import textures into UEFN to use as icons, see [Importing Assets](https://dev.epicgames.com/documentation/en-us/fortnite/importing-assets-in-unreal-editor-for-fortnite). For information on how to expose assets such as textures in Verse, see [Exposing Assets](https://dev.epicgames.com/documentation/en-us/fortnite/exposing-assets-with-asset-reflection-to-verse-in-unreal-editor-for-fortnite).

### Creating Durable Entitlements in Verse

Durable entitlements in Verse follow the same format as consumable entitlements, but with a key difference —`Consumable` is set to `false` instead of `true`. Durable entitlements can only be purchased once by players and players can only own one of a given durable entitlement.

For this example, you will create a shovel as a durable entitlement.  An icon for the shovel texture is included after the snippet below.

```verse
Shovel<public> := module:
    Name<public><localizes>: message = "Shovel"
    Description<public><localizes>: message = "An unbreakable shovel used to dig holes for planting."
    ShortDescription<public><localizes>: message = "Digs holes."

shovel<public> := class<concrete>(my_island_entitlement):
    var Name<override><final>             := Shovel.Name
    var Description<override><final>      := Shovel.Description
    var ShortDescription<override><final> := Shovel.ShortDescription
    var Icon<override><final>             := # path to your texture here
    MaxCount<override>:int= 1
    Consumable<override>:logic = false
    PaidRandomItem<override>:logic = false
    PaidArea<override>:logic = false
    ConsequentialToGameplay<override>:logic = true
```

[![Image of a basic shovel with a wooden handle.](https://dev.epicgames.com/community/api/documentation/image/277e0344-9676-480f-bd51-30ddf7fd6a35?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/277e0344-9676-480f-bd51-30ddf7fd6a35?resizing_type=fit)

Shovel

By default, items are not `Consumable` and have a `MaxCount` of `1`. If the item is a Paid Area, a Paid Random Item or provides a meaningful advantage that is consequential to gameplay, the relevant fields must be defined in your code.

### Entitlement Validation Rules

A valid entitlement in Verse must follow the guidelines below. Purchases of an entitlement that doesn’t meet them will fail.

The rules that define a valid entitlement are:

- **Name** has a character limit of **50**.
- **Description** has a character limit of **500**.
- **ShortDescription** has a character limit of **100**.
- **MaxCount** must be **1** when **Consumable=false**.
- **MaxCount** has a maximum value of **10,000,000**.

Setting  **MaxCount < 1** is not enforced but will fail as you cannot grant less than a single item to a player.

### The Entitlement Catalog

You can use the Entitlement Catalog to view all the entitlements you are offering to players.

You can view a report listing your entitlements in UEFN by clicking **Tools** > Entitlement**Catalog**, or directly from the catalog in the Creator Portal for your island.

[![](https://dev.epicgames.com/community/api/documentation/image/e0d9f06f-3ae8-47c8-a3b2-81fc517eccaf?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/e0d9f06f-3ae8-47c8-a3b2-81fc517eccaf?resizing_type=fit)

## Offers

An offer specifies a price in **V-Bucks** for an item or asset. Each offer has its own name, description, and icon, separate from the entitlement specifications. An offer is defined in Verse.

Every offer has the following properties:

- **Name**: The offer name.
- **Description**: The long description displayed alongside the offer.
- **ShortDescription**: A short description you can use to summarize the offer in smaller dialog boxes.
- **Icon**: An image of the offer
- **EntitlementType**: A declaration of the entitlement included in the offer.
- **Price**: A price in V-Bucks. It must be no less than 50 V-Bucks and no greater than 5000 V-Bucks. The price must be set in multiples of 50.

### Create a Simple Offer

This snippet defines a basic offer for a simple offer — the **corn seed pack**. You can reuse the corn seed icon from the entitlement example as the icon for this offer.

```verse
CornSeedPacket<public> := module:
    Name<public><localizes> : message = "Corn seed pack"
    Description<public><localizes> : message = "A pack of corn seeds. Opening a pack yields 10 corn seeds for planting."
    ShortDescription<public><localizes> : message = "Contains 10 corn seeds for planting."

corn_seed_pack<public> := class(entitlement_offer):
    var Name<override> : message                = CornSeedPacket.Name
    var Description<override> : message         = CornSeedPacket.Description
    var ShortDescription<override> : message    = CornSeedPacket.ShortDescription
    var Icon<override> : texture                = # Your texture here
    # Reference entitlement type defined in the Entitlements module
    EntitlementType<override> : concrete_subtype(entitlement) = cornseedpacket
    # Set entitlement offer price
    Price<override> : price_dimension = MakePriceVBucks(100.0)
```

The price in V-Bucks must be a multiple of 50, and between 50 and 5000 V-Bucks.

You must ensure players can see accurate numerical odds of obtaining each paid random item prior to purchase. Failure to do so will be considered a violation of the Fortnite Developer Rules, and subject you and your island to the appropriate sanctions.

For more information, see [In-Island Transactions Restrictions](https://dev.epicgames.com/documentation/en-us/fortnite/in-island-transactions-restrictions-in-fortnite).

### Create and Modify Fixed and Alternate Offers

You can make alternate offers for the same entitlement to offer special prices for holidays, introductory bonuses and to vary the price per area. You can also use it for entitlement testing by creating an identical offer but using a different icon to see which appeals to players more. Let’s use this icon as an example.

```verse
CornSeedPacketAlternate<public> := module:
    Name<public><localizes> : message = "Corn seed pack"
    Description<public><localizes> : message = "Special price! Only today!"
    ShortDescription<public><localizes> : message = "Special offer half price!"

corn_seed_pack_alternate<public> := class(entitlement_offer):
    var Name<override> : message                = CornSeedPacketAlternate.Name
    var Description<override> : message         = CornSeedPacketAlternate.Description
    var ShortDescription<override> : message    = CornSeedPacketAlternate.ShortDescription
    var Icon<override> : texture                = # Your texture here
    # Reference entitlement type defined in the Entitlements module
    EntitlementType<override> : concrete_subtype(entitlement) = cornseedpacket
    # Set entitlement offer price
    Price<override> : price_dimension = MakePriceVBucks(50.0)
```

[![An alternate to the previous corn seed packet. It is a hessian-style sack container instead.](https://dev.epicgames.com/community/api/documentation/image/c834ec50-7145-4e57-b133-215314e2fb59?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/c834ec50-7145-4e57-b133-215314e2fb59?resizing_type=fit)

Alternate Corn Packet

## Bundle Offers

Bundles are defined in Verse and can contain a combination of different offers, stacks of the same offer, or a mix of the two. Like simple offers, bundle offers specify their own price, name and description, and have an icon that is distinct from the entitlements and offers. You can also nest offers by including bundles within a bundle offer. An example would be a limited-time bundle that includes a shovel and a bundle of corn seed packets. This allows you to use smaller bundles as building blocks for larger, combined bundles.

The standard bundle types are:

- **Stacked bundle**: A bundle containing multiple offers of the same entitlement, usually for a discounted price.
- **Multi-offer bundle**: A bundle that combines offers for multiple entitlements, this can also include a mix of stacked offers and regular offers.

The depth of nested offers cannot exceed 5 or the attempted transaction will fail. Try to limit nesting offers where possible.

### Creating a Stacked Bundle

This snippet defines a stacked bundle of corn seeds. A bundle contains a [tuple](https://dev.epicgames.com/documentation/en-us/fortnite/tuple-in-verse) [array](https://dev.epicgames.com/documentation/en-us/fortnite/array-in-verse) of offers, which contains the defined offer and an `int` indicating the number of offers. In this case, there would be two `corn_seed_pack` offers in this bundle. An icon is provided for this example.

```verse
CornSeedPacketBundle<public> := module:
    Name<public><localizes> : message = "Corn seed pack bundle"
    Description<public><localizes> : message = "Two packs of corn seeds. Opening a pack yields 10 corn seeds for planting."
    ShortDescription<public><localizes> : message = "Two packs of corn seeds containing 10 corn seeds for planting."

corn_seed_pack_bundle<public> := class(bundle_offer):
    var Name<override> : message                = CornSeedPacketBundle.Name
    var Description<override> : message         = CornSeedPacketBundle.Description
    var ShortDescription<override> : message    = CornSeedPacketBundle.ShortDescription
    var Icon<override> : texture                = # your texture here
    # Set entitlements and its quantity in bundle
    # You can create bundle of different entitlements
    Offers<override> : []tuple(offer, int) = array{(corn_seed_pack{},2)}
    # Set bundle offer price
    Price<override> : price_dimension = MakePriceVBucks(150.0)
```

[![Two corn seed packets bundled together with rope.](https://dev.epicgames.com/community/api/documentation/image/23af3f24-9753-47cb-bf93-6bbd5b19b73b?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/23af3f24-9753-47cb-bf93-6bbd5b19b73b?resizing_type=fit)

Corn Seed Packet Bundle.

### Creating Multi-Offer Bundles

Players might want to avoid multiple transactions, so you can make a bundle that includes multiple offers that include different entitlements. This snippet creates a multi-offer bundle that provides the player with the maximum number of corn packs and a shovel.

```verse
StarterBundle<public> := module:
    Name<public><localizes> : message = "Starter bundle"
    Description<public><localizes> : message = "Everything a new player needs. Get fully stocked to start quickly! A shovel that digs holes, and ten packs of corn seeds each containing 10 corn seeds for planting."
    ShortDescription<public><localizes> : message = "A shovel that digs holes, and ten packs of corn seeds each containing 10 corn seeds for planting."

starter_bundle<public> := class(bundle_offer):
    var Name<override> : message                = StarterBundle.Name
    var Description<override> : message         = StarterBundle.Description
    var ShortDescription<override> : message    = StarterBundle.ShortDescription
    var Icon<override> : texture                = # your texture here
    # Set entitlements and its quantity in bundle
    # You can create bundle of different entitlements and add bundle within bundle
    Offers<override> : []tuple(offer, int) = array{
        (corn_seed_pack{}, 10),
        (shovel{}, 1)
    }
    # Set bundle offer price
    Price<override> : price_dimension = MakePriceVBucks(1350.0)
```

In Verse, bundles do not contain entitlements directly. Instead, they contain offers that themselves have entitlement definitions.

[![An icon for the multi-offer bundle that contains a shovel and 10 corn seed packets.](https://dev.epicgames.com/community/api/documentation/image/a379bfee-07f4-432a-a3cd-fbb3a843e219?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/a379bfee-07f4-432a-a3cd-fbb3a843e219?resizing_type=fit)

Multi-Offer Bundle

### Dynamically Created Offers

A dynamically created offer is an offer or bundle offer generated at runtime in Verse. Common use cases for dynamic offers could be:

- An offer for the maximum amount of wood a player can hold for a crafting game.
- A bundle to max out health and mana potions at the entrance of a dungeon for a dungeon crawler.

For simplicity, tie it to something simple like a button or a sign. In Verse code this would follow the flow: On Interaction > call BuyOffer.

This snippet showcases a way to sell a bundle of corn seed packs up to the maximum a player can have. An error message is printed if the purchase fails.

```verse
TryBuyOffer(Player : player)<suspends>:void =
    Purchases := GetPurchasedEntitlements(Player, Entitlements.corn_seed_pack)
    var NumPlayerCornSeedPacks : int = 0
    if (Purchase := Purchases[0]):
        set NumPlayerCornSeedPacks = Purchase(1)

    # Limit to at least 1 packet.
    # If the player has the maximum amount, the offer displays with a disabled purchase button.
    NumCornSeedPacks := Max(1, Entitlements.corn_seed_pack{}.MaxCount - NumPlayerCornSeedPacks)
	
    Offer := ExampleOffers.max_corn_seed_pack_bundle{
        Offers := array{(ExampleOffers.corn_seed_pack{}, NumCornSeedPacks)},
        Price := MakePriceVBucks(NumCornSeedPacks * OfferInfo.CornSeedPacket.Price)
    }
    Result := BuyOffer(Player, Offer)

    if (not Result?):
        Print("Failed to buy the {offer.name} offer.")
```

## Offer Validation Rules

A valid offer or bundle offer must follow the guidelines below. Purchases that do not meet them will fail moderation. The rules that define a valid offer are:

- The depth of nested offers cannot exceed **5**.
- The total number of entitlement identifiers cannot exceed **100 per offer**. This means the total amount of different entitlements sold at one time is **100** at maximum.
- The price of the offer must be between **50** and **5000** V-Bucks, and can only be in multiples of **50**.
- The default text for an offer `Name` cannot exceed **50** characters.
- The default text for an offer `Description` cannot exceed **500** characters.
- The default text for an offer `ShortDescription` cannot exceed **100** characters.
- An offer must contain at least 1 entitlement.
- An offer does not contain a quantity of an entitlement that is greater than the `MaxCount` of the entitlement.
- An offer does not contain a durable entitlement with a `MaxCount` > 1.

You may choose to place restrictions on where your offers are surfaced and who can view them. To learn more, see [In-Island Transactions Restrictions](https://dev.epicgames.com/documentation/en-us/fortnite/in-island-transactions-restrictions-in-fortnite).

## Create a Storefront

Now that you have your entitlements and their offers and bundles set up, you need a place to sell them!

### The Default UI

[![](https://dev.epicgames.com/community/api/documentation/image/a9bbec84-5272-4e64-89a0-bcedacd9af18?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/a9bbec84-5272-4e64-89a0-bcedacd9af18?resizing_type=fit)

The default storefront UI opens with a list of all entitlements and offers you have added. The first entitlement in the list is highlighted and features an overview of the entitlement in a window next to the list.

- Storefronts can have multiple pages.
- Lists longer than five items are scrollable.

A player triggers the purchase flow by calling the `BuyOffer` method or by using the default storefront with the `ShowOffersDialog` method. Below are examples of some devices you can use to tie your storefront purchase flow into your game design:

- Volumes device
- Scene Graph Timer device
- NPCs
- Conversation device

It is best practice when designing a storefront to require player choice to open a purchase flow. Bypassing this choice and forcing the purchase flow to open for players removes player agency and risks unhappy players.

[![](https://dev.epicgames.com/community/api/documentation/image/a842ef44-54be-4bde-8132-3938f96ee8b7?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/a842ef44-54be-4bde-8132-3938f96ee8b7?resizing_type=fit)

All offers have **Purchase** and **Inspect** buttons that open marketplace windows to either purchase an item or inspect what an offer includes. Only bundles have an **Inspect Bundle** button.

![Corn Seed Pack Bundle Offer Panel](https://dev.epicgames.com/community/api/documentation/image/58399320-79f1-4776-bdee-f297db5c6712?resizing_type=fit&width=1920&height=1080)

![Corn Seed Pack Bundle Offer Inspection Panel](https://dev.epicgames.com/community/api/documentation/image/74f90ba1-e3e2-4ca8-98b8-dd7134225485?resizing_type=fit&width=1920&height=1080)

Corn Seed Pack Bundle Offer Panel

Corn Seed Pack Bundle Offer Inspection Panel

Selecting the **Close** button closes the marketplace.

The shopfront experience is fully controlled by the developer:

- You decide which items or gameplay properties you want to offer to your players.
- You set the price for each offer or bundle offer.
- You can present your own storefront or use the premade Fortnite storefront UI.

### The Storefront UI

This snippet defines a generic event callback that opens the premade Fortnite storefront UI. The callback can be from a subscription, a button push, a conversation event, and so on.

```verse
OnEvent(Agent:agent):void=
    if(Player:= player[Agent]):
        spawn{ShowOffersDialog(Player, array{
                ExampleOffers.shovel{},
                ExampleOffers.cornseedpacket{}
            })}
```

### Handling Purchases

This snippet contains a generic offer purchase. An error message is printed if the purchase fails.

```verse
TryBuyOffer(Player:player, Offer : offer)<suspends>:void =
    Result := BuyOffer(Player, Offer)

    if (not Result?):
        Print("Failed to buy the {offer.name} offer.")
```

To aid in debugging failed purchases, include a way to identify which purchase failed in the error message, for example, by including the name of the offer in the error message above.

## Additional Functions

### Paid Random Items

There are two ways to offer paid random items in your island:

- You can offer them for purchase with V-Bucks
- You can allow players to redeem them with content that was purchased with V-bucks.

When creating an item that grants a random reward, you must set `PaidRandomItem` to `true`.

  If you offer content that can be used to redeem a random reward, you must use the `RestrictPaidRandomItems` function to prevent players without access from acquiring the random reward.

```verse
OnEvent(Agent:agent):void=
    if (Player := player[Agent]):
        if (RestrictPaidRandomItems[Player]):
            Print("Player is not allowed to purchase PaidRandomItems.")
        else:
            Print("Player is allowed to purchase PaidRandomItems.")
```

### Direct Prompts to Purchase

If your island has direct purchase prompts, you must use the `RestrictDirectPromptsToPurchase` function to determine if a player is eligible to receive the prompt.

```verse
OnEvent(Agent:agent):void=
    if (Player:= player[Agent]):        
        if (RestrictDirectPromptsToPurchase[Player]):
            Print("Player is not allowed to receive direct purchase prompts.")
        else:
            Print("Player is allowed to receive direct purchase prompts.")
```

### Consequential to Gameplay

If the item you are selling gives players a meaningful advantage in your island, you must set `ConsequentialToGameplay` to **true**.

Items that are consequential to gameplay include any time that, if purchased, would provide players a meaningful advantage in the game. The advantage or benefit a player gets from the purchased item could be direct (such as, an item that increases the player’s gameplay progress rate, power, or capabilities) or indirect (such as, an item that grants access to an item that meaningfully impacts how quickly the player can progress through the game, or their likelihood of winning).

If there is a freely available alternative of the item you are selling that would provide the same advantage you do not need to set `ConsequentialToGameplay` to **true**. If a gameplay item has an incidental but inconsequential impact on gameplay, as is the case with different outfit color schemes having slightly different visibilities in different environments, or different emotes making different body motions, it is not considered consequential.

```verse
# The base entitlement you should define for ALL of your entitlements in your experience.
my_island_entitlement := class<abstract><castable>(entitlement){}

CornSeedPacket<public> := module:
    Name<public><localizes> : message = "Corn seed pack"
    Description<public><localizes> : message = "A pack of corn seeds. Opening a pack yields 10 corn seeds for planting."
    ShortDescription<public><localizes> : message = "Contains 10 corn seeds for planting."

cornseedpacket<public> := class<concrete>(my_island_entitlement):
    var Name<override>:message = CornSeedPacket.Name
    var Description<override>:message = CornSeedPacket.Description
    var ShortDescription<override>:message = CornSeedPacket.ShortDescription
    var Icon<override>:texture = # path to your texture here.
    MaxCount<override>:int= 10
    Consumable<override>:logic = true
    PaidRandomItem<override>:logic = false
    PaidArea<override>:logic = false
    ConsequentialToGameplay<override>:logic = true
```
