# Melee Designer Devices

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/using-melee-designer-devices-in-fortnite-creative
> **爬取时间**: 2025-12-26T23:38:26.652009

---

The **Melee Designer** creates customized weapons that you can use as loot that drops from enemies, or grant them to players directly using [Item Spawner](https://dev.epicgames.com/documentation/en-us/fortnite/item-spawner) or [Item Granter](https://dev.epicgames.com/documentation/en-us/fortnite/item-granter) devices. The Customize panel for the Melee Designer is somewhat different from most other devices; refer to **How to Use the Melee Designer** below for more information.

Some ways you can customize a weapon are:

- Change the rarity for the weapon.
- Give the weapon a cool unique name.
- Choose special charge attacks for the weapon, such as Ground Pound, Drill, or Whirlwind.
- Adjust how much damage the customized weapon does to enemies or the environment with basic attacks, basic attack combos, jump attacks, or charge attacks.
- Adjust how much knockback a basic attack, jump attack, or charge attack inflicts on an opponent.

Set up your weapon the way you want it, then use the Melee Designer to spawn as many copies as you need. Because changes made to the options in the Melee Designer affect every weapon it spawns, you can rebalance your game at any time.

For help finding the **Melee Designer** device, see [Using Devices](https://dev.epicgames.com/documentation/en-us/fortnite/using-devices-in-fortnite).

If you're using multiple copies of a device on an island, it can be helpful to [rename](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#rename-a-device) them. You can choose names that relate to each device’s purpose, so it's easier to remember what each one does.

## How to Use the Melee Designer

The Customize panel for the Melee Designer device works a little bit differently from other devices in Creative. When you place a Melee Designer and open the Customize panel, you are prompted to choose a weapon type (sword or hammer).

Deleting a Melee Designer device will cause all weapons spawned from it to permanently revert to default settings.

[![Choose a Weapon](https://dev.epicgames.com/community/api/documentation/image/8f30d0e8-f78f-4b7a-abd6-afd21e1bd193?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/8f30d0e8-f78f-4b7a-abd6-afd21e1bd193?resizing_type=fit)

Once you choose the weapon type, you cannot change the weapon for that device. If you change your mind about the weapon type, you have to place another Melee Designer device and choose the other weapon.

[![Spawn the Customized Weapon](https://dev.epicgames.com/community/api/documentation/image/14deeabe-2e70-4c9b-9c50-c00483564979?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/14deeabe-2e70-4c9b-9c50-c00483564979?resizing_type=fit)

When you begin to customize your sword or hammer, you can give the weapon a special name. For example, if you want it to be a powerful unique weapon, give it a special name that connects to the narrative, or theme, or characters of your island.

[![Create a Named Weapon](https://dev.epicgames.com/community/api/documentation/image/462492a9-20b5-4949-9b19-d3d171cd5205?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/462492a9-20b5-4949-9b19-d3d171cd5205?resizing_type=fit)

If you want to create a category of weapons spawned from the current Melee Designer, which all have the same stats and abilities, you can use a more general name such as "Cavalry Sword" or "Knight's Hammer".

[![Create a Special Weapon Type](https://dev.epicgames.com/community/api/documentation/image/2a71db55-7e6a-4c23-9be4-7eb4a859a998?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/2a71db55-7e6a-4c23-9be4-7eb4a859a998?resizing_type=fit)

If you have many Melee Designer devices, it might be helpful to rename the device with the name you choose for the weapon – that way you can easily see which device spawns each weapon type.

Each Melee Designer device can spawn multiple weapons, and each spawned weapon will have the statistics and abilities you choose in the Customize panel. If you change the customizations in that device, all weapons spawned from that device will have the new customizations. If you delete a Melee Designer device, any weapons spawned from that device will lose all customizations and return to the base weapon defaults.

## Normal Weapon Attacks

The sword and hammer weapons have several attacks available, even if you don't choose special actions or charge attacks. This section describes these normal attacks and how you can modify them in the Melee Designer.

### Basic Attack

For mouse and keyboard, press the left mouse button to perform a basic attack. For consoles, press the normal attack button or trigger to perform a basic attack.

| Sword Basic Attack | Hammer Basic Attack |
| --- | --- |
|  |  |

### Basic Attack Combo

To perform a basic attack combo, press the attack control repeatedly. When using the sword, the player can perform a three-stroke combo, a four-stroke combo, or a five-stroke combo. When using the hammer, the player can perform a three-stroke combo with the final stroke hitting twice.

| Sword Combos |  |
| --- | --- |
| Two-stroke combo | Three-stroke combo |
| Four-stroke combo | Five-stroke combo |

| Hammer combos |  |
| --- | --- |
| Two-stroke combo | Three-stroke combo |

### Jump Attack

Press the jump button or key, then the attack control, to perform a jump attack. The player will jump into the air and then bring the weapon slamming downward.

| Sword Jump Attack | Hammer Jump Attack |
| --- | --- |
| Sword Jump Attack | Hammer Jump Attack |

### Sprint Attack

Press the attack control while [sprinting](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#sprint) to perform a sprint attack. The player sprints forward and then performs a powerful backhand slash (for the sword), or a backhand slam (for the hammer).

|  |  |
| --- | --- |
| Sword Sprint Attack | Hammer Sprint Attack |

## Special Actions and Attacks

The Melee Designer provides a large number of options for customizing a sword or hammer. Some of these options grant the player special actions or attacks. This section will describe the special actions and attacks that are available, and how they affect a player.

### Secondary Action - Dodge

If you customize a weapon with the **Secondary Action** option and select **Dodge Only**, a player who uses this customized weapon will be granted a special type of movement while they are using the weapon. By using a movement control (such as the WASD keys on a keyboard, or the left stick of a controller) and pressing the special action button or key (such as the right mouse button), the player will perform a dodge in the following ways:

- **Forward**: the player will roll forward in a somersault.

  If you set the Secondary Action option to **Dodge and Block**, players will not be able to do the forward roll. Instead, if the forward movement control is pressed, the player will jump forward while blocking.
- **Left**: the player will make a short jump to the left.
- **Right**: the player will make a short jump to the right.
- **Backward**: the player leaps backward from their original position (potentially disengaging from an opponent or trap).

### Secondary Action - Block

If you customize a weapon with the **Secondary Action** option and select **Block Only** or **Dodge and Block**, pressing the secondary action key will move the melee weapon into a blocking position.

If you choose **Dodge and Block**, the player can block and also use Dodge by following these steps:

1. Press and hold the key or button for **Block**.
2. Press the movement control (left, right, or backward) and then immediately press the **Jump** key or button. This should initiate the left, right, or backward dodge. While blocking, the player cannot perform the forward roll dodge; instead they just jump up and forward. This is designed so that the player can perform a Jump Attack while blocking.

### Charge Attacks

You can customize a sword or hammer with one of three charge attacks: **Ground Pound**, **Drill**, or **Whirlwind**.

- **Ground Pound**: the player jumps into the air, performs an aerial flip, and slams the weapon downward with increased force.
- **Whirlwind**: the player holds the weapon out and spins rapidly in a circle, damaging everyone and everything in its radius.
- **Drill**: the player dives forward with the weapon held out in front, and spins like a drill.

To perform a charge attack, press and hold the attack control. The weapon begins to glow, and when it is ready to activate there is a visual effect cue. If you customize a melee weapon with the Charge Attack option, you can determine how long the weapon must charge to activate the special attack. The player will be vulnerable while the weapon is charging up, and if they try to attack the charge depletes and they have to start over.

## Contextual Filtering

Some devices are affected by a feature called **contextual filtering**. This feature hides or displays options depending on the values selected for certain related options. This feature will reduce clutter in the Customize panel and make options easier to manage and navigate. However, it may not be easy to recognize which options or values trigger contextual filtering. To help you identify them, in our device docs we use *italic* for any values that trigger contextual filtering. All options will be listed, including those affected by contextual filtering; if they are hidden or displayed based on a specific option’s value, there will be a note about that in the Description field for that option.

## Device Options

This device has some basic functionality, like changing the rarity, and setting how much damage the weapon does. There are also some advanced options, like changing the player's speed when wielding the weapon, and setting the percentage chance of a critical hit.

You can configure this device with the following options.

Default values are **bold**. Values that trigger contextual filtering are *italic*.

### Basic Options

| Option | Value | Description |
| --- | --- | --- |
| **Spawn Weapon Button** | Click button | This spawns a melee weapon that has the properties you set. When it spawns it drops to the ground. You can spawn as many of these weapons as you need. |
| **Display Name** | Enter a name | You can enter a name for your customized weapon. The text field has a limit of 32 characters. |
| **Rarity** | **Don't Override**, Common, Uncommon, Rare, Epic, Legendary | The base melee weapons have a rarity of **Common**. You can choose to change the weapon's rarity with this option. |
| **Base Attack: Damage - Players** | **Sword: 20**, Pick an amount **Hammer:** **25**, Pick an amount | Determines the base damage of the customized weapon when used in combat against other players. If the **Basic Attack: Show Options** option is set to **Hide**, this option will not display in either the **Basic Options** or **All Options** lists. |
| **Secondary Action** | No Action, **Dodge and Block**, Dodge Only, Block Only | This determines whether the player has a special action when wielding the melee weapon. See **Special Actions and Attacks**, above. |
| **Charge Attack** | *None*, **Ground Pound**, Drill, Whirlwind | This determines which ability will be used when the player holds down the attack button.   - **Ground Pound**: the player jumps into the air, performs an aerial flip, and slams the weapon downward with increased force. - **Drill**: the player dives forward with the weapon held out in front, and spins like a drill. - **Whirlwind**: the player holds the weapon out and spins rapidly in a circle, damaging everyone and everything in its radius.   If you choose **Ground Pound**, and you have the **Charge Attack: Show Options** option set to **Show**, the **Ground Pound: Impact Radius** option is displayed in the All Options list. |
| **Charge Attack: Damage** | **Sword: 60**, Pick an amount **Hammer: 75**, Pick an amount | Determines the amount of damage a Charge Attack does. |

### All Options (Additional)

| Option | Value | Description |
| --- | --- | --- |
| **Basic Attack: Show Options** | ***Show***, Hide | If you choose **Show**, several additional options for the basic attack are displayed. If you choose **Hide**, those options are not displayed. |
| **Basic Attack: Damage - AI** | **Sword: 20**, Pick an amount **Hammer:** **25**, Pick an amount | Determines the base damage of the customized weapon when used in combat against AI enemies (such as creatures, guards, or wildlife). If the **Basic Attack: Show Options** option is set to **Hide**, this option will not display. |
| **Basic Attack: Damage - Environmental** | **Sword: 10**, Pick an amount **Hammer: 40**, Pick an amount | Determines the base damage of the customized weapon when used on the environment (such as structures or terrain elements). If the **Basic Attack: Show Options** option is set to **Hide**, this option will not display. |
| **Basic Attack: Knockback - Players** | **Sword: 400**, Pick an amount **Hammer: 600**, Pick an amount | Determines how hard the weapon knocks away enemy players when it hits. If the **Basic Attack: Show Options** option is set to **Hide**, this option will not display. |
| **Basic Attack: Knockback - AI** | **Sword: 400**, Pick an amount **Hammer: 600**, Pick an amount | Determines how hard the weapon knocks away AI enemies when it hits. If the **Basic Attack: Show Options** option is set to **Hide**, this option will not display. |
| **Basic Attack: Energy Cost** | **0**, Pick an amount | Determines the amount of Energy needed to perform a basic attack. **Energy** is the same resource used for sprinting. If the **Basic Attack: Show Options** option is set to **Hide**, this option will not display. |
| **Basic Attack: Low Energy Multiplier** | **0.0**, Pick an amount | If the **Basic Attack: Energy Cost** option is set to an amount above zero, this determines the damage multiplier applied when the player doesn't have enough Energy to perform a basic attack. When this option's value is at the default value of **0.0**, the player cannot perform a Basic Attack until they have enough Energy. If the **Basic Attack: Show Options** option is set to **Hide**, this option will not display. |
| **Lock On Targeting** | **Lock On**, No Lock On | Determines whether players lock onto the nearest opponent while they are charging up their charge attack. |
| **Block Resistance** | **100%**, Pick a percentage | The percentage of damage negated while a player successfully blocks an attack. |
| **Block Impact: Energy Cost** | **5**, Pick a number | Determines the amount of Energy needed to successfully Block. If the player doesn't have enough Energy when hit, their Block is broken. |
| **Dodge: Energy Cost** | **0**, Pick an amount | Determines the amount of Energy needed to perform a Dodge. |
| **Speed Adjustment** | **0**, Pick a positive or negative amount | This determines how much the player's speed is altered when they are wielding this melee weapon. If you select a negative value, they are slowed down. If you select a positive value, they speed up. |
| **Charge Attack: Show Options** | ***Show***, Hide | If you choose **Show**, several additional options for the charge attack are displayed. Additional options change based on which charge attack you select. If you choose **Hide**, those options are not displayed. |
| **Ground Pound: Impact Radius** | **256**, Pick an amount | Determines the impact radius of the Ground Pound charge attack. If the **Charge Attack: Show Options** option is set to **Hide**, this option will not display. |
| **Charge Attack: Charge Time** | **Sword: 1.1S**, Pick an amount **Hammer: 1.5S**, Pick an amount | Determines the amount of time the weapon must charge before the player can activate the charge attack. If the **Charge Attack: Show Options** option is set to **Hide**, this option will not display. |
| **Charge Attack: Knockback** | **Sword: 400**, Pick an amount **Hammer: 600**, Pick an amount | Determines how hard the weapon knocks away opponents that are hit with a charge attack. If the **Charge Attack: Show Options** option is set to **Hide**, this option will not display. |
| **Charge Attack: Energy Cost** | **0**, Pick an amount | Determines the amount of Energy needed to perform a charge attack. **Energy** is the same resource used for sprinting. If the **Charge Attack: Show Options** option is set to **Hide**, this option will not display. |
| **Charge Attack: Break Block** | **Yes**, No | Determines whether using a charge attack will break another player's block. |
| **Charge Attack: Feedback** | None, Light, **Medium**, Heavy | Determines the amount of camera shake and controller feedback that occurs when using a charge attack. If the **Charge Attack: Show Options** option is set to **Hide**, this option will not display. |
| **Critical Hit: Chance %** | **5%**, Pick a percentage | Determines the chance that a successful charge attack will be a critical hit. A critical hit applies the value in the **Critical Hit: Damage Multiplier** option to the charge attack's base damage value. |
| **Critical Hit: Damage Multiplier** | **2.0X**, Pick a multiplier | When the weapon gets a critical hit, this multiplier is applied to the charge attack's base damage value. |
| **Jump Attack** | **Enabled**, *Disabled* | Determines whether jump attacks are available to players. If you select **Disabled**, additional options for jump attack do not display. |
| **Jump Attack: Damage** | **Sword**: **20**, Pick an amount **Hammer**: **25**, Pick an amount | Determines the base amount of damage the weapon inflicts for a successful jump attack. This option only displays if the jump attack is enabled. |
| **Jump Attack: Knockback** | **Sword**: **400**, Pick an amount **Hammer**: **600**, Pick an amount | Determines how hard the weapon knocks away enemies that are hit with a jump attack. This option only displays if the jump attack is enabled. |
| **Jump Attack: Energy Cost** | **0**, Pick an amount | Determines the amount of Energy needed to perform a jump attack. **Energy** is the same resource used for sprinting. This option only displays if the jump attack is enabled. |
| **Sprint Attack** | **Enabled**, *Disabled* | Determines whether sprint attacks are available to players. If you select **Disabled**, additional options for sprint attack do not display. |
| **Sprint Attack: Damage** | **Sword**: **40**, Pick an amount **Hammer**: **50**, Pick an amount | Determines the base amount of damage the weapon inflicts for a successful sprint attack. This option only displays if the sprint attack is enabled. |
| **Sprint Attack: Knockback** | **Sword**: **400**, Pick an amount **Hammer**: **400**, Pick an amount | Determines how hard the weapon knocks away enemies that are hit with a sprint attack. This option only displays if the sprint attack is enabled. |
| **Sprint Attack: Energy Cost** | **10**, Pick an amount | Determines the amount of Energy needed to perform a Sprint Attack. **Energy** is the same resource used for sprinting. This option only displays if the sprint attack is enabled. |
| **Attack Combo: Show Options** | ***Show***, Hide | If you choose **Show**, several additional options for attack combos are displayed. If you choose **Hide**, those options are not displayed. |
| **Attack 1: Damage Multiplier** | **1.0X**, Pick a multiplier | Determines the damage multiplier for the first weapon swing in a basic attack combo. If the **Attack Combo: Show Options** option is set to **Hide**, this option will not display. |
| **Attack 1: Knockback Multiplier** | **1.5X**, Pick a multiplier | Determines the knockback multiplier for the first weapon swing in a basic attack combo. If the **Attack Combo: Show Options** option is set to **Hide**, this option will not display. |
| **Attack 1: Energy Cost Multiplier** | **1.0X**, Pick a multiplier | Determines the energy cost multiplier for the first weapon swing in a basic attack combo. If the **Attack Combo: Show Options** option is set to **Hide**, this option will not display. |
| **Attack 2: Damage Multiplier** | **1.1X**, Pick a multiplier | Determines the damage multiplier for the second weapon swing in a basic attack combo. If the **Attack Combo: Show Options** option is set to **Hide**, this option will not display. |
| **Attack 2: Knockback Multiplier** | **1.0X**, Pick a multiplier | Determines the knockback multiplier for the second weapon swing in a basic attack combo. If the **Attack Combo: Show Options** option is set to **Hide**, this option will not display. |
| **Attack 2: Energy Cost Multiplier** | **1.0X**, Pick a multiplier | Determines the energy cost multiplier for the second weapon swing in a basic attack combo. If the **Attack Combo: Show Options** option is set to **Hide**, this option will not display. |
| **Attack 3: Damage Multiplier** | **1.2X**, Pick a multiplier | Determines the damage multiplier for the third weapon swing in a basic attack combo. If the **Attack Combo: Show Options** option is set to **Hide**, this option will not display. |
| **Attack 3: Knockback Multiplier** | **1.0X**, Pick a multiplier | Determines the knockback multiplier for the third weapon swing in a basic attack combo. If the **Attack Combo: Show Options** option is set to **Hide**, this option will not display. |
| **Attack 3: Energy Cost Multiplier** | **1.0X**, Pick a multiplier | Determines the energy cost multiplier for the third weapon swing in a basic attack combo. If the **Attack Combo: Show Options** option is set to **Hide**, this option will not display. |
| **Attack 4: Damage Multiplier** | **1.3X**, Pick a multiplier | Determines the damage multiplier for the fourth weapon swing in a basic attack combo. If the **Attack Combo: Show Options** option is set to **Hide**, this option will not display. |
| **Attack 4: Knockback Multiplier** | **1.0X**, Pick a multiplier | Determines the knockback multiplier for the fourth weapon swing in a basic attack combo. If the **Attack Combo: Show Options** option is set to **Hide**, this option will not display. |
| **Attack 4: Energy Cost Multiplier** | **1.0X**, Pick a multiplier | Determines the energy cost multiplier for the fourth weapon swing in a basic attack combo. If the **Attack Combo: Show Options** option is set to **Hide**, this option will not display. |
| **Attack 5: Damage Multiplier** | **1.4X**, Pick a multiplier | Determines the damage multiplier for the fifth weapon swing in a basic attack combo. If the **Attack Combo: Show Options** option is set to **Hide**, this option will not display. |
| **Attack 5: Knockback Multiplier** | **1.0X**, Pick a multiplier | Determines the knockback multiplier for the fifth weapon swing in a basic attack combo. If the **Attack Combo: Show Options** option is set to **Hide**, this option will not display. |
| **Attack 5: Energy Cost Multiplier** | **1.0X**, Pick a multiplier | Determines the energy cost multiplier for the fifth weapon swing in a basic attack combo. If the **Attack Combo: Show Options** option is set to **Hide**, this option will not display. |
| **Use Custom Color** | **No**, Yes | Determines whether or not to use a custom color for the weapon's visual effects. |
| **Custom Color** | **#FFFFFF**, Pick a color | If the Use Custom Color option is set to Yes, use this to select the new color. Click the swatch to open the Color Picker. Select a color swatch or type a Hex Code to search for a color. Then, click the arrow to close the Color Picker. |
| **Custom Color Intensity** | **50**, Pick a number | Determines the brightness of the custom color. |
| **Weapon Glow Intensity** | **50**, Pick a number | Determines the brightness of the visual effects that appear on the weapon itself. |

## Design Examples

Here are some examples of how you can use the Melee Designer device.

- [Knockback Weapon](https://dev.epicgames.com/documentation/en-us/fortnite/using-melee-designer-devices-in-fortnite-creative)
- [Special Weapon](https://dev.epicgames.com/documentation/en-us/fortnite/using-melee-designer-devices-in-fortnite-creative)
- [Combo Weapon](https://dev.epicgames.com/documentation/en-us/fortnite/using-melee-designer-devices-in-fortnite-creative)

### Knockback Weapon

There are a few variables that you can change to create a unique melee experience. In this case, the weapon will do no damage but will have increased knockback to allow knocking people out of arenas or rings.

**Devices used**:

- 1 x **Melee Designer**
- 1 x [**Item Granter**](using-item-granter-devices-in-fortnite-creative)
- 4 x [**Damage Volume**](using-damage-volume-devices-in-fortnite-creative)
- 1 x [Player Spawner](https://dev.epicgames.com/documentation/en-us/fortnite/using-player-spawn-pad-devices-in-fortnite-creative)
- 1 x [**Creature Manager**](using-creature-manager-devices-in-fortnite-creative)
- 3 x [**Creature Placer**](using-creature-placer-devices-in-fortnite-creative)

1. Create a simple raised arena. 3x3 roof tiles is an effective area.
2. Place a **Melee Designer** anywhere on the island. Set the initial weapon to **Hammer** and customize it to the following settings:

   [![Knockback Melee Designer Settings](https://dev.epicgames.com/community/api/documentation/image/2ee06b53-45a6-432b-9bb5-65ed1fd33d06?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/2ee06b53-45a6-432b-9bb5-65ed1fd33d06?resizing_type=fit)

   | Option | Value | Description |
   | --- | --- | --- |
   | Rarity | Epic | The weapon will have a rarity of Epic. This has no in-game effect beyond the color within the inventory. |
   | Basic Attack: Knockback - Players | 1,500 | A player will be knocked back 1,500 units when hit with an M1 attack. |
   | Basic Attack: Knockback - AI | 1,500 | An AI will be knocked back 1,500 units when hit with an M1 attack. |
   | Charge Attack: Knockback | 1,500 | A player or an AI will be knocked back 1,500 units when hit with a charge attack. |
   | Jump Attack: Knockback | 1,500 | A player or an AI will be knocked back 1,500 units when hit with a jump attack. |
   | Sprint Attack: Knockback | 1,500 | A player or an AI will be knocked back 1,500 units when hit with a sprint attack. |
3. Place an **Item Granter** beside the Melee Designer. Interact with the Melee Designer, click **Spawn Weapon**, and pick up the hammer. Press **Tab** to open your inventory, then drag and drop the spawned hammer onto the Item Granter to register it. Customize the Item Granter to the following settings:

   [![Knockback Item Granter Settings](https://dev.epicgames.com/community/api/documentation/image/2d76f7fb-6528-4e57-aa0b-8afa11a83d63?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/2d76f7fb-6528-4e57-aa0b-8afa11a83d63?resizing_type=fit)

   | Option | Value | Description |
   | --- | --- | --- |
   | Equip Granted Item | First Item | The hammer will be automatically equipped when it is granted. |
4. Surround your arena with **Damage Volumes**. Use a length, height, and width that will create a cage around the arena, so being knocked out of it will cause contact with the volumes. Customize them to the following settings:

   [![Knockback Damage Volume Settings](https://dev.epicgames.com/community/api/documentation/image/d225b97c-355f-488f-9f09-c391488eb817?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/d225b97c-355f-488f-9f09-c391488eb817?resizing_type=fit)

   | Option | Value | Description |
   | --- | --- | --- |
   | Damage Type | Elimination | Touching the Damage Volume device will cause instant elimination of both players and AI characters. |
5. Place a **Player Spawner** on the raised arena. Keep the default settings and set its direct event bindings to the following:

   [![Knockback Player Spawner Events](https://dev.epicgames.com/community/api/documentation/image/d149a950-2177-4421-951b-94dad21f5f22?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/d149a950-2177-4421-951b-94dad21f5f22?resizing_type=fit)

   | Function | Device | Event | Description |
   | --- | --- | --- | --- |
   | On Player Spawned Send Event To | ItemGranter | Grant Item | When the player spawns, they will be granted the hammer. |
6. Beside the Melee Designer and Item Granter, place a **Creature Manager**. Customize it to the following settings:

   [![Knockback Creature Manager Settings](https://dev.epicgames.com/community/api/documentation/image/b29429f3-7da4-470c-925a-06cf477e3499?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/b29429f3-7da4-470c-925a-06cf477e3499?resizing_type=fit)

   | Option | Value | Description |
   | --- | --- | --- |
   | Health | 10,000 | Sets the creature health to 10,000 to make the creatures spawned functionally invincible unless knocked into the Damage Volume. |
   | Allow Weapon Knockback | Yes | Creatures are affected by the knockback of melee weapons. |
7. On the raised arena with the Player Spawner, place 3 **Creature Placers**. Keep the default settings.

Here’s an overview of how devices communicate in this Design Example:

| Device A | Function | Device B | Event | Explanation |
| --- | --- | --- | --- | --- |
| **ItemGranter** | Grant Item | **PlayerSpawner** | On Player Spawned Send Event To | When the player spawns, they will be granted the hammer. |

You now have the basic functionality for melee weapons that only inflict knockback.

You can vary the amount of knockback dealt by different attacks to incentivize different styles of gameplay. Varying weapons and special moves can allow people to choose one that fits their style. Creating a large arena with platforms and paths that players can knock each other off of can create an interesting new game mode for players.

### Special Weapon

Another method of mixing up the style of fighting is creating weapons that can only do damage with their special attacks and jump attacks.

**Devices used**:

- 1 x **Melee Designer**
- 1 x [**Item Granter**](using-item-granter-devices-in-fortnite-creative)
- 1 x [Player Spawner](https://dev.epicgames.com/documentation/en-us/fortnite/using-player-spawn-pad-devices-in-fortnite-creative)
- 3 x [**Creature Placer**](using-creature-placer-devices-in-fortnite-creative)

1. Create a simple raised arena. 3x3 roof tiles is an effective area.
2. Place a **Melee Designer** anywhere on the island. Set the initial weapon to **Hammer** and customize it to the following settings:

   [![Special Melee Designer Settings](https://dev.epicgames.com/community/api/documentation/image/acb08e92-1882-412d-9673-8258b2f65677?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/acb08e92-1882-412d-9673-8258b2f65677?resizing_type=fit)

   | Option | Value | Description |
   | --- | --- | --- |
   | Rarity | Epic | The weapon will have a rarity of Epic. This has no in-game effect beyond the color within the inventory. |
   | Basic Attack: Damage - Players | 0 | M1 attacks will not deal any damage to players. |
   | Basic Attack: Damage - AI | 0 | M1 attacks will not deal any damage to AI. |
   | Sprint Attack | Disabled | Disables the ability to use the sprint attack. |
3. Place an **Item Granter** beside the Melee Designer. Interact with the Melee Designer, click **Spawn Weapon**, and pick up the hammer. Press **Tab** to open your inventory, then drag and drop the spawned hammer on the Item Granter to register it. Customize the Item Granter to the following settings:

   [![Special Item Granter Settings](https://dev.epicgames.com/community/api/documentation/image/bbeb2e9a-6fa7-45a4-a479-1c10e4aaa6b2?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/bbeb2e9a-6fa7-45a4-a479-1c10e4aaa6b2?resizing_type=fit)

   | Option | Value | Description |
   | --- | --- | --- |
   | Equip Granted Item | First Item | The hammer will be automatically equipped when it is granted. |
4. Place a **Player Spawner** on the raised arena. Keep the default settings and set its direct event bindings to the following:

   [![Special Player Spawner Events](https://dev.epicgames.com/community/api/documentation/image/a73e885d-2069-471f-80b6-4b46229a012b?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/a73e885d-2069-471f-80b6-4b46229a012b?resizing_type=fit)

   | Function | Device | Event | Description |
   | --- | --- | --- | --- |
   | On Player Spawned Send Event To | ItemGranter | Grant Item | When the player spawns, they will be granted the hammer. |
5. On the raised arena with the Player Spawner, place 3 **Creature Placers**. Keep the default settings.

Here’s an overview of how devices communicate in this Design Example:

| Device A | Function | Device B | Event | Explanation |
| --- | --- | --- | --- | --- |
| **ItemGranter** | Grant Item | **PlayerSpawner** | On Player Spawned Send Event To | When the player spawns, they will be granted the hammer. |

You now have the basic functionality for melee weapons that only inflict damage from special attacks and jump attacks.

You can give different special attacks different damage values so the ones that are more difficult to use are more effective. You could also set air slams, dash attacks, and other non-M1 attacks to do small amounts of damage if you want to create more dynamic and varied gameplay.

### Combo Weapon

Another method of varying fighting involves chaining M1 attacks with escalating damage.

**Devices used**:

- 1 x **Melee Designer**
- 1 x [**Item Granter**](using-item-granter-devices-in-fortnite-creative)
- 1 x [Player Spawner](https://dev.epicgames.com/documentation/en-us/fortnite/using-player-spawn-pad-devices-in-fortnite-creative)
- 1 x [**Creature Manager**](using-creature-manager-devices-in-fortnite-creative)
- 3 x [**Creature Placer**](using-creature-placer-devices-in-fortnite-creative)

1. Create a simple raised arena. 3x3 roof tiles is an effective area.
2. Place a **Melee Designer** device anywhere on the island. Set the initial weapon to **Sword** and customize it to the following settings:

   | Option | Value | Description |
   | --- | --- | --- |
   | Rarity | Epic | The weapon will have a rarity of Epic. This has no in-game effect beyond the color within the inventory. |
   | Basic Attack: Damage - Players | 5 | M1 attacks will deal 5 damage to players. |
   | Basic Attack: Damage - AI | 5 | M1 attacks will deal 5 damage to AI. |
   | Jump Attack: Damage | 5 | Jump attacks will deal 5 damage. |
   | Sprint Attack: Damage | 5 | Sprint attacks will deal 5 damage. |
   | Attack 2: Damage Multiplier | 3x | The second attack in a combo will deal 3x damage. |
   | Attack 3: Damage Multiplier | 5x | The third attack in a combo will deal 5x damage. |
   | Attack 4: Damage Multiplier | 10x | The fourth attack in a combo will deal 10x damage. |
   | Attack 5: Damage Multiplier | 15x | The fifth attack in a combo will deal 15x damage. |
3. Place an **Item Granter** beside the Melee Designer. Interact with the Melee Designer, click **Spawn Weapon**, and pick up the sword. Press **Tab** to open your inventory, then drag and drop the spawned sword on the Item Granter to register it. Customize the Item Granter to the following settings:

   [![Combo Item Granter Settings](https://dev.epicgames.com/community/api/documentation/image/e6bb5beb-cbca-42ef-8612-34ae8e1d6121?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/e6bb5beb-cbca-42ef-8612-34ae8e1d6121?resizing_type=fit)

   | Option | Value | Description |
   | --- | --- | --- |
   | Equip Granted Item | First Item | The sword will be automatically equipped when it is granted. |
4. Place a **Player Spawner** on the raised arena. Keep the default settings and set its direct event bindings to the following:

   [![Combo Player Spawner Events](https://dev.epicgames.com/community/api/documentation/image/5a8d6408-dfdb-4a2a-816b-23a7fe2c7a28?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/5a8d6408-dfdb-4a2a-816b-23a7fe2c7a28?resizing_type=fit)

   | Function | Device | Event | Description |
   | --- | --- | --- | --- |
   | On Player Spawned Send Event To | ItemGranter | Grant Item | When the player spawns, they will be granted the sword. |
5. Beside the Melee Designer and Item Granter, place a **Creature Manager**. Customize it to the following settings:

   [![Combo Creature Manager Settings](https://dev.epicgames.com/community/api/documentation/image/c23489cc-102e-4832-b272-e62eb192262b?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/c23489cc-102e-4832-b272-e62eb192262b?resizing_type=fit)

   | Option | Value | Description |
   | --- | --- | --- |
   | Health | 200 | Sets the creature health to 200 to make the creatures spawned require multiple chained hits to be easily defeated. |
   | Allow Weapon Knockback | Yes | Creatures are affected by the knockback of melee weapons. |
6. On the raised arena with the Player Spawner, place 3 **Creature Placers**. Keep the default settings.

Here’s an overview of how devices communicate in this Design Example:

| Device A | Function | Device B | Event | Explanation |
| --- | --- | --- | --- | --- |
| **ItemGranter** | Grant Item | **PlayerSpawner** | On Player Spawned Send Event To | When the player spawns, they will be granted the sword. |

You now have the basic functionality to require multiple M1 hits chained together in a combo to build up damage.

This mode may work best when fighting AI creatures, but having intense combo-building swordfights can also be fun between players. Consider setting the damage to only scale on the fifth swing along with a massive increase in the knockback to create the effect of building up to a massive finishing attack.
