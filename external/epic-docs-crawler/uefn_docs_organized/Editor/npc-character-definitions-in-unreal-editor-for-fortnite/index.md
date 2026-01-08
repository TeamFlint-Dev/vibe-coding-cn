# NPC Character Definitions

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/npc-character-definitions-in-unreal-editor-for-fortnite>
> **爬取时间**: 2025-12-27T02:14:15.050228

---

This feature is in Early Access. You can publish an island with this feature, but be aware that through the Early Access period, changes may break your island and may require your active intervention.

Create **NPC Character Definitions** to modify NPCs beyond the **[NPC Spawner](https://dev.epicgames.com/documentation/en-us/fortnite/using-npc-spawner-devices-in-unreal-editor-for-fortnite)** device's basic settings. With the NPC Spawner’s basic options, you can create instances of characters. Through Character Definitions, you can customize character type, behavior, and modifiers. You can even write [Verse scripts](https://dev.epicgames.com/documentation/en-us/fortnite/create-custom-npc-behavior-in-unreal-editor-for-fortnite) that further instruct character behaviors.

With Character Definitions, you can save the properties of custom characters as assets. Any NPC Spawner in your project can then reference and reuse these assets. After connecting the asset to an NPC Spawner device, you can use the device's settings to override specific Character Definition properties.

[![NPC Character Definition in UEFN](https://dev.epicgames.com/community/api/documentation/image/bb348f49-1ca5-47ec-b795-208d13ca2d6a?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/bb348f49-1ca5-47ec-b795-208d13ca2d6a?resizing_type=fit)

The NPC Spawner device's modifiers override any Character Definition modifiers to provide the means for slight variations in NPC instances.

## Creating Character Definitions

[![Character Defeinition Thumbnail](https://dev.epicgames.com/community/api/documentation/image/4b6b62f6-145f-4021-ae5f-d240586a7087?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/4b6b62f6-145f-4021-ae5f-d240586a7087?resizing_type=fit)

You can either create Character Definitions through the **Content Drawer** or directly through the NPC Spawner's settings.

Your modified Character Definitions can be seen once imported into the NPC Spawner device. If you create a Character Definition within the NPC Spawner, your modifications are immediately reflected in the NPC Spawner device.

To create a Character Definition through the Content Drawer, follow these steps:

1. Navigate to your project's content folder and left-click within the **Content Drawer**.
2. In the pop-up window, navigate to **Artificial Intelligence > NPC Character Definition**.
3. Name your Character Definition then double-click the thumbnail to edit your NPC's properties.

To create a Character Definition through the NPC Spawner device, follow these steps:

1. Place an NPC Spawner device and open its **Details** panel.
2. In the **User Options**, navigate to **NPC Character Definition** and left-click on its dropdown menu.
3. In its **Create New Asset** window, select **NPC Character Definition**.
4. Name your Character Definition then double-click its square thumbnail to open the Character Definition window.

## Character Definitions

[![Character Definitions](https://dev.epicgames.com/community/api/documentation/image/271480e9-921d-4086-9ddf-3a3aca5fe0d5?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/271480e9-921d-4086-9ddf-3a3aca5fe0d5?resizing_type=fit)

Through the Character Definition's settings, you can customize the following options.

- **NPC Character Type**
- **NPC Behavior**
- **NPC Character Modifiers**

### NPC Character Type

[![Character Type](https://dev.epicgames.com/community/api/documentation/image/9add81b4-1aa2-49f7-b9da-4803ae6271e6?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/9add81b4-1aa2-49f7-b9da-4803ae6271e6?resizing_type=fit)

Select from the **NPC Character Type** dropdown to set the base properties for how your character exists in the gameplay. You can choose a character modeled after Fortnite guards and wildlife, or create customized behaviors with Verse.

This setting has contextual filtering and will trigger different options once selected.

| Character Type | Description |
| --- | --- |
| **Custom** | Behaviors are defined in Verse. |
| **Guard** | NPCs have the same functionality as the **[Guard Spawner](https://dev.epicgames.com/documentation/en-us/fortnite/using-guard-spawner-devices-in-fortnite-creative)**, though you can have more control over properties like movement and behavior. |
| **Wildlife** | Creates the subtype options of **Boar**, **Chicken**, **Raptor**, and **Wolf**. Each subtype has its own default behavior. Wildlife NPCs have the same functionality as the **[Wildlife Spawner](https://dev.epicgames.com/documentation/en-us/fortnite/using-wildlife-spawner-devices-in-fortnite-creative)**, though you can  control over properties like movement and behavior. |

Additional character types are available when working on specific brand islands. To learn more, see the [Custom IP Character Definitions](https://dev.epicgames.com/documentation/en-us/fortnite/using-npc-character-definitions-in-unreal-editor-for-fortnite#custom-ip-character-definitions) section on this page.

### NPC Character Behavior

[![Character Behavior](https://dev.epicgames.com/community/api/documentation/image/3e2980bd-705c-4ae9-b2f8-fe08e43e795a?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/3e2980bd-705c-4ae9-b2f8-fe08e43e795a?resizing_type=fit)

After you select a character type, you can set the character's behavior. You can set behaviors as empty, default, or assigned through Verse.

| Character Behavior | Description |
| --- | --- |
| **Empty Behavior** | Available with Custom character types. Creates a blank behavior for NPCs to remain in their reference pose. This is useful to remove NPC behaviors so it will only be animated in Sequence cinematics. |
| **Default Behavior** | Available with the Guard and Wildlife character types. Allows you to alter the behavioral settings of characters intended to have the mannerisms of Battle Royale guards. |
| **Verse Behavior** | Available with all character types. Allows you to include any Verse scripts for your character. |

For more information on creating your own NPC Behaviors, check out the [Create Custom NPC Behavior page](https://dev.epicgames.com/documentation/en-us/fortnite/create-custom-npc-behavior-in-unreal-editor-for-fortnite).

### NPC Character Modifiers

[![Character Modifiers](https://dev.epicgames.com/community/api/documentation/image/34f4ee8c-fd31-46c3-b74e-71d0df7e8d24?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/34f4ee8c-fd31-46c3-b74e-71d0df7e8d24?resizing_type=fit)

Use **Character Modifiers** to customize the characteristics of your character. Each Character Type will have its own preset of starting modifiers automatically applied when you select it.

Click the plus arrow to add more Character Modifiers. You can only have one of each modifier active at a time.

[![](https://dev.epicgames.com/community/api/documentation/image/8205c303-759e-453a-8eda-195d705dac0f?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/8205c303-759e-453a-8eda-195d705dac0f?resizing_type=fit)

| Character Modifiers | Description |
| --- | --- |
| **Awareness Modifier** | Modifies alertness and awareness. |
| **Cosmetic Modifier** | Modifies looks and cosmetics. You can choose between Fortnite Character Item Definitions (CIDs), which will display as internal names. |
| **Effects Modifier** | Modifies the effects applied to an NPC. |
| **Guard Perception Modifier** | Modifies sight and hearing. |
| **Health Modifier** | Modifies health and shield. |
| **Inventory Modifier** | Modifies an NPC's inventory. |
| **Navigation Modifier** | Modifies the NPC's navigation parameters. |
| **Patrol Path Modifier** | Modifies the patrol path. |
| **Team Modifier** | Modifies the team. You can apply a team number or specify if the NPC is considered a wildlife, creature, or neutral. |
| **UI Modifier** | Modifies the display information for an NPC, such as name and health bar. |

### Custom IP Character Definitions

A few brand partners have their own NPCs available through a NPC Character Definition.

Depending on the IP, you can find the unique NPCs in one or both of the following:

- The **NPC Character Type** which can include unique modifiers.
- Through the **Cosmetic Modifier** when selecting a **Custom** or **Guard** character type.

IP assets have specific rules and guidelines for use. Check the brand rules for the IP assets you intend to use. To learn more about the various brand partners and content, see [Game Collections](https://dev.epicgames.com/documentation/en-us/fortnite/game-collections-in-unreal-editor-for-fortnite).

You can only use brand assets in a project specific to the relevant IP property.

## Importing Character Definitions

[![Importing Character Definitions](https://dev.epicgames.com/community/api/documentation/image/f8af2c03-34a4-4c7f-b340-63c3a79b6492?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/f8af2c03-34a4-4c7f-b340-63c3a79b6492?resizing_type=fit)

After your Character Definition is created and saved, import it into an NPC Spawner device's **NPC Character Definition** setting. Once imported, your NPC Spawner's character automatically updates to reflect your Character Definition.

You can use the same Character Definition for multiple devices and make slight variations to characters by overriding individual device settings. Any updates you make for the Character Definition will affect every device it's assigned to.

## Placing Character Definitions

You can place Character Definitions directly from the **Content Drawer** or through the NPC Spawner device.

To place multiple Character Definitions, you may need to save the level first.

Dragging a Character Definition from the Content Drawer is a shortcut with the same functionality as placing an NPC Spawner device with an assigned Character Definition.
