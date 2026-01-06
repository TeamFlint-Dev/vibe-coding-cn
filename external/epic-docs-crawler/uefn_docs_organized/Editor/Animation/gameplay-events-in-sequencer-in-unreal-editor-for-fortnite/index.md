# Gameplay Events in Sequencer

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/gameplay-events-in-sequencer-in-unreal-editor-for-fortnite
> **爬取时间**: 2025-12-27T00:05:25.347176

---

Timing is everything, especially when you have a specific time you want a device to execute a specific function. Typically, triggering functions involves setting up multiple devices or triggers in complicated ways or even using the channel device to pull game mechanics, functions, and visuals together.

With **Gameplay Events in Sequencer,** you can trigger device functions at the exact time you want during the gameplay.

Gameplay Events in Sequencer do not work with Verse-authored custom devices. This feature only works with the devices found in the Content Browser **Device folder**.

## Timing Events

Using [Sequencer](unreal-editor-for-fortnite-glossary#sequencer) simplifies the event timing process and causes functions to trigger on time without relying on a chain reaction of events firing from connected devices. This is helpful for rhythm games, or to execute a game mechanic that depends heavily on a player timing their movement through a level to avoid danger.

### Configuring the Triggers

Before you can set up a gameplay event in [Sequencer,](https://dev.epicgames.com/documentation/en-us/fortnite/sequencer-and-control-rig-in-unreal-editor-for-fortnite)you have to create a **Level Sequence** and drag a [Cinematic Sequence device](https://dev.epicgames.com/documentation/en-us/fortnite/using-cinematic-sequence-device-in-unreal-editor-for-fortnite) into the [viewport](https://dev.epicgames.com/documentation/en-us/fortnite/unreal-editor-for-fortnite-glossary#viewport).

1. Right-click in the **[Content Browser](https://dev.epicgames.com/documentation/en-us/fortnite/content-browser)** and select **Cinematics** > **Level Sequence**.

   [![Open the Right-click menu and create a Level Sequence.](https://dev.epicgames.com/community/api/documentation/image/87cdf5e9-e5a5-44bf-b596-09034d5828cb?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/87cdf5e9-e5a5-44bf-b596-09034d5828cb?resizing_type=fit)
2. Name the Level Sequence thumbnail.
3. Double-click the thumbnail to open Sequencer.
4. Click **+Track** and select **Actor to Sequence** > **Add Device,**or search for the device in the search field.

   [![Add an actor to the Sequence Outliner](https://dev.epicgames.com/community/api/documentation/image/6b7efbe6-ce86-48f0-8aa4-69b798ae677d?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/6b7efbe6-ce86-48f0-8aa4-69b798ae677d?resizing_type=fit)
5. Click the **+** icon next to the device name and select **Gameplay Events** from the Track dropdown menu.

   [![Add a Gameplay Event to the device.](https://dev.epicgames.com/community/api/documentation/image/6b40d240-fafd-461d-a85c-dc2ff498ccf6?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/6b40d240-fafd-461d-a85c-dc2ff498ccf6?resizing_type=fit)
6. Add a **keyframe** to the **Gameplay Event**.

   [![Add a keyframe to the Gameplay Event.](https://dev.epicgames.com/community/api/documentation/image/5444e749-a406-4706-b14d-b054e41c01cd?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/5444e749-a406-4706-b14d-b054e41c01cd?resizing_type=fit)
7. Right-click the keyframe in the Timeline and select **Properties**. The **Key** menu opens.

   [![Add a time and function to the Key properties.](https://dev.epicgames.com/community/api/documentation/image/d5588917-9e50-4d8e-b96e-05c230ca1ea5?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/d5588917-9e50-4d8e-b96e-05c230ca1ea5?resizing_type=fit)
8. Add the **time** you want the device’s gameplay function to trigger in the **Time** field.
9. Select the device’s **gameplay event** from the **Gameplay Event Function Property** dropdown menu.

   Device functions in the **Gameplay Event Function Property** list match those of the selected device.
10. **Save** the Level Sequence.

### Playing the Level Sequence

When the Cinematic Sequence device plays the Level Sequence, the device events set in Sequencer trigger at the dedicated time set time in the Gameplay Events **Time field**.

Decide whether the Cinematic Sequence device should play the Level Sequence automatically at the beginning of the game, or set the device to play the sequence when triggered by another device, such as a [**Trigger**](https://dev.epicgames.com/documentation/en-us/fortnite-creative/using-trigger-devices-in-fortnite-creative) or a [**Timed Objective device**](https://dev.epicgames.com/documentation/en-us/fortnite-creative/using-timed-objective-devices-in-fortnite-creative).

[![The Cinematic Sequence device plays the Level Sequence which causes the devices to trigger at the times set in the Gameplay Time field.](https://dev.epicgames.com/community/api/documentation/image/bc7bed77-c352-4188-9d99-903a3d45f288?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/bc7bed77-c352-4188-9d99-903a3d45f288?resizing_type=fit)

1. Select the **Cinematic Sequence device** in the **[Outliner](https://dev.epicgames.com/documentation/en-us/fortnite/outliner-panel)** or the [Viewport](https://dev.epicgames.com/documentation/en-us/fortnite/user-interface-reference-for-unreal-editor-for-fortnite#viewport).
2. Click on the blank field in the **Sequence** option and select a **Level Sequence**.

   [![Add a sequence to the Cinematic Sequence device.](https://dev.epicgames.com/community/api/documentation/image/0331c615-de15-44f8-9a6e-f9ee5067566f?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/0331c615-de15-44f8-9a6e-f9ee5067566f?resizing_type=fit)
3. Uncheck **Autoplay** to remove the autoplay function. Only do this if you plan to have a device trigger the play function of the Cinematic Sequence device.

   [![Uncheck the Autoplay option.](https://dev.epicgames.com/community/api/documentation/image/c7fd3589-d81b-4b5e-8348-795ad287b73a?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/c7fd3589-d81b-4b5e-8348-795ad287b73a?resizing_type=fit)
4. Click the **Array +** icon in the **Play Function** user option.

   [![Add the device and event that triggers the Cinematic Sequence device.](https://dev.epicgames.com/community/api/documentation/image/bd3b2765-2b74-4c2f-971d-fff49ffe7d66?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/bd3b2765-2b74-4c2f-971d-fff49ffe7d66?resizing_type=fit)
5. Select a **device** from the top **Play Function dropdown menu**.
6. Select an **Event** from the **Event dropdown menu**.

Leave the default values for the other user options unless you want to change their values for your Level Sequence.

You can add multiple devices to a Level Sequence and set a single or several staggered triggering times for each device in the Level Sequence.

You can even set one device (or more) to trigger multiple times over a period of time or timed intervals.

**Single Event**

**Multiple Events**

**Multiple Events for a Single Device**
