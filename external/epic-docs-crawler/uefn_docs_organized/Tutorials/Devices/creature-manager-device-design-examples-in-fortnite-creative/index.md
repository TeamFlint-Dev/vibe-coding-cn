# Creature Manager Device Design Examples

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/creature-manager-device-design-examples-in-fortnite-creative
> **爬取时间**: 2025-12-26T23:07:59.715811

---

Learn a few tricks for using the Creature Manager to add dimension to your gameplay!

## Basic Custom Creature

The **Creature Manager**, at its most basic level, is a way to create creatures with unique stats. In this first example, you’ll make Fiend enemies move much faster than normal!

### Devices Used

- 1 x [Creature Manager](https://dev.epicgames.com/documentation/en-us/fortnite/using-creature-manager-devices-in-fortnite-creative) device
- 1 x [Player Spawner](https://dev.epicgames.com/documentation/en-us/fortnite/using-player-spawn-pad-devices-in-fortnite-creative) device
- 1 x [Item Granter](https://dev.epicgames.com/documentation/en-us/fortnite/using-item-granter-devices-in-fortnite-creative) device
- 1 x [Creature Spawner](https://dev.epicgames.com/documentation/en-us/fortnite/using-creature-spawner-devices-in-fortnite-creative) device

### Set Up the Devices

By itself, this device does nothing. To spawn unique creatures, pair a Creature Manager device with a Creature Spawner or Creature Placer device.

For more general info on devices, see [Using Devices](https://dev.epicgames.com/documentation/en-us/fortnite/using-devices-in-fortnite).

1. Place a **Player Spawner** device.
2. Place an **Item Granter** device and register a **Tactical Assault Rifle** to it.

   See the [Fortnite Weapons Primer](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-weapons-primer) for how to register items.
3. Customize the Devices as follows:

   [![](https://dev.epicgames.com/community/api/documentation/image/5f4a9394-d41b-44b2-8609-58910d893591?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/5f4a9394-d41b-44b2-8609-58910d893591?resizing_type=fit)

   | Option | Value | Description |
   | --- | --- | --- |
   | **Receiving Players** | All | All players will receive the registered weapon. |
   | **grant on Game Start** | On | Players will get the weapon registered to this device at the start of the game. |
4. Place a **Creature Manager** device.
5. Customize the device as follows:

   [![](https://dev.epicgames.com/community/api/documentation/image/3f539e2a-287d-4ca8-a3e6-bbb0351c98f5?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/3f539e2a-287d-4ca8-a3e6-bbb0351c98f5?resizing_type=fit)

   | Option | Value | Description |
   | --- | --- | --- |
   | **Movement Speed** | Very Fast | The creature's speed will give your players a challenge! |
6. Place a Creature Spawner device.
7. Customize the device as follows:

   [![](https://dev.epicgames.com/community/api/documentation/image/8aa7fb0f-b59c-4307-aff9-93264d52c568?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/8aa7fb0f-b59c-4307-aff9-93264d52c568?resizing_type=fit)

   | Option | Value | Description |
   | --- | --- | --- |
   | **Creature Type** | Fiend | Select this creature type (or any other type that appeals to you!). |

You now have the basic functionality for a custom creature!

### Design Tip

Creature movement speed is a great way to give a creature a different feel from its default configurations. Faster creatures feel more threatening than slower ones, but sometimes a slower movement speed is exactly what you need for a big, lumbering creature!

## Heavy Boss

The Creature Manager device is also very useful for tweaking a creature's health. In this example, you'll raise the health of a Major Ice Brute to make it into a formidable boss!

### Devices Used

- 1 x **Creature Manager** device
- 1 x **Player Spawner** device
- 1 x [Volume](https://dev.epicgames.com/documentation/en-us/fortnite/using-volume-devices-in-fortnite-creative) device
- 1 x [Timer](https://dev.epicgames.com/documentation/en-us/fortnite/using-timer-devices-in-fortnite-creative) device
- 1 x [Automated Turret](https://dev.epicgames.com/documentation/en-us/fortnite/using-automated-turret-devices-in-fortnite-creative) device
- 1 x [Heavy Turret](https://dev.epicgames.com/documentation/en-us/fortnite/using-heavy-turret-devices-in-fortnite-creative) device

### Set Up the Devices

1. Start with the **Arctic Island** starter island.

   For how to find this island, see Building Your First Island.
2. Create a small structure for the player with assets from the **Ice House Gallery** and **Ice and Snow Castle Floor Gallery**.

   See [Using Prefabs and Galleries](https://dev.epicgames.com/documentation/en-us/fortnite/using-prefabs-and-galleries-in-fortnite-creative) for more info.
3. Place a **Player Spawner** device on top of the structure.
4. Customize the player spawner as follows:

   [![](https://dev.epicgames.com/community/api/documentation/image/3b464736-a8ec-48cc-8522-199b7b84c96e?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/3b464736-a8ec-48cc-8522-199b7b84c96e?resizing_type=fit)

   | Option | Value | Description |
   | --- | --- | --- |
   | **Visible in Game** | Off | This hides the player spawner once the game starts. |
5. Place an Item Granter device, then register a Tactical Assault Rifle to the device.
6. Customize the item granter as follows:

   [![](https://dev.epicgames.com/community/api/documentation/image/f762fd7c-2723-4c19-9f9c-37cce750ca52?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/f762fd7c-2723-4c19-9f9c-37cce750ca52?resizing_type=fit)

   | Option | Value | Description |
   | --- | --- | --- |
   | **Receiving Players** | All | All players can receive the registered weapon. |
   | **Spare Weapon Ammo** | 999 | This setting provides enough ammo that it's unlikely the player will run out. |
   | **Grant on Game Start** | On | Players will receive the weapon at the start of the game. |
7. Place a **Creature Manager** device.
8. Customize the device as follows:

   [![](https://dev.epicgames.com/community/api/documentation/image/9fe8034f-7d42-4a60-83d1-0b9e82f083f6?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/9fe8034f-7d42-4a60-83d1-0b9e82f083f6?resizing_type=fit)

   | Option | Value | Description |
   | --- | --- | --- |
   | **Creature Type** | Major Ice Brute | This will give you a good boss creature. |
   | **Health** | 3,000 | This much health takes a lot of work to eliminate this formidable boss. |
9. Place a Creature Placer device away from the structure,
10. Customize the device as follows:

    [![](https://dev.epicgames.com/community/api/documentation/image/8204baec-384e-4abf-a2ad-976a25e1a293?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/8204baec-384e-4abf-a2ad-976a25e1a293?resizing_type=fit)

    | Option | Value | Description |
    | --- | --- | --- |
    | **Creature Type** | Major Ice Brute | This matches the Creature Manager device setting. |
11. Place an **Automated Turret** device on top of the structure to help the player fight the boss.
12. Customize the turret as follows:

    [![](https://dev.epicgames.com/community/api/documentation/image/58f30898-1680-4aaa-bb9a-6da686bd77fd?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/58f30898-1680-4aaa-bb9a-6da686bd77fd?resizing_type=fit)

    | Option | Value | Description |
    | --- | --- | --- |
    | **Can Target Players** | False | This prevents the turrent from being used on other players. |
13. Place a Heavy Turret device on top of the structure to give the player even more firepower.

You now have the basic functionality for a Heavy Boss!

### Design Tip

The Creature Manager can help when you want a specific enemy to match your environment but need more control over their balancing. There is a different high-health creature (the Megabrute), but using the Creature Manager, you can use a creature that feels more authentic to the arctic environment!

## Build a Brute Rush Game!

You can use multiple creature managers for the same creature type to create the effect of creatures getting stronger in different phases of the game.

In this example, you'll use this functionality to create a wave survival game where brutes get more dangerous on each wave.

### Devices Used

- 3 x **Creature Manager** devices
- 1 x **Player Spawner** device
- 1 x **Item Granter** device
- 3 x [Creature Spawner](https://dev.epicgames.com/documentation/en-us/fortnite/using-creature-spawner-devices-in-fortnite-creative) devices
- 3 x [Trigger](https://dev.epicgames.com/documentation/en-us/fortnite/using-trigger-devices-in-fortnite-creative) devices
- 3 x [HUD Message](https://dev.epicgames.com/documentation/en-us/fortnite/using-hud-message-devices-in-fortnite-creative) device
- 1 x [End Game](https://dev.epicgames.com/documentation/en-us/fortnite/using-end-game-devices-in-fortnite-creative) device
- 1 x [**Post Processing**](using-post-processing-devices-in-fortnite-creative) device

### Set Up the Basic Gameplay

1. Begin with the **Black Glass Island** starter island.
2. Place a **Player Spawner** device.
3. Customize the player spawner as follows:

   [![](https://dev.epicgames.com/community/api/documentation/image/39b7931a-ad5a-480f-b7ee-e3996f9fd144?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/39b7931a-ad5a-480f-b7ee-e3996f9fd144?resizing_type=fit)

   |  |  |  |  |  |  |  |
   | --- | --- | --- | --- | --- | --- | --- |
   | Option | Value | Description |  | --- | --- | --- |
   | **Visible in Game** | Off | The player spawner will not be visible once the game starts. |  |  |  |  |
4. Place an **Item Granter** device and register a **Tactical Assault Rifle** to the device.
5. Customize the device as follows:

   [![](https://dev.epicgames.com/community/api/documentation/image/9765c5b1-a554-444f-92aa-e7190d9fcc7c?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/9765c5b1-a554-444f-92aa-e7190d9fcc7c?resizing_type=fit)

   | Option | Value | Description |
   | --- | --- | --- |
   | **Receiving Players** | All | All players can receive the registered weapon. |
   | **Spare Weapon Ammo** | 999 | This setting provides enough ammo that it's unlikely the player will run out. |
   | **Grant on Game Start** | On | Players will receive the weapon at the start of the game. |

### Configure the Different Waves

1. Place a **Creature Spawner** device at a distance in front of the player spawner, and name it **Wave 1 Creature Spawner**.
2. Customize the this device as follows:

   [![](https://dev.epicgames.com/community/api/documentation/image/1c20dfca-771e-45e2-b48d-cbd37f0512a4?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/1c20dfca-771e-45e2-b48d-cbd37f0512a4?resizing_type=fit)

   Plus:

   (w:600)

   | Option | Value | Description |
   | --- | --- | --- |
   | **Creature Type** | Brute | The creature that will spawn each time. |
   | **Limit Spawned Creatures** | Yes | Creatures do not spawn indefinitely. |
   | **Total Spawn Limit** | 3 | How many times this wave can respawn. |
   | **Activation Range** | 15.0 Tiles | This means the spawner will trigger when a player gets within 15 tiles.. |
   | **Spawner Visibility** | Off | Players can't see the spawner's location. |
   | **Spawn Effects Visibility** | Off | Players will see visual effects when a creature spawns. |
   | **Max Spawn Distance** | 4.0 Tiles | Sets the maximum distance a creature can span from the spawner. |
   | **Preferred Spawn Location** | Random | Creatures will spawn in random locations, adding tension to the play. |
3. Duplicate the Creature Spawner device two more times for **Waves 2** and **3**, and name them accordingly so you can keep track of how you're using them.

   Using consistent naming conventions makes the rest of this setup much easier!
4. For the **Wave 2 Creature Spawner**, set **Number of Creatures** to **3** and **Total Spawn Limit** to **4**. Also set **Enabled at Game Start** to **Off**.
5. For the **Wave 3 Creature Spawner**, set **Number of Creatures** to **4** (the default value) and **Total Spawn Limit** to **5** and set **Enabled at Game Start** to **Off**.
6. Place a **Creature Manager** device to set the **Brute** stats for **Wave 1**.
7. Customize the device as follows:

   [![](https://dev.epicgames.com/community/api/documentation/image/1e07877a-93ac-4f53-bbd9-58bea9f4bd5b?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/1e07877a-93ac-4f53-bbd9-58bea9f4bd5b?resizing_type=fit)

   | Option | Value | Description |
   | --- | --- | --- |
   | **Creature Type** | Brute | The creature that will spawn each time. |
   | **Health** | 200 | Setting the health this high makes eliminating the Brute a challenge! |
   | **Score** | 10 | This determines the amount of score a player earns when eliminating a creature. |
   | **Damage to Player** | 10.0 | This is the amount of damage the creature can inflict on a player. |
   | **Movement Speed** | Slow | Slow down the speed this creature moves at. |
8. Place another Creature Manager device to set the Brute stats during Wave 2.
9. Customize it as follows:

   [![](https://dev.epicgames.com/community/api/documentation/image/a6626759-7352-4ec9-9368-badb8b6e8b8e?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/a6626759-7352-4ec9-9368-badb8b6e8b8e?resizing_type=fit)

   | Option | Value | Description |
   | --- | --- | --- |
   | **Creature Type** | Brute | The creature that will spawn each time. |
   | **Health** | 300 | Setting the health this high makes eliminating the Brute a challenge! |
   | **Score** | 25 | This determines the amount of score a player earns when eliminating a creature. |
   | **Damage to Player** | 25.0 | This is the amount of damage the creature can inflict on a player. |
   | **Enabled On Game Start** | Off | You don't want the second wave to start until it's triggered. |

   Note that in this wave, the creature's health increases, along with score for eliminating and Damage to player. Also, you're not slowing the creature down on this wave, but using the default speed, which is in the middle.
10. Place a final Creature Manager to set the Brute stats for Wave 3, and customize:

    [![](https://dev.epicgames.com/community/api/documentation/image/a4376ca8-c791-487d-848e-5b7e43ab988b?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/a4376ca8-c791-487d-848e-5b7e43ab988b?resizing_type=fit)

    | Option | Value | Description |
    | --- | --- | --- |
    | **Creature Type** | Brute | The creature that will spawn each time. |
    | **Health** | 400 | Setting the health this high makes eliminating the Brute a challenge! |
    | **Score** | 50 | This determines the amount of score a player earns when eliminating a creature. |
    | **Damage to Player** | 40.0 | This is the amount of damage the creature can inflict on a player. |
    | **Moveement Speed** | Fast | How quickly the creature moves once spawned. |
    | **Enabled On Game Start** | Off | You don't want the second wave to start until it's triggered. |

    Now the creatures have even more health, wreak even more damage, and are moving fast!
11. Place a **Trigger** device to count the number of Brutes the player needs to eliminate during Wave 1.
12. Customize the device:

    [![](https://dev.epicgames.com/community/api/documentation/image/9f718542-80e2-4dbe-ac95-6a6bdde44530?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/9f718542-80e2-4dbe-ac95-6a6bdde44530?resizing_type=fit)

    | Option | Value | Description |
    | --- | --- | --- |
    | **Visible in Game** | Off | No need for the player to see this in-game. |
    | **Triggered by Player** | Off | This will be triggered by another device, as explained shortly. |
    | **Trigger VFX** | Off | No visual effects needed. |
    | **Trigger SFX** | Off | No sound effects needed either. |
    | **Transmit Every X Triggers** | 3 | Sets how many times the trigger needs to be activated before it does something. |
13. Duplicate the trigger two more times for Waves 2 and 3. For the **Wave 2 Trigger**, set **Transmit Every X Triggers** to **4**. For the **Wave 3 Trigger**, set the **Transmit Every X Triggers** to **5**.
14. Place a **HUD Message** device to tell the player that Wave 1 has begun.
15. Customize the HUD Message device as follows:

    [![](https://dev.epicgames.com/community/api/documentation/image/6b84d2bf-101a-40d6-a67f-20df2687f179?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/6b84d2bf-101a-40d6-a67f-20df2687f179?resizing_type=fit)

    | Option | Value | Description |
    | --- | --- | --- |
    | **Message** | Wave 1 | Gives the player a heads up that the first wave of attacks is starting. |
    | **Show on Round Start** | On | Show at the start of the round. |
    | **Time from Round Start** | Instant | Starts with no delay. |
    | **Text Color** | White | You can use white or another if you prefer. |
16. Add another HUD Message device to alert the player for Wave 2.
17. Customize it:

    [![](https://dev.epicgames.com/community/api/documentation/image/28f4a9d7-d831-4fde-9e13-23db87783f0e?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/28f4a9d7-d831-4fde-9e13-23db87783f0e?resizing_type=fit)

    | Option | Value | Description |
    | --- | --- | --- |
    | **Message** | Wave 2 | Alerts the player when the second wave starts. |
    | **Text Color** | White | You can use white or another if you prefer. |
18. Repeat placing a HUD Message device for Wave 3 and customize accordingly.

### Set Up the Game End and Polish

1. In a place that the player won't be able to see (such as underneath the ground), place an **End Game** device.

   For tips on how to hide a device underground, see Hotkeys and [Keybinding Shortcuts](https://dev.epicgames.com/documentation/en-us/fortnite/hotkey-and-keybinding-shortcuts-in-fortnite-creative) under **Object Placement**.
2. Customize the **End Game** device as follows:

   [![](https://dev.epicgames.com/community/api/documentation/image/73a2827c-b176-426f-a8cc-f0d20fc8566c?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/73a2827c-b176-426f-a8cc-f0d20fc8566c?resizing_type=fit)

   | Option | Value | Description |
   | --- | --- | --- |
   | **Custom Victory Callout** | You Survived! | Will show at the end of the game. |
3. Place a Post Process device.
4. Customize the device:

   [![](https://dev.epicgames.com/community/api/documentation/image/c76a4eb3-578c-4d44-bb3d-a469bfaa7fa1?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/c76a4eb3-578c-4d44-bb3d-a469bfaa7fa1?resizing_type=fit)

   | Option | Value | Description |
   | --- | --- | --- |
   | **Post Process Effect** | Retro | This provides a cool visual filter. |

### Bind Functions / Events

[Direct event binding](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) is how you set devices to communicate directly with other devices. This involves setting [functions](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) and [events](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) for the devices involved.

1. Configure the following event on the Wave 1 Creature Manager so that it activates the elimination trigger for that wave.

   [![](https://dev.epicgames.com/community/api/documentation/image/860b45ae-ac05-41ea-a4d9-76ffe1cd3769?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/860b45ae-ac05-41ea-a4d9-76ffe1cd3769?resizing_type=fit)

   | Event | Select Device | Select Function |
   | --- | --- | --- |
   | **On a Matching Creature Type Is Eliminated Send Event To** | Wave 1 Elimination Trigger | Trigger |
2. Repeat for Waves 2 and 3, binding them to the appropriate devices (now you see why it's important to use good naming practices!)
3. Configure the following event on the **Wave 1 Elimination Trigger** so that when it triggers enough times, it:

   - Enables the Creature Spawner for this wave.
   - Disables the Creature Spawner for the next wave.
   - Enables the Creature Manager for the next wave
   - Displays the HUD message for the start of the next wave.

   [![](https://dev.epicgames.com/community/api/documentation/image/768a116e-693c-4a62-93bf-943030e74259?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/768a116e-693c-4a62-93bf-943030e74259?resizing_type=fit)

   | Event | Select Device | Select Function |
   | --- | --- | --- |
   | **On Triggered Send Event To** | Wave 1 Creature Spawner | Disable |
   | **On Triggered Send Event To** | Wave 2 Creature Spawner | Enable |
   | **On Triggered Send Event To** | Wave 2 Creature Manager | Enable |
   | **On Triggered Send Event To** | Wave 2 HUD Message | Show |

   You don't need to disable the currently active Creature Manager because enabling a different Creature Manager for the same creature type automatically disables any others.
4. Configure the following event on the Wave 2 Elimination Trigger for the next wave:

   [![](https://dev.epicgames.com/community/api/documentation/image/6ac5bc72-5104-4652-ac40-d9677506d150?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/6ac5bc72-5104-4652-ac40-d9677506d150?resizing_type=fit)

   | Event | Select Device | Select Function |
   | --- | --- | --- |
   | **On Triggered Send Event To** | Wave 3 Creature Spawner | Enable |
   | **On Triggered Send Event To** | Wave 2 Creature Manager | Disable |
   | **On Triggered Send Event To** | Wave 3 HUD Message | Show |
   | **On Triggered Send Event To** | Wave 3 Creature Manager | Enable |
5. Configure the following event on the Wave 3 Elimination Trigger so that when the player completes the final wave, the game ends.

   [![](https://dev.epicgames.com/community/api/documentation/image/ae178046-7049-4d63-97de-660f87c1697b?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/ae178046-7049-4d63-97de-660f87c1697b?resizing_type=fit)

   | Event | Select Device | Select Function |
   | --- | --- | --- |
   | **On Triggered Send Event To** | End Game Device | Activate |

### Modify Island Settings

Make the following modifications to the **Island Settings**.

1. Go to **Island Settings > User Interface**.
2. Under **HUD**, change **HUD Info Type** to **Score**.

   [![](https://dev.epicgames.com/community/api/documentation/image/08c9873b-e6c1-4f8b-84ab-55d7626bec8c?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/08c9873b-e6c1-4f8b-84ab-55d7626bec8c?resizing_type=fit)

You now have a working wave survival game with creature upgrades for each wave!

### Design Tip

The devices you've used here can easily be tweaked to make this mode work well in a multiplayer context.

The Creature Manager device has a Score Distribution setting that you can tweak so that players will receive different score rewards based on how they contribute to an elimination.

Consider whether you want your players competing to do damage or get eliminations for the most points, or just have them all receive the same point rewards when configuring this setting.
