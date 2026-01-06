# Top Scorer In Class

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/top-scorer-in-class-in-fortnite-creative
> **爬取时间**: 2025-12-27T00:28:24.796601

---

This is a demonstration of how the Class Selector can be used with other devices to achieve gameplay objectives. In this example, the player is expected to eliminate monsters to gain scores and the goal is to reach a score of 500.

*Top Scorer In Class Video*

## Ingredients

**You need:**

- **4 Class Designer devices**
- **3 Class Selector devices**
- **4 Attribute Trigger devices**
- **4 Score Manager devices**
- **1 Creature Manager device**
- **1 Timer device**
- **10+ Creature Placer devices**

## Method

The amount of score the player gets depends on the class they selected. The more powerful classes with better weapons and player stats gain fewer points for each elimination than the weaker classes.

The emphasis here is to show how the Class Identifier defined in the Class Designer can be used by the Attribute Trigger to transmit messages to different channels.

## Modified Options

### Class Designer Device Options

For each of the four Class Designers, you will define the class names, identifiers, attributes, and inventory loadout. The inventory loadout is set up by dropping items onto the device. You want to create a clear contrast in power between player stats and weapon loadout for each class. For this setup, the default starting class is the weakest one and it starts with a Common Pistol. To make it the default starting class, assign its Class Identifier in **My Island** settings under the **Game** tab. The strongest class gets an epic Rocket Launcher and has the most health and shield.

[![Class Designer Device Options](https://dev.epicgames.com/community/api/documentation/image/074292a7-9579-467d-9700-28e426fe4be8?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/074292a7-9579-467d-9700-28e426fe4be8?resizing_type=fit)

### Class Selector Device Options

All three Class Selectors are placed in the play area near the Player Spawn point and they all have the **Visible In Game** option set to **Yes**. The player will interact with the Class Selectors by running over the visible activation zone. Be sure to set the **Clear Items On Switch** option to **Class Item Only** so that items that were assigned in the current class are removed.

[![Class Selector Device Options](https://dev.epicgames.com/community/api/documentation/image/00bd3844-dbe7-4dd0-9bcc-33836c55b01b?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/00bd3844-dbe7-4dd0-9bcc-33836c55b01b?resizing_type=fit)

### Score Manager Device Options

Assign a different **Score Value** to each of the Score Manager devices. In this example, I use a score of 5, 10, 15, and 20. As mentioned, each of the four classes will earn different scores, and you can set this using Attribute Triggers. You need to assign a unique channel number to the **Activate When Receiving From** option for each of the four Score Managers.

[![Score Manager Device Options](https://dev.epicgames.com/community/api/documentation/image/500ada45-0aed-4e67-9a7f-b7dbe0968bd3?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/500ada45-0aed-4e67-9a7f-b7dbe0968bd3?resizing_type=fit)

### Attribute Triggers Device Options

The Attribute Triggers listen to a channel and transmit a signal after checking against various player (instigator) attributes.

Each of the four Attribute Triggers is listening to a signal that is sent when players eliminate monsters. With the same incoming signal, the Attribute Trigger will do a series of checks, and send a signal to the Score Managers when all checks are valid. The key difference here is the option **Check for Class**. Since all four Attribute Triggers are listening to the same signal, only the one that matches the player’s class will pass the check, and send a unique signal to the corresponding Score Manager. Assign a valid and unique Class Identifier to this option for each of the Attribute Triggers.

[![Attribute Trigger Device Options 1](https://dev.epicgames.com/community/api/documentation/image/3a4e49fc-82d3-434c-a03a-f60ccfa756f9?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/3a4e49fc-82d3-434c-a03a-f60ccfa756f9?resizing_type=fit)

Assign the same channel number (25 in this example) to the **Listen to Channel** option for each of the Attribute Triggers. This channel signal is going to be sent by the Creature Placer device to all four Attribute Triggers.

[![Attribute Trigger Device Options 2](https://dev.epicgames.com/community/api/documentation/image/01cebd88-6927-4790-aa15-00ca1c5717f8?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/01cebd88-6927-4790-aa15-00ca1c5717f8?resizing_type=fit)

Assign the **If all Checks are Valid Transmit On** option to a channel number that uniquely corresponds to the one assigned in the Score Manager. Make sure that the number is different for each of the four Attribute Triggers.

[![Attribute Trigger Device Options 3](https://dev.epicgames.com/community/api/documentation/image/b9f10ea5-a2cf-41db-ad16-b0a611156ec1?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/b9f10ea5-a2cf-41db-ad16-b0a611156ec1?resizing_type=fit)

### Creature Manager and Creature Placer Device Options

For the Creature Manager, the only thing to do is to change the **Score** option from **Default** to **None**. This will ensure that no additional score is given, and all scoring should only come from the Score Managers.

Place one Creature Placer in the play area and set the options shown below. Set the **When Eliminated Transmit On** option to the channel number that was assigned to the **Listen to Channel** option in the four Attribute Triggers.

[![Creature Placer Device Options 1](https://dev.epicgames.com/community/api/documentation/image/af5a5313-308e-4455-bcd9-07a737dfe16c?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/af5a5313-308e-4455-bcd9-07a737dfe16c?resizing_type=fit)

Set the **Spawn When Receiving From** option to a unique channel number. This device is listening for a signal sent by the Timer device through this channel. What it does is at every time interval sent by the Timer, it will spawn a monster if the monster spawned by this Creature Placer was destroyed.

[![Creature Placer Device Options 2](https://dev.epicgames.com/community/api/documentation/image/71c198a5-459d-4bf6-88b1-31601d643905?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/71c198a5-459d-4bf6-88b1-31601d643905?resizing_type=fit)

For all the other options, you can set it to whatever you want. If you intend to have different monster types for different Creature Placers, be sure to add more Creature Managers with their **Score** options set to **None**.

Once all that is done, you can copy the Creature Placer device and place those copies all over the play area.

### Timer Device Options

You can use the Timer to make the Creature Placers periodically spawn monsters by transmitting a signal through a unique channel number. The key options to look at are:

- **Duration**: This drives the spawn frequency. **5 sec** is used in this example.
- **Looping**: Set this to **Yes**.
- **When Complete Transmit On**: Set this to the channel number the Creature Placers are listening to for the spawning of monsters.

[![Timer Device Options](https://dev.epicgames.com/community/api/documentation/image/94002400-3c24-47d1-9837-675b0ac4960e?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/94002400-3c24-47d1-9837-675b0ac4960e?resizing_type=fit)

### Channel Usage Summary

Each Attribute Trigger sends a signal through a unique channel (20 to 23) to each Score Manager based on the different Class Identifiers they are checking for.

[![Channel Usage Summary 1](https://dev.epicgames.com/community/api/documentation/image/9acc94f7-4ea8-43b6-8cde-91db155a2938?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/9acc94f7-4ea8-43b6-8cde-91db155a2938?resizing_type=fit)

Each Creature Placer will send a signal through a specific channel to all four Attribute Triggers when the monster is eliminated.

[![Channel Usage Summary 2](https://dev.epicgames.com/community/api/documentation/image/141748fb-5893-405e-a5fa-8c08578603db?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/141748fb-5893-405e-a5fa-8c08578603db?resizing_type=fit)

The Timer periodically sends a signal through a specific channel to all Creature Placers to spawn monsters.

[![Channel Usage Summary 3](https://dev.epicgames.com/community/api/documentation/image/3ae980f6-e16b-4da6-9598-8e6d0e8eed74?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/3ae980f6-e16b-4da6-9598-8e6d0e8eed74?resizing_type=fit)
