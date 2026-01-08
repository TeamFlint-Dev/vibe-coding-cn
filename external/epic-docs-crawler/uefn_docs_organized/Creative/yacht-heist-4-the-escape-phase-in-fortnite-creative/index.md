# 4. The Escape Phase

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/yacht-heist-4-the-escape-phase-in-fortnite-creative>
> **爬取时间**: 2025-12-27T02:15:26.587886

---

This section covers parts 4 and 5 marked by the blue beacons on the yacht.

[![Yacht Beacons](https://dev.epicgames.com/community/api/documentation/image/0059e35c-f633-45b3-8428-cd3318399210?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/0059e35c-f633-45b3-8428-cd3318399210?resizing_type=fit)

## Part 4 - Escape

### Jewel Beacon

This beacon guides the player towards the jewel. It is enabled when the player opens the door to the Lower deck and disabled when the player picks up the jewel.

[![Jewel Beacon](https://dev.epicgames.com/community/api/documentation/image/b14e95d7-4a34-47f7-a55f-181f57d5373e?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/b14e95d7-4a34-47f7-a55f-181f57d5373e?resizing_type=fit)

| Setting | Value | Description |
| --- | --- | --- |
| Requires Line Of Sight | Off | The player should be able to see the beacon from anywhere. |
| Beacon To Show | Badge | Use the badge style of beacon. |
| Icon Identifier | Piggy Bank | Use the Piggy Bank icon. |
| Hide HUD Icon | 500M | Only hide the icon when the player is far away. |
| Friendly Team | Neutral | All players should be able to see the beacon. |
| Enabled on Phase | None | The beacon is not automatically enabled on any phase. |

### Jewel Item Spawner

This spawns the jewel when the vault door explodes, and triggers the beginning of the Escape phase, including the start of the Escape track, when the player picks up the jewel. Register a **jewel** to this device.

[![Jewel Spawner](https://dev.epicgames.com/community/api/documentation/image/52f7bb8d-f35a-493f-95c0-d3503b5e4c3b?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/52f7bb8d-f35a-493f-95c0-d3503b5e4c3b?resizing_type=fit)

| Setting | Value | Description |
| --- | --- | --- |
| Items Respawn | Off | The jewel will only spawn once. |
| Base Visible During Game | Off | The base of the spawner will be invisible during gameplay. |
| Spawn Item on Timer | Off | The jewel will not be automatically spawned. |
| Respawn Item on Timer | Off | The jewel will not respawn. |

**Direct Event Binding**

| Event | Device | Function | Description |
| --- | --- | --- | --- |
| On Item Picked Up | \_MasterAlertSwitch | Disable | During the Escape phase, the Alert system is disabled to ensure that the Sneak Alert track isn’t accidentally triggered. |
| On Item Picked Up | \_JewelBeacon | Disable | The beacon that guided the player to the jewel is disabled. |
| On Item Picked Up | \_MusicStartSwitch | Turn On | This indicates that the player is in the Escape phase in case they are eliminated and respawn. |
| On Item Picked Up | \_EscapeHUDMessage | Show | Shows the HUD message telling the player to escape. |
| On Item Picked Up | \_EscapeBoatBeacon | Enable | Enables the beacon that guides the player to the escape boat. |
| On Item Picked Up | \_EscapeItemGranter | Grant Item | Gives the player the minigun, shotgun, and grenades for escaping the yacht. |
| On Item Picked Up | \_EscapeHealthPowerup | Pickup | Restores the player's health for the Escape phase. |
| On Item Picked Up | \_EscapeBoatTrigger | Enable | Enables the trigger on the Escape Boat which allows the player to trigger the end of the game. |
| On Item Picked Up | \_ReinforcementsTrigger, \_ReinforcementsTrigger2 | Trigger | Spawns two more guards on each of the Guard spawners. |
| On Item Picked Up | \_EscapeDrumsOnSetter, \_EscapeBassOnSetter, \_EscapeSynthOnSetter, \_TempoFastSetter | Set Value on Receive | Starts the Escape track. |
| On Item Picked Up | DamageVolume10 | Disable | Disables the damage volume that would have eliminated the player trying to jump onto the escape boat before getting the jewel. |
| On Item Picked Up | VaultExitLock | Open | Opens the door to access the rest of the yacht. |

### Escape HUD Message Device

This HUD message tells the player to escape the yacht, and is shown when the player picks up the jewel.

[![Escape HUD Message](https://dev.epicgames.com/community/api/documentation/image/bfd9f0e6-1a79-4282-853d-671454f6256f?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/bfd9f0e6-1a79-4282-853d-671454f6256f?resizing_type=fit)

| Setting | Value | Description |
| --- | --- | --- |
| Message | "They brought reinforcements! Escape the yacht in the boat off the front deck!" | This message is shown. |
| Background Opacity | 100% | The message will have an opaque background. |
| Background Color | #B38129 | The color for the background is chosen to match the gold aesthetic of the yacht. |
| Placement | Top Center | The message will appear in the top center of the screen. |
| Text Color | White | The text color for the message is white. |
| Shadow Offset | 0 | The text will not have a shadow offset. |
| Outline Strength | 0 | The text will not have an outline. |

### Escape Item Granter

When the player picks up the jewel, they are granted a minigun, shotgun, and grenades. Register the **Mythic Brutus’ Minigun**, **Mythic Striker Pump Shotgun**, and **5 Grenades** to this device.

[![Escape Item Granter](https://dev.epicgames.com/community/api/documentation/image/e875d599-1f05-4d08-a1d4-386e8e1dfead?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/e875d599-1f05-4d08-a1d4-386e8e1dfead?resizing_type=fit)

| Setting | Value | Description |
| --- | --- | --- |
| Grant | All Items | All three registered items will be granted when triggered. |
| Equip Granted Item | Yes | One of the granted items will be automatically equipped. |
| Initial Weapon Ammo | 1 | The Spawner grants 1 initial ammo. The island is set to grant infinite ammo, therefore the number is not important here. |
| Spare Weapon Ammo | 0 | The Spawner will not give bonus ammo. |

### Escape Health Powerup

When the player picks up the jewel, their health is returned to full.

[![Escape Health Powerup](https://dev.epicgames.com/community/api/documentation/image/6d7d3315-7321-4f61-a1d6-beca27ac3828?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/6d7d3315-7321-4f61-a1d6-beca27ac3828?resizing_type=fit)

| Setting | Value | Description |
| --- | --- | --- |
| Effect | Set to | The player’s health will be set to the specified value. |
| Effect Magnitude | 100 | The player’s health will be set to 100. |
| Respawn | No | The powerup will only be used once. |
| Ambient Audio | Off | The powerup will not play audio. |
| Pick Up Audio | Off | The powerup will not play audio. |

### Reinforcement Triggers

When the player picks up the jewel, these two triggers will each spawn an additional guard from each Guard Spawner.

[![reinforcement triggers](https://dev.epicgames.com/community/api/documentation/image/23af1c1b-5d92-4d16-8bdb-f3a49c6e0099?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/23af1c1b-5d92-4d16-8bdb-f3a49c6e0099?resizing_type=fit)

| Setting | Value | Description |
| --- | --- | --- |
| Trigger VFX | Off | The trigger will not play any VFX. |
| Trigger SFX | Off | The trigger will not play any SFX. |

**Direct Event Binding**

| Event | Device | Function | Description |
| --- | --- | --- | --- |
| On Triggered | \_GuardSpawner1 to 10 | Spawn | Each of the reinforcement triggers will spawn one guard on each Guard Spawner. |

## Part 5 - Game End

### Escape Boat Beacon

This beacon guides the player towards the escape boat. It is enabled when the player picks up the Jewel and stays on for the remainder of the game.

[![Escape Boat Beacon](https://dev.epicgames.com/community/api/documentation/image/cb4bcc0d-0e1c-4970-b00d-b5553cf14014?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/cb4bcc0d-0e1c-4970-b00d-b5553cf14014?resizing_type=fit)

| Setting | Value | Description |
| --- | --- | --- |
| Requires Line Of Sight | Off | The player should be able to see the beacon from anywhere. |
| Beacon To Show | Badge | Use the badge style of beacon. |
| Icon Identifier | Boat | Use the Boat icon. |
| Hide HUD Icon | 500M | Only hide the icon when the player is super far away. |
| Friendly Team | Neutral | All players should be able to see the beacon. |
| Enabled on Phase | None | The beacon is not automatically enabled on any phase. |

### Escape Boat Trigger

This trigger calls events on other devices to end the game, including stopping the Escape track.

[![Escape Boat Trigger](https://dev.epicgames.com/community/api/documentation/image/f962cec3-6c8e-4e51-84f8-ecb59b2d6ad0?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/f962cec3-6c8e-4e51-84f8-ecb59b2d6ad0?resizing_type=fit)

| Setting | Value | Description |
| --- | --- | --- |
| Visible in Game | Off | The trigger will be invisible during gameplay. |
| Enabled on Game Start | Off | The trigger will begin enabled so that the player won’t be able to end the game too early. |
| Triggered by Water | Off | The trigger will not be triggered by water. |
| Trigger Delay | 1.0 Seconds | There will be a brief delay before the game ends after the player lands on the boat. |
| Trigger VFX | Off | The trigger will not play any VFX. |
| Trigger SFX | Off | The trigger will not play any SFX. |

**Direct Event Binding**

| Event | Device | Function | Description |
| --- | --- | --- | --- |
| On Triggered | \_EscapeDrumsOffSetter, \_EscapeBassOffSetter, \_EscapeSynthOffSetter, \_TempoSlowSetter | Set Value on Receive | The Escape track is turned off. |
| On Triggered | \_EndGameSpeaker | Play | A sound effect is played to indicate the end of the game. |
| On Triggered | \_EscapeBoatPropMover | Start | The escape boat will begin to move away from the yacht. |
| On Triggered | \_EndGameDevice | Activate | The game is ended. |

### Escape Boat Prop Mover

When the player steps on the escape boat trigger, the Prop Mover begins to move the escape boat away from the yacht.

[![Escape Prop Mover](https://dev.epicgames.com/community/api/documentation/image/2a895468-cfde-4ae5-8eca-0c1481fffd02?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/2a895468-cfde-4ae5-8eca-0c1481fffd02?resizing_type=fit)

| Setting | Value | Description |
| --- | --- | --- |
| Distance | 400.0 Meters | The escape boat will continue moving through the end of the game. |
| Speed | 10.0 Meters/Second | The escape boat will move at 10 m/s. |
| On Player Collision Behavior | Continue | In case the boat movement registers the player’s position as a collision, it will not stop moving. |
| On Prop Collision Behavior | Continue | If the boat collides with any props, it will continue moving. |
| Should Move from Start | Off | The escape boat will not start moving at the beginning of the game. |

### End Game Speaker

When the player steps on the escape boat trigger, the Speaker plays a musical accent to emphasize the end of the game.

[![End Game Speaker](https://dev.epicgames.com/community/api/documentation/image/732f89c7-33d7-44e2-a93a-ca3a3f24cff8?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/732f89c7-33d7-44e2-a93a-ca3a3f24cff8?resizing_type=fit)

| Setting | Value | Description |
| --- | --- | --- |
| Audio | Accent 3 | The sound effect played will be Accent 3, a low musical hit. |
| Volume | 1.5 | The sound effect will be very obvious and noticeable. |
| Play on Hit | Off | Hitting the Speaker will not trigger the sound effect. |
| Enable Spatialization | Off | The sound effect will play exactly the same throughout the island. |
| Enable Volume Attenuation | Off | The sound effect will play equally loud throughout the island. |

### End Game Device

The end game section can give the player three different outcomes:

- If the player ends the game early, they will get a defeat screen.
- If the player gets eliminated, they will get a defeat screen.
- If the player completes the heist, they will get a success screen.

When the player steps on the escape boat trigger, the first end game device will end the game.

[![End Game Device](https://dev.epicgames.com/community/api/documentation/image/db7eea5e-fb89-4c11-9585-4553f8771559?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/db7eea5e-fb89-4c11-9585-4553f8771559?resizing_type=fit)

| Setting | Value | Description |
| --- | --- | --- |
| Custom Victory Callout | Heist completed! | This message will be shown on the victory screen. |
| Game End Callout | Cooperative | The game end will show the victory screen for all players. |
| Custom Victory Animation | You Won! | This message will be shown on the victory screen. |
| Custom Victory Animation Sub Text | You have escaped with the jewel! | This message will be shown on the victory screen. |

### End Game Device 2

If the player fails to accomplish the mission, this device will show the Failure callout at the end of the game.

| Setting | Value | Description |
| --- | --- | --- |
| Custom Defeat Callout | You Failed your objective! | This message will be shown on the defeat screen. |
| Game End Callout | Cooperative | The game end will show the defeat screen for all players. |
| Custom Victory Animation | You lose! | This message will be shown on the defeat screen. |
| Custom Victory Animation style | Shards | This animation will be shown on the defeat screen. |
| Custom Victory Animation Sub Text | Your heist has been stopped! | This message will be shown on the defeat screen. |

### Elimination Manager

This device will be activated if the player ends the game early.

[![elimination manager](https://dev.epicgames.com/community/api/documentation/image/65bf6f0d-1eef-4abe-afe1-9d3ce4c3ab30?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/65bf6f0d-1eef-4abe-afe1-9d3ce4c3ab30?resizing_type=fit)

| Setting | Value | Description |
| --- | --- | --- |
| Valid on Self Elimination | On | Self elimination triggers the elimination manager. |
| Target Type | Players only | AI will not be affected by this device. |
| Initial Movement of Item | None | Item is not tossed or falls on spawn. |
| Initial Weapon Ammo | 0 | No weapon ammo granted by elimination manager. |
