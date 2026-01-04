# 3. The Sneak Phase

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/yacht-heist-3-the-sneak-phase-in-fortnite-creative
> **爬取时间**: 2025-12-27T02:15:03.890656

---

This section covers parts 0, 1, 2, and 3, marked by the blue beacons on the yacht.

[![Yacht Beacons](https://dev.epicgames.com/community/api/documentation/image/6a80d197-6e05-40a4-a727-2a09a60ef5a1?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/6a80d197-6e05-40a4-a727-2a09a60ef5a1?resizing_type=fit)

## Part 0 - Game Start

To start, set up your Island Settings. Press the **TAB** key, and click **MY ISLAND** at the top of the screen. From here, you can access the **GAME**, **SETTINGS**, and **UI** tabs.

### Island Settings

The following unique settings should be set:

- **Game**

  - Max Players: 1
  - Time Limit: None
  - Game Start Countdown: Off
- **Settings**

  - Time of Day: 9:00 PM
  - Enable Fire: No
  - Infinite Ammo: On
  - Allow Building: None
  - Structure Damage: None
  - Start With Pickaxe: No
  - Eliminated Player’s Items: Keep
  - Respawn Time: 1 Second
- **UI**

  - HUD Info Type: AI Enemy Elimination

### Player Spawner

Spawns the player and triggers other devices to initialize the game.

[![Player Spawner](https://dev.epicgames.com/community/api/documentation/image/be50f678-03c9-41a3-a0c1-4cb95af0ce9b?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/be50f678-03c9-41a3-a0c1-4cb95af0ce9b?resizing_type=fit)

| Setting | Value | Description |
| --- | --- | --- |
| Player Team | Any | The team does not influence gameplay. |
| Visible in Game | Off | Don’t want the spawner to be visible during gameplay. |

**Direct Event Binding**

| Event | Device | Function | Description |
| --- | --- | --- | --- |
| On Player Spawned | \_GameStartTrigger | Trigger | The trigger that initializes the game on the first spawn is triggered. |
| On Player Spawned | \_MusicStartSwitch | Check State | The switch that determines what state the music is in is checked, which turns on and off the correct music tracks. |

### Damage Volumes

The Damage Volume devices are placed all around the yacht, right under the water level, and will eliminate any player that tries to jump overboard. A damage volume is placed above the escape boat to eliminate any player that tries to jump onto it before completing the heist.

[![Damage volumes](https://dev.epicgames.com/community/api/documentation/image/114ac0b8-2fb1-4891-8126-b1e9af120692?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/114ac0b8-2fb1-4891-8126-b1e9af120692?resizing_type=fit)

| Setting | Value | Description |
| --- | --- | --- |
| Zone Width | Any | Choose the size of the volume to fit your level. |
| Zone Depth | Any | Choose the size of the volume to fit your level. |
| Zone Height | Any | Choose the size of the volume to fit your level. |
| Damage Type | Elimination | Player is eliminated on contact with this device. |

### Class Designer

This device sets up the player settings and inventory. Register an **Epic Suppressed Pistol** to the device by going to the **Weapons**tab and dragging the pistol onto the **Item Granter** device.

[![Class Designer](https://dev.epicgames.com/community/api/documentation/image/6e344cdb-ce8f-4cb8-8f92-fe118faae755?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/6e344cdb-ce8f-4cb8-8f92-fe118faae755?resizing_type=fit)

| Setting | Value | Description |
| --- | --- | --- |
| Class Name | Infliltrator | The player will be the infiltrator class. |
| Class Identifier | 1 | This will be considered Class 1. |
| Grant Items on Respawn | Yes | When the player dies, they will respawn with the items. |
| Equip Granted Item | First Item | The pistol is automatically equipped. |
| Initial Weapon Ammo | 0 | The class designer will not grant ammo as the island is set up with infinite ammo. |
| Spare Weapon Ammo | 0 | The class designer will not grant spare ammo as the island is set up with infinite ammo. |
| Start with Pickaxe | No | The player will only have a pistol for this phase. |
| Allow Health Recharge | On | The player's health will recharge with time. |
| Allow Sliding | On | The player can slide. |
| Allow Slide Kick | On | The player can slide kick. |

### Music Start Switch

The state of the switch corresponds to whether the music should be in the **Sneak** or **Escape** phases. When the switch is checked, it sets the values to turn the correct tracks on and off. If the Switch is off when checked, the Sneak track will play, and if the Switch is on, the Escape track will play.

[![Music Start Switch](https://dev.epicgames.com/community/api/documentation/image/b9f96f3b-f785-46f0-83e1-104ed85886ba?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/b9f96f3b-f785-46f0-83e1-104ed85886ba?resizing_type=fit)

**Direct Event Binding**

| Event | Device | Function | Description |
| --- | --- | --- | --- |
| On Check Result On | \_EscapeDrumsOnSetter, \_EscapeBassOnSetter, \_EscapeSynthOnSetter | Set Value on Receive | These Value Setters turn on the Escape track when their values are set. |
| On Check Result On | \_SneakBaseOffSetter, \_AlertDrumsOffSetter, \_AlertBassOffSetter, \_AlertSynthOffSetter | Set Value on Receive | These Value Setters turn off the Sneak track when their values are set. |
| On Check Result Off | \_EscapeDrumsOffSetter, \_EscapeBassOffSetter, \_EscapeSynthOffSetter | Set Value on Receive | These Value Setters turn off the Escape track when their values are set. |
| On Check Result Off | \_SneakBaseOnSetter, \_AlertDrumsOffSetter, \_AlertBassOffSetter, \_AlertSynthOffSetter | Set Value on Receive | These Value Setters turn on the Sneak track when their values are set. |

### Game Start Trigger

This trigger spawns the guards at the beginning of the game.

[![Game Start Trigger](https://dev.epicgames.com/community/api/documentation/image/69c93e02-e46e-4a79-b961-ccce55ddc453?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/69c93e02-e46e-4a79-b961-ccce55ddc453?resizing_type=fit)

| Setting | Value | Description |
| --- | --- | --- |
| Activate on Game Phase | Game Start | The trigger is automatically triggered when the game begins. |
| Times Can Trigger | 1 | The trigger will only trigger once at the beginning of the game. |
| Trigger VFX | Off | The trigger won’t play VFX. |
| Trigger SFX | Off | The trigger won’t play SFX. |

**Direct Event Binding**

| Event | Device | Function | Description |
| --- | --- | --- | --- |
| On Triggered | \_GuardSpawner1-10 | Spawn | All of the guards in the island are spawned manually, so this spawns the first set at the beginning of the game. |
| On Triggered | \_KeycardBeacon | Enable | The beacon showing the player to the Keycard is enabled at the beginning of the game. |

### Skydome

The Skydome device controls the lighting and moon placement for this game.

[![skydome device](https://dev.epicgames.com/community/api/documentation/image/8f7b0606-4664-482a-b325-02888e6adc94?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/8f7b0606-4664-482a-b325-02888e6adc94?resizing_type=fit)

| Setting | Value | Description |
| --- | --- | --- |
| Light Source | Moon 2 | The heist takes place at night |
| Light Source Custom Color | #A2E5FF (light blue) | The color of the light source. |
| Light Source Intensity | 50% | Creates a night-time feeling. |
| Skydome Top Color | #000000 (black) | The color tint for the top side of the sky gradient. |
| Stars Visibility | Bright | The stars are clearly visible. |
| Volume Width | 0.2 Tiles | Width of the skydome volume |
| Volume Depth | 0.2 Tiles | Depth of the skydome volume |
| Volume Height | 0.2 Tiles | Height of the skydome volume |
| Ambient Light Intensity | 15% | Ambient light intensity of the color source. |

## Part 1 - Keycard

### Keycard HUD Message Device

This HUD Message device tells the player to get the Keycard. It is shown when the game begins.

[![Keycard HUD](https://dev.epicgames.com/community/api/documentation/image/050b079a-7297-418b-9220-6846c1bfd2c7?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/050b079a-7297-418b-9220-6846c1bfd2c7?resizing_type=fit)

| Setting | Value | Description |
| --- | --- | --- |
| Message | "Find the Keycard for the Vault override system!" | This message is shown. |
| Show on Round Start | On | The message will be shown when the game starts. |
| Time from Round Start | Instant | The message will be shown when the game starts. |
| Background Opacity | 100% | The message will have an opaque background. |
| Background Color | #B38129 | The color for the background is chosen to match the gold aesthetic of the yacht. |
| Placement | Top Center | The message will appear in the top center of the screen. |
| Text Color | White | The text color for the message is white. |

### Keycard Beacon

This beacon guides the player towards the Keycard. It is enabled when the game starts and disabled when the player picks up the Keycard.

[![Keycard Beacon](https://dev.epicgames.com/community/api/documentation/image/29c32b72-a02d-40af-9b4a-466a8436be51?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/29c32b72-a02d-40af-9b4a-466a8436be51?resizing_type=fit)

| Setting | Value | Description |
| --- | --- | --- |
| Requires Line Of Sight | Off | The player should be able to see the beacon from anywhere. |
| Beacon To Show | Badge | Use the badge style of beacon. |
| Icon Identifier | Key | Use the Key icon. |
| Hide HUD Icon | 500M | Only hide the icon when the player is super far away. |
| Friendly Team | Neutral | All players should be able to see the beacon. |
| Enabled on Phase | None | The beacon is not automatically enabled on any phase. |

Use HUD messages and beacons to make sure that the player always knows what their goal is.

### Keycard Item Spawner

This spawns the Keycard and triggers other devices when the Keycard is picked up. Register a **Rig Keycard** to this device.

[![Keycard Spawner](https://dev.epicgames.com/community/api/documentation/image/0744ed6d-c45f-4a5a-b4dd-f0e5fcba6be8?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/0744ed6d-c45f-4a5a-b4dd-f0e5fcba6be8?resizing_type=fit)

| Setting | Value | Description |
| --- | --- | --- |
| Items Respawn | Off | The Keycard will only spawn once. |
| Base Visible During Game | Off | The base will be invisible during gameplay. |
| Time Before First Spawn | Instant | The Keycard will be spawned when the game starts. |
| Respawn Items on Timer | Off | The Keycard will not respawn. |
| Initial Weapon Ammo | 1 | The Spawner only have one keycard. |
| Spare Weapon Ammo | 0 | The Spawner will not give bonus ammo. |
| Run Over Pickup | On | The player will be able to just run through the item to pick it up. |

**Direct Event Binding**

| Event | Device | Function | Description |
| --- | --- | --- | --- |
| On Items Picked Up | \_LowerDeckBeacon | Enable | The beacon guiding the player to the lower deck is enabled. |
| On Items Picked Up | \_KeycardBeacon | Disable | The beacon guiding the player to the Keycard is disabled. |
| On Items Picked Up | \_LowerDeckHUDMessage | Show | The message telling the player to go to the lower deck is shown. |

## Part 2 - Lower Deck

### Lower Deck HUD Message Device

This HUD message tells the player to go to the lower deck, and it is shown when the player picks up the Keycard.

[![lower deck HUD](https://dev.epicgames.com/community/api/documentation/image/59242833-c0fa-412a-8170-cd5bff47f5d3?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/59242833-c0fa-412a-8170-cd5bff47f5d3?resizing_type=fit)

| Setting | Value | Description |
| --- | --- | --- |
| Message | "Go to the Lower Deck!" | This message is shown. |
| Background Opacity | 100% | The message will have an opaque background. |
| Background Color | #B38129 | The color for the background is chosen to match the gold aesthetic of the Yacht. |
| Placement | Top Center | The message will appear in the top center of the screen. |
| Text Color | White | The text color for the message is white. |
| Shadow Offset | 0 | The text will not have a shadow offset. |
| Outline Strength | 0 | The text will not have an outline. |

### Lower Deck Beacon

This beacon guides the player toward the lower deck. It is enabled when the player picks up the Keycard and disabled when the player opens the door to the lower deck.

[![Lower deck Beacon](https://dev.epicgames.com/community/api/documentation/image/1e2e67ad-faf3-49af-8fdf-124335660c6f?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/1e2e67ad-faf3-49af-8fdf-124335660c6f?resizing_type=fit)

| Setting | Value | Description |
| --- | --- | --- |
| Requires Line Of Sight | Off | The player should be able to see the beacon from anywhere. |
| Beacon To Show | Badge | Use the badge style of beacon. |
| Icon Identifier | Key | Use the Key icon. |
| Hide HUD Icon | 500M | Only hide the icon when the player is far away. |
| Friendly Team | Neutral | All players should be able to see the beacon. |
| Enabled on Phase | None | The beacon is not automatically enabled on any phase. |

### Lower Deck Lock Device

This locks the door to the lower deck and unlocks it when the Conditional Button is activated using the Keycard.

[![lower deck lock](https://dev.epicgames.com/community/api/documentation/image/315cc9b3-58d8-4455-ac5e-9490a8228e97?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/315cc9b3-58d8-4455-ac5e-9490a8228e97?resizing_type=fit)

| Setting | Value | Description |
| --- | --- | --- |
| Visible During Game | Off | The lock is invisible during gameplay. |

### Lower Deck Conditional Button

This Conditional Button unlocks the door to the lower deck and triggers the enabling and disabling of beacons and the next HUD message to guide the player to the vault. Register a **Rig Keycard** to this device.

[![lower deck conditional button](https://dev.epicgames.com/community/api/documentation/image/a6f7f018-78a3-4aef-aec3-3305aab337d0?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/a6f7f018-78a3-4aef-aec3-3305aab337d0?resizing_type=fit)

| Setting | Value | Description |
| --- | --- | --- |
| Reset Delay | 1.7 seconds | After 1.7 seconds, the Conditional Button will reset. |
| Use Color for Hologram | On | The Conditional Button displays the same color as the device when it can be interacted with. |
| Interact Text | Unlock Lower Deck | This text will show when hovering on the device when the player has the Keycard. |
| Missing Items Text | Missing Keycard | This text will show when hovering on the device when the player doesn’t have the Keycard. |
| Disable After Use | On | The Conditional Button will turn off after the player interacts with it once. |
| Key Items Required | 1 | The Conditional Button requires 1 Keycard. |
| Consume Key Items | Off | The player will not lose the Keycard after interacting with the Conditional Button. |

**Direct Event Binding**

| Event | Device | Function | Description |
| --- | --- | --- | --- |
| On Activated | \_LowerDeckBeacon | Disable | The beacon guiding the player to the lower deck is disabled. |
| On Activated | \_LowerDeckLockDevice | Open | The locked door is opened. |
| On Activated | \_JewelBeacon | Enable | The beacon guiding the player to the jewel is enabled. |

## Part 3 - Vault

### Vault HUD Message Device

This HUD message tells the player to trigger the vault override, and it is shown when the player opens the door to the lower deck.

[![Vault HUD](https://dev.epicgames.com/community/api/documentation/image/2032aaa1-c935-4d8d-9ab8-e85d7a208fa2?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/2032aaa1-c935-4d8d-9ab8-e85d7a208fa2?resizing_type=fit)

| Setting | Value | Description |
| --- | --- | --- |
| Message | "Trigger the Vault Override and grab the jewel!" | This message is shown. |
| Message Recipient | All | This message is shown to players of any team or class. |
| Background Opacity | 100% | The message will have an opaque background. |
| Background Color | #B38129 | The color for the background is chosen to match the gold aesthetic of the Yacht. |
| Placement | Top Center | The message will appear in the top center of the screen. |
| Text Color | White | The text color for the message is white. |
| Shadow Offset | 0 | The text will not have a shadow offset. |
| Outline Strength | 0 | The text will not have an outline. |

### Vault Override Conditional Button

This Conditional Button triggers the countdown for the vault explosion when activated with a Keycard. Register a **Rig Keycard** to this device.

[![vault conditional button](https://dev.epicgames.com/community/api/documentation/image/214f740c-5e78-4811-a132-bd80276131cf?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/214f740c-5e78-4811-a132-bd80276131cf?resizing_type=fit)

| Setting | Value | Description |
| --- | --- | --- |
| Interact Time | 3.0 Seconds | The player must interact with the Conditional Button for 3 seconds to activate it. |
| Reset Delay | 1.7 seconds | After 1.7 seconds, the Conditional Button will reset. |
| Direct Color | Orange | The device will be orange. |
| Use Color for Hologram | On | The background on the hologram will also be orange. |
| Interact Text | Activate Vault Override | This message will show when the player hovers over the Conditional Button. |
| Disable After Use | On | The Conditional Button will turn off after the player interacts with it once. |
| Key Items Requires | 1 | The Conditional Button requires 1 Keycard. |

**Direct Event Binding**

| Event | Device | Function | Description |
| --- | --- | --- | --- |
| On Activated | VaultExitLock | Close | The lock on the door behind the player will close. |
| On Activated | \_VaultExplosionTimer | Start | The timer that triggers the vault explosion will start counting down. |

### Vault Exit Lock

This locks the door behind the player when the vault explosion countdown begins.

[![Vault Exit Lock](https://dev.epicgames.com/community/api/documentation/image/7c9b2106-e129-4145-bf35-50a55a1641ec?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/7c9b2106-e129-4145-bf35-50a55a1641ec?resizing_type=fit)

| Setting | Value | Description |
| --- | --- | --- |
| Initial Door Position | Open | The door starts out open so that the player will be able to clearly see the vault down the hallway in the lower deck. |
| Visible During Game | Off | The lock itself shouldn’t be visible during gameplay. |
| Starts Locked | Unlocked | The door will begin unlocked. |

Consider what you want the player to be able to see, and use Lock devices to open and close doors to control their line of sight. In this instance, the player should not see new guards spawning, and they should have protection for a short period before beginning the escape, so the door to the vault room is closed when the player is not likely to be looking at it.

### Vault Explosive Device

This Explosive device removes the door at the end of the countdown.

[![vault explosives](https://dev.epicgames.com/community/api/documentation/image/a5c373a4-6e9f-4e82-b2b8-5ddb631acedc?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/a5c373a4-6e9f-4e82-b2b8-5ddb631acedc?resizing_type=fit)

| Setting | Value | Description |
| --- | --- | --- |
| Can Be Damaged | Off | The Explosive device will not respond to damage. |
| Blast Radius | 0.25 Tile | The explosion radius will be 0.25 tiles |
| Player Damage | 10 | The explosion will only do a little bit of damage to the player if they are close to it. |
| Structure Damage | 5000 | The explosion will damage and destroy the vault door piece. |
| Damage Indestructible Buildings | Yes | The explosion will damage and destroy the vault door piece. |
| Visible During Game | No | The Explosive device will be invisible during gameplay. |
| Collision During Games | Off | The Explosive device will not have normal collisions during gameplay. |

### Vault Explosive Device 2

This Explosive device explodes at the end of the vault explosion countdown.

| Setting | Value | Description |
| --- | --- | --- |
| Can Be Damaged | Off | The Explosive device will not respond to damage. |
| Blast Radius | 1.0 Tile | The explosion radius will be 1 tile. |
| Player Damage | 10 | The explosion will only do a little bit of damage to the player if they are close to it. |
| Structure Damage | 0 | The explosion will not do damage structures. |
| Visible During Game | No | The Explosive device will be invisible during gameplay. |
| Collision During Games | Off | The Explosive device will not have normal collisions during gameplay. |

### Vault Explosion Timer

This timer starts when the player activates the Conditional Button, and after 5 seconds, triggers the vault to explode along with other device changes. This is when the Sneak track ends. Use timed events like this to create dramatic and memorable moments!

[![explosion timer](https://dev.epicgames.com/community/api/documentation/image/ad1dbeb3-6d3f-4eef-ae26-62c99f816794?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/ad1dbeb3-6d3f-4eef-ae26-62c99f816794?resizing_type=fit)

| Setting | Value | Description |
| --- | --- | --- |
| Duration | 5.0 Seconds | The timer will last for 5 seconds. |
| Visible During Game | All | The countdown will be visible during gameplay. |
| Timer Color | White | The timer will show as white. |
| Display Time In | Seconds Only | The timer will only show seconds. |
| Timer Running Text | "Watch out! The door is gonna blow in…" | This message is shown before the countdown on the HUD. |
| Timer Label Text Style | Bold | The message will be shown bold. |

**Direct Event Binding**

| Event | Device | Function | Description |
| --- | --- | --- | --- |
| On Success | \_VaultExplosiveDevice | Explode | After the countdown, the Explosive device will explode. |
| On Success | \_VaultExplosiveDevice2 | Explode | After the countdown, the second Explosive device will explode. |
| On Success | \_JewelItemSpawner | Spawn Item | After the countdown, the jewel is spawned inside of the vault. |
| On Success | \_SneakBaseOffSetter, \_AlertDrumsOffSetter, \_AlertBassOffSetter, \_AlertSynthOffSetter | Set Value | The Sneak Base and Sneak Alert tracks will be stopped when the vault door explodes. |
| On Success | \_EscapeSynthOnSetter, \_EscapeBassOnSetter, \_EscapeDrumsOnSetter | Enable | This enables the escape track devices. |

The music is turned off when the vault explodes and starts again when the player picks up the jewel to create a moment of silence and rest before beginning the high-energy escape sequence. This also builds some tension as the player picks up the jewel — the main objective of the heist.

## Next Section

[![4. The Escape Phase](https://dev.epicgames.com/community/api/documentation/image/be4ca3a8-7390-48a9-a22b-5e3bd4247caf?resizing_type=fit&width=640&height=640)

4. The Escape Phase

This section shows you how to set up the escape phase of the Yacht Heist.](https://dev.epicgames.com/documentation/en-us/fortnite/yacht-heist-4-the-escape-phase-in-fortnite-creative)
