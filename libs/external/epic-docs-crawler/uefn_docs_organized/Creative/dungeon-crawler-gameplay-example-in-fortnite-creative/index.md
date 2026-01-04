# Dungeon Crawler Example

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/dungeon-crawler-gameplay-example-in-fortnite-creative
> **爬取时间**: 2025-12-27T00:28:50.856752

---

[![Dungeon Crawler Gameplay Example in Fortnite Creative](https://dev.epicgames.com/community/api/documentation/image/41c475c7-29f9-4304-8515-c1c582e3f0d2?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/41c475c7-29f9-4304-8515-c1c582e3f0d2?resizing_type=fit)

This example demonstrates how the Score Managers are used not just for scoring, but also to manage events in a game.

*Dungeon Crawler Video*

## Ingredients

**You will need:**

- **5 x [Score Manager devices](https://dev.epicgames.com/documentation/en-us/fortnite/using-score-manager-devices-in-fortnite-creative)**
- **4 x [Class Designer devices](https://dev.epicgames.com/documentation/en-us/fortnite/using-class-designer-devices-in-fortnite-creative)**
- **3 x [Class Selector devices](https://dev.epicgames.com/documentation/en-us/fortnite/using-class-selector-devices-in-fortnite-creative)**
- **8 x [Trigger devices](https://dev.epicgames.com/documentation/en-us/fortnite/using-trigger-devices-in-fortnite-creative)**
- **4 x [Lock devices](https://dev.epicgames.com/documentation/en-us/fortnite/using-lock-devices-in-fortnite-creative)**
- **5 x [HUD Message devices](https://dev.epicgames.com/documentation/en-us/fortnite/using-hud-message-devices-in-fortnite-creative)**
- **5 x [Creature Manager devices](https://dev.epicgames.com/documentation/en-us/fortnite/using-creature-manager-devices-in-fortnite-creative)**
- **20 x [Creature Placer devices](https://dev.epicgames.com/documentation/en-us/fortnite/using-creature-placer-devices-in-fortnite-creative)**
- **4 x [Button devices](https://dev.epicgames.com/documentation/en-us/fortnite/using-button-devices-in-fortnite-creative)**
- **1 x [Team Settings and Inventory Device](https://dev.epicgames.com/documentation/en-us/fortnite/using-team-settings-and-inventory-devices-in-fortnite-creative)**

## Method

There are five zones in this game. The player starts off with a common assault rifle, which gets upgraded as the player progresses in the game. More challenging monsters are encountered as each zone in the dungeon is unlocked. This playthrough culminates in a final boss encounter, which concludes when the boss is eliminated.

### Class Designer Device Options

Since the plan is to switch the player’s weapons upon the completion of each zone, you need to use four **Class Designers**, which represent our four **zones**. There isn’t much to set up. Make sure each of the Class Designers have a unique **Class Identifier,** with four different weapon loadouts.

### Class Selector Device Options

We will use three Class Selectors since the player is going to switch class three times. The player starts off with a default class, which you specify in the **Default Class Identifier** option located in **My Island > Game**. Assign a unique Class Identifier to the **Class To Switch To** option for each of the Class Selectors.

- Class switching will be done remotely and triggered by a specific Score Manager. For each of the three Class Selectors, set the **Change Player to Class when Receiving From** option to **channels 1, 2 and 3** respectively.
- At the same time, class switching is also used to enable and disable specific Score Managers. Set the **When Class Switched Transmit On** option to **channels 4, 5 and 6** respectively.

### Score Manager Device Options

Three different functional uses are demonstrated here with the five Score Managers.

#### Score Manager Devices 1, 2 and 3

- These give the player a score when a creature is eliminated.

  - Set the **Activate When Receiving From** option to **channels 11, 12 and 13** respectively.
  - Set the **Score Value** option to **1, 2 and 3**.
- There are five **Creature Placers** associated with each Score Manager device in their respective zones. As such, these devices can only be triggered five times before we do something.

  - Set the **Times Can Trigger** option to **5** for each device.
- Once all five creatures have been eliminated, you want to unlock a door to give the player access to the next zone, change the player's loadout (class switch), and prepare a trigger device to spawn the next group of creatures.

  - Set the **On Max Triggers Transmit To** option to **channels 1, 2 and 3** respectively.
- When a player switches classes upon completing a zone, the Score Managers associated with the zones are no longer needed and the next set of Score Managers should be enabled.

  - Set the **Disable When Receiving From** option to **channels 4, 5 and 6** respectively.
  - For devices 2 and 3, set the **Enable When Receiving From** option to **channels 4 and 5** respectively.
  - For devices 2 and 3, set the **Enabled During Phase** option to **None**.

#### Score Manager Device 4

For this device, you will use the score output to trigger other devices.

- Start with a base score for killing a creature in this zone.

  - Set the **Score Value** option to **4**.
- Increase the score awarded by 1 for subsequent creature eliminations.

  - Set the **Score Increment** option to 1.
- Once the Score Manager increases its Score Value to a specific value, you want to transmit a signal to a Lock Device to unlock a door, then display a HUD message and enable a Trigger.

  - Set the **On Score Output Transmit To** option to **channel 7**.
- Since there are only four creatures in this specific zone, the increment will happen three times so that a Score of 7 will be awarded when the final creature is eliminated.

  - Set the **Transmit on Score** option to **7**.
- The other settings are similar to the ones for Devices 1, 2 and 3.

  - Set the **Activate When Receiving From** option to **channel 14**.
  - Set the **Enable When Receiving From** option to **channel 6**.
  - Set the **Disable When Receiving From** option to **channel 19**.

#### Score Manager Device 5

This device is not going to award any score to the player. This is going to be used as a counter for the spawning of the final boss.

- The player will cross four Triggers and activate four Buttons before the final boss is spawned.

  - Set the **Times Can Trigger** option to **8**.
- This is done by incrementing the device when either the Trigger or Button sends a signal through a specific channel.

  - Set the **Increment when Receiving From** option to **channel 9**.
- Once this device has been triggered eight times, it sends a signal to spawn the final boss.

  - Set the **On Max Triggers Transmit To** option to **channel 10**.

### Lock Device Device Options

The Lock devices are attached to any Door objects to facilitate the locking and unlocking of doors based on Triggers. We use these devices to gate a player's access to the next zone, and they stay locked unless all creatures in the current zone are eliminated.

- You want the doors to be locked by default and unlocked when a signal is received.

  - Set the **Unlock when Receiving From** option to **channels 1, 2, 3 and 7** respectively.

### Trigger Device Options

Triggers are devices that are used to relay signals to other devices. For this example, we want the Triggers to do two things:

- Enable the spawning of creatures when the player triggers the device.
- Add to the Score Manager counter (Device 5) to facilitate the spawning of the final boss.

Four of the Triggers will be placed in the game world, right at the door of the next zone so that they are triggered by the player when they walk through the door. The other four are placed somewhere where the player will have no access to them. They are triggered remotely.

- Each device should only be triggered once.

  - Set the **Times Can Trigger** option to **1** for all eight devices.
- All of them should be invisible to the player.

  - Set the **Visible in Game** option to **No**.

#### Trigger Devices 1 to 4

- Place each device in front of the doors in the play area. They should all be disabled by default, and enabled when the player eliminates all creatures in the current zone.

  - Set the **Enabled on Game Start** option to **Disabled**.
  - Set the **Enable When Receiving From** option to **channels 1, 2, 3 and 7**.
- When the player triggers the device, you want to transmit a signal to the Creature Placers to spawn creatures, tell a non-player-facing Trigger device to signal the Score Manager to increment its counter, and enable the Buttons in the final zone for the last Trigger device.

  - Set the **When Triggered Transmit On** option to **channels 16, 17, 18 and 19** respectively.

#### Trigger Devices 5 to 8

- Place these in a location that the player cannot interact with. They act as interfaces between the first four Triggers and the Score Manager counter.

  - Set the **Trigger when Receiving From** option to **channels 16, 17, 18 and 19**.
  - Set the **When Triggered Transmit On** option to **channel 9**.

### Creature Manager Device Options

Five different types of creatures will be introduced. You can decide what type of creatures you want for each zone, and for the final boss. You can also set the creatures to have whatever health you want.

- Scoring is driven entirely by the Score Managers. Because of this you don't want creature elimination to award any default scores.

  - Set the **Score** option to **None**.

### Creature Placer Device Options

The system only allows up to 20 Creature Placers in the game world. So place five creatures in zones 1, 2 and 3. Then place four creatures in zone 4, and place 1 final creature (the boss) in zone 5.

- The Creature Placer send signals to the Score Manager to award score points when the creature is eliminated

  - Set the **When Eliminated Transmit On** option to **channels 11, 12, 13 and 14** to signal Creature Placers in zones 1, 2, 3 and 4 respectively. For the final boss, set it to **channel 8**. This signal will inform the Team Settings & Inventory device to end the game.
- The Creature Placers will spawn when the player steps onto a Trigger, which happens when they walk through the door. This applies only to zones 2, 3 and 4.

  - Set the **Spawn When Receiving From** option to **channels 16, 17 and 18** to signal Creature Placers in zones 2, 3 and 4 respectively. For the final boss, set it to **channel 10**. This specific signal is sent by the fifth Score Manager device when it reaches a specific trigger count.
- The Creature Placers in zone 1 are spawned immediately when the game starts.

  - Set the **Activate on Game Phase** option to **Game Start** for creatures in zone 1. Set it to **Never** for creatures in all the other zones.

### Button Device Options

The Buttons are not required, but they were deliberately added to this example to demonstrate how the Score Manager can be used as a counter, by listening to signals from multiple sources. You should place four buttons against the wall in the final zone.

- Each button should only be triggered once.

  - Set the **Times Can Trigger** option to **1**.
- As a precautionary measure, the player should never be able to interact with the buttons until they walk through the door to the final zone.

  - Set the **Enabled At Game Start** option to **Disabled**.
  - Set the **Enable When Receiving From** option to **channel 19**. This signal is sent by a Trigger.
- When the button is interacted with, a signal is sent to the Score Manager.

  - Set the **When Interacted With Transmit On** option to **channel 9**.

### Team Settings and Inventory Device Options

This device's main purpose is to end the game when the final boss is eliminated. You could also use the Round Settings device for this too.

- Set the **End Round When Receiving From** option to **channel 8**. This signal is sent by the Creature Placer when the final boss is eliminated.
