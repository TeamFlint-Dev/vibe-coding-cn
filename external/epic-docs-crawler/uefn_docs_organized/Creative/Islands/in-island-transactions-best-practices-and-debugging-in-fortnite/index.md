# Transaction Best Practices and Debugging

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/in-island-transactions-best-practices-and-debugging-in-fortnite
> **爬取时间**: 2025-12-26T23:59:58.538119

---

This feature is currently experimental. This means that you can use the feature for testing and feedback, but with the understanding that the feature may change before full release. You cannot publish an island that contains an experimental feature.

Learn best practices for various aspects of in-island transactions, along with tips for testing and debugging your storefront.

## Using the In-Island Transactions Verse Device

The In-Island Transactions Verse device contains a template for in-island transactions. It has all of the implementations for key aspects of the [Marketplace module](https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/fortnitedotcom/marketplace) in the Verse API. This includes items, offers, bundle offers, and the handling of purchases by leveraging the default store UI. Using this code as a guide can help you quickly set up your storefront.

To access the device:

- Navigate to **Verse Explorer**.
- Right-click your project name.
- Select **Add new Verse file to project**.
- Select **In-Island Transactions Device**.

[![Creating an In-Island Transactions device](https://dev.epicgames.com/community/api/documentation/image/c20d7ebf-bbf7-4de2-a7b4-b2bffda38801?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/c20d7ebf-bbf7-4de2-a7b4-b2bffda38801?resizing_type=fit)

To use the code straight out of the box, go into the Verse code and edit the file for:

- **Item names**
- **Descriptions**
- **Icons**

Replace the default names in the code with names that match your entitlements and offers.

## Coding Best Practices

You can refine your Verse code to improve the scalability of your code and the performance of your island.

### Organizing Your Workflow

A common best practice in programming is the separation of concerns. You want files and functions to be focused on performing a specific task so it becomes easier to maintain them in the future as the scope of the project grows.

This results in smaller, cleanly organized code files that are easier to read and understand, which will make debugging easier.

Possible ways you can apply this with transactions include:

- Putting item definitions in a separate file.
- Putting offers and bundle offers in a separate file.
- Creating a device that handles all static, predefined offers.
- Creating a device that only handles dynamic offers.
- Creating a device that only handles purchases.

### Organizing with Modules

[Modules](https://dev.epicgames.com/documentation/en-us/fortnite/modules-and-paths-in-verse) are atomic units of code that can be redistributed for use in multiple files. Modules can be changed over time without breaking dependencies in the files in which the module is already used. You can separate lengthy or repetitive units of code, like entitlement definitions, into a different file and then import them with the `using` statement.

A large benefit of using modules is that you only need to define a variable for a member of the module once in one location. This enables you to then share the same data across different Verse code files by importing the module and referencing the variables. If there are errors involving data from the module, it reduces the points of failure that you need to check to just the module, rather than everywhere you have used the contents of the module.

The snippet below demonstrates how you can define the entitlement info for `CornSeedPacket` in a module.

```verse
EntitlementInfo<public> := module:
       CornSeedPacket<public> := module:
        Name<public><localizes> : message = "Corn seed pack"
        Description<public><localizes> : message = "A pack of corn seeds. Opening a pack yields 10 corn seeds for planting."
        ShortDescription<public><localizes> : message = "Contains 10 corn seeds for planting."
```

Both`EntitlementInfo` and `CornSeedPacket` are defined as modules to allow you to import all of the entitlement information, and directly access the member variables of `CornSeedPacket`, such as its `Name` variable.

This snippet demonstrates how to import the `EntitlementInfo` module to help define the `corn_seed_pack` entitlement.

Note that retyping strings for variables such as `Name` is not required as you can reference the variable directly from the `CornSeedPacket` module. This reduces the risk of visual bugs such as typos.

```verse
Entitlements<public> := module:
    using { EntitlementInfo }

    # Using custom entitlement class to distinguish your entitlements.
    my_island_entitlement<public> := class<abstract><castable>(entitlement){}

    corn_seed_pack<public> := class<concrete>(my_island_entitlement):
        var Name<override> : message = CornSeedPacket.Name
        var Description<override> : message = CornSeedPacket.Description
        var ShortDescription<override> : message = CornSeedPacket.ShortDescription
        var Icon<override> : texture = # insert texture here
        # Maximum of 10 corn seed packets in the inventory
        MaxCount<override> : int = 10
        # Each corn seed packet is consumable - usage removes it from Player's inventory
        # To be implemented: consuming grants 10 corn seed entitlements
        Consumable<override> : logic = true
        PaidRandomItem<override> : logic = false
        PaidArea<override> : logic = false
```

The `using` statement requires a file path to the module you want to import. You do not require a file path in this instance as the module is assumed to be in the same folder.

### Improving Island Performance

You can improve the responsiveness of your experience by defining your item purchasing and granting methods with the `<suspends>` effect and calling them using [spawn](https://dev.epicgames.com/documentation/en-us/fortnite/spawn-in-verse).

This allows the `TryBuyOffer` to complete asynchronously while other aspects of your game logic continue to execute. This also prevents your game from pausing until a transaction completes.

```verse
TryBuyOffer(Player:player, Offer:offer)<suspends>:void=
    Result := BuyOffer(Player, Offer)

OnButtonInteraction(Agent:agent):void=
    if (Player := player[Agent]):
        spawn{TryBuyOffer(Player, OfferType)}
```

## Icon Best Practices

Game textures have specific requirements in order to render properly in-game. When creating textures in UEFN with imported images, make sure the source image file uses the power of two for height and width. This increases the compatibility and stability of your island across platforms.

[Power of two](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-glossary#power-of-two) is also used in texture streaming to lower texture resolution on platforms with less memory.

Texture streaming helps with:

- Changing a texture’s resolution
- Determining how quickly a game loads
- Increasing the visual quality of the game
- Saving GPU memory

For more information about the power of two rule and resizing textures see [Resizing Textures](https://dev.epicgames.com/documentation/en-us/fortnite/resizing-textures-in-unreal-editor-for-fortnite).

For information about importing custom assets into UEFN, see [Importing Assets](https://dev.epicgames.com/documentation/en-us/fortnite/importing-assets-in-unreal-editor-for-fortnite). 
For information on how to expose assets such as textures in Verse, see [Exposing Assets](https://dev.epicgames.com/documentation/en-us/fortnite/exposing-assets-with-asset-reflection-to-verse-in-unreal-editor-for-fortnite).

## Testing and Debugging Your Entitlements

Both Live Edit and Private Playtest sessions are debugging sessions. Debug sessions have the following effects on transactions, entitlements, and offers behavior:

- Transactions do not deduct V-Bucks from accounts.
- Granted and purchased entitlements are removed at the end of the debug session.
- Debug sessions have access to the **Debug Command** menu.

Your offers must be available on a private and playtest version of the island and accessible to all teammates to be used during the testing phase. The offered items are not considered live. Offers are live once the island is published and public.

### Accessing the Debug Command Menu

You can access the Debug Command menu by pressing the Esc key on a PC or the Start/Options button on the controller, then selecting the Debug Commands option from the menu.

[![](https://dev.epicgames.com/community/api/documentation/image/1fbb623e-729a-4009-ad66-942e40fb18db?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/1fbb623e-729a-4009-ad66-942e40fb18db?resizing_type=fit)

### Store Debug Commands

You can find the debug commands for your storefront under Store Debug Commands, where you have access to the following commands:

|  |  |
| --- | --- |
| Command Name | Description |
| **Open Storefront** | Shows a dynamic store UI with offers for all available entitlements, allowing players to purchase them individually. This allows you to choose the entitlement you want to test directly. |
| **Grant All Entitlements** | Fills this player's inventory so they own the maximum number of all entitlements available. You can also test in-game behavior to check if players have access to an item in an area where they shouldn't. |
| **Grant One Entitlement** | Grants one of every entitlement to a player.  This can grant a large number of entitlements while leaving room in a player’s inventory to still test purchases of non-durable entitlements without reaching the maximum quantity. If granting the entitlement will conflict with `Consumable=false` or `MaxCount`, then the entitlement isn’t granted.  You can also test in-game behavior if players have access to an item in an area they shouldn't. |
| **Force Remove Entitlements** | This removes all owned entitlements from the player’s inventory.  This allows you to reset a player’s inventory to continue testing purchasing offers. This command can be useful to test the `GetEntitlementsChangedEvent` cases for when entitlements are removed from the player inventory. For example, preventing the access to an area if the keycard for the door is removed from the inventory.  This command can also be useful for speeding up iteration in testing by quickly resetting the inventory. |
| **Print Owned Entitlements** | Prints all owned entitlements to the output log. |
| **Purchases Always Fail** | OFF by default. When set to OFF, purchases behave as intended. When set to ON, purchases will always fail regardless of the conditions indicating that they would succeed.  Purchases Always Fail is useful for testing `BuyOffer` cases returning false, indicating failure of a purchase attempt. |
