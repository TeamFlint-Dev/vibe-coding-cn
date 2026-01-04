# 34.30 Fortnite Ecosystem Updates and Release Notes

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/34-30-fortnite-ecosystem-updates-and-release-notes
> **爬取时间**: 2025-12-27T00:33:55.510210

---

The v34.30 update gives more control over matchmaking queues. Negan from The Walking Dead Universe arrives as an NPC, teaming up with players to fight Walkers, which now have customizable behavior.

A new tutorial teaches you how to create animated timers in UEFN.

Other additions include Fencing Fields Prefabs and Galleries, OG Weapons like the Zapotron and Guided Missile, and updates to devices like the Item Spawner and Reboot Van.

## Creator Queue Controls MVP

Creators can now adjust how matchmaking queues behave. The Matchmaking Server (MMS) creates these queues when a party chooses to play an island in a public match and there is not an existing game session they can join. If, at any point, the number of players being sought is achieved, then the queue is flushed and the players in the queue are sent to the new game session. If the queue exists for too long and an acceptable queue has not been collected, then the queue will be canceled rather than starting a session that cannot properly function.

Matchmaking queues have 2 phases:

- **Main phase** - If the queue fills for a full session then players are sent to a new match. If a match has not been made by the end of the main phase then the queue enters an Overtime phase.
- **Overtime phase** - During the overtime phase a lower number of players can be targeted to attempt to get a satisfactory session started rather than canceling the queue. If, at the end of the queue's overtime phase, we have not reached the Minimum Players, the queue will be canceled. Otherwise, we will proceed into the match with the current queue.

New island settings have been added to enable creators to customize their queue:

- **Queue Main Duration**
- **Overtime Player Target**
- **Minimum Players**
- **Queue Overtime Duration**

The result is that creators now have the ability to control thresholds for their games. The base goal is always to prefer fuller matches, but, if a game has a very meaningful population point at which the island hits a better gameplay experience, then creators can use that as the Overtime Player Target, and fall back to that after a short wait for Max Players.  Then, in cases where that fails, a fallback to a minimum player count occurs.

### Private Match Exception

Since parties form their own match lobby, and launch the session themselves, these queue controls are not used for Private Matchmakes.

## The Walking Dead Universe

### Fight Walkers with Negan at your side!

Negan is now available as a character in the NPC Spawner. Fight side by side to take down Walkers with his best girl, Lucille, or with the Shiva Shotgun - which now has a flashlight, making it extra useful in those dark spaces.

