# Class Setup In an Arena

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/class-setup-in-an-arena-gameplay-example-in-fortnite-creative
> **爬取时间**: 2025-12-27T00:28:44.914904

---

The **Class Setup In an Arena** gameplay example shows you how to set up multiple devices and zones which, when interacted with or walked through by a player, change many of their attributes, including [health](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#health), [shields](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#shield), [movement modifier](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#movement-modifier), jump height, and [items](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#item) in [inventory](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#inventory).

[![Switching to swordsman to fight a brute.](https://dev.epicgames.com/community/api/documentation/image/2160024c-5ad6-4079-a8f0-af3d28d4ec6a?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/2160024c-5ad6-4079-a8f0-af3d28d4ec6a?resizing_type=fit)

This example also shows how to send a message to the player’s [HUD](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary).

Some devices and zones are visible, while others are invisible but triggered when a player enters the area or defeats an enemy.

As you follow this tutorial, you will learn how to build your own Class Setup In an Arena using the following devices:

- Class Designer
- Class Selector
- Mutator Zone (to trigger class changes)
- Explosive (to trigger class changes)
- Collectible Object (to trigger class changes)
- HUD Message

## Devices Used

Many of the devices listed below were used to create the various class challenges, and so are described only in passing. Refer to their device pages for more on how to use them.

- **6 x** [Barrier](https://www.epicgames.com/fortnite/en-US/creative/docs/using-barrier-devices-in-fortnite-creative) **devices**
- **7 x** [Billboard](https://www.epicgames.com/fortnite/en-US/creative/docs/using-billboard-devices-in-fortnite-creative) **devices**
- **6 x** [Class Designer](https://www.epicgames.com/fortnite/en-US/creative/docs/using-class-designer-devices-in-fortnite-creative) **devices**
- **6 x** [Class Selector](https://www.epicgames.com/fortnite/en-US/creative/docs/using-class-selector-devices-in-fortnite-creative) **devices**
- **2 x** [Collectible Gallery](https://www.epicgames.com/fortnite/en-US/creative/docs/using-collectible-object-devices-in-fortnite-creative) **objects**
- **1 x** [Creature Placer](https://www.epicgames.com/fortnite/en-US/creative/docs/using-creature-placer-devices-in-fortnite-creative) **device**
- **1 x** [Damage Volume](https://www.epicgames.com/fortnite/en-US/creative/docs/using-damage-volume-devices-in-fortnite-creative) **device**
- **1 x** [End Game](https://www.epicgames.com/fortnite/en-US/creative/docs/using-end-game-devices-in-fortnite-creative) **device**
- **3 x** [Explosive](https://www.epicgames.com/fortnite/en-US/creative/docs/using-explosive-devices-in-fortnite-creative) **devices**
- **6** **x** [HUD Message](https://www.epicgames.com/fortnite/en-US/creative/docs/using-hud-message-devices-in-fortnite-creative) **devices**
- **2 x** [Mutator Zone](https://www.epicgames.com/fortnite/en-US/creative/docs/using-mutator-zone-devices-in-fortnite-creative) **devices**
- **1 x** [Player Spawn Pad](https://www.epicgames.com/fortnite/en-US/creative/docs/using-player-spawn-pad-devices-in-fortnite-creative) **device**
- **3 x** [Sentry](https://www.epicgames.com/fortnite/en-US/creative/docs/using-sentry-devices-in-fortnite-creative) **devices**
- **2 x** [Timer](https://www.epicgames.com/fortnite/en-US/creative/docs/using-timer-devices-in-fortnite-creative) **devices**
- **1 x** [Trigger](https://www.epicgames.com/fortnite/en-US/creative/docs/using-trigger-devices-in-fortnite-creative) **device**

To learn more about placing [props](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#prop) and using the [grid](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#grid), refer to the [Video Tutorials](https://www.epicgames.com/fortnite/en-US/creative/docs/fortnite-creative-video-tutorials).

## Build an Arena Around the Course

This gameplay example demonstrates the use of classes in a contained area, so build an [arena](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#arena) to contain the devices the player interacts with.

Press **Q** to build walls around the visible **Class Selector** devices and other devices to make a path that channels the player to the devices and zones you set up.

You can choose the material. You can also use props to build the walls. Refer to the [Video Tutorials](https://www.epicgames.com/fortnite/en-US/creative/docs/fortnite-creative-video-tutorials) linked under **Work on your Island** to learn how to use props.

[![Hovering above an arena maze that holds the challenges for the player.](https://dev.epicgames.com/community/api/documentation/image/1fda82ba-a1ee-41a0-bff2-5a2edc9f9a77?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/1fda82ba-a1ee-41a0-bff2-5a2edc9f9a77?resizing_type=fit)

## Set Up a Class Designer Device

With **Class Designer** devices, you can customize the properties of various classes to assign different attributes to each class. This determines how gameplay changes from class to class.

In the tables describing the customized device settings, only the first of each device type’s options are displayed. The description will say whether the option can or should be changed for multiple devices of the same type.

1. Place a **Class Designer** device in the desired location. The location can be anywhere, as the player will not be interacting with this device.
2. When placing additional Class Designer devices, spread them out to make it easier to drop weapons on the correct devices when customizing them.
3. Approach the device and press **E** to open the device options screen.
4. Rename the class by changing the **Class Name** option. For example, the first device’s Class Name is "Tank".
5. Ensure that each **Class Identifier** is unique among all Class Designers. For example, the first device has a Class Identifier of 1.
6. Place a weapon in the inventory and drop it onto the **Class Designer** to register it. This is the weapon the player receives when switching to the class.

   - To obtain a weapon from the inventory, press **I** to open the inventory. Navigate to the **Weapons** tab and double-click a weapon to equip it.
   - To drop the weapon from your inventory, press **I** to open the inventory. Click and drag the desired weapon out of the [Quick Bar](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#quick-bar). For example, the first device gives players a shotgun.
   - The item should appear above the device once dropped.
7. Set **Equip Granted Item** to **First Item**, so when the player switches to this class, they equip the granted weapon immediately.
8. Edit any other properties you want to change. For example, the first device has a **Max Health** of 300, **Starting Shields** of 100%, **Shields** of 300, **Movement Multiplier** set to 0.7, and **Gravity** set to high.

   The customized options should resemble those below:

   [![Customized class designer options.](https://dev.epicgames.com/community/api/documentation/image/e278d547-9f8e-4acf-bdc5-c9b4e5542747?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/e278d547-9f8e-4acf-bdc5-c9b4e5542747?resizing_type=fit)

   | Option | Value | Explanation |
   | --- | --- | --- |
   | **Class Name** | **Tank** | Sets the name of the class. Must be changed so the class can easily be identified if any modifications are needed. **Name each device differently.** |
   | **Class Identifier** | **1** | Sets an identifier value for the class. Must be changed so any devices that communicate with this device can use the Class Identifier. **Increment the value by 1 for each additional device.** |
   | **Equip Granted Item** | **First Item** | When the player switches to this class, they automatically equip the weapon granted by the Class Designer. |
   | **Max Health** | **300** | Sets the maximum health of the player to the specified amount. **Can be changed to give a class more or less health. Different devices can have different values.** |
   | **Starting Shields** | **100%** | Grants the player full shields as soon as they switch to this class. **Can be changed to give a class less or no starting shields. Different devices can have different values.** |
   | **Max Shields** | **300** | Sets the maximum shields of the player to the specified amount. **Can be changed to give a class more or less shields. Different devices can have different values.** |
   | **Movement Multiplier** | **0.7** | Sets the player’s movement speed. **Can be changed to give a class a different movement speed. Different devices can have different values.** |
   | **Gravity** | **High** | Sets the level of gravity that affects the player. **Can be changed to give a class a different gravity effect. Different devices can have different values.** |
   | **(Any Desired Option)** | **(Desired Value)** | **Any option different from the default can be changed as desired. All options can be different for different devices.** |

   For sample classes you can use with your own Class Setup in an Arena Island, refer to the [Sample Classes](https://dev.epicgames.com/documentation/en-us/fortnite/class-setup-in-an-arena-gameplay-example-in-fortnite-creative) section.

   [![Player next to a Class Designer device which gives players a shotgun with the customization prompt displayed.](https://dev.epicgames.com/community/api/documentation/image/4fda3e54-e2ff-4ecc-b931-ee3c4dc1a447?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/4fda3e54-e2ff-4ecc-b931-ee3c4dc1a447?resizing_type=fit)
9. Set up all the **Class Designer** devices. Repeat steps 1-7 for the other 5 **Class Designers.** For each repetition, change:

   - The **Class Name.**
   - The **Class Identifier.**
   - The weapon and items registered to the **Class Designer.**
   - Any other properties you want to change. Refer to the [Sample Classes](https://dev.epicgames.com/documentation/en-us/fortnite/class-setup-in-an-arena-gameplay-example-in-fortnite-creative) section at the end of this document for suggestions.

## Set Up a Visible Class Selector Device

Players interact directly with visible **Class Selectors** to switch classes. A player can instantly switch their class when they walk over the device.

1. Place a **Class Selector** device on your Island. The location should be contained in the arena built in a previous step, at one of the locations where you want your player to change class.
2. Open the **Customize** screen.
3. Change the **Class to Switch to** option to the desired Class Identifier. For example, the first device sets this to 1, the value to the first class designer’s Class Identifier.
4. Change the **Time to Switch** value to **Instant**. This ensures that as soon as the player crosses the device, their class is switched.
5. Change the **When Class Switched Transmit On** value. For example, the first device sets this value to 1. This option transmits a notification to the appropriate channel so other devices can receive this signal and perform other actions.
6. The customized options should resemble those below:

   [![Customized visible class selector options.](https://dev.epicgames.com/community/api/documentation/image/ccb60f18-3ea7-4622-83f8-d4f462581ad1?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/ccb60f18-3ea7-4622-83f8-d4f462581ad1?resizing_type=fit)

   | Option | Value | Explanation |
   | --- | --- | --- |
   | **Class to Switch to** | **1** | Sets the class to switch the player to when the device is activated, based on the Class Identifier setting for the Class Designer devices. Must be changed to allow the player of the gameplay example to switch their class on a certain action. **Set each device to change to a different class.** |
   | **Time to Switch** | **Instant** | Ensures that the class is switched as soon as the player enters the Class Selector zone. Must be changed so there is no delay in switching classes. |
   | **When Class Switched Transmit On** | **Channel 1** | Sets the channel a message is transmitted to on device activation. Must be changed so other devices can receive signals from this device. **Each device must transmit on a different channel.** |

   [![Player next to a Class Selector device with the customization prompt displayed.](https://dev.epicgames.com/community/api/documentation/image/2179ab82-7707-4c54-aa55-b250042d0360?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/2179ab82-7707-4c54-aa55-b250042d0360?resizing_type=fit)
7. Set up all the visible **class selectors** in the appropriate places in your enclosed area. Repeat steps 1-6 for two of the other visible **class selectors.** For each repetition, change:

   - The **Class To Switch To** identifier. Each of these should match a different Class Identifier used by the class designers.
   - The channel for the **When Class Switched Transmit On** option. These should be different for each new device.

When working with channels, each device must transmit to a unique channel, unless you specifically want one trigger to activate multiple effects.

## Set Up an Invisible Class Selector Device

The invisible **Class Selector** devices receive signals from trigger devices like **Mutator Zones, Explosives, Collectible Objects,** and other similar devices to change the player’s class. Players never interact with them directly.

1. Place a **Class Selector** device on your island. The location can be anywhere as the player will not be interacting with this device.
2. Open the **Customize** screen.
3. Change the **Class To Switch To** option to the desired **Class Identifier**. Because there are already three visible devices, set this value to **4** for the fourth class designer’s Class Identifier, on the first invisible class selector.
4. Change the **Time to Switch** value to **Instant**. As soon as the player triggers the device, their class is switched.
5. Change the **When Class Switched Transmit On** value.

   - In the gameplay example walkthrough, the invisible device sets this value to **12**. This option transmits a notification to the appropriate channel so other devices can receive this signal and perform other actions. Your version may use a different channel.
6. Set the **Change Player to Class when Receiving From** option to a specified channel. For the first invisible class selector, set this value to **4**.
7. Set the **Visible During Game** option to **Off**. Since the invisible class selectors are triggered by other devices, there is no need to keep the device visible.
8. Set the **Volume Visible During Game** option to **Off**. Since the invisible class selectors are triggered by other devices, there is no need to keep the volume visible.
9. The customized options should resemble those below:

   [![customized invisible class selector options](https://dev.epicgames.com/community/api/documentation/image/d7082225-d2e1-47e4-9ba0-26679c3d2ecd?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/d7082225-d2e1-47e4-9ba0-26679c3d2ecd?resizing_type=fit)

   | Option | Value | Explanation |
   | --- | --- | --- |
   | **Visible During Game** | **Off** | Sets the visibility of the device to the player. Change it so the player cannot see the device during the game. |
   | **Volume Visible During Game** | **Off** | Sets the visibility of the device’s aura to the player. Change it so the player cannot see the device volume during the game. |
   | **Class to Switch to** | **4** | Sets the class the player switches to when the device is activated. Must be changed so the proper class is switched to on device activation. |
   | **Time to Switch** | **Instant** | Ensures that the class is switched as soon as the Class Selector receives a signal from a triggering device. Must be changed so there is no delay in switching classes. |
   | **Change Player to Class when Receiving From** | **Channel 12** | Sets the channel that will trigger the Class Selector device. Should be the same channel as that transmitted on by the desired triggering device. Must be changed so the class can be automatically switched when receiving a signal. |
   | **When Class Switched Transmit On** | **Channel 4** | Sets the channel a message is transmitted to after the player activates the device. Must be changed so other devices can receive signals from this device. |
10. Set up all the invisible **class selectors.** Repeat steps 1-9 for the other two invisible **class selectors.** For each repetition, change:

    - The **Class To Switch To** identifier.
    - The channel for the **When Class Switched Transmit On** option.

## Signal Class Changes Using Devices

You can use any device that can send a signal on a channel to trigger a class change. The gameplay walkthrough video shows examples using a **Mutator Zone** device, an **Explosive** device, and a **Collectible Object** device. In all cases, communicating with the invisible class selector devices using a signal on a channel changes the player’s class, which in turn determines how the player’s gameplay is affected. The examples shown are not exhaustive, you can use other devices that can signal on channels when creating your own version.

### Set Up a Mutator Zone to Trigger a Class Change

You can set up a Mutator Zone device so that when a player enters the zone, they change class.

1. Place the **Mutator Zone** device in the desired location. The location should be within the arena built in a previous step.
2. Open the **Customize** screen for the mutator zone.
3. Set the **On Player Entering Zone Transmit On** channel to the **Change Player to Class when Receiving From** channel of the appropriate class selector.

   - In the gameplay example walkthrough, this value is 12, to signal the first invisible class selector, which is the fourth class selector overall. Your version may use a different channel.
4. Optionally, you can set the **On Player Exiting Zone Transmit On** channel to change the player’s class again when they leave the zone by signaling a different class selector.
5. If you expect your players to need weapons while in the mutator zone, set the **Allow Weapon Fire** option to **Yes**.

   - In the gameplay example walkthrough video, the mutator zone is invisible because the player can’t avoid it. If you want to create a more open version, you can make your mutator zones visible.
6. The customized options should resemble those below:

   [![Customized mutator zone options.](https://dev.epicgames.com/community/api/documentation/image/dcf9c9ba-ee12-41c7-a7bb-5604b16e5bf5?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/dcf9c9ba-ee12-41c7-a7bb-5604b16e5bf5?resizing_type=fit)

   | Option | Value | Explanation |
   | --- | --- | --- |
   | **Allow Weapon Fire** | **Yes** | Optional. Lets the player shoot weapons while inside the mutator zone. |
   | **Zone Visible During Game** | **Yes** | Optional. Lets the player see the mutator zone during the game. |
   | **On Player Entering Zone Transmit On** | **Channel 12** | Sets the channel to transmit to when the player enters the mutator zone. Change it to the channel for the appropriate Class Selector. |
   | **On Player Leaving Zone Transmit On** | **Channel 20** | Sets the channel to transmit to when the player leaves the mutator zone. Change it to the channel for the appropriate class selector. |

   [![Player next to a Mutator Zone device which is one unit large in all dimensions.](https://dev.epicgames.com/community/api/documentation/image/fd252853-dbb6-43f3-a873-80781c3e5ef7?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/fd252853-dbb6-43f3-a873-80781c3e5ef7?resizing_type=fit)

### Set Up an Explosive to Trigger a Class Change

You can configure an Explosive device so when it explodes, the player who exploded it changes class.

1. Place the **Explosive** device in the desired location. The location should be within the enclosed arena built in a previous step. Optionally, you can place the explosive so that when it explodes, it destroys a wall or other barrier blocking the player from progressing.
2. Open the **Customize** screen for the explosive.
3. Set the **When Exploded Transmit On** channel for the **Change Player to Class when Receiving From** channel of the appropriate class selector.

   - In the gameplay example walkthrough, this value is 13, to signal the second invisible class selector, which was the fifth class selector overall. Your version may use a different channel.
4. Optionally, you can change the customize options for the size of the explosion, the damage it does to players and objects, and whether it can destroy objects set to be indestructible by the player. These options are how you can set an explosive to destroy obstacles blocking the player.

   [![Customized options for an explosive device.](https://dev.epicgames.com/community/api/documentation/image/556f52b1-be63-4954-b1c6-c99191b83d7f?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/556f52b1-be63-4954-b1c6-c99191b83d7f?resizing_type=fit)

   | Option | Value | Explanation |
   | --- | --- | --- |
   | **Blast Radius** | **0.25** | Optional. Reduces the explosion size so only whatever is directly in contact with the explosive takes damage. |
   | **Player Damage** | **0** | Optional. Prevents all damage to the player. |
   | **Structure Damage** | **500** | Optional. Ensures most props or buildings are destroyed by the explosion. |
   | **Damage Indestructible Buildings** | **Yes** | Optional. Ensures that buildings and props indestructible to the player can be destroyed by the explosive. |
   | **When Exploded Transmit On** | **13** | Sets the channel to transmit to when the device explodes. Change it to the channel for the appropriate class selector. |

   [![Player next to an Explosive device that will destroy the wall and trigger a class change.](https://dev.epicgames.com/community/api/documentation/image/4fc56784-aea7-4e87-8db5-126f94780d9c?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/4fc56784-aea7-4e87-8db5-126f94780d9c?resizing_type=fit)

### Set Up a Collectible Object to Trigger a Class Change

You can configure a Collectible Object device so that when it is picked up, the player who picked it up changes class.

1. Place the **Collectibles Gallery** in a convenient location.
2. Select one or more **Collectible Object** devices for use, then delete the rest.
3. Place the collectible object in the desired location. The location should be within the enclosed arena built in a previous step.
4. Set the **Score** option to **0**, as you don’t need to give Score for this gameplay example.
5. Optionally, set the **Turn Visibility On When Receiving From** channel to listen for a signal sent by another device.

   - The gameplay example walkthrough uses this to reveal the collectible object at the end of the previous challenge, using a signal on channel 15. Your version may use a different channel.
6. Set the **When Collected Transmit On** channel for the **Change Player to Class when Receiving From** channel of the appropriate class selector.

   - In the gameplay example walkthrough, this value is 16, to signal the third invisible class selector, which was the sixth class selector overall. Your version may use a different channel.

   [![Customized collectible device options.](https://dev.epicgames.com/community/api/documentation/image/fc55c6fa-d1de-4722-8d8e-3132cc0c9168?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/fc55c6fa-d1de-4722-8d8e-3132cc0c9168?resizing_type=fit)

   | Option | Value | Explanation |
   | --- | --- | --- |
   | **Collectible Object** | **Amber Pyramid** | Controls the appearance of the collectible object. Use any you prefer. |
   | **Score** | **0** | Score is not used, so collecting the object should not give any score. |
   | **Turn Visibility On When Receiving From** | **15** | Optional. Use this option if you want a signal from another device to make the collectible object visible to the player. |
   | **When Collected Transmit On** | **16** | Sets the channel to transmit to when the object is collected. Change it to the channel for the appropriate class selector. |

   [![Player next to a Collectible Object device which will trigger a class change and start a challenge.](https://dev.epicgames.com/community/api/documentation/image/5a89430c-1042-425c-b146-d02e96ba68af?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/5a89430c-1042-425c-b146-d02e96ba68af?resizing_type=fit)

## Set Up a HUD Message Device

The **HUD Message Device** allows for messages to be sent to the player’s HUD, indicating when the class is changed or providing useful information on how the gameplay has changed.

1. Place a **HUD Message Device** in the desired location. The location can be anywhere, as the player will not be interacting with this device.
2. Open the **Customize** screen.
3. Change the **Show When Receiving From** option to the channel of the desired class selector’s transmission channel. As described under [Set Up a Visible Class Selector Device](https://dev.epicgames.com/documentation/en-us/fortnite/class-setup-in-an-arena-gameplay-example-in-fortnite-creative), the transmission channel of the first device in the video example is 1.
4. Enter the desired text into the **Message** option.
5. Change the **Time From Round Start** option to **Off**. This ensures the message is only played when signaled by the appropriate class designer.
6. Optionally, you can configure where the message appears on the screen using the **Placement** option.
7. The customized options should resemble those below:

   [![Customized HUD message options.](https://dev.epicgames.com/community/api/documentation/image/93d3455f-e218-4cbd-8c63-36121970112f?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/93d3455f-e218-4cbd-8c63-36121970112f?resizing_type=fit)

   | Option | Value | Explanation |
   | --- | --- | --- |
   | **Message** | **You are now a Tank!** | The message to display to the player when triggered. Must be changed so a relevant message can be displayed. **Should be changed among multiple devices.** |
   | **Time From Round Start** | **Off** | Ensures the message is only displayed when a signal is received from the appropriate Class Designer. |
   | **Placement** | **Top Center** | Optional. Changes the location where the message displays on the player’s screen. |
   | **Show When Receiving From** | **Channel 1** | The channel that triggers the device to show the desired message. Must be changed so the message is displayed when receiving from the proper channel. **Each s****hould match one of the Class Designer devices.** |

   [![Player next to a HUD Message Device with the customization prompt displayed.](https://dev.epicgames.com/community/api/documentation/image/fc16ac94-3bc4-4f68-bae5-d24f1829cbbf?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/fc16ac94-3bc4-4f68-bae5-d24f1829cbbf?resizing_type=fit)
8. Set up all the **HUD Message Devices.** Repeat steps 1-5 for all the **HUD Message Devices.** For each repetition, change:

   - The **Message** option.
   - The channel for the **Show When Receiving From** option.

## Change the Default Class of the Player

The default class of the player determines the class of the player when they first land on the island. Since you don’t want them to have a class at the beginning, set it to a class identifier that is not being used.

In the **Island** **Settings**, change the **Default Class Identifier** to a **Class Identifier** that is not used by a **Class Selector** device.

- Refer to [Understanding Island Settings](https://dev.epicgames.com/documentation/en-us/fortnite/understanding-island-settings-in-fortnite-creative) for more.
- In the gameplay example walkthrough, the default Class Identifier is set to 7.

[![The island settings screen displaying the Default Class Identifier option and its value of 7.](https://dev.epicgames.com/community/api/documentation/image/8a499745-ec87-452a-935b-a88d7a82c45b?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/8a499745-ec87-452a-935b-a88d7a82c45b?resizing_type=fit)

## Sample Classes

Here are a variety of additional sample classes you can create using the devices shown in this gameplay example. These were all used in the gameplay walkthrough. The Tank class was described above in the [Set Up a Class Designer Device](https://dev.epicgames.com/documentation/en-us/fortnite/class-setup-in-an-arena-gameplay-example-in-fortnite-creative) section.

| Name | Skirmisher | Sniper | Swordsman | Grenadier | Medic |
| --- | --- | --- | --- | --- | --- |
| **Weapon Granted** | Submachine gun | Sniper rifle | Infinity Sword | Grenade Launcher | Pistol |
| **Items Granted** | – | – | – | Grenades | Chug Splash, Med-Mist, Med Kits |
| **Max Health** | 125 | 100 | 200 | 100 | 100 |
| **Max Shield** | 125 | 100 | 100 | 300 | 100 |
| **Movement Multiplier** | 1.5 | 0.8 | 1.3 | 1 | 1 |
| **Gravity** | Normal | Low | Low | Normal | Normal |

## Design Challenges for the Player

In the Class Setup in an Arena walkthrough video, there are six challenges for players to overcome using the weapons and abilities granted by the Class Selector devices. Players progress through each challenge, one at a time, gaining new classes and weapons after each challenge.

Each of the challenges used in the walkthrough video refers to one of the sample classes created for this gameplay example. Each challenge is accompanied by one or more Billboard devices that give your players hints about what they need to do to beat the challenges.

Because the challenges aren’t the focus of this gameplay example, and creating fun challenges for your players can be complex, the specific details of the challenges you set up for your Island are up to you. The descriptions below present a short outline of how the challenges in the gameplay example walkthrough video were created, along with the devices used.

You are encouraged to be creative with your own version of the gameplay example. You can customize, remove, or add challenges of your own to keep your island interesting and fresh for your players. For more on how to use all the devices mentioned in the challenges below, refer to each device’s page.

### Tank Challenge

The Tank challenge is triggered when the player enters a visible class selector, then blows up an explosive with a shotgun to destroy a wall. The explosive does damage, but as a Tank, the player’s shields can completely absorb the damage without dropping.

Place a wall blocking the path, and place an explosive in the wall. Place a Player Spawner device and the first visible Class Selector device next to the explosive for the player to destroy with the shotgun gained from the Tank class, which they will survive due to the high shields the player gained from the class. Place a billboard with a brief instruction on the wall.

**Devices used:**

- **1 x** [Billboard](https://www.epicgames.com/fortnite/en-US/creative/docs/using-billboard-devices-in-fortnite-creative) **device**
- **1 x** [Class Designer](https://www.epicgames.com/fortnite/en-US/creative/docs/using-class-designer-devices-in-fortnite-creative) **device**
- **1 x** [Class Selector](https://www.epicgames.com/fortnite/en-US/creative/docs/using-class-selector-devices-in-fortnite-creative) **device**
- **1 x** [Explosive](https://www.epicgames.com/fortnite/en-US/creative/docs/using-explosive-devices-in-fortnite-creative) **device**
- **1 x** [HUD Message](https://www.epicgames.com/fortnite/en-US/creative/docs/using-hud-message-devices-in-fortnite-creative) **device**

### Skirmisher Challenge

The Skirmisher challenge is triggered when the player enters a visible class selector. The player has to race a timer that puts up a Barrier device, using their increased movement to get past before the 3-second timer counts down.

Place the second visible class selector for the Skirmisher class. Place a billboard with a brief instruction on the wall. Place a mutator zone in the player’s path, and connect it using a channel signal to a timer with a 3-second countdown that sends a signal on a channel to activate a barrier, so that your players have to race to get past the barrier before the timer runs out.

**Devices used:**

- **1 x** [Barrier](https://www.epicgames.com/fortnite/en-US/creative/docs/using-barrier-devices-in-fortnite-creative) **device**
- **1 x** [Billboard](https://www.epicgames.com/fortnite/en-US/creative/docs/using-billboard-devices-in-fortnite-creative) **device**
- **1 x** [Class Designer](https://www.epicgames.com/fortnite/en-US/creative/docs/using-class-designer-devices-in-fortnite-creative) **device**
- **1 x** [Class Selector](https://www.epicgames.com/fortnite/en-US/creative/docs/using-class-selector-devices-in-fortnite-creative) **device**
- **1 x** [HUD Message](https://www.epicgames.com/fortnite/en-US/creative/docs/using-hud-message-devices-in-fortnite-creative) **device**
- **1 x** [Mutator Zone](https://www.epicgames.com/fortnite/en-US/creative/docs/using-mutator-zone-devices-in-fortnite-creative) **device**
- **1 x** [Timer](https://www.epicgames.com/fortnite/en-US/creative/docs/using-timer-devices-in-fortnite-creative) **device**

### Swordsman Challenge

The Swordsman challenge is triggered when the player enters a visible Class Selector. The player has to defeat a spawned brute with their sword to trigger dropping a barrier so they can progress.

Place the third visible class selector for the Swordsman class, and connect it through a channel signal to a barrier containing a Creature Placer device so that when your player becomes a Swordsman, the barrier drops and a brute spawns. Place a billboard with a brief instruction on the wall. Place a second barrier connected to the creature placer through a channel signal so that when the player defeats the brute, the second barrier drops.

**Devices used:**

- **2 x** [Barrier](https://www.epicgames.com/fortnite/en-US/creative/docs/using-barrier-devices-in-fortnite-creative) **devices**
- **1 x** [Billboard](https://www.epicgames.com/fortnite/en-US/creative/docs/using-billboard-devices-in-fortnite-creative) **device**
- **1 x** [Class Designer](https://www.epicgames.com/fortnite/en-US/creative/docs/using-class-designer-devices-in-fortnite-creative) **device**
- **1 x** [Class Selector](https://www.epicgames.com/fortnite/en-US/creative/docs/using-class-selector-devices-in-fortnite-creative) **device**
- **1 x** [Creature Placer](https://www.epicgames.com/fortnite/en-US/creative/docs/using-creature-placer-devices-in-fortnite-creative) **device**
- **1 x** [HUD Message](https://www.epicgames.com/fortnite/en-US/creative/docs/using-hud-message-devices-in-fortnite-creative) **device**

### Sniper Challenge

The Sniper challenge is triggered when the player, prompted by a message on a billboard, jumps up and hits an invisible mutator zone, which sends a signal to an invisible class selector. The player must [mantle](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#mantle) to the top of a high wall, and from there, shoot an explosive to drop an invisible barrier so they can continue.

Place a high wall in the path the player must take, with a barrier at the top blocking the player. Customize the barrier so that it doesn’t block shooting, and so it will drop when it receives a signal from a channel. Place a billboard with a brief instruction on the wall. Place an explosive beyond the barrier that’s customized to send a signal on the same channel to drop the barrier when the explosive explodes. Set up a mutator zone connected to an invisible class selector placed elsewhere so that when the player jumps up, they become a Sniper. The player can then jump or mantle to the top of the wall, shoot the explosive, and drop the barrier.

**Devices used:**

- **1 x** [Barrier](https://www.epicgames.com/fortnite/en-US/creative/docs/using-barrier-devices-in-fortnite-creative) **devices**
- **1 x** [Billboard](https://www.epicgames.com/fortnite/en-US/creative/docs/using-billboard-devices-in-fortnite-creative) **device**
- **1 x** [Class Designer](https://www.epicgames.com/fortnite/en-US/creative/docs/using-class-designer-devices-in-fortnite-creative) **device**
- **1 x** [Class Selector](https://www.epicgames.com/fortnite/en-US/creative/docs/using-class-selector-devices-in-fortnite-creative) **device (invisible)**
- **1 x** [Explosive](https://www.epicgames.com/fortnite/en-US/creative/docs/using-explosive-devices-in-fortnite-creative) **device**
- **1 x** [HUD Message](https://www.epicgames.com/fortnite/en-US/creative/docs/using-hud-message-devices-in-fortnite-creative) **device**
- **1 x** [Mutator Zone](https://www.epicgames.com/fortnite/en-US/creative/docs/using-mutator-zone-devices-in-fortnite-creative) **device**

### Grenadier Challenge

The Grenadier challenge is triggered when the player, prompted by a message on a billboard, shoots an explosive to destroy a wall, which also triggers a barrier preventing the player from backtracking. Three sentries behind a barrier are revealed, which the player must defeat at range with equipped explosive weapons and items. Once all three sentries are defeated, the barrier drops and the player can continue.

Place an explosive in a wall, customized so that it destroys the wall when exploded. Configure the explosive to send a channel signal to an invisible class selector when it explodes, switching the player to the Grenadier class. Place a billboard with a brief instruction on the wall. Place a barrier behind the player, triggered by the same signal. Place three Sentry devices so they are revealed by destroying the wall but behind a barrier that blocks movement but not shooting. Place a billboard with instructions to destroy the sentries behind them on the wall. Customize the sentries so each, when destroyed, sends a signal on a channel to a Trigger device. Configure the trigger so it must be activated three times before it sends a signal on another channel to drop the barrier, so that the player must destroy all three sentries before they can continue.

**Devices used:**

- **2 x** [Barrier](https://www.epicgames.com/fortnite/en-US/creative/docs/using-barrier-devices-in-fortnite-creative) **devices**
- **2 x** [Billboard](https://www.epicgames.com/fortnite/en-US/creative/docs/using-billboard-devices-in-fortnite-creative) **device**
- **1 x** [Class Designer](https://www.epicgames.com/fortnite/en-US/creative/docs/using-class-designer-devices-in-fortnite-creative) **device**
- **1 x** [Class Selector](https://www.epicgames.com/fortnite/en-US/creative/docs/using-class-selector-devices-in-fortnite-creative) **device (invisible)**
- **1 x** [Explosive](https://www.epicgames.com/fortnite/en-US/creative/docs/using-explosive-devices-in-fortnite-creative) **device**
- **1 x** [HUD Message](https://www.epicgames.com/fortnite/en-US/creative/docs/using-hud-message-devices-in-fortnite-creative) **device**
- **3 x** [Sentry](https://www.epicgames.com/fortnite/en-US/creative/docs/using-sentry-devices-in-fortnite-creative) **device**
- **1 x** [Trigger](https://www.epicgames.com/fortnite/en-US/creative/docs/using-trigger-devices-in-fortnite-creative) **device**

### Medic Challenge

The Medic challenge is triggered when the player picks up an amber pyramid collectible object. The player starts taking damage from a damage volume as a timer counts down, and must use granted shield and healing items to survive until the Timer countdown ends. Once the timer countdown ends, the final barrier drops, and the player can collect a Fortnite coin collectible object to win the game.

Place a collectible object in front of a barrier, configured to send a signal on a channel to an invisible Class Selector when collected. The signal switches the player to the Medic class, and also starts a 30-second timer countdown and activates a damage volume. When the timer countdown ends, the timer sends a signal on a channel to deactivate the damage volume and drop the barrier. Place a second collectible object that sends a signal to an End Game device when collected.

**Devices used:**

- **1 x** [Barrier](https://www.epicgames.com/fortnite/en-US/creative/docs/using-barrier-devices-in-fortnite-creative) **device**
- **1 x** [Billboard](https://www.epicgames.com/fortnite/en-US/creative/docs/using-billboard-devices-in-fortnite-creative) **device**
- **1 x** [Class Designer](https://www.epicgames.com/fortnite/en-US/creative/docs/using-class-designer-devices-in-fortnite-creative) **device**
- **1 x** [Class Selector](https://www.epicgames.com/fortnite/en-US/creative/docs/using-class-selector-devices-in-fortnite-creative) **device (invisible)**
- **2 x** [Collectible Gallery](https://www.epicgames.com/fortnite/en-US/creative/docs/using-collectible-object-devices-in-fortnite-creative) **objects**
- **1 x** [Damage Volume](https://www.epicgames.com/fortnite/en-US/creative/docs/using-damage-volume-devices-in-fortnite-creative) **device**
- **1 x** [End Game](https://www.epicgames.com/fortnite/en-US/creative/docs/using-end-game-devices-in-fortnite-creative) **device**
- **1 x** [HUD Message](https://www.epicgames.com/fortnite/en-US/creative/docs/using-hud-message-devices-in-fortnite-creative) **device**
- **1 x** [Timer](https://www.epicgames.com/fortnite/en-US/creative/docs/using-timer-devices-in-fortnite-creative) **device**

## Conclusion

The gameplay example walkthrough shown in the video below serves as a demonstration of the basic functionality. This gameplay example can be applied to your Island to give players the ability to switch classes to overcome enemies and obstacles. There are endless ways for a creator to trigger a class change, those presented in this gameplay example are only a small sample.
