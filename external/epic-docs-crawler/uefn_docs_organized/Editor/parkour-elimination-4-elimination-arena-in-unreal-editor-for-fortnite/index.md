# 4. Elimination Arena

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/parkour-elimination-4-elimination-arena-in-unreal-editor-for-fortnite>
> **爬取时间**: 2025-12-27T00:21:01.636792

---

Strap in! This section uses lots of devices that all need to work together to give players the optimal elimination experience. The arena is designed in a way that encourages players to gain a height advantage by sprinting, long jumping and mantling to the upper levels to pick off opponents from above.

## Assigning Classes

**Devices used:**

- 1 x [Class Selector](https://www.fortnite.com/creative/docs/using-class-selector-devices-in-fortnite-creative)
- 1 x [Trigger](https://dev.epicgames.com/documentation/en-us/fortnite-creative/using-trigger-devices-in-fortnite-creative)

[![class selector](https://dev.epicgames.com/community/api/documentation/image/9e690d91-8c35-4ce4-ac74-915886ea27ce?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/9e690d91-8c35-4ce4-ac74-915886ea27ce?resizing_type=fit)

When players are teleported into the arena, the **Class Selector** will change them into **Class 2**. This causes no difference to the player, but it is important for when the arena countdown finishes. When the 30-second countdown is over, a global teleport will be done for everyone who's in **Class 1**: the players who made it into the arena on their own will be unaffected.

Place the **Class Selector** in the center of the arena, underneath the future location of the teleporters, and configure the **User Options** as follows:

| Option | Value | Explanation |
| --- | --- | --- |
| **Class to Switch To** | Class Slot: 2 | The Class ID that the player will be switched to. |
| **Size of Volume** | 5.0 Meters | A volume broad enough to catch anyone who teleports into the main arena. |
| **Time To Switch** | 0.0 | There is no delay in switching class. |
| **Volume Visible In Game** | False | The volume VFX cannot be seen in gameplay. |
| **Visible During Game** | False | The base of the Class Selector is not visible during gameplay. |
| **Activation Audio** | False | No SFX are made when the class is changed. |
| **Zone Audio** | False | No SFX are made for entering the zone. |
| **Display VFX On Activation** | False | There is no visual element played on characters for swapping teams. |

**Trigger #4**

Trigger #4 delays the activation of the class selector to avoid players that teleport in too quickly to change classes.

This trigger prevents the Class Selector from shutting off for a period during which someone who has been eliminated can respawn and teleport in; otherwise, it's possible to have unfortunate timing and be unable to change classes, resulting in the player being teleported to the same spot every 2 seconds for the entire match. A delay of 10 seconds should safely cover the maximum time it takes to be eliminated, respawn, and teleport to fall on the Class Selector. Configure the device's **User Options** as follows:

| Option | Value | Explanation |
| --- | --- | --- |
| Trigger Delay | 10.0 | 10 seconds leaves enough time for even a worst-case situation to give time to change classes. |
| Trigger SFX | False | Not used in gameplay. |
| Trigger VFX | False | Not used in gameplay. |
| Visible In Game | False | This device is not visible during gameplay. |

**Direct Event Binding**

| Device A | Function | Device B | Event | Explanation |
| --- | --- | --- | --- | --- |
| **Class Selector**  [class selector](https://dev.epicgames.com/community/api/documentation/image/33997daf-ff5e-45df-a737-cccad2c4d7fb?resizing_type=fit) | Disable | **Trigger #4**  [trigger device](https://dev.epicgames.com/community/api/documentation/image/cfd63958-d2cb-478c-a859-4e01f1533fe4?resizing_type=fit) | On Triggered | Disables the Class Selector when the trigger is activated. |

## Teleporting Players to the Elimination Arena

**Devices used:**

- 4 x [Player Reference](https://www.fortnite.com/creative/docs/using-player-reference-devices-in-fortnite-creative)
- 5 x Teleporter
- 1 x [Mutator Zone](https://www.fortnite.com/creative/docs/using-mutator-zone-devices-in-fortnite-creative)
- 1 x [Campfire](https://www.fortnite.com/creative/docs/using-campfire-devices-in-fortnite-creative)

**Player Reference #1 to #4**

[![player reference](https://dev.epicgames.com/community/api/documentation/image/eb74e529-3b9b-4a79-aa1b-49671834e257?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/eb74e529-3b9b-4a79-aa1b-49671834e257?resizing_type=fit)

These are intermediary devices. At the start of the game, they store a player ID so that when the 30-second timer runs out, all remaining players will be teleported regardless of where they are in the race.

These devices interact with two other device types: the four teleporters in the arena, and the Player Spawners that initially broadcast when a player enters the game. Set up the Player Reference devices as follows:

| Option | Value | Explanation |
| --- | --- | --- |
| **Visible in Game** | False | The Player Reference devices are not visible in game. |
| **Play Audio** | False | The Player Reference Devices do not play any audio when registering or activated. |

[![teleporters](https://dev.epicgames.com/community/api/documentation/image/5a9cbab1-1fc7-49b9-ad73-713e2e05ef1f?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/5a9cbab1-1fc7-49b9-ad73-713e2e05ef1f?resizing_type=fit)

**Teleporter #7** is for players who make the final jump in the parkour race. **Teleporters #8 to #11** teleport anyone who fails to get through the race. All of them are set up so they drop players directly onto the **Class Selector**.

**Teleporter #7**

| Option | Value | Explanation |
| --- | --- | --- |
| **Teleport Target Group** | Group None | Entering this teleporter does not go anywhere, it is for destinations only. |
| **Teleporter Rift Visible** | False | The teleporter rift is not visible in game. |
| **Play Visual Effects** | False | Visual effects of the teleporter are not played. |
| **Play Sound Effects** | False | SFX for the use of the teleporter are not played. |
| **Conserve Momentum** | False | Players are dropped from a standing height and will not take damage from the momentum of their fall getting into Teleporter #6. |

**Teleporter #8 to #11**

| Option | Value | Explanation |
| --- | --- | --- |
| **Teleporter Group** | Group None | These have no target destination and are for destinations only. |
| **Teleport Target Group** | None | Entering this teleporter does not go anywhere, it is for destinations only. |
| **Teleporter Rift Visible** | False | The teleporter rift is not visible in game. |
| **Play Visual Effects** | False | Visual effects of the teleporter are not played. |
| **Play Sound Effects** | False | SFX for the use of the teleporter are not played. |
| **Conserve Momentum** | False | Players are dropped from a standing height and will not take damage from the momentum of their fall getting into Teleporter #6. |
| **Selected Class** | Class Slot: 1 | The Class ID of the players who can be teleported. This is removed by jumping through Teleporter #6 and entering the Main Arena, so anyone still attempting the parkour portion during the final countdown will be affected. |

**Mutator Zone #1**

[![mutator](https://dev.epicgames.com/community/api/documentation/image/f2496a5d-478e-4e1c-bdf0-bb64c767181a?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/f2496a5d-478e-4e1c-bdf0-bb64c767181a?resizing_type=fit)

The **Mutator Zone #1** is what's used to teleport everyone to the main combat arena once the timer expires. This can be placed anywhere on ground level, but needs to be below the lava so its volume takes in everything.

| Option | Value | Explanation |
| --- | --- | --- |
| **Zone Width** | 100 | Can be infinitely wide to take in the whole structure. |
| **Zone Depth** | 100 | Can be infinitely deep to take in the whole structure. |
| **Zone Height** | 13 | Just shy of entering the top combat arena, leaving it out of the zone. Height will depend on your own parkour area design. |
| **Enabled on Phase** | None | By default, this is not active until it is activated. |

**Campfire #1**

[![campfire](https://dev.epicgames.com/community/api/documentation/image/88d0d59c-2209-4a16-8d0e-242e306ca24f?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/88d0d59c-2209-4a16-8d0e-242e306ca24f?resizing_type=fit)

This campfire is a backup in case the Mutator Zone #1 teleportation does not work, to make sure it's not possible to be left behind forever.

| Option | Value | Explanation |
| --- | --- | --- |
| **Pulse Interval** | "2.0": 2 Seconds | Every 2 seconds, the campfire sends out a healing pulse. |

**Direct Event Binding**

| Device A | Function | Device B | Event | Explanation |
| --- | --- | --- | --- | --- |
| **Player Reference #1 to #4**  [player reference](https://dev.epicgames.com/community/api/documentation/image/8ef0a7c3-f7ae-4c83-830c-6679c1472273?resizing_type=fit) | Register Player | **Player Spawner #1 to #4**  [spawn pad](https://dev.epicgames.com/community/api/documentation/image/1c88e79c-1ee3-41aa-86b0-da6f2777618f?resizing_type=fit) | On Player Spawned | When each player spawns, they will be assigned a player reference device. This will store the player ID as an instigator in the reference devices, so if another device calls on this one to activate, it will use that stored player. |
| **Player Reference #1 to #4**  [player reference](https://dev.epicgames.com/community/api/documentation/image/bf9134b0-d1e3-4b6e-bb00-a98e0e6800a4?resizing_type=fit) | Activate | **Mutator Zone #1**  [Mutator Zone](https://dev.epicgames.com/community/api/documentation/image/45e369af-aa2e-46bd-acc1-7d42bfd69fbb?resizing_type=fit) | On Player Entering Zone | If a player is still in the parkour section when the timer expires, the Mutator Zone will send a signal which will prompt it to send ALL players on the map to the arena. There is a check for this so people who cleared the parkour won't be affected. |
| **Teleporter #8 to #11**  [Teleporter](https://dev.epicgames.com/community/api/documentation/image/4a6c36b8-f6c9-4c75-9cb3-a5fd43d139a9?resizing_type=fit) | Teleport | **Player Reference #1 to #4**  [player reference](https://dev.epicgames.com/community/api/documentation/image/e696df3e-1b6c-47f0-a87a-311f07158aa8?resizing_type=fit) | On Activated | Multiple players can clog up a teleporter and break functionality, so the cleanest method is to have one for each player. This set up only teleports the player with a Class ID 1, so anyone who is Class ID 2 will be unaffected. |
| **Player Reference #1 to #4**  [player reference](https://dev.epicgames.com/community/api/documentation/image/8501d957-c29c-41be-a929-96bf17229602?resizing_type=fit) | Activate | **Campfire**  [Campfire](https://dev.epicgames.com/community/api/documentation/image/e72c7c00-90b3-4dd0-b284-26a6898897ab?resizing_type=fit) | On Campfire Pulse | Every 2 seconds, it will again attempt to teleport everyone who is not Class ID 2; anyone who might have gotten stuck or otherwise bypassed the Mutator Zone will still be teleported as a result, and will fall onto the Class Selector to turn into Class 2 and stop being teleported. |

## 30-Second Countdown

Devices used:

- 1 x Mutator Zone
- 1 x HUD Message
- 2 x Trigger
- 1 x [Timed Objective](https://www.fortnite.com/creative/docs/using-timed-objective-devices-in-fortnite-creative)

**Mutator Zone #2**

The arena mutator zone has only one job: **to prevent weapons from firing before the 30 seconds are up**. It should be wide and deep enough for the whole arena, and as high as desired, since it needs to encompass the entire area.

Find and place the Mutator Zone #2. By default, mutator zones stop you from firing your weapon, which is why you won't see that setting below. Configure the **User Options** as follows:

| Option | Value | Explanation |
| --- | --- | --- |
| **Zone Width** | 5 | Enough to fill the arena. |
| **Zone Depth** | 5 | Enough to fill the arena. |
| **Zone Height** | 13 | Enough to fill the arena. |
| **Enabled on Phase** | Always | The Mutator Zone is always active during any gameplay. |

[![Trigger and HUD](https://dev.epicgames.com/community/api/documentation/image/6565e579-bb17-4577-a802-ca7116ae1bea?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/6565e579-bb17-4577-a802-ca7116ae1bea?resizing_type=fit)

**Trigger #5** and **HUD Message #5** have one function: when someone walks through **Teleporter #6** at the end of the parkour race, Trigger #5 is set off and begins the 30-second countdown. HUD Message #5 will send a message to any players who finish the parkour race, informing them to buy a weapon. Anyone unceremoniously teleported inside when the countdown ends will have to figure it out on their own.

Find and place Trigger #5 and HUD Message #5 on top of the player spawn area, and configure their **User Options** as follows:

**Trigger #5**

| Option | Value | Explanation |
| --- | --- | --- |
| **Trigger SFX** | False | Makes no sound in gameplay. |
| **Trigger VFX** | False | Makes no visual effect in gameplay. |
| **Visible In Game** | False | Is invisible during normal gameplay. |

**HUD Messenger #5**

| Option | Value | Explanation |
| --- | --- | --- |
| **Message** | Buy the best weapon! No firing until timer elapses... | The message sent from the device. |
| **Show on Round Start** | False | Does not automatically send a message a predetermined time after the round starts. |
| **Show for Duration** | False | Message remains on the HUD until receiving a signal to deactivate it. |
| **Priority** | False | Will be overwritten if there's any additional triggers somehow as a safeguard. |

**Trigger #6**

This a buffer to make sure the end arena routine can only happen a single time. This is done by making it only able to be activated a single time, and passing on the signal elsewhere. Configure the **User Options** as follows:

| Option | Value | Explanation |
| --- | --- | --- |
| **Times Can Trigger** | 1 | This can only be triggered a single time. |
| **Trigger SFX** | False | No sound when triggered. |
| **Trigger VFX** | False | No VFX when triggered. |
| **Visible In Game** | False | Is invisible during gameplay. |

**Timed Objective**

This device sends the final signal to set the elimination portion of gameplay going. It is activated by Trigger #6. Place the device on top of the starting area and configure the **User Options** as follows:

| Option | Value | Explanation |
| --- | --- | --- |
| **Time** | 30.0 | Duration of the timer. |
| **Timer Label Text** | Battle Starts In… | The display on the HUD during the timer countdown. |
| **Visible During Game** | False | The device is not visible during the game. |

**Direct Event Binding**

| Device A | Function | Device B | Event | Explanation |
| --- | --- | --- | --- | --- |
| **Trigger #5**  [trigger device](https://dev.epicgames.com/community/api/documentation/image/93c48e35-d553-4b60-9600-0e9bab1ac953?resizing_type=fit) | Trigger | **Teleporter #6**  [Teleporter](https://dev.epicgames.com/community/api/documentation/image/2af43c6a-0765-4809-8012-d92f33cb459d?resizing_type=fit) | On Entered | When jumping through Teleporter #6, the instigator is carried into it and can pass on a second command. |
| **HUD Message #5**  [hud message](https://dev.epicgames.com/community/api/documentation/image/438afcb4-554b-4710-8cb3-bdb53860aab9?resizing_type=fit) | Show | **Trigger #5**  [trigger device](https://dev.epicgames.com/community/api/documentation/image/a7e4c0cb-e152-4add-8292-97b968c551b4?resizing_type=fit) | On Triggered | Provides players instructions upon first entering the elimination arena. |
| **HUD Message #5**  [hud message](https://dev.epicgames.com/community/api/documentation/image/94ffe525-9b2a-47a8-8068-21a28f430212?resizing_type=fit) | Hide | **Timed Objective**  [Timed Objective](https://dev.epicgames.com/community/api/documentation/image/45db08cf-0999-461a-aa42-3ed97706ce00?resizing_type=fit) | On Completed | When the countdown is finished the message will disappear. |
| **Trigger #6**  [trigger device](https://dev.epicgames.com/community/api/documentation/image/d465d3e5-01e5-4826-b53a-9e543cc9a4bb?resizing_type=fit) | Trigger | **Teleporter #6**  [Teleporter](https://dev.epicgames.com/community/api/documentation/image/0898993c-0294-400b-88d7-2b5f1c03e164?resizing_type=fit) | On Entered | Begins the chain of events leading to the end of the parkour race and transitioning to the arena! |
| **Timed Objective**  [Timed Objective](https://dev.epicgames.com/community/api/documentation/image/70d86fb8-8d30-42e1-a9bc-79b98d2809a0?resizing_type=fit) | Start | **Trigger #6**  [trigger device](https://dev.epicgames.com/community/api/documentation/image/89b81642-1fd8-4762-a2ff-e2fc19f2c74e?resizing_type=fit) | On Triggered | Starts the countdown once the first player lands on Trigger #6. |
| **Mutator Zone #1**  [Mutator Zone](https://dev.epicgames.com/community/api/documentation/image/2064460d-1470-4838-804f-9264d7956147?resizing_type=fit) | Disable | **Timed Objective**  [Timed Objective](https://dev.epicgames.com/community/api/documentation/image/cdcd375d-7466-49ca-8bdd-f446002e8df9?resizing_type=fit) | On Completed | Once the timer finishes, this Mutator Zone is turned on and encompasses the entire parkour arena. |
| **Mutator Zone #2**  [Mutator Zone](https://dev.epicgames.com/community/api/documentation/image/5bff4667-d0e5-4502-ad59-649def214942?resizing_type=fit) | Disable | **Timed Objective**  [Timed Objective](https://dev.epicgames.com/community/api/documentation/image/bcec1a8b-6897-4622-a729-5c946253c60c?resizing_type=fit) | On Completed | When the countdown is completed, players will be allowed to use their equipped weapons. |
| **Player Spawner #1 to #4**  [spawn pad](https://dev.epicgames.com/community/api/documentation/image/8e187a5f-7d9c-4a5d-a468-63ba292d1bee?resizing_type=fit) | Disable | **Timed Objective**  [Timed Objective](https://dev.epicgames.com/community/api/documentation/image/bac589a3-ad9b-4f30-89c2-00174664982d?resizing_type=fit) | On Completed | This disables the Spawn Pads so future eliminations will take place at the main combat arena. |
| **Player Checkpoint**  [Player Checkpoint](https://dev.epicgames.com/community/api/documentation/image/0f4aed55-9a81-48db-821e-21c6f59224f0?resizing_type=fit) | Disable | **Timed Objective**  [Timed Objective](https://dev.epicgames.com/community/api/documentation/image/c690b23c-da9a-45ab-ae8a-a79719f5fa59?resizing_type=fit) | On Completed | When the 30-second timer ends, it will disable Player Checkpoints so that future eliminations spawn in the Secondary Player Spawn Pads in the elimination arena side rooms. |
| **Trigger #4**  [trigger device](https://dev.epicgames.com/community/api/documentation/image/a63b2f1a-b02b-4637-a00d-4b1db615d712?resizing_type=fit) | Trigger | **Timed Objective**  [Timed Objective](https://dev.epicgames.com/community/api/documentation/image/6b9e8adb-b42d-4a80-b3a7-09d18000cb5b?resizing_type=fit) | On Completed | When everything else is disabled, this starts the 10-second timer before turning off the Class Designer. |
| **Campfire**  [Campfire](https://dev.epicgames.com/community/api/documentation/image/98304bb6-6720-4550-aeb8-48fcbd923174?resizing_type=fit) | Light | **Timed Objective**  [Timed Objective](https://dev.epicgames.com/community/api/documentation/image/b3af6857-9ac2-4d77-9283-9eaeb43956f1?resizing_type=fit) | On Completed | When the countdown expires, the campfire is lit and will begin to pulse. |

## Granting Weapons to Players

**Devices used:**

- 4 x [Vending Machine](https://www.fortnite.com/creative/docs/using-vending-machine-devices-in-fortnite-creative)
- 4 x [Conditional Button](https://www.fortnite.com/creative/docs/using-conditional-button-devices-in-fortnite-creative)
- 4 x [Item Granter](https://www.fortnite.com/creative/docs/using-item-granter-devices-in-fortnite-creative)

[![weapons granting](https://dev.epicgames.com/community/api/documentation/image/229ae06b-732e-4e16-aa05-4c279bf6c60d?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/229ae06b-732e-4e16-aa05-4c279bf6c60d?resizing_type=fit)

Players that teleport into the arena will need to spend the coin they collected at the start of the game to buy a weapon. The conditional button will grant the actual weapon, but the vending machine is used to show the player what they are getting.

**Vending Machine #1 to #4**

All four **Vending Machine** devices have identical settings. Choose a visible location for the first one and configure the **User Options** as follows:

| Option | Value | Explanation |
| --- | --- | --- |
| **First Item Resource Type** | Metal | The cost in resources to purchase from the vending machine. |
| **Cost Of First Item** | 999 | This is intentionally impossible to buy, as you must use the button to purchase. Register a weapon of differing rarities to each vending machine that will match the one you intend to get; in my case I used Striker shotguns. |

**Conditional Button #1 to #4**

Each **Conditional Button** device has a single gold coin registered as the cost. Place the button in front of the first vending machine and configure the **User Options** as follows for the Legendary weapon, the rest just need to be duplicated with different rarities or types of weapons.

| Option | Value | Explanation |
| --- | --- | --- |
| **Disable After Use** | True | Once you buy something from it, the button is disabled and nobody else can use it. This makes it so only one weapon can be bought per person. |

**Item Granter #1 to #4**

The **Item Granter** devices communicate with the Conditional Buttons to grant players one of the four available weapons. In **Item List**, press **+** to add the type of weapon you want players to get. Expand **Index**, then search for the weapon. The granter will have the following **User Options**:

| Option | Value | Explanation |
| --- | --- | --- |
| **On-Grant Action** | Keep All | No changes are made to the player's inventory upon being granted. |
| **Equip Granted Item** | True | Automatically equips the shotgun when it is granted by the conditional button. |

**Direct Event Binding**

| Device A | Function | Device B | Event | Explanation |
| --- | --- | --- | --- | --- |
| **Item Granter #1 to #4**  [Item Granter](https://dev.epicgames.com/community/api/documentation/image/9f616e7b-454d-4d6b-bfed-4a0ef5c51def?resizing_type=fit) | Grant Item | **Trigger #1 to #3**  [trigger device](https://dev.epicgames.com/community/api/documentation/image/5fbbf788-06ee-4964-879b-8dcda9db250e?resizing_type=fit) | On Triggered | Upon spending the coin and using the Conditional Button in front of the vending machine, it disables itself and grants the shotgun. |

## Elimination Arena Spawn Protection

**Devices used:**

- 4 x Lock (4)
- 8 x Trigger (8)
- 4 x Player Spawner

[![Elimination arena spawn](https://dev.epicgames.com/community/api/documentation/image/8a4441ba-89b0-4089-b381-5b8abd129b54?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/8a4441ba-89b0-4089-b381-5b8abd129b54?resizing_type=fit)

Here is one of the four elimination arena spawn rooms: each has a Lock, two Triggers, and a Player Spawn Pad.

**Lock #4 to #7**

Will interact with two triggers. This is done so that doors automatically open and close without player intervention and prevent others from sneaking inside to spawn camp. By default the doors are locked, so you won't see a setting for that in the lock device.

| Option | Value | Explanation |
| --- | --- | --- |
| **Visible During Game** | False | The lock is not visible during gameplay. |

**Trigger #7 to #10**

These triggers are set directly in front of the closed doors, so approaching them will trigger and open it. It's set to a 2-second delay, meaning the door will open for 2 seconds before closing again.

| Option | Value | Explanation |
| --- | --- | --- |
| **Reset Delay** | "2.0": 2 seconds | Time that must pass before the trigger can be activated again. |
| **Trigger SFX** | False | No sound is made on activation in gameplay. |
| **Trigger VFX** | False | No VFX is done on activation in gameplay. |
| **Visible In Game** | False | The trigger is not visible in game. |

**Trigger #11 to #14**

These triggers piggyback off the signal sent to open the door, and after a delay will send one to close and lock it again before everything resets. They can be anywhere on the island to work as no contact is required. They were put in the spawn rooms to keep things simple.

| Option | Value | Explanation |
| --- | --- | --- |
| **Triggered By Player** | False | The player cannot activate this device, only another device can. |
| **Delay** | "2.0": 2 seconds | The time between receiving a signal and sending one out; this is the same as the reset delay of its paired trigger. |
| **Reset Delay** | "2.0": 2 seconds | Time that must pass before the trigger can be activated again. |
| **Trigger SFX** | False | No sound is made on activation in gameplay. |
| **Trigger VFX** | False | No VFX is done on activation in gameplay. |
| **Visible In Game** | False | The trigger is not visible in game. |

**Player Spawn Pad #5 to #8**

These spawn pads are set to secondary so they only work when the primary ones are disabled by the end of the countdown.

| Option | Value | Explanation |
| --- | --- | --- |
| **Priority Group** | 2 | Is not used in the game unless nothing of higher priority exists to spawn players. |
| **Visible During Game** | False | The spawn pad base is not visible in game. |

**Direct Event Binding**

| Device A | Function | Device B | Event | Explanation |
| --- | --- | --- | --- | --- |
| **Lock #1 to #3**  [lock device](https://dev.epicgames.com/community/api/documentation/image/522a8f7a-6dbc-4bc4-a362-363024007b69?resizing_type=fit) | Unlock + Open | **Trigger #7 to #10**  [trigger device](https://dev.epicgames.com/community/api/documentation/image/85f09f17-d8b6-45bb-978e-d41a7edf77ce?resizing_type=fit) | On Triggered | When stepping on the trigger in front of the door, it will send a signal to open and unlock. |
| **Trigger #7 to #10**  [trigger device](https://dev.epicgames.com/community/api/documentation/image/2cb522a6-fd2b-40e3-b848-cd23df7e81d2?resizing_type=fit) | Trigger | **Trigger #11 to #14**  [trigger device](https://dev.epicgames.com/community/api/documentation/image/606aab8c-f15c-4faa-9ba8-8b8c63c27518?resizing_type=fit) | On Triggered | Shuts the door after the delay. |
| **Lock #1 to #3**  [lock device](https://dev.epicgames.com/community/api/documentation/image/20beb63d-3bb6-4e15-8f57-1f8341d0e578?resizing_type=fit) | Lock + Close | **Trigger #11 to #14**  [trigger device](https://dev.epicgames.com/community/api/documentation/image/da3d52fa-08dc-45ac-899c-61ee023ad7a7?resizing_type=fit) | On Triggered | After the two-second delay, this sends the signal to close and lock the door to the paired Lock device. |

## Playtesting your Island

You did it!

Once everything is set up and ready to go, [playtest your island](playtesting-your-island-unreal-editor-for-fortnite) to make sure that it runs as expected in Fortnite.

To **Publish** your project, see the [Publishing Projects](publishing-projects-in-unreal-editor-for-fortnite) page.