[![](https://dev.epicgames.com/community/api/documentation/image/e24e1912-5a32-4c9f-b0e3-10137636becb?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/e24e1912-5a32-4c9f-b0e3-10137636becb?resizing_type=fit)

Walkers now do more damage to each other if they’re on different teams, and they’ve had several cosmetic and animation upgrades to make them an even more interesting enemy. Remember that you can configure Walkers to behave in a variety of ways to make them fit your island’s gameplay!

Want to know more? The [Configuring Walkers page](https://dev.epicgames.com/documentation/uefn/twdu-configuring-walker-npcs-in-unreal-editor-for-fortnite) documents how to change the look, feel, and behavior of Walkers, and the [Walker NPC Template doc](https://dev.epicgames.com/documentation/uefn/twdu-walker-npc-template-in-unreal-editor-for-fortnite) explains how to level up your [level design](https://dev.epicgames.com/documentation/uefn/the-walking-dead-universe-level-design-in-unreal-editor-for-fortnite) to get the most out of your [hero weapons](https://dev.epicgames.com/documentation/uefn/the-walking-dead-universe-weapons-in-unreal-editor-for-fortnite).

Remember! You’ll be able to publish your The Walking Dead Universe islands starting May 16 via the Creator Portal. Release the horde of Walkers, and let players fight their way through your unique environments.

## Rift Point Volume Device Updates

Play a special animation, or a sound cue when players enter and exit the volume, or create custom events that can only be created with the use of the new Verse functions.

- **Entered****and **E******xit Events** - 
  An event that happens when a player enters or exits the rift.

**New Verse Functions:**

- **GetAgentsInVolume** - 
  A function that searches for Players in the volume.
- **IsAgentInVolume** - 
   A function that checks whether Players have entered the volume.

## Item Spawner Device Updates

True dual weapons can now have their secondary initial and spare ammo counts customized.  This allows creators to customize the new Pump & Dump weapon the same as they can existing weapons.

- **Initial Secondary Weapon Ammo** - The amount of ammunition already loaded in the secondary dual wield weapon when granted (clamped to weapon's magazine size)
- **Spare Secondary Weapon Ammo** - The amount of spare ammunition for the secondary weapon added to the player's inventory when a dual wield weapon is granted. If default, will provide ammo based on the ammo type if the player does not currently have any ammo of that type.

## Reboot Van Device Updates

Creators can utilize the new Reboot Card Purchasing feature from Battle Royale.  The device accepts any type of resource to suit a wide variety of use cases.  The required resource can be set by dropping the resource item onto the ground next to the device.

**New Options**

- **Can Purchase Reboot Card** - Determines if players can purchase an eliminated player’s reboot card.
- **Cost To Purchase Reboot Card** - Determines how much of the set currency it costs to purchase an eliminated player’s reboot card.
- **Can Purchase Expired Reboot Card** - Determines if players can purchase a reboot card when the timer has expired.

**New Event**

- **On Reboot Card Purchased** - Fires when a player purchases a Reboot Card.

## New OG Weapons

- Zapotron
- Guided Missile
- Dragon's Breath Shotgun

## New Prefabs & Galleries

- Added 4 New **Fencing Fields Prefabs:**

  - Fencing Fields Diner
  - Fencing Fields Factory
  - Fencing Fields Warehouse
  - Fencing Fields Mansion
- Added 5 New **Fencing Fields Galleries:**

  - Fencing Fields Floor Gallery
  - Fencing Fields Roof Gallery
  - Fencing Fields Wall Gallery
  - Fencing Fields Prop Gallery
  - Fencing Fields Nature Gallery

## Animated Timer UI Tutorial in UEFN

[![](https://dev.epicgames.com/community/api/documentation/image/9c32c942-066e-4ccb-a31e-4c2fd123d2c0?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/9c32c942-066e-4ccb-a31e-4c2fd123d2c0?resizing_type=fit)

Learn how to create your own custom animated timer in UEFN. Make your racing games feel more engaging with a pulsing timer as the clock runs out, or apply the pressure to a free for all island with a clock face that changes color to warn players their time is almost up.

See the [Making an Animated Timer](https://dev.epicgames.com/documentation/en-us/uefn/making-an-animated-timer-in-unreal-editor-for-fortnite) document for more information.

## Scene Events in Scene Graph

[![](https://dev.epicgames.com/community/api/documentation/image/f3c8cb77-0f9b-417b-9872-d80e0368e93f?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/f3c8cb77-0f9b-417b-9872-d80e0368e93f?resizing_type=fit)

Scene events are communication protocols that provide a way for different parts of a Scene Graph to talk to one another. Multiple components can respond to a scene event, and events can be sent up or down the hierarchy. It might be helpful to imagine a scene event as messages you can pass across the Scene Graph, giving each component an opportunity to respond to the message.

See the new document, [Scene Events](https://dev.epicgames.com/documentation//uefn/scene-events-in-unreal-editor-for-fortnite), to learn more about using and creating scene events. Follow along with the tutorial to better understand how scene events can be used to modify component behavior, or create a complex string of events in the scene.

## ICYMI: Discover Performance Snapshot for Fortnite Creators

You can now get a personalized view of your Fortnite island's Discover performance. Once your island surpasses 5,000 daily impressions in Discover, the Discover Performance Snapshot will be available in your Publishing tab the next day. This snapshot provides key engagement and attraction metrics that influence your island’s discoverability, helping you spot trends and identify areas to optimize.

For more information and to check out other recent improvements to Creator Portal, check out [the blog](https://create.fortnite.com/news/get-a-personalized-view-of-your-fortnite-island-s-discover-performance).

## Community Bug Fixes

The following fixes are from issues that you submitted to us on the forums. Thank you for your patience and for reporting these issues!

- Fixed an issue where Physical Materials such as Lava and Ice were not behaving as expected.
- [Forum Report](https://forums.unrealengine.com/t/lava-tile-stopped-continuous-bouncing-after-the-recent-update/2385571)
- Fixed an issue where 'Fortnite cell snapping' settings were not saving between sessions.
- [Forum Report](https://forums.unrealengine.com/t/fortnite-cell-snapping-re-enables-itself-when-launching-uefn/2364744)
- Fixed an issue where the NPC Spawner's Agent did not work as a damage function instigator.
- [Forum Report](https://forums.unrealengine.com/t/npc-spawners-agent-does-not-work-as-a-damage-function-instigator/1881914)

## Fortnite Ecosystem Updates and Fixes

**Fixes:**

- Fixed a material issue with Alien Trees making them reflect bright light.
- Fixed the issue where copied Earth Sprites would not display their item pool.
- Fixed an issue where the Bank Vault and Armored Transport would sometimes not display a progress bar if activated too quickly after starting the game or resetting the vault.

- Fixed an issue where surfaces such as lava and ice fail to react properly to players landing on them. Players are now damaged and bounce.

## Brand Island Updates and Fixes

### LEGO

**New:**

- Multiplayer Previewing has been added to LEGO Islands! Use Minifigure NPC's to playtest your island!
- New tool tip text for LEGO collectible objects that reads,  "Choose what color of stud you want your collectible to be!"

### The Walking Dead Universe

**New:**

- Add new TWDU ambient sound cues for creators.

**Fixes:**

- Removed the audio file named "Zombie" from the TWDU audio files.

### Fall Guys Islands

- Multiplayer Previewing is now available on Fall Guys islands.

## UEFN Updates and Fixes

**New:**

- Improved visualization with a new collision mesh count metric to track unique collisions.
- All validation issues (both sentry and asset) are now reported under the "UEFN Validation" section of the Message Log.

**Fixes:**

- Fixed a validation error related to opening the Patchwork Music Manager in older projects.

- Fixed a validation error related to enabling "Spawn Wind FX" on tree props.

### Animation and Cinematics

**Fixes:**

- Fixed three issues related to Sequencer:

  - Added missing Key Interpolation options in the Keys right-click menu.
  - Bindings would not update with the added actors when using Binding Properties in the right-click menu.
  - Binding labels would not update when updating bindings with Assign Actor > Add Selected, or Replace with Selected.

### Environments and Landscapes

**Fixes:**

- Fixed a crash state related to undoing landscape creation.
- Fixed the bug preventing Fortnite Cell Snap state from saving between sessions.

### Materials

**Fixes:**

- Fixed a bug triggered by copying, pasting, then deleting collapsed material nodes. These actions would cause the Input and Output pin base expressions to linger in the material graph. There is no solution in place to fix materials affected by this issue and they will need to be recreated.

### Modeling

**New:**

- The new default CollisionMode option is now set to SimpleAndComplex.

## Verse Updates and Fixes

### Verse Language

**Fixes:**

- Fixed an issue where interfaces created in Verse that use concrete classes did not support enforcing default fields.

  - If the code doesn't compile due to this error, then either do not make the class concrete, or add an override of the data field in the class with a default value.

### Tools

**Fixes:**

- Fixed a bug where Verse code compiles regardless of errors reported in VS Code.
