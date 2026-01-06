# Class Designer Devices

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/using-class-designer-devices-in-fortnite-creative
> **爬取时间**: 2025-12-26T23:47:06.974339

---

The **Class Designer** device is used in conjunction with the [Class Selector](https://dev.epicgames.com/documentation/en-us/fortnite/using-class-selector-devices-in-fortnite-creative) device to make it easy to create [class-based gameplay](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary).

The Class Designer gives you a way to define a custom [class](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) with an initial set of [attributes](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) and an inventory [loadout](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary).

Each device is used to design one custom class. To define the inventory loadout for this class, drop [items](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) onto the device to [register](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) them for that class.

The Class Identifier is used by:

- The **[Class Selector](https://dev.epicgames.com/documentation/en-us/fortnite/class-selector)** device
- The Team Settings & Inventory device
- **Island** **Settings**

There is a hierarchy of setting overrides, described as follows:

- Island Settings are the baseline.
- Team Settings & Inventory overrides Island Settings if there is a specific value set in the device.
- Class Designer overrides both Team Settings & Inventory and Island Settings, if there is a specific value set in the device that differs from the Island Settings or Team Settings & Inventory values.

See the pages under Island Settings for more info.

For information on finding the Class Designer device, see [Using Devices](https://dev.epicgames.com/documentation/en-us/fortnite/using-devices-in-fortnite).

If you're using multiple copies of a device on an island, it can be helpful to [rename](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) them. You can choose names that relate to each device's purpose, so it's easier to remember what each one does.

## Device Options

A player cannot interact with this device in [Play mode](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) even if it is visible.
This device has some basic functionality, like setting the maximum health and shields for the class, and whether items are granted to the player when they respawn. Additionally, there are some advanced options, such as turning on player movement features like Sprinting and Sliding.

### Contextual Filtering

Some devices are affected by a feature called **contextual filtering**. This feature hides or displays options depending on the values selected for certain related options. This reduces clutter in the Customize panel and makes options easier to manage and navigate. To help identify them, values that trigger contextual filtering are in *italic*.

All options are listed, including those affected by contextual filtering; if they are hidden or displayed based on a specific option's value, there will be a note about it in the Description field for that option.

Default values are **bold**. Values that trigger contextual filtering are *italic*.

You can configure this device with the following options.

| Option | Value | Description |
| --- | --- | --- |
| **Class Identifier** | **Class Not Selected**, Pick a number | This is used by the Class Selector to identify which Class the player will switch to. If multiple Class Designers use the same identifier, the one that was placed first will be used. |
| **Class Name** | Enter text | Enter a name for your custom class. The text field is limited to 24 characters. |
| **Class Description** | Enter text | Enter a description of up to 512 characters. |
| **Grant Items On Respawn** | Yes, **No** | Determines whether the device grants the listed items to players when they [respawn](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary). |
| **Equip Granted Item** | **Don't Equip**, Pick an item | If the device grants items to the player, this determines whether the item listed in order should be equipped or not. Specifying an item order higher than the number of items in the list results in the last item being granted. |
| **Visible During Game** | Yes, **No** | Determines whether the device is visible during the game. |
| **Initial Weapon Ammo** | **Don't Override**, select a number from 1 to 999 | Sets the amount of ammunition loaded in the weapon when granted, limited by the weapon's magazine size. |
| **Spare Weapon Ammo** | **Default**, select a number from 1 to 999 | Sets how much spare ammunition is added to the player's inventory when a weapon is granted. **Default** provides ammo based on the ammo type used by the weapon. |
| **Start With Pickaxe** | **Don't Override**, No, Yes | Determines whether players start the game with a pickaxe. |
| **Invincibility** | **Don’t Override**, On, Off | Determines if players should spawn with invincibility. |
| **Max Health** | **Don't Override**, Pick an amount | Determines the maximum health players can attain. This takes precedence over a Team Settings & Inventory device. |
| **Allow Health Recharge** | **Off**, On | When set to **On**, players can regenerate health over time. |
| **Health Recharge Delay** | **6.5 Seconds**, Pick a time | Determines how long after taking damage before a player's health starts to recharge. |
| **Health Recharge Amount** | **1**,Pick a number | Sets how much health per second is recharged after **Health Recharge Delay** completes. |
| **Starting Shield Percentage** | **Don't Override**, No Shields, 50% Shields, 100% Shields | Determines how many shields the player has when they spawn, as a percentage of their **Max Shields**. This takes precedence over a **Team Settings & Inventory** device. |
| **Max Shields** | **Don't Override**, No Shields, Pick an amount | Determines the maximum shield capacity this class can attain. This takes precedence over a Team Settings & Inventory device. |
| **Allow Shield Recharge** | **Off**, On | When set to **On**, allows player shields to recharge over time. |
| **Shield Recharge Delay** | **6.5 Seconds**, Pick a time | Determines how long after taking damage before a player's shield starts to recharge. |
| **Shield Recharge Amount** | **1**,Pick a number | Sets how much health per second is recharged after **Shield Recharge Delay** completes. |
| **Allow Overshield** | **Don't Override**, Off, On | Determines whether the Overshield feature is available. |
| **Overshield: More Options** | **Hide**, *Show* | If you choose **Show**, three more options for Overshield are displayed below **Allow Overshield**. |
| **Overshield Max** | **Don't Override**, Pick an amount | *This only displays if you have set the **Overshield: More Options** option to **Show**.* Determines the maximum amount of Overshield a player can have. If you set an amount here, it will override any amount set in the My Island > Settings tab. |
| **Overshield Recharge Delay** | **Don't Override**, Pick an amount of seconds | *This only displays if you have set the **Overshield: More Options** option to **Show***. The Overshield starts to recharge after this amount of time if the player takes no damage during the delay. If you set the delay here, it will override the delay set in Island Settings. |
| **Overshield Recharge Rate** | **Don't Override**, Pick an amount | *This only displays if you have set the **Overshield: More Options** option to **Show***. Determines how much the Overshield recharges each second, after the recharge delay has ended. If you set the recharge amount here, it will override the recharge amount in Island Settings. |
| **Movement Multiplier** | **Don't Override**, Pick a multiplier | Determines how fast the player moves as a multiplication of the base move speed. This takes precedence over a Team Settings & Inventory device. |
| **Allow Sprinting** | **Don't Override**, Off, On | Determines whether the Sprinting feature is available. |
| **Sprinting: More Options** | **Hide**, *Show* | If you choose **Show**, three more options for Sprinting are displayed below **Allow Sprinting**. |
| **Sprinting Energy Cost Per Second** | **Don't Override**, Pick an amount | This only displays if you have set the **Sprinting: More Options** option to **Show**. Determines how fast sprinting Energy is drained each second while a player is sprinting. If you set the energy cost here, it will override the energy cost set in the My Island > Settings tab. |
| **Sprinting Jump Multiplier** | **Don't Override**, Pick or enter a multiplier | This only displays if you have set the **Sprinting: More Options** option to **Show**. Determines how much higher or farther players jump when sprinting, as a multiple of normal jump height or length. Use the arrows to select a multiplier. If you set the jump multiplier here, it will override the jump multiplier set in the My Island > Settings tab. |
| **Sprinting Speed Multiplier** | **Don't Override**, Pick a multiplier | This only displays if you have set the **Sprinting: More Options** option to **Show**. Determines how fast a player moves when Sprinting, as a multiple of their speed when not Sprinting. If you set the sprint speed here, it will override the sprint speed set in the My Island > Settings tab. |
| **Energy Max** | **Don't Override**, Pick an amount | Determines how much Energy is available to the player. This affects Sprinting, as well as other abilities that use Energy. |
| **Energy Recharge Amount** | **Don't Override**, Pick an amount | When Energy begins to recharge, this determines the amount of Energy recharged each second. |
| **Energy Recharge Delay** | **Don't Override**, Pick a time | After a player stops using Energy, this sets the length of delay before the player's Energy begins to recharge. |
| **Allow Sliding** | **Don't Override**, Off, On | Determines whether the Sliding feature is available. |
| **Allow Slide Kick** | **Don't Override**, Off, On | Determines whether sliding players can use the Slide Kick to impact and knock away players on an opposing team. |
| **Allow Shoulder Bashing** | **Don't Override**, Off, On | Determines whether the Shoulder Bashing feature is available. |
| **Instant Reload** | **Don't Override**, On, Off | Determines whether weapons are reloaded instantaneously, or reloaded based on the time defined in each weapon. This takes precedence over a Team Settings & Inventory device. |
| **Infinite Reserve Ammo** | **Don't Override**, On, Off | Determines whether players have infinite reserve ammo or not. This takes precedence over a Team Settings & Inventory device. |
| **Infinite Items** | **Don't Override**, On, Off | Determines whether players have infinite items (grenades, health items, traps, etc.) during the game. |
| **Infinite Building Materials** | **Don't Override**, On, Off | Determines whether players have infinite building materials. This takes precedence over a Team Settings & Inventory device. |
| **Eliminated Player's Items** | **Don't Override**, Drop, Keep, Delete | Determines what happens to the player's items when the player is eliminated. This takes precedence over a Team Settings & Inventory device. Options are:   - **Drop**: The player's items are dropped on the ground, and other players can pick them up. - **Keep**: The player's items are retained. - **Delete**: The player's items are removed from the game. |
| **Eliminated Player's Resources** | **Don't Override**, Drop, Keep, Delete | Determines what happens to the player's resources (wood, metal, stone, gold) when they are eliminated. This takes precedence over a Team Settings & Inventory device. Options are:   - **Drop**: The player's items are dropped on the ground. Other players can pick them up. - **Keep**: The player's items are retained. - **Delete**: The player's items are removed from the game. |
| **Eliminated Player's Game Resources** | **Don't Override**, Drop, Keep, Delete | Determines what happens to the player's resources (wood, metal, stone, gold) when they are eliminated. This takes precedence over a Team Settings & Inventory device. Options are:   - **Drop**: The player's items are dropped on the ground. Other players can pick them up. - **Keep**: The player's items are retained. - **Delete**: The player's items are removed from the game. |
| **Fall Damage** | **Don't Override**, On, Off | Determines whether players are affected by fall damage. This takes precedence over a Team Settings & Inventory device. |
| **Gravity** | **Don't Override**, Very Low, Low, Normal, High, Very High | Determines the amount of gravity that affects players during the game. |
| **Jump Fatigue** | **Don't Override**, On, Off | Determines whether continuous jumping applies a penalty to jump height. This takes precedence over a Team Settings & Inventory device. |
| **Allow Mantling** | **Don't Override**, On, Off | Determines whether the Mantling feature is available. |
| **Mantling: More Options** | **No**, *Yes* | If you choose **Yes**, two more options for Mantling are displayed below **Allow Mantling**. |
| **Mantling Minimum Height** | **Don't Override**, Very Low, Low, Normal, High | This only displays if you have set the **Show More Options: Mantling** option to **Show**. Determines the lowest height at which a player can use mantling on a ledge. You might want to adjust this value if gravity or other factors affect mantling. |
| **Mantling Minimum Height In Water** | **Don't Override**, Very Low, Low, Normal, High | This only displays if you have set the **Show More Options: Mantling** option to **Show**. Determines the lowest height at which a player can mantle from the water. You might want to adjust this value if gravity or other factors affect mantling. |
| **Allow Hurdling** | **Don't Override**, On, Off | Determines if hurdling is available to players. If you choose **On**, players will hurdle over obstacles automatically if they are sprinting toward the obstacle. |
| **Player Flight** | **Don't Override**, On, Off | Determine whether players can fly. This takes precedence over a Team Settings & Inventory device. |
| **Always Show Name Plates** | **Don't Override**, Always Show to Team, Always Show to All, Always Hide, No | Determines whether players names and locations can be seen by other players. |
| **Limit Name Plate Max Distance** | **Dont' Override**, Select a distance | If set to a number, name plates will disappear if that player is further away than that distance from the camera. |
| **Name Plate Line of Sight** | **Don't Override**, Always Show, Hide Behind Objects | If set, the name plates will hide whenever a player is obstructed by an obstacle. |
| **Focus Angle** | **Don't Override**, Pick an angle | When a player is focusing, this determines the maximum angle another player can be from the focusing player's look direction in order to be a valid focus target. |
| **Focus Time** | **Don't Override**, Pick a number | Determines the amount of time a player must focus on another player to see that player's name plate. |
| **Show Voice Indicator** | **Don't Override**, Don't Override Show Name Plates, Always Show to Team, Always Show to Hostiles, Always Show to All, Disable | Determines whether the voice indicator can be seen on a player's name plate. Can be used to control the voice indicator and name plate separately. |
| **Show Player Health Indicator** | **Don't Override**, Team Only, Enemies, Anyone, Never | Determines who can see the health indicator over the player's head. This takes precedence over a Team Settings & Inventory device. Options are:   - **Team Only**: Only team members can see the player's health indicator. - **Enemies**: Only enemies can see the player's health indicator. - **Anyone**: All players can see the player's health indicator. - **Never**: No one can see the player's health indicator. |
| **Display Health for All Players** | **Don't Override**, Yes, No | Determines if this player can see the health bar display on the HUD for all players.  This is actually a separate UI element from **Show Player Health Indicator**, and is often used for [boss fight](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) scenarios. |
| **Glider Redeploy** | **Don't Override**, On, Off | Determines whether the player can freely deploy gliders without using an item. This takes precedence over a Team Settings & Inventory device. |
| **Down But Not Out** | **Don't Override**, Default, Classic, Improved, Off | Determines the type of Down But Not Out state this class allows. This takes precedence over a Team Settings & Inventory device. Options are:   - **Don't Override**: The settings for Down But Not Out are not affected by this device. - **Default**: The Down But Not Out state is set automatically based on team size. - **Classic**: Enables the Down But Not State for this class. - **Improved**: Enables the Down But Not State for this class, and adds more interactions during the state like opening doors and dropping inventory items. - **Off**: Down But Not Out is disabled for this class. |
| **Drop Reboot Card on Elimination** | **Don't Override**, If Can Be Rebooted, No | Determines if players drop a Reboot Card when eliminated. Reboot cards are only dropped if a remaining teammate is eligible to use a Reboot Van. |
| **Allow Building** | **Don't Override**, None, All, Traps Only, No Traps | Determines whether players can build and place traps. This takes precedence over a Team Settings & Inventory device. Options are:   - **None**: The player can neither build nor place traps. - **All**: The player can build or place traps, if they have the required resources. - **Traps Only**: The player cannot build, but can place traps. - **No Traps**: The player can build, but not place traps. |
| **Respawn Time** | **Don't Override**, Pick or enter an amount of seconds | Determines how long the player must wait after being eliminated before they are respawned. Use the arrows to select a number. This takes precedence over a Team Settings & Inventory device. |
| **Spawn Limit** | **Don't Override**, Infinite, Pick a number | Determine the number of times the player can spawn into the game (also known as Number of Lives). This includes the initial spawn. So setting it to 1 means the player will not be able to respawn when eliminated. This takes precedence over a Team Settings & Inventory device. |
| **Spawn Location** | **Don't Override**, Spawn Pads, Sky, Current Location, Do Not Spawn | Determines where the player will spawn when the game starts. This takes precedence over a Team Settings & Inventory device. Options are:   - **Spawn Pads**: Where the Player Spawner device is placed. - **Sky**: Up in the air where the player will parachute down. - **Current Location**: Where they are currently located. - **Do Not Spawn**: Player will not be spawned unless triggered by event binding. |
| **Health Granted on Elimination** | **Don't Override**, Pick an amount | How much health the player gets when they eliminate another player. When the amount awarded will cause their current health to exceed their max health, the excess amount will be awarded as shields. This takes precedence over a Team Settings & Inventory device. |
| **Wood Granted on Elimination** | **Don't Override**, Pick an amount | How much wood the player gets when they eliminate another player. This takes precedence over a Team Settings & Inventory device. |
| **Stone Granted on Elimination** | **Don't Override**, Pick an amount | How much stone the player gets when they eliminate another player. This takes precedence over a Team Settings & Inventory device. |
| **Metal Granted on Elimination** | **Don't Override**, Pick an amount | How much metal the player gets when they eliminate another player. This takes precedence over a Team Settings & Inventory device. |
| **Gold Granted on Elimination** | **Don't Override**, Pick an amount | How much gold the player gets when they eliminate another player. This takes precedence over a Team Settings & Inventory device. |
| **Maximum Building Resources** | **Don't Override**, Pick an amount | Sets the maximum amount of resources a player can carry. This takes precedence over a Team Settings & Inventory device. |
| **Allow Item Drop** | **Don't Override**, Yes, No | Determines whether players can drop items from their inventory during the game. This takes precedence over a Team Settings & Inventory device. |
| **Allow Item Pick Up** | **Don't Override**, Yes, No | Determines whether players can pick up items during the game. This takes precedence over a Team Settings & Inventory device. |
| **Harvest Multiplier** | **Don't Override**, Pick a multiplier | Determines the rate at which players can harvest resources. This takes precedence over a Team Settings & Inventory device. |
| **Override Spawn Immunity Time** | **Don’t Override**, Yes, No | Determines if the invulnerability time granted to a player on respawn should be overridden. |
| **Visible In UI** | **On**, Off | If there is a Class Selector UI device active, this option determines whether this class is shown in the Class Selector UI list of available classes. |

## Direct Event Binding

Following are the [direct event binding](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) options for this device.

### Functions

A [function](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) listens for an event on a device then performs an action.

1. For any function option, click the **option**, then **Select Device** to access and select from the **Device dropdown menu**.
2. Once you've selected a device, click **Select Event** to bind the timer to an event that will trigger the function for the device.
3. If more than one device should be affected by a function, press the **Add** button and repeat.

| Option | Description |
| --- | --- |
| **Show in UI When Receiving From** | Enables this class in the Class Selector UI when an event occurs. |
| **Hide in UI When Receiving From** | Disables this class in the Class Selector UI when an event occurs. |

### Events

There are no events for this device.

## Gameplay Examples

- [Class Setup In A Hole](https://dev.epicgames.com/documentation/en-us/fortnite/class-setup-in-an-arena-gameplay-example-in-fortnite-creative)
- [Top Scorer In Class](https://dev.epicgames.com/documentation/en-us/fortnite/top-scorer-in-class-in-fortnite-creative)
- [Dungeon Crawler](https://dev.epicgames.com/documentation/en-us/fortnite/dungeon-crawler-gameplay-example-in-fortnite-creative)
