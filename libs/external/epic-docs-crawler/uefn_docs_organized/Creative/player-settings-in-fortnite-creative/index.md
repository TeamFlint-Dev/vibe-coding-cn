# Player Settings

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/player-settings-in-fortnite-creative
> **爬取时间**: 2025-12-26T23:21:54.607301

---

There are a number of ways you can modify how **players** interact with your island, from how gravity affects them to whether they can build. All of these options contribute to the player experience.

There are many Player subcategories, and each one has multiple settings. From the **Island Settings** tab, click **Player**, then click any **subcategory** to expand it.

[![The Player category has a slew of subcategories.](https://dev.epicgames.com/community/api/documentation/image/8cffa73d-5635-4889-a66e-4bb8d341b87f?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/8cffa73d-5635-4889-a66e-4bb8d341b87f?resizing_type=fit)

If you want to modify a specific setting and know the name of that setting, use the **search bar** to find it.

Any changes you make to these settings are automatically saved. You can restore the settings to their original values at any time by clicking the **Restore Defaults** button. This will reset only the settings for your current selected category.

The following sections describe the settings available in each subcategory, and how you can use them.

Some settings are grayed out. This usually indicates that another setting must be changed before that setting is available.

## Locker Settings

**Locker settings** influence player appearance.

| Option | Values | Description |
| --- | --- | --- |
| Hide Back Bling | No, Yes | Determines whether any back bling will show during the game. |
| Enable Jam | On, Default, Off | When this is set to On, it adds jam emotes to the Emote Wheel. Jam emotes can use up island memory, so if memory becomes problematic, set this to Off to regain the memory. Default means to use whatever value Fortnite has set. The other two options override this. |

## Controls Settings

The **Aim Assist control setting** provides crosshairs in your gun sight for more accurate aim. This is used primarily in FPS (first-person shooter) and TPS (third-person shooter) games.

| Option | Values | Description |
| --- | --- | --- |
| Allow Aim Assist | Yes, No | Toggles Aim Assist off and on for gamepad controllers. |

## Locomotion Settings

**Locomotion settings** control player movements, energy, speed, and damage.

| Option | Values | Description |
| --- | --- | --- |
| Locomotion Preset | Current BR, Current Ballistic, Custom | You can use this to quickly match locomotion on your island to current Battle Royale settings, or current Ballistic settings. Set to Custom if you want to fully customize locomotion settings on your island. |
| Energy Max | 100, Pick a number | Determines how much energy is available. This affects sprinting and any other abilities that use energy. |
| Energy Recharge Amount | 45, Pick a number | Determines the amount of energy recharge per second after Energy Recharge Delay. |
| Energy Recharge Delay | 4 S, Pick a time in seconds | Determines the delay between when a player stops using energy before it recharges back to the Energy Recharge Amount. |
| Fall Damage | Off, On | Sets whether players can take fall damage during the game. If you set this to On, the Fall Damage Type option becomes available. |
| Fall Damage Type | Thresholds, Linear | This option is only available if the Fall Damage option is set to On. Determines how fall damage is calculated. |
| Gravity | Normal, Low, Very Low, High, Very High | Sets the level of gravity that affects the players during the game. |
| Jump Fatigue | On, Off | Determines whether continuous jumping sets a penalty to jump height. |
| Allow Mantling | Off, On | Mantling lets players grab a ledge and pull themselves up when jumping. This setting toggles mantling on and off. |
| PBWs Generate Ledges | Off, On | This option is only available if the Allow Mantling option is set to On. Player Built Walls (PBWs) will generate ledge launch props only if both Allow Mantling and this option are set to On. If either is set to Off, ledge launch props will not be generated. |
| Mantling Minimum Height | Normal, Low, Very Low, High, Very High | This sets the lowest ledge that can be mantled from the ground. You can adjust this value if gravity or other factors affect a player's mantling. |
| Mantling Minimum Height in Water | Normal, Low, Very Low, High, Very High | This sets the lowest ledge that a player can mantle while in water. |
| Allow Hurdling | Off, On | Determines whether players can hurdle over low obstacles. |
| Allow Sprinting | Off, On | Sets whether sprinting is available. When available, players can use sprinting to move faster. |
| Sprinting Energy Cost Per Second | 20, Pick a value | Sets how much energy is drained when sprinting. The higher the number, the more energy is used up. |
| Sprinting Jump Multiplier | 1.2X, Pick a value | The multiplier increases the jump height when a player is sprinting compared to regular jump height. |
| Sprinting Speed Multiplier | 1.2X, Pick a value | The multiplier increases player sprinting speed compared to regular speed. |
| Allow Sliding | Off, On | Determines whether players can use sliding. |
| Allow Slide Kick | Off, On | Determines whether players can use a slide kick on opposing players to push them away. |
| Allow Shoulder Bashing | Off, On | Determines whether players can use shoulder bashing. If shoulder bashing is enabled, it automatically opens doors when players slide or sprint through them. |
| Glider Redeploy | On, Off | Determines whether players can freely deploy their gliders at the appropriate height without the use of items. |
| Player Flight | Off, On | Determines whether players can fly in-game. |
| Player Flight Sprint | On, Off | Determines whether players can use the sprint control to fly faster. |
| Flight Speed | 1.0X, Pick a value | The multiplier increases player flying speed, compared to normal speed. |
| Disable Player Collision | Off, On | If this is set to Off, players pass through each other instead of colliding. |
| Movement Speed Tunings | Ch 4 Movement, Ch 5 Movement | Determines the movement speed tunings used for player locomotion. Chapter 5, released in December 2023, changed some of the movement speed tunings for Battle Royale. Changing this setting to CH 5 Movement will emulate those settings. |
| Allow Boosted Jump | Off, On | If this is set to On, it enables players to jump higher and faster when the are sprinting toward an edge and jump off. |
| Allow Roll Landing | Off, On | If this is set to On, it enables players to go into a roll when landing after a fall. |
| Allow Wall Kick | Off, On | If this is set to On, it enables players to kick off a wall. |
| Allow Wall Scramble | Off, On | If this is set to On, it enables players to jump toward a wall and climb up it for a short distance. |

## Health Settings

**Health settings** determine the player starting health and various impacts on health.

| Option | Values | Description |
| --- | --- | --- |
| Invincibility | Off, On | Setting this to On will spawn players with invincibility. |
| Starting Health Percentage | 100/% Health, Pick a percentage | Determines how much health a player has at initial spawn. |
| Max Health | 100 Health, Pick a number | Sets the maximum health a player can reach during a game. |
| Allow Health Recharge | Off, On | Health recharge lets a player regenerate over time. If set to On, the Health Recharge Delay and Health Recharge Amount settings become available. |
| Health Recharge Delay | 6.5 Seconds, Instant (0), Pick a time | This option is only available if Allow Health Recharge is set to On. If a player takes damage, this determines how long before the player starts regenerating, based on the value of Health Recharge Amount. |
| Health Recharge Amount | 1, Instant (0), Pick a number | Determines how much health is recharged per second once the Health Recharge Delay is finished. |

## Shields Settings

**Shield settings** control how shields work in the game.

| Option | Values | Description |
| --- | --- | --- |
| Max Shields | 100 Shields, Pick a number | Sets the maximum amount of shields a player can have. |
| Allow Shield Recharge | Off, On | Shield recharge lets player shields regenerate over time. If set to On, you can also set Shield Recharge Delay and Shield Recharge Amount. |
| Shield Recharge Delay | 6.5 Seconds, Instant (0), Pick a time | If a player's shield takes damage, this determines how long before the shield starts regenerating, based on the Shield Recharge Amount. |
| Shield Recharge Amount | 1, Instant (0), Pick a number | Determines how much shield health is recharged per second once the Shield Recharge Delay is finished. |
| Allow Overshield | Off, On | Determines whether the Overshield is available. Overshield is an additional shield that protects players from damage. If this is set to On, the Overshield Max, Overshield Recharge Delay, and Overshield Recharge Rate settings become available. |
| Overshield Max | 50, Pick a number | Determines the maximum amount of Overshield a player can have. |
| Overshield Recharge Delay | 6.5 Seconds, Instant (0), Pick a time | If a player's overshield takes damage, this determines how long before the shield starts regenerating, based on the Shield Recharge Amount. |
| Overshield Recharge Rate | 1, Pick a number | Determines how much overshield health is recharged per second once the Shield Recharge Delay is finished. |

## Self Damage Settings

**Self damage settings** define the damage players can suffer based on their own actions.

| Option | Values | Description |
| --- | --- | --- |
| Self-Damage Only on Non-Zero Damage | No, Yes | Determines whether the player must inflict non-zero damage to something else before taking on self-damage. |
| Self-Damage Only on Target Filter | All, Non-Players, Players Only | Specifies which targets cause self-damage on collision. |
| Self-Damage Weapon Filter | All, Pickaxe Only, Melee Only, Ranged Only | Determines the types of weapons that can inflict self-damage. |

## Pickups Settings

**Pickups settings** define what types of pickups are allowed, and when.

| Option | Values | Description |
| --- | --- | --- |
| Auto Pickup Ammo | Default, No, Yes, Auto Only | This determines whether ammo pickups are automatic. Yes means the pickup requires no interaction other than proximity to the ammo. No means the player must take an action to pick up the ammo. Auto Only means that the interaction is hidden in the UI. |
| Auto Pickup Items | Default, No, Yes, Auto Only | This determines whether item pickups are automatic. Yes means the pickup requires no interaction other than proximity to the item. No means the player must take an action to pick up the item. Auto Only means that the interaction is hidden in the UI. |
| Auto Pickup Traps | Default, No, Yes, Auto Only | This determines whether trap pickups are automatic. Yes means the pickup requires no interaction other than proximity to the trap. No means the player must take an action to pick up the trap. Auto Only means that the interaction is hidden in the UI. |
| Auto Pickup Weapons | Default, No, Yes, Auto Only | This determines whether weapons pickups are automatic. Yes means the pickup requires no interaction other than proximity to the weapon. No means the player must take an action to pick up the weapon. Auto Only means that the interaction is hidden in the UI. |
| Auto Pickup World Resources | Default, No, Yes, Auto Only | This determines whether world resources (wood, stone, and so on) pickups are automatic. Yes means the pickup requires no interaction other than proximity to the resource. No means the player must take an action to pick up the resource. Auto Only means that the interaction is hidden in the UI. |

## Build Mode Settings

Use **build mode settings** to determine whether your game will support building, and if it does, refine the parameters of building limits.

| Option | Values | Description |
| --- | --- | --- |
| Allowed to Edit | Default, Anyone | Defines who is allowed to change player-build structures. Default means that players can only edit their own builds. |
| Building Can Destroy Environment | Yes, No | Determines whether any player-built structures can destroy the environment if they overlap. |
| Player Built Wood Structure Health Multiplier | 1.0X, Pick a number | Applies a health multiplier for any player-built structures made of wood. You can only access this option if None is not selected under Allow Building above. |
| Player Built Stone Structure Health Multiplier | 1.0X, Pick a number | Applies a health multiplier for any player-built structures made of stone. You can only access this option if None is not selected under Allow Building above. |
| Player Built Metal Structure Health Multiplier | 1.0X, Pick a number | Applies a health multiplier for any player-built structures made of metal. You can only access this option if None is not selected under Allow Building above. |
| Keep Player Built Structures Between Rounds | Off, On | Set this option to On to keep player-built structures from one round to the next. Otherwise, they will be removed at the start of each round. |

## Inventory Settings

Inventory items are found under the **Content** tab, sorted by categories like **Prefabs**, **Galleries**, and **Devices**.

**Inventory** is those items players are [equipped](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#equip) with [in-game](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#in-game), such as weapons and [items](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary). Use these settings to expand or restrict what items a player can equip.

In Fortnite, inventory items are found under the **Content** tab, sorted by categories like **Prefabs**, **Galleries**, and **Devices**.

| Option | Values | Description |
| --- | --- | --- |
| No Cooldowns After Use | On, Off | If this is set to On, players have no cooldowns for weapons, abilities and items during the game. This does not affect cooldowns prevented by the No Cooldowns After Swap option. |
| No Cooldowns After Swap | On, Off | If this is set to On, players have no cooldown after swapping weapons or items during the game. And example of the cooldowns prevented is the short cooldown when players swap from one shotgun to another shotgun. |
| Infinite Consumables | Off, On | If you set this to On, players will have an infinite quantity of consumable items are available in-game. Examples of consumable items are grenades, health items, shield items, traps and so on. |
| Maximum Building Resources | 500, Pick a number | This limits the amount of resources a player can carry at one time to use for building. |
| Infinite Building Resources | On, Off | As with items above, If you set this to On, players will have an infinite quantity of building materials available in-game. |
| Infinite Gold | On, Off | Determines whether players have infinite gold during the game. |
| Infinite World Resources | On, Off | Determines whether players have infinite world resources during the game. |
| Infinite Reserve Ammo | Off, On | If this to On, players will have an infinite amount of reserve ammo during the game. |
| Infinite Magazine Ammo | Off, On | If this to On, players will have an infinite amount of magazine ammo during the game. |
| Infinite Charges | Off, On | Determines whether players have infinite charges for weapons and abilities during the game. |
| Infinite Reserve Energy | Off, On | For weapons and abilities that use energy, this determines whether players have infinite reserve energy for weapons during the game. |
| Infinite Loaded Energy | Off, On | For weapons and abilities that use energy, this determines whether players have infinite loaded energy for weapons during the game. |
| Infinite Durability | On, Off | Determines whether weapons and items have infinite durability during the game. |
| Allow Item Drop | Yes, No | Determines whether players can drop items from their inventory in-game. |
| Maximum Equipment Slots | Don't Override, None, Pick a number of slots | Sets the maximum number of equipment slots a player has in-game. |
| Display Empty Ammo Slots | On, Off | Determines whether empty ammo slots show up in a player's inventory. |

## Equipment Settings

**Equipment settings** control player interactions with various tools and weapons.

| Option | Values | Description |
| --- | --- | --- |
| Pickaxe Damage | On, Off | Determines whether players can inflict damage to each other with their pickaxe. |
| Pickaxe Range Multiplier | Default, Medium, Large | This modifies the distance at which a pickaxe can inflict damage. |
| Start with Pickaxe | Yes, No | Determines if players start the game with or without a pickaxe. |
| Disable Harvest Slot | False, True | Determines whether the harvest slot will be visible and selectable. |
| Weapon Destruction | 100/%, None, Percentage | This setting is only available if the Weapon Destruction option is set to Percentage. This determines the percentage of damage a weapon does to the environment and buildings. |
| Weapon Destruction Percentage | Pick a percentage | Modifies the amount of damage dealt by percentage amount if Weapon Destruction is set to Percentage. |
| Pickaxe Destruction | None, Default, Instant | Modify the damage a pickaxe does to the environment and buildings. |
| Environment Damage | All, Player Built Only, Off | Determines whether players can inflict damage on the environment in-game. |
| Enable Fire | Yes, No | Determines whether weapons that use fire can set structures on fire. |
| Structure Damage | All, Self Built, Team Built, Enemy Built, Enemy and Self Built, None | Determines which structures players can damage based on who built them. |
| Impulse on Hit | True, False | **ONLY AVAILABLE IN UEFN:** Determines whether weapons generate an impulse on physical objects. |
