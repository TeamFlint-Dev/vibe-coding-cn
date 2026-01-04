# Team Settings and Inventory Devices

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/using-team-settings-and-inventory-devices-in-fortnite-creative
> **爬取时间**: 2025-12-26T23:29:06.473763

---

The **Team Settings and Inventory** device is important for most team-based games. It provides team and inventory configurations that go beyond the choices the [Island Settings](understanding-island-settings-in-fortnite-creative) give you. You can also use this to customize individual devices, and create variations in team setup.

There is a hierarchy of setting overrides, described as follows:

- Island Settings are the baseline.
- Team Settings & Inventory overrides Island Settings if there is a specific value set in the device.
- Class Designer overrides both Team Settings & Inventory and Island Settings, if there is a specific value set in the device that differs from the Island Settings or Team Settings & Inventory values.

To find the Team Settings & Inventory device, go to the Creative inventory and select the Devices tab. From there you can search or browse for the device. For more information on finding devices see [Finding and Placing Devices](https://dev.epicgames.com/documentation/en-us/fortnite/using-devices-in-fortnite).

If you're using multiple copies of a device on an island, it can be helpful to [rename](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#rename-a-device) them. You can choose names that relate to each device's purpose, so it's easier to remember what each one does.

## Contextual Filtering

Some devices are affected by a feature called contextual filtering. This feature hides or displays options depending on the values selected for certain related options. This feature will reduce clutter in the Customize panel and make options easier to manage and navigate.

However, it may not be easy to recognize which options or values trigger contextual filtering. To help you identify them, in our device docs we use *italic* for any values that trigger contextual filtering. All options will be listed, including those affected by contextual filtering; if they are hidden or displayed based on a specific option's value, there will be a note about that in the **Description** field for that option.

## Device Options

When this device is placed, the device uses settings inherited from the Island Settings in its default state. Because of this, it has no effect on the game until you customize it.

This device has some basic functionality, like setting max [health](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#health) and max [shields](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#shield), as well as setting a spawn limit. Additionally, there are some advanced options, like how much [resource](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#resource) or [score](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#score) a player is granted when they eliminate another player.

You can configure this device with the following options.

Default values are **bold**. Values that trigger contextual filtering are *italic*.

| Option | Value | Description |
| --- | --- | --- |
| **Team Name** | Enter a name | Type a name for the team in the text field. The text field has a character limit of 24 characters. |
| **Team Description** | Enter text | Type a description for the team in the text field. The text field has a character limit of 512 characters. |
| **Team** | **All**, Pick or enter a team | Specifies which team the settings on this device apply to. |
| **Team Color** | **Don't Override**, Pick a color | Determines whether the game uses the default color for the team, or if it uses the color you pick here. |
| **Team Icon** | **None**, Pick an icon | Determines the icon used for the team. Click the icon to open the **Icon Library Picker**. You can scroll through the icons to find one, or you can type a word into the search bar at the top and click the **Search** button. Select an icon, then click the checkmark.  [Team Icon Picker](https://dev.epicgames.com/community/api/documentation/image/da8abdd8-fc20-4786-9675-ed1aa8a0e982?resizing_type=fit)  Click to enlarge image |
| **Default Class Identifier** | **Don't Override**, None, Pick a class number | Defines the default class assigned to players at the start of the game, or if a player's chosen class is reset.   - **Don't Override**: Classes keep the default [class identifier](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#class-identifier) defined in the [Class Designer](https://dev.epicgames.com/documentation/en-us/fortnite/using-class-designer-devices-in-fortnite-creative) device or island settings. - **None**: There is no default class. - **Class Number**: Override the default class identifier defined in the [Class Designer](https://dev.epicgames.com/documentation/en-us/fortnite/using-class-designer-devices-in-fortnite-creative) device or island settings, and assign the selected class identifier instead. |
| **Grant Items On Respawn** | Yes, **No** | Determines whether the device grants its items when players on this team [respawn](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#respawn). |
| **Grant Condition** | **Always**, Only When Empty | Determines whether the device grants its items to a player when they respawn, or only if the player's inventory is empty. For this to be used, the **Grant Items On Respawn** option must be set to **Yes**. |
| **On-Grant Behavior** | **Clear All**, Clear Items, Keep All | Determines what happens to the player's inventory when the player respawns. |
| **Equip Granted Item** | **Don't Equip**, Pick an item | If the device grants items to the player, this determines which items (listed in order) should be [equipped](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#equip). If you choose an item slot that is higher than the total number of items in the device, the device grants the last item in the list. |
| **Initial Weapon Ammo** | **Don't Override**, Pick or enter an amount | Sets the amount of ammunition loaded in the weapon when granted, limited by the weapon's magazine size. |
| **Spare Weapon Ammo** | **Default**, Pick or enter an amount | Sets how much spare ammunition is added to the player's inventory when a weapon is granted. **Default** provides ammo based on the ammo type used by the weapon. |
| **Start With Pickaxe** | **Don't Override**, No, Yes | Determines whether or not players start the game with a pickaxe. |
| **Invincibility** | ***Don't Override***, On, *Off* | Determines if players should spawn with invincibility. If this is set to **Don't Override** or **Off**, the **Starting Health Percentage** option is displayed below this one. |
| **Starting Health Percentage** | **Don't Override**, Pick or enter an amount | This option only displays if the **Invincibility** option is set to **Don't Override** or **Off**. Determines how much health a player has when they spawn. |
| **Max Health** | **Don't Override**, Pick or enter an amount | Determines the maximum amount of health players can have during the game. If you have a Class Designer device, the options for that device can override this. |
| **Allow Heath Recharge** | On, **Off** | Determine if health recharge is available or not. Health recharge allows player health to regenerate over time. |
| **Health Recharge Delay** | **6.5 seconds**, Pick or enter a number | Determines how long of a delay there is after players take damage, before their health begins to recharge. |
| **Health Recharge Amount** | **1**, Pick or enter a number | Once the Health Recharge Delay is over, this determines how much health is recharged per second. |
| **Starting Shield Percentage** | **Don't Override**, Pick or enter an amount | Determines the player's shield value when they spawn. |
| **Max Shields** | **Don't Override**, Pick or enter a number | Determines the maximum shield value a player can reach during the game. |
| **Allow Shield Recharge** | On, **Off** | Determines if shield recharge is available or not. Shield recharge allows player shields to regenerate over time. |
| **Shield Recharge Delay** | **6.5 seconds**, Pick or enter a number | Determines how long of a delay there is after players take damage, before their shield begins to recharge. |
| **Shield Recharge Amount** | **1**, Pick or enter a number | Once the Shield Recharge Delay is over, this determines how much shield is recharged per second. |
| **Allow Overshield** | **Don't Override**, On, Off | Determines whether the Overshield feature is available. |
| **Overshield: More Options** | **Hide**, *Show* | If you choose **Show**, three more options for Overshield are displayed below this one. |
| **Overshield Max** | **Don't Override**, Pick or enter an amount | This only displays if you have set the **Overshield: More Options** option to **Show**. Determines the maximum amount of Overshield a player can have. If you set an amount here, it will override any amount set in the Island Settings. |
| **Overshield Recharge Delay** | **Don't Override**, Pick or enter an amount | This only displays if you have set the **Overshield: More Options** option to **Show**. The Overshield starts to recharge after this amount of time if the player takes no damage during the delay. If you set the delay here, it will override the delay set in the Island Settings. |
| **Overshield Recharge Rate** | **Don't Override**, Pick or enter an amount | This only displays if you have set the **Overshield: More Options** option to **Show**. Determines how much the Overshield recharges each second, after the recharge delay has ended. If you set the recharge amount here, it will override the recharge amount in the Island Settings. |
| **Movement Multiplier** | **Don't Override**, Pick or enter a multiplier | Sets a value that is multiplied by the player's base movement speed. This defaults to 1. Numbers lower than 1 will make players move slower, numbers higher than 1 will make the player move faster. |
| **Allow Sprinting** | **Don't Override**, On, Off | Determines whether the Sprinting feature is available. |
| **Sprinting: More Options** | **Hide**, *Show* | If you choose **Show**, three more options for Sprinting are displayed below this one. |
| **Sprinting Energy Cost Per Second** | **Don't Override**, Pick or enter an amount | This only displays if you have set the **Sprinting: More Options** option to **Show**. Determines how fast Sprinting Energy is drained each second while a player is sprinting. If you set the energy cost here, it will override the energy cost set in the Island Settings. |
| **Sprinting Jump Multiplier** | **Don't Override**, Pick or enter a multiplier | This only displays if you have set the **Sprinting: More Options** option to **Show**. Determines how much higher or farther players jump when sprinting, as a multiple of normal jump height or length. If you set the jump multiplier here, it will override the jump multiplier set in the Island Settings. |
| **Sprinting Speed Multiplier** | **Don't Override**, Pick or enter a multiplier | This only displays if you have set the **Sprinting: More Options** option to **Show**. Determines how fast a player moves when sprinting, as a multiple of their speed when not sprinting. If you set the sprint speed here, it will override the sprint speed set in the Island Settings. |
| **Energy Max** | **Don't Override**, Pick or enter an amount | Determines how much Energy is available to the player. This affects Sprinting, as well as other abilities that use Energy. |
| **Energy Recharge Amount** | **Don't Override**, Pick or enter an amount | When Energy begins to recharge, this determines the amount of Energy recharged each second. |
| **Energy Recharge Delay** | **Don't Override**, Pick or enter a time | After a player stops using Energy, this sets the length of delay before the player's Energy begins to recharge. |
| **Allow Sliding** | **Don't Override**, On, Off | Determines whether the Sliding feature is available. |
| **Allow Slide Kick** | **Don't Override**, On, Off | Determines whether sliding players can use the Slide Kick to impact and knock away players on an opposing team. |
| **Allow Shoulder Bashing** | **Don't Override**, On, Off | Determines whether the Shoulder Bashing feature is available. |
| **Instant Reload** | **Don't Override**, On, Off | Determines whether weapons ignore their normal reload time and reload instantly instead. If you have a Class Designer device, the options for that device can override this. |
| **No Cooldowns After Use** | Don't Override, On, Off | Determines whether players have no cooldown on weapons and abilities during the game. This does not affect cooldowns prevented by the **No Cooldowns After Swap** setting. |
| **No Cooldowns After Swap** | Don't Override, On, Off | Determines whether players have no cooldown after swapping weapons or items during the game. |
| **Infinite Reserve Ammo** | **Don't Override**, On, Off | Determines whether players have infinite reserve ammunition during the game. If you have a Class Designer device, the options for that device can override this. |
| **Infinite Magazine Ammo** | Don't Override, On, Off | Determines whether players have infinite magazine ammunition during the game. |
| **Infinite Charges** | Don't Override, On, Off | Determines whether players have infinite charges for weapons and abilities during the game. |
| **Infinite Reserve Energy** | Don't Override, On, Off | Determines if players have infinite reserve energy for weapons and abilities during the game. |
| **Infinite Loaded Energy** | **Don't Override**, On, Off | Determines whether players have infinite loaded energy for weapons and abilities during the game. |
| **Infinite Durability** | **Don't Override**, On, Off | Determines if players have infinite durability for weapons and items during the game. |
| **Infinite Consumables** | **Don't Override**, On, Off | Determines whether players have infinite consumable items (such as grenades, health items, traps, and so on). |
| **Infinite Building Resources** | **Don't Override**, On, Off | Determines whether player building resources are infinitely available in-game. |
| **Infinite Gold** | Don't Override, On, Off | Determines whether players have infinite gold during the game. |
| **Infinite World Resources** | Don't Override, On, Off | Determines whether players have infinite world resources during the game. |
| **Eliminated Player's Items** | **Don't Override**, Drop, Keep, Delete | Determines what happens to the player's items when the player is eliminated. If you have a Class Designer device, the options for that device can override this.  Values for this option are:   - **Don't Override**: This device does not affect eliminated player items. - **Drop**: Items are dropped on the ground. Other players can pick them up. - **Keep**: Player keeps items. - **Delete**: Items are removed from the game. |
| **Eliminated Player's Resources** | **Don't Override**, Drop, Keep, Delete | Determines what happens to a player's resources when the player is eliminated. If you have a Class Designer device, the options for that device can override this.  Values for this option are:   - **Don't Override**: This device does not affect eliminated player resources. - **Drop**: Resources are dropped on the ground. Other players can pick them up. - **Keep**: Player keeps resources. - **Delete**: Resources are removed from the game. |
| **Eliminated Player's Game Resources** | **Don't Override**, Drop, Keep, Delete | Determines what happens to a player's game resources when the player is eliminated. If you have a Class Designer device, the options for that device can override this.   - **Don't Override**: This device does not affect eliminated player resources. - **Drop**: Resources are dropped on the ground. Other players can pick them up. - **Keep**: Player keeps resources. - **Delete**: Resources are removed from the game. |
| **Fall Damage** | **Don't Override**, On, Off | Determines whether players are affected by fall damage during the game. If you have a Class Designer device, the options for that device can override this. |
| **Gravity** | **Don't Override**, Very Low, Low, Normal, High, Very High | Changing the Gravity affects how high players can jump, as well as how much damage players take when they fall. If you have a Class Designer device, the options for that device can override this. |
| **Jump Fatigue** | **Don't Override**, On, Off | Determines whether continuous jumping applies a penalty to jump height. If you have a Class Designer device, the options for that device can override this. |
| **Player Flight** | **Don't Override**, On, Off | Determines whether players can fly during the game. If you have a Class Designer device, the options for that device can override this. |
| **Allow Mantling** | **Don't Override**, On, Off | Determines whether the Mantling feature is available. |
| **Mantling: More Options** | **No**, *Yes* | If you choose **Yes**, two more options for Mantling are displayed below **Allow Mantling**. |
| **Mantling Minimum Height** | **Don't Override**, Very Low, Low, Normal, High | This only displays if you have set the **Show More Options: Mantling** option to **Show**. Determines the lowest height at which a player can use mantling on a ledge. You might want to adjust this value if gravity or other factors affect mantling. |
| **Mantling Minimum Height In Water** | **Don't Override**, Very Low, Low, Normal, High | This only displays if you have set the **Show More Options: Mantling** option to **Show**. Determines the lowest height at which a player can mantle from the water. You might want to adjust this value if gravity or other factors affect mantling. |
| **Allow Vaulting** | **Don't Override**, On, Off | Determines if players can vault over low obstacles. If you choose **On**, players will vault over obstacles automatically if they are sprinting toward the obstacle. |
| **Always Show Name Plates** | **Don't Override**, Always Show to Team, Always Show to All, Always Hide, No | Determines whether players names and locations can be seen by other players. |
| **Name Plate Line of Sight** | **Don't Override**, Always Show, *Hide Behind Obstacles* | If set, the name plates are hidden whenever a player is obstructed by an obstacle. If this is set to **Hide Behind Objects**, an additional option displays below this one. |
| **Focus Angle** | **Don't Override**, Pick or enter an angle | When focusing, this is the maximum angle a player can be from the look direction of another player in order to be valid for focusing. |
| **Focus Time** | **Don't Override**, Pick or enter an amount | How long you need to focus on a player for their name plate to be visible. |
| **Show Voice Indicator** | **Don't Override**, Don't Override Show Name Plates, Always Show to Team, Always Show to Hostiles, Always Show to All, Disable | Determines whether the voice indicator can be seen on a player's name plate. Can be used to control the voice indicator and name plate separately. |
| **Show Player Health Indicator** | **Don't Override**, Team Only, Enemies, Anyone, Never | Determines who can see the health indicators over players' heads. If you have a Class Designer device, the options for that device can override this. |
| **Display Health for All Players** | **Don't Override**, Yes, No | Determines whether all players get a health bar displayed on the HUD for this team or class. If this is enabled for a team with more than one player, or enabled for multiple teams, this will only display the health of one player at a time. If you have a Class Designer device, the options for that device can override this. |
| **Glider Redeploy** | **Don't Override**, On, Off | Determines whether players can freely deploy gliders without using a [item](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) item. If you have a Class Designer device, the options for that device can override this. |
| **Down But Not Out** | **Don't Override**, Default, On, Off | Determines whether the player can be put into the Down But Not Out state. If you choose **Default**, this will be determined automatically depending on team size. If you have a Class Designer device, the options for that device can override this. |
| **Drop Reboot Card on Elimination** | **Don't Override**, On, Off | Determines if a player drops a Reboot Card when they are eliminated. Reboot Cards only drop if the eliminated player has a teammate eligible to use a Reboot Van. |
| **Limit Name Plate Max Distance** | **Don't Override**, Yes, No | Determines if name plates should disappear based on distance from the camera. |
| **Allow Building** | **Don't Override**, None, All, Traps Only, No Traps | Determines whether players can build or place [traps](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#trap). If you have a Class Designer device, the options for that device can override this.  Values for this option are:   - **None**: The player can neither build nor place traps. - **All**: The player can build or place traps, if they have the required resources. - **Traps Only**: The player cannot build, but can place traps. - **No Traps**: The player can build, but not place traps. |
| **Respawn Time** | **Don't Override**, Pick or enter an amount of time | Determines the amount of time (in seconds) the player must wait after being eliminated before they are [respawned](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#respawn) back into the game. If you have a Class Designer device, the options for that device can override this. |
| **Only Allow Respawning If Spawn Pads Found** | **Don't Override**, No, Yes | If you choose **Yes**, players can only respawn if there is a [spawn pad](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) available. |
| **Respawn Type** | **Don't Override**, Individual, Wave | Changing the respawn type to **Wave** causes all eliminated team members during a certain window to respawn together. Set the time in the **Respawn Time** option. |
| **Spawn Limit** | **Don't Override**, Infinite, Pick a number | Determines the number of times the player can spawn into the game, including the initial spawn at the start of the game. If you choose **1** it means the player can't respawn after they are eliminated. If you have a Class Designer device, the options for that device can override this. |
| **After Last Spawn Go To** | **Don't Override**, Spectator, Pick a team | Determines which team a player joins after they use all of their permitted spawns. |
| **Max Initial Team Size** | **Don't Override**, Unlimited, Pick a team size | Determines the maximum team size at the start of the game. During the game, more players can be added to this team using the **After Last Spawn Go To** option. |
| **Initial Team Size Ratio** | **Don't Override**, Pick an amount | Determines number of players to be placed in this team at the start of the game, relative to the size of other teams. This is capped by the number set in the **Max Initial Team Size** option. |
| **Win on Time Out** | **Don't Override**, Yes, No | Sets the win condition for the team to be when the game ends by running out of time. |
| **Eliminations To End** | **Don't Override**, Off, Pick a number | Causes the round to end when this team has gotten the chosen number of eliminations. |
| **Creature Eliminations To End** | **Don't Override**, Off, Pick a number | Causes the round to end when this team has destroyed the chosen number of [creatures](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#creature). |
| **Objectives To End** | **Don't Override**, Off, Pick a number | Causes the round to end when this team has completed the chosen number of objectives. |
| **Collect Items To End** | **Don't Override**, Off, All, Pick a number | Causes the round to end when this team has collected the chosen number of collectible objects. |
| **Score To End** | **Don't Override**, Off, Pick a number | Causes the round to end when this team has achieved the chosen score. |
| **Use Team Score** | **Don't Override**, Yes, No | Determines whether a team gains score with its players, or whether the team score uses a sum of the its players' scores. If you choose **Yes**, the team retains its score even if a player leaves the team or the game. |
| **Spawn Location** | **Don't Override**, Spawn Pads, Sky, Current Location, Do Not Spawn | Determines where the player will spawn when the game starts. If you have a Class Designer device, the options for that device can override this.  Values for this option are:   - **Don't Override**: This device does not affect spawn location. - **Spawn Pads**: Players spawn on designated spawn pads. - **Sky**: Up in the air where the player will parachute down. - **Current Location**: Where the player is currently located. - **Do Not Spawn**: The player is not spawned. |
| **Health Granted On Elimination** | **Don't Override**, Pick an amount | Specifies how much health the player gets when they eliminate another player. Any health awarded above the player's **Max Health** value is awarded as shields instead. |
| **Wood Granted On Elimination** | **Don't Override**, Pick an amount | Specifies how much wood the player gets when they eliminate another player. |
| **Stone Granted On Elimination** | **Don't Override**, Pick an amount | Specifies how much stone the player gets when they eliminate another player. |
| **Metal Granted On Elimination** | **Don't Override**, Pick an amount | Specifies how much metal the player gets when they eliminate another player. |
| **Gold Granted On Elimination** | **Don't Override**, Pick an amount | Specifies how much gold the player gets when they eliminate another player. |
| **Self-Damage On Hit Amount** | **Don't Override**, Pick an amount | Sets the amount of damage players deal to themselves when they hit something else. |
| **Self-Damage Only On Non-Zero Damage** | **Don't Override**, Yes, No | Determines whether or not the player only receives self-damage when the player inflicts non-zero damage to something else. |
| **Self-Damage Target Filter** | **Don't Override**, Non-Players, Players Only, All | Specifies which targets cause self-damage when hit. |
| **Self-Damage Weapon Filter** | **Don't Override**, Pickaxe Only, Melee Only, Ranged Only, All | Determines which weapons can inflict self-damage. |
| **Maximum Building Resources** | **Don't Override**, Pick an amount | Sets the maximum amount of resources a player can carry during the game. If you have a Class Designer device, the options for that device can override this. |
| **Allow Item Drop** | **Don't Override**, Yes, No | Determines if players can drop items from their inventory during the game. If you have a Class Designer device, the options for that device can override this. |
| **Allow Item Pick Up** | **Don't Override**, Yes, No | Determines whether players can pick up items during the game. If you have a Class Designer device, the options for that device can override this. |
| **Harvest Multiplier** | **Don't Override**, Pick a multiplier | Determines the rate at which players can harvest resources from world objects. If you have a Class Designer device, the options for that device can override this. |
| **Elimination Score** | **Don't Override**, Pick an amount | Sets the amount of score awarded to a player on this team when they eliminate another player. |
| **Assist Score** | **Don't Override**, Pick an amount | Sets the amount of score awarded to a player on this team when they assist in eliminating another player. |
| **Override Spawn Immunity Time** | **Don't Override**, *Yes*, No | Determines if the invulnerability time granted to a player after respawn should be overridden. If this is set to **Yes**, an additional option displays below this one. |
| **Spawn Immunity Time** | **Don't Override**, Default, None, Pick or enter an amount of time | This option only displays if the **Override Spawn Immunity Time** option is set to **Yes**. Determines how long invulnerability is granted to a player when they respawn. |
| **Maximum Equipment Slots** | **Don't Override**, None, Pick a number | Set the maximum number of equipment slots a player can have during the game. |
| **Wood Resource Widget Is Visible** | **Don't Override**, Yes, No | If this is set to **Yes**, players can see the wood resource widget. |
| **Metal Resource Widget Is Visible** | **Don't Override**, Yes, No | If this is set to **Yes**, players can see the metal resource widget. |
| **Stone Resource Widget Is Visible** | **Don't Override**, Yes, No | If this is set to **Yes**, players can see the stone resource widget. |
| **Gold Resource Widget Is Visible** | **Don't Override**, Yes, No | If this is set to **Yes**, players can see the gold resource widget. |
| **Allow Friendly Fire** | **Don't Override**, Yes, No | Determines whether or not a player can damage another player on their team. |
| **Spawn Event Activates for AI** | **On**, Off | Determines if the **On Team Member Spawned** event will activate for AI that are on the device's team. |
| **Spawn Event Activates for Players** | **On**, Off | Determines if the **On Team Member Spawned** event will activate for players that are on the device's team. |
| **Respawn Alive Players** | Yes, **No** | Determines if players who are alive also respawn when the **Respawn at Player Spawner** function is triggered. |
| **Display Empty Ammo Slots** | Don't Override, Yes, No | Determines whether empty ammo slots are shown in the player's inventory. |
| **Dynamic Team Emotes** | Don't Override, Yes, No | Determines whether players on a team can use emotes to extend team invites to other players.  If this is set to Enabled, a two-person emote will be added to players' collection. Players can press and hold B, then click Manage Teams to select the team invite emote. |
| **Dynamic Team Leave** | Don't Override, Yes, No | This setting is only editable if the **Dynamic Team Emotes** option is set to **Enabled**. Determines whether players invited to a team can leave it using emotes.  If this is set to Enabled, an emote is added to player's collection that can be used to leave the player's current team.  Players can press and hold **B**, then click **Manage Teams** to select the Leave Team emote. |

## Direct Event Binding

Direct event binding allows devices to communicate directly, which makes your workflow more intuitive, and gives you more freedom to focus on your design ideas.

Below are the following direct event binding options for this device.

### Functions

A [function](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) listens for an event on a device then performs an action.

1. For any function, click the **option**, then **Select Device** to access and select from the **Device dropdown menu**.
2. Once you've selected a device, click **Select Event** to bind the device to an event that will trigger the function for the device.
3. If more than one device or event triggers a function, click the **Add** button to add a line and repeat these steps.

| Option | Description |
| --- | --- |
| **End Round When Receiving From** | This function ends the round when an event occurs. |
| **Respawn at Player Spawner When Receiving From** | This function respawns the instigating player at the most appropriate player spawner. |

### Events

An [event](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#event) tells another device when to perform a function.

1. For any event option, click the **option**, then **Select Device** to access and select from the **Device dropdown menu**.
2. Once you've selected a device, click **Select Function** to bind the timer to a function for that device.
3. If more than one device is affected by the function, press the **Add** button and repeat.

| Option | Description |
| --- | --- |
| **On Team Is Out of Respawns Send Event To** | When a team is out of respawns, an event is sent to the selected device, which triggers the selected function. |
| **On Enemy Eliminated by Team Member Send Event To** | When an enemy is eliminated by a team member, an event is sent to the selected device, which triggers the selected function. |
| **On Team Member Eliminated Send Event To** | When a team memeber is eliminated, an event is sent to the selected device, which triggers the selected function. |
| **On Team Member Spawned Send Event To** | When a team member is spawned, an event is sent to the selected device, which triggers the selected function. |

## Gameplay Examples Using Team Settings and Inventory

- [5 Rounds Of Econ Lessons](https://dev.epicgames.com/documentation/en-us/fortnite/5-rounds-of-econ-lessons-gameplay-example-in-fortnite-creative)
- [Dungeon Crawler](https://dev.epicgames.com/documentation/en-us/fortnite/dungeon-crawler-gameplay-example-in-fortnite-creative)
- [Mazey Escape](https://dev.epicgames.com/documentation/en-us/fortnite/mazey-escape-in-fortnite-creative)
- [Spawner 123](https://dev.epicgames.com/documentation/en-us/fortnite/spawner-123-in-fortnite-creative)
