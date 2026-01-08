# Tracker Devices

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/using-tracker-devices-in-fortnite-creative>
> **爬取时间**: 2025-12-26T23:48:46.691442

---

Use the **Tracker** device to create and track custom [objectives](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) that a player can complete, and send a signal to another device when the player completes a tracked objective.

You can track objectives set for individual players, a team, or multiple teams. For teams, you can also track persistence data for individual players from one session to the next. (For more on this, see [Tracking Persistence Data](https://dev.epicgames.com/documentation/en-us/fortnite/using-tracker-devices-in-fortnite-creative) below.

For help on how to find the Tracker device, see [Using Devices](https://dev.epicgames.com/documentation/en-us/fortnite/using-devices-in-fortnite).

You'll need a separate tracker for each objective you want to track.

If you're using multiple copies of a device on an island, it can be useful to [rename](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) them. Choosing names that relate to a device's purpose makes it easier to remember what each one does, and easier to find a specific device when using the [Event Browser](https://dev.epicgames.com/documentation/en-us/fortnite/event-browser-in-fortnite-creative).

## Contextual Filtering

Some devices are affected by a feature called contextual filtering. This feature hides or displays options depending on the values selected for certain related options. This feature will reduce clutter in the Customize panel and make options easier to manage and navigate.

However, it may not be easy to recognize which options or values trigger contextual filtering. To help you identify them, in our device docs we use *italic* for any values that trigger contextual filtering. All options will be listed, including those affected by contextual filtering; if they are hidden or displayed based on a specific option's value, there will be a note about that in the **Description** field for that option.

## Device Options

This device has some basic functionality, like which stat is tracked, and the value for that stat when the target is met. There are also some advanced options, like whether completion progress is shared among team members or tracked individually.

Default values are **bold**. Values that trigger contextual filtering are *italic*.

You can configure this device with the following options.

| Option | Values | Description |
| --- | --- | --- |
| **Stat to Track** | **Eliminations**, Pick a stat to track | Determines which statistic the device will track for the **Tracker Value**.  Stats that can be tracked are:   - **Events** - **Eliminations** (default) - **Eliminated** - **Score** - **Chest Opened** - **Llama Opened** - **Player Revived** - **Player Interrogated** - **Race Checkpoint Activated** - **Fish Fished** - **Weapon Fished** - **Prop Destroyed** - **Shield Potion Consumed** - **Distance Traveled on Foot** - **Distance Traveled in Vehicle** - **Distance Traveled in Air** - **Distance Traveled** - **Round Completed** - **Round Won** - **Game Completed** - **Game Won** - **Play Time Elapsed** |
| **Reset on First Spawn** | **No**, Yes | Determines whether the tracked stat will be reset when the player spawns in to a new game or round. If **Stat to Track** is set to **Rounds Completed**, **Rounds Won**, **Games Complete**, or **Games Won**, the device will not be reset regardless of the setting you select here. |
| **Target Value** | **10**, Pick a number | When the device counts to the selected value, the objective is complete. If you select **0**, the tracker will never complete. |
| **Starting Value** | **0**, Pick or enter a number | Determines the value the tracker is set to when it first begins tracking. |
| **Valid Team** | **Any**, Pick or enter a number | This tracker can be assigned to players on the selected team. |
| **Assign on Game Start** | **On**, Off | Determines whether this tracker is assigned to applicable players when the game starts. |
| **Assign When Joining in Progress** | **On**, Off | Determines whether a player will be assigned this tracker when they join a game already in progress. |
| **Sharing** | **Individual**, Team, All | Determines whether progress is tracked for individual players, for all members of a team, or whether all players contribute progress toward a single target value. Note that if you want to use the **Resolves Conflicts** option with persistence data (statistics carried forward from session to session) you will need to set this to **Team** or **All**, as **Resolves Conflicts** doesn't apply to individual players. See [Tracking Persistence Data](https://dev.epicgames.com/documentation/en-us/fortnite/using-tracker-devices-in-fortnite-creative) for more info. |
| **Target Team** | **Any**, Pick or enter a number | Determines which team is tracked when the **Stat to Track** option is set to **Eliminations** or **Eliminated**. |
| **Target Class** | **Any**, Pick or enter a number | Determines which class is tracked when the **Stat to Track** option is set to **Eliminations** or **Eliminated**. |
| **When Target Is Reached** | Do Nothing, End Round, **Complete Tracker** | Determines what happens when the target tracker value is reached. |
| **Winning Team** | Completing Team Wins, **Use Game Win Conditions**, Pick or enter a number | Determines which team wins the round when the tracker is completed. This option is only valid if the **When Target is Reached** option is set to **End Round**. |
| **Amount to Change on Event** | **1**, Pick or enter a number | Determines how much to increment (add) or decrement (subtract) the tracker value each time the **Increment Progress When Receiving From** or **Decrement Progress When Receiving From** option is triggered. |
| **Show on HUD** | No, Detailed, List, **Both** | Determines whether tracker progress is displayed on the player's HUD. If you choose **Detailed** or **Both**, a color-coded text box displays in the upper left of the player's HUD.  [Quest Box](https://dev.epicgames.com/community/api/documentation/image/f2535126-601f-4a92-9c35-94945e41939c?resizing_type=fit) |
| **Tracker Title** | Enter text | Assigns a title to the tracker, which is displayed if **Show on HUD** is enabled. The text field has a 32-character limit. |
| **Description Text** | Enter text | Assigns a description to the tracker, which is displayed below the title if the **Show on HUD** option is enabled. The text field has a 64-character limit. |
| **Show Progress** | **Total**, Remaining, Off | Determines whether **Tracker Progress** is displayed after the **Tracker Description** if the **Show on HUD** option is enabled. If you choose **Total**, the tracker will count up to the target value. If you choose **Remaining**, the tracker will count down from the target value. |
| **HUD Widget** | **Default**, Slim, Tiny | Determines which widget is used for the HUD. |
| **Tracker Completion Ceremony** | **Yes**, No | Determines whether or not the completion of this tracker will be accompanied by a ceremony. |
| **Quest Icon** | **None**, Pick an icon | Sets the icon that shows on the quest box if the **Shown on HUD** option is set to show tracked stats. Click the icon to open the Icon Library picker, and choose an icon by scrolling through the Icon Library, or type a word into the search box to search for a specific icon. Select an icon, then click the checkmark. See the [Icon List table](https://dev.epicgames.com/documentation/en-us/fortnite/using-tracker-devices-in-fortnite-creative) below for available icons.  [Icon Picker](https://dev.epicgames.com/community/api/documentation/image/6c2e4aa5-0177-4b4e-9f69-e37b8e998338?resizing_type=fit) |
| **Color** | **#FFFFFF**, Pick a color | Sets the color of the icon and the quest box. Click the color swatch to open the color picker. Each color swatch has its hex code next to the swatch. You can also type a hex code into the search bar to find a specific color. Select a color, then click the checkmark.  [Color Picker](https://dev.epicgames.com/community/api/documentation/image/fa54887e-5133-4735-9139-255640e9e675?resizing_type=fit) |
| **Use Persistence** | **Off**, *On* | Determines whether this device should load data from earlier game sessions. If you set this to **On**, more options will show. Also see [Tracking Persistence Data](https://dev.epicgames.com/documentation/en-us/fortnite/using-tracker-devices-in-fortnite-creative) below. |
| **Auto Save** | Yes, **No** | This only displays if **Use Persistence** is set to **On**. Determines if the device saves its data automatically. |
| **Auto Load** | Initial Spawn, **Off** | This only displays if **Use Persistence** is set to **On**. Determines whether the device data and player's progress is automatically loaded. If this is set to **Initial Spawn**, data will only be loaded when the player initially spawns. If this is set to **Off**, data is never auto-loaded, and the creator needs to activate this with an event. |
| **Resolves Conflicts** | **Highest**, Lowest, First Player, Average, Median | This option only displays if **Use Persistence** is set to **On**. Conflict resolution is how the game treats persistence data when players join a new session. When a tracker affects more than one player at the same time, the setting selected here will determine how the tracked value is applied. Note that this option only has an effect on the game if **Sharing** is set to **Team** or **All**. It has no effect if **Sharing** is set to **Individual**.  This option determines what number the tracker should start with at the beginning of a session.   - **Highest**: Applies the highest value in the group to each player. - **Lowest**: Applies the lowest value in the group to each player. - **First Player**: Uses the value from the first player loaded into that session and applies it to each player in the group. - **Average**: Takes the average value across all tracked players in the current session. - **Median**: Takes the value in the middle of all sorted values for this session. |
| **Resolves Conflict After Tracker Active** | **Yes**, No | This option only displays if **Use Persistence** is set to **On**. This option determines whether the value of the tracked stat is recalculated based on the persistence value of new players. |

## Tracking Persistence Data

You can set the Tracker device to collect persistence data, meaning stats tracked across multiple sessions, with multiple players or teams.

Persistence is based on player data for a specific island, and will track multiple players for a single island.

For example, if you have a group quest where players have to collectively tame 200 wolves, but the group only manages to tame 100 before the session ends, a player can return the next day and continue taming the wolves. However, the player may be playing with a different group entirely, and that's where conflict resolution becomes important.

If the **Resolves Conflict** option is set to **Average**, in the new group, you might have one player with a persistent tracked value of 50, another with a value of 100, and a third player new to the game who starts with 0. In this case the starting value for each player would be 50+100+0/3, or **50** if you've selected **Average**.

The same tracked values set for **Median** would be **50**, based on the median (middle) value: 0 - **50** - 100.

## Direct Event Binding

Following are the [direct event binding](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) options for this device.

### Functions

A [function](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) listens for an event on a device then performs an action.

1. For any function option, click the **option**, then **Select Device** to access and select from the **Device dropdown menu**.
2. Once you've selected a device, click **Select Event** to bind the timer to an event that will trigger the function for the device.
3. If more than one device should be affected by a function, press the **Add** button and repeat.

| Option | Description |
| --- | --- |
| **Remove From All When Receiving From** | This function removes the tracker from all valid players when an event occurs. |
| **Complete When Receiving From** | Immediately completes the tracker when when an event occurs. |
| **Reset Progress When Receiving From** | Resets the progress for the triggering player (and any players sharing progress) when an event occurs. |
| **Increment Progress When Receiving From** | Increases the tracker's v+alue when an event occurs. |
| **Remove When Receiving From** | Removes the tracker from the triggering player, and any players sharing the event. |
| **Assign When Receiving From** | Assigns the tracker to the [instigating](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) player (and any players sharing progress) when an event occurs. |
| **Assign to All When Receiving From** | Assigns the tracker to all valid players when an event occurs. |
| **Increase Target Value When Receiving From** | Increases the value of the target when an event occurs. |
| **Decrease Target Value When Receiving From** | Decreases from the target value when an event occurs. |
| **Decrement Progress When Receiving From** | Subtracts from the target value when an event occurs. |
| **Save When Receiving From** | Saves the device data and player's personal progress when an event occurs. |
| **Load for Player When Receiving From** | Loads instigating player's data when an event occurs . |
| **Load for All When Receiving From** | Loads all player data when an event occurs. |
| **Clear Persistence When Receiving From** | Clears instigating player's data when an event occurs. |
| **Save for All When Receiving From** | Saves player data for all players when an event occurs. |
| **Clear for All When Receiving From** | Clears data for all players when an event occurs. |

### Events

An [event](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) tells another device when to perform a function.

1. For any event option, click the **option**, then **Select Device** to access and select from the **Device dropdown menu**.
2. Once you've selected a device, click **Select Function** to bind the timer to a function for that device.
3. If more than one device is affected by the function, press the **Add** button and repeat.

| Option | Description |
| --- | --- |
| **When Complete Send Event To** | When the tracker completes, it sends an event to the selected device, which triggers the selected function. |
| **On Saved Send Event To** | When the tracker saves data and players progress, it sends an event to the selected device, which triggers the selected function.. |
| **On Loaded Send Event To** | When the tracker loads data and players progress, it sends an event to the selected device, which triggers the selected function. |
| **On Cleared Send Event To** | When device clears persistent data, it sends an event to the selected device, which triggers the selected function. |

## Using the Tracker Device in Verse

You can use the code below to control a Tracker device in [Verse](https://dev.epicgames.com/documentation/en-us/uefn/learn-programming-with-verse-in-unreal-editor-for-fortnite). This code shows how to use events and functions in the Tracker device API. Modify it to fit the needs of your experience.

```verse
using { /Fortnite.com/Devices }
using { /Verse.org/Simulation }
using { /Verse.org/Random }
using { /UnrealEngine.com/Temporary/Diagnostics }

# A Verse-authored creative device that can be placed in a level
tracker_device_verse_example := class(creative_device):

    # Reference to the Switch Device in the level.
    # In the Details panel for this Verse device,
    # set this property to your Switch Device.
    @editable
    MyTrackerDevice:tracker_device = tracker_device{}

    # Runs when the device is started in a running game
    OnBegin<override>()<suspends>:void=
        # Example for subscribing to an event on the Creative device.
        # Signaled when the tracked value reaches `GetTarget` for an `agent`.
        # Sends the `agent` that reached `GetTarget` for their tracked value.
        MyTrackerDevice.CompleteEvent.Subscribe(OnObjectiveCompleted)

        for(Player : GetPlayspace().GetPlayers()):

            # Sets the target value that must be achieved in order for `CompleteEvent` to trigger.
            # Clamped to `0 <= TargetValue <= 10000`.
            MyTrackerDevice.SetTarget(5)

            # Assign Tracker device to player.
            MyTrackerDevice.Assign(Player)

            # Get random integer value between 1 and 3.
            TargetValueIncrease:int = GetRandomInt(1,3)
            Print("Random target increase is {TargetValueIncrease}")

            # Increase this player's target value by the random integer.
            # `for (X := 1..TargetValueIncrease):` runs as many times as TargetValueIncrease
            for (X := 1..TargetValueIncrease):
                # Increases the target value for `Agent` by 1.
                MyTrackerDevice.IncreaseTargetValue(Player)

        # Wait for 10 seconds.
        Sleep(10.0)

        # This example iterates through all players in the experience to show how to do operations per player on the device.
        for(Player : GetPlayspace().GetPlayers()):
            # Is true if `Agent` has reached the *TargetValue* for the tracker.
            # `not` operation inverts the result of HasReachedTarget function call
            if (not MyTrackerDevice.HasReachedTarget[Player]):
                Print("Player has not reached target.")
            else:
                Print("Player has reached target.")
                # Saves tracked progress for `Agent`. Only valid if *Use Persistence* is set to *Use*.
                MyTrackerDevice.Save(Player)

    # This function runs when the player reaches the target value for the Tracker device because it's an event handler for CompleteEvent.
    OnObjectiveCompleted(Agent:agent):void=
        Print("Objective for tracker device completed.")

        # Returns the current tracked value for `Agent`.
        TargetValue := MyTrackerDevice.GetValue(Agent)
        Print("Target for completed objective for agent is {TargetValue}")
```

To use this code in your UEFN experience, follow these steps.

1. Drag a Tracker device onto your island.
2. Create a new Verse device named **tracker\_device\_verse\_example**. See [Create Your Own Device Using Verse](https://dev.epicgames.com/documentation/en-us/uefn/create-your-own-device-in-verse#creatinganewdevicewithverse) for steps.
3. In Visual Studio Code, open **tracker\_device\_verse\_example.verse** in Visual Studio Code and paste the code above.
4. Compile your code and drag your Verse-authored device onto your island. See [Adding Your Verse Device to Your Level](https://dev.epicgames.com/documentation/en-us/uefn/create-your-own-device-in-verse#addingyourversedevicetoyourlevel) for steps.
5. Add a reference for the Tracker device on your island to your Verse device. See [Adding a Verse Reference to a Creative Device in Your Level](https://dev.epicgames.com/documentation/en-us/uefn/customize-device-properties-in-verse#addingaversereferencetoacreativedeviceinyourlevel) for steps.
6. Save your project and click **Launch Session** to playtest.

### Tracker Device Verse API

See the [`tracker_device` API Reference](https://dev.epicgames.com/documentation/en-us/uefn/verse-api/fortnitedotcom/devices/tracker_device) for more information on using the Tracker device in Verse.
