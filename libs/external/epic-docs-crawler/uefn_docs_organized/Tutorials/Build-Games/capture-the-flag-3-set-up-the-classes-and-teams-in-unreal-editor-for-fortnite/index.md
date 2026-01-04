# 3. Set Up Classes and Teams

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/capture-the-flag-3-set-up-the-classes-and-teams-in-unreal-editor-for-fortnite
> **爬取时间**: 2025-12-27T00:16:28.603140

---

**Devices used:**

- 4 x [Class Designer](https://www.fortnite.com/en-US/creative/docs/using-class-designer-devices-in-fortnite-creative)
- 2 x [Team Settings & Inventory](https://www.fortnite.com/en-US/creative/docs/using-team-settings-and-inventory-devices-in-fortnite-creative)

## Classes

[![Class Designers](https://dev.epicgames.com/community/api/documentation/image/38348c0a-8ab0-4d07-9d73-b059a0375181?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/38348c0a-8ab0-4d07-9d73-b059a0375181?resizing_type=fit)

To make this game more interesting, there are different classes that the player can choose from whenever they visit the respawn rooms, and each has different stats and weapons.

The classes are described below, along with the purpose of each class.

| Class Name | Description | Weapons and Items | Stats |
| --- | --- | --- | --- |
| **Scout** | The Scout class is a dual-purpose class. Scouts can be used for capturing the enemy's flag because of their speed, but they can also be used as snipers that defend their own team's flag. | - **Cupid's Crossbow** - **Boogie Bomb** - **Smoke Grenades (2)** - **Shadow Bombs (2)** | - Starting Shields — 50 - Starting Health — 75 - Speed and Jump Height — Scouts have the fastest run speed and largest jump height of all the classes. |
| **Sapper** | The Sapper class is the best general-purpose class. They are average-to-good for any task. Sappers can be used to capture, or to defend. | - **Fiend Hunter Crossbow** - **Mechanical Explosive Bow** - **Shield Bubble** - **Slurp Juice (2)** | - Starting Shields — 100 - Starting Health — 100 - Speed and Jump Height — Sappers have average run speed, and a smaller jump height. |
| **Defender** | The Defender is designed as the ultimate class for protecting a flag from capture. This class features a deadly melee weapon, high health and shields, and a grappling hook to catch an enemy running away with a flag. | - **The Pickaxe** - **Harpoon Gun** - **Slurp Juice (2)** - **Stink Bomb (2)** - **Shield Bubble (2)** | - Starting Shields — 150 - Starting Health — 150 - Speed and Jump Height — The Defender has the slowest run speed and smallest jump height of all classes. |
| **Shaman** | The Shaman class is the healing class for this game. It features group healing items and some interesting weapons. | - **The Pickaxe** - **Primal Stink Bow** - **Slurp Juice (2)** - **Chug Splash (6)** - **Jellyfish (3)** | - Starting Shields — 75 - Starting Health — 100 - Speed and Jump Height — The Shaman has an above-average run speed, and a high jump height (but not as high as the Scout). |

### Configure the Class Designers

To create the four classes, place four **Class Designer** devices anywhere. They will be set to invisible. Configure the class for each device under the **User Options**:

**Sapper**

| Option | Value | Explanation |
| --- | --- | --- |
| **Class Name** | Sapper | Name of the class defined by this device. |
| **Class Identifier** | Class Slot: 1 | Class names are chosen by the creator, so for any device to act based on this class, it is assigned a number. |
| **Grant Items on Respawn** | True | When the player is eliminated and respawns, they are given the equipment and items defined for their class. |
| **Start with Pickaxe** | False | The Sapper will use a different weapon and will not need to gather resources, so this is set to No. |
| **Eliminated Player's Items** | Delete | When a Sapper is eliminated, they do not drop their equipment and items. Instead, those items are deleted. This means no other players can get additional items for eliminating someone with this class. |
| **Gravity** | Very High | Gravity affects how high a class can jump. Setting Gravity to Very High gives the Sapper a low jump height. |

**Scout**

| Option | Value | Explanation |
| --- | --- | --- |
| **Class Name** | Scout | Name of the class defined by this device. |
| **Class Identifier** | Class Slot: 2 | Class names are chosen by the creator, so for any device to act based on this class, it is assigned a number. |
| **Grant Items on Respawn** | True | When the player is eliminated and respawns, they are given the equipment and items defined for their class. |
| **Start with Pickaxe** | False | The Scout will use a different weapon and will not need to gather resources, so this is set to No. |
| **Max Health** | 75 | This sets the maximum health a Scout can have. |
| **Max Shields** | 50 | This sets the maximum amount of shields a Scout can have. |
| **Movement Multiplier** | 1.2 | The Scout is faster than the other classes, so there is a multiplier applied to the Scout’s base movement speed. |
| **Eliminated Player’s Items** | Delete | When a Scout is eliminated, they do not drop their equipment and items. Instead, those items are deleted. This means no other players can get additional items for eliminating someone with this class. |
| **Gravity** | Normal | Gravity affects how high a class can jump. Since some classes have Gravity set to a value higher than Normal, the Scout will be able to jump higher than those classes. |

**Defender**

| Option | Value | Explanation |
| --- | --- | --- |
| **Class Name** | Defender | Name of the class defined by this device. |
| **Class Identifier** | Class Slot: 3 | Class names are chosen by the creator, so for any device to act based on this class, it is assigned a number. |
| **Grant Items on Respawn** | True | When the player is eliminated and respawns, they are given the equipment and items defined for their class. |
| **Start with Pickaxe** | True | The Defender needs a melee weapon, since they are most likely to be guarding the flag and will be in close combat. The Defender starts with a pickaxe equipped. |
| **Max Health** | 150 Health | This sets the maximum health a Defender can have. |
| **Max Shields** | 150 Shields | This sets the maximum amount of shields a Defender can have. |
| **Movement Multiplier** | 0.8 | The Defender is slower than other classes, so a multiplier is added that will make the Defender’s movement speed less than the default. |
| **Eliminated Player’s Items** | Delete | When a Defender is eliminated, they do not drop their equipment and items. Instead, those items are deleted. This means no other players can get additional items for eliminating someone with this class. |
| **Gravity** | Very High | Gravity affects how high a class can jump. Setting Gravity to Very High gives the Defender a low jump height. |

**Shaman**

| Option | Value | Explanation |
| --- | --- | --- |
| **Class Name** | Shaman | Name of the class defined by this device. |
| **Class Identifier** | Class Slot: 4 | Class names are chosen by the creator, so for any device to act based on this class, it is assigned a number. |
| **Grant Items on Respawn** | True | When the player is eliminated and respawns, they are given the equipment and items defined for their class. |
| **Start with Pickaxe** | True | The Shaman is a support class, and will likely be close to their team members to heal them. Having a melee weapon is important to defend themselves and their injured team members. The Shaman starts with the pickaxe equipped. |
| **Max Shields** | 75 Shields | This sets the maximum amount of shields a Shaman can have. |
| **Movement Multiplier** | 1.1 | The Shaman isn’t as fast as the Scout, but is faster than the Sapper and Defender. A multiplier is applied to the Shaman’s base movement speed, but the multiplier is not as high as the one for the Scout. |
| **Eliminated Player’s Items** | Delete | When a Shaman is eliminated, they do not drop their equipment and items. Instead, those items are deleted. This means no other players can get additional items for eliminating someone with this class. |
| **Gravity** | High | Gravity affects how high a class can jump. Setting Gravity to High gives the Shaman a lower jump height than the Scout, but higher than the Sapper or Defender. |

In addition to customizing the options for each Class Designer, you need to register the equipment and items for each class. Below is a table listing the equipment for each class. Follow these steps to register the equipment and items for each Class Designer device.

1. Under **User Options**, locate **Item List**.
2. Press **+**, then expand **Index**.
3. Search for the desired weapon or item, then select it.
4. Press **+** to add the next item.

| Class | Equipment and Items |
| --- | --- |
| **Sapper** | Fiend Hunter Crossbow, Mechanical Explosive Bow, Slurp Juice (2), Shield Bubble |
| **Scout** | Cupid’s Crossbow, Boogie Bomb, Smoke Grenades (2), Shadow Bombs (2) |
| **Defender** | Harpoon Gun, Slurp Juice (2), Stink Bombs (2), Shield Bubble (2) |
| **Shaman** | Primal Stink Bow, Slurp Juice (2), Chug Splash (6), Jellyfish (3) |

## Configure Team Settings

To finish setting up the classes, you need to place and customize a **Team Settings & Inventory** device. With this, you can set up the initial conditions for players when they first spawn. Customize the options for the Team Settings & Inventory device as shown below.

| Option | Value | Explanation |
| --- | --- | --- |
| **Default Class Identifier** | Pick a class identifier | You can pick the class you want to set as the class a player is assigned when they first spawn into the game, before they choose a class. |
| **Grant Items on Respawn** | True | When the player is eliminated and respawns, they are given the equipment and items defined for their class. |
| **Equip Granted Item** | First Item | When a player spawns, they are automatically equipped with the first item registered with the Class Designer device for their class. **Make sure the first item you register with each Class Designer is a weapon** so players can start the game armed. |

[Playtest your island](playtesting-your-island-unreal-editor-for-fortnite) at any time by clicking the "Launch Session" button.

[![Launch Session](https://dev.epicgames.com/community/api/documentation/image/da74564c-b7bb-4994-8ae9-3323881fbf38?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/da74564c-b7bb-4994-8ae9-3323881fbf38?resizing_type=fit)

## Next Section

[![4. Set Up Spawn Rooms](https://dev.epicgames.com/community/api/documentation/image/6a51095a-aab5-4bb4-ac97-18e7e23790f8?resizing_type=fit&width=640&height=640)

4. Set Up Spawn Rooms

Make spawn rooms with locking doors where players can safely choose a class.](https://dev.epicgames.com/documentation/en-us/fortnite/capture-the-flag-4-set-up-spawn-rooms-in-unreal-editor-for-fortnite)
