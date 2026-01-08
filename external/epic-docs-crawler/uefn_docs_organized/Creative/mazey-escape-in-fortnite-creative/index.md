# Mazey Escape

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/mazey-escape-in-fortnite-creative>
> **爬取时间**: 2025-12-27T00:27:19.920845

---

[![Mazey Escape Gameplay Example](https://dev.epicgames.com/community/api/documentation/image/270c65b2-908f-448f-b3d0-8056321f3315?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/270c65b2-908f-448f-b3d0-8056321f3315?resizing_type=fit)

This example demonstrates the use of Perception Triggers to activate various devices placed in a maze.

*Mazey Escape Video*

## Ingredients

**You Need:**

- **4 Item Spawner devices**
- **1 Item Granter device**
- **2 Conditional Button devices**
- **2 Lock Devices**
- **9 Perception Trigger devices**
- **1 Trigger device**

## Method

The player must acquire torches scattered all over the maze to unlock doors that finally lead to the exit. Not all the torches are visible. The only way to get them is to explore every corner of the maze.

- There are 2 sections in the maze, separated by a locked door.
- To get out of the first section, the player must find 4 torches.
- In the second section, the player must also find 4 torches to unlock the door to leave the maze.
- Perception Triggers are scattered all over the maze. But not all of them are enabled at the same time. The player will have to run around the maze in a specific order to activate the triggers, collect the torches, and finally unlock the doors.

### Item Spawner Device Options

In this example, two Item Spawners are placed in each section of the maze. Follow these steps for all four of them.

1. Drop a Torch onto the Item Spawners to register it.
2. Set the **Items Respawn option** to **Off**. We want the Torches to spawn only once.
3. Set the **Time between spawns** option to **Never**.
4. Set the **Run over pickup** option to **On**.
5. Set the **Enabled At Game Start** option to **No.** We want the Item Spawners to be enabled by the activation of specific Perception Triggers.
6. The four Item Spawners are enabled by different channels. Set the **Enable When Receiving From** option to these channel numbers.

   1. For Item Spawner 1: Channel 2
   2. For Item Spawner 2: Channel 5
   3. For Item Spawner 3: Channel 9
   4. For Item Spawner 4: Channel 11

### Item Granter Device Options

The Item Granter is placed outside of the play area. It is set up to remotely award the player a torch when activated by a Perception Trigger. To set up the Item Granter, follow the steps below.

1. Set the **On-Grant Action** option to **Keep All**.
2. Set the **Grant Item When Receiving From** option to **channel 1**. Any Perception Trigger that activates the Item Granter will be transmitting a signal to this specific channel.

### Conditional Button Device Options

The Conditional Button signals the Lock Device to unlock the door. To activate the Conditional Button, the player must possess four torches and the Conditional Buttons must also be enabled. Follow these steps for both Conditional Buttons.

1. Set the **Key Items Required** option to **4**.
2. Set the **Enabled at Game Start** to **No**.
3. Set the **Enable When Receiving From** to **channel 6** for the first button and **channel 12** for the second button. These signals are sent by two different Perception Triggers.
4. Set the **When Activated Transmit On** option to **channel 7** for the first button and **channel 13** for the second button. These signals are transmitted to the corresponding Lock Devices located beside the doors.

### Lock Device Device Options

The Lock Device is set up to lock the doors for each section by default. They are unlocked only when the Conditional Buttons tell them to do so. Set up the two Lock Devices using the steps below.

1. Set the **Unlock when Receiving From** option to **channel 7** for the first device.
2. Set the **Unlock when Receiving From** option to **channel 13** for the second device.

### Perception Triggers Device Options

In this example, a variety of configurations are used to demonstrate the various forms of signalling between the 9 Perception Triggers and other devices.

**Device 1**: This device awards the player a torch when the player looks at the device, and awards the player a torch when the player looks away from the device. Follow these steps to set up the first device.

1. Set the **Times Can Trigger** option to **2**. We want to award exactly 2 torches from this device.
2. Set the **When a Player Looks At This Device Transmit On** option to **channel 1**.
3. Set the **When a Player Looks Away From This Device Transmit On** option to **channel 1**. These signals are sent to the Item Granter to award the player the torches.

**Device 2**: This device activates the Item Spawner next to it when the device sees the player. It enables the third Perception Trigger when the device loses sight of the player. Follow these steps to set up Device 2.

1. Set the **Times Can Trigger** option to 2. One trigger for the Item Spawner, the other trigger for Device 3.
2. Set the **When Device Sees a Player Transmit On** option to **channel 2**. This activates the Item Spawner.
3. Set the **When Device Loses Sight Of a Player Transmit On** option to **channel 3**. This enables Device 3.

**Device 3**: This enables the fourth Perception Trigger when it sees a player. Follow these steps to set up Device 3.

1. Set the **Times Can Trigger** option to 1. It only needs to trigger once.
2. Set the **Enabled On Game Start** option to **Disabled**.
3. Set the **Enable When Receiving From** option to **channel 3**. This device is enabled by Device 2.
4. Set the **When Device Sees a Player Transmit On** option to **channel 4.** This enables Device 4.

**Device 4**: This device activates the Item Spawner next to it when the device sees the player. It enables the first Conditional Button when the device loses sight of the player. Follow these steps to set up Device 4.

1. Set the **Times Can Trigger** option to **2**.
2. Set the **Enabled On Game Start** option to **Disabled**.
3. Set the **Enable When Receiving From** option to **channel 4**. This device is enabled by Device 3.
4. Set the **When Device Sees a Player Transmit On** option to **channel 5**. This activates the Item Spawner.
5. Set the **When Device Loses Sight Of a Player Transmit On** option to **channel 6**. This enables the Conditional Button.

**Device 5**: This device is enabled when the Conditional Button is activated. When the player looks at this device, it enables the next device. Follow these steps to set up Device 5.

1. Set the **Times Can Trigger** option to **1**. It only needs to trigger once.
2. Set the **Enabled On Game Start** option to **Disabled**.
3. Set the **Enable When Receiving From** option to **channel 7**. The device is enabled by the first Conditional Button.
4. Set the **When a Player Looks At This Device Transmit On** option to **channel 8**. This enables Device 6.

**Device 6**: This activates the Item Spawner next to it when the device sees the player. It enables the seventh and eighth Perception Triggers when the device loses sight of the player. Follow these steps to set up Device 6.

1. Set the **Times Can Trigger** option to **2**. One trigger is for the Item Spawner, the other trigger for the seventh and eighth Perception Trigger Devices.
2. Set the **Enabled On Game Start** option to **Disabled**.
3. Set the **Enable When Receiving From** option to **channel 8**. This device is enabled by Device 5.
4. Set the **When Device Sees a Player Transmit On** option to **channel 9**. This activates the Item Spawner.
5. Set the **When Device Loses Sight Of a Player Transmit On** option to **channel 10**. This enables Devices 7 and 8.

**Device 7**: This awards the player a torch when the player looks at the device. Follow these steps to set up Device 7.

1. Set the **Times Can Trigger** option to **1**.
2. Set the **Enabled On Game Start** option to **Disabled**.
3. Set the **Enable When Receiving From** option to **channel 10**. This device is enabled by Device 6.
4. Set the **When a Player Looks At This Device Transmit On** option to **channel 1**. This signal is sent to the Item Granter to award the player a torch.

**Device 8**: This activates the Item Spawner next to it when the device sees the player. It enables the ninth Perception Trigger and the second Conditional Button when the device loses sight of the player. Follow these steps to set up Device 8.

1. Set the **Times Can Trigger** option to **2**. One trigger is for the Item Spawner, the other trigger is for the other devices.
2. Set the **Enabled On Game Start** option to **Disabled**.
3. Set the **Enable When Receiving From** option to **channel 10**. This device is enabled by Device 7.
4. Set the **When Device Sees a Player Transmit On** option to **channel 1**1. This activates the Item Spawner.
5. Set the **When Device Loses Sight Of a Player Transmit On** option to **channel 12**. This enables Device 9 and the second Conditional Button.

**Device 9**: This awards the player a torch when the player looks at the device. Follow these steps to set up Device 9.

1. Set the **Times Can Trigger** option to **1**.
2. Set the **Enabled On Game Start** option to **Disabled**.
3. Set the **Enable When Receiving From** option to **channel 12**. This device is enabled by Device 8.
4. Set the **When a Player Looks At This Device Transmit On** option to **channel 1**. This signal is sent to the Item Granter to award the player a torch.

### Trigger Device Options

The Trigger is placed right after the 2nd door. It simply ends the game when the player walks out of the door and steps over it. Be sure to also place a Team & Inventory Setting device outside the play area to receive this signal to end the game.

1. Set the **Times Can Trigger** option to **1**.
2. Set the **Visible in Game** option to **No**.
3. Set the **When Triggered Transmit On** option to **channel 14**. This signal is sent to the Team & Inventory Setting to end the game.
