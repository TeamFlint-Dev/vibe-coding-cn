# Timer Devices

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/using-timer-devices-in-fortnite-creative
> **爬取时间**: 2025-12-26T23:39:58.710478

---

The **Timer device** provides a way for players to keep track of the time something has taken, either for scoreboard purposes or to trigger actions. It can be configured in several ways, and act either as a countdown to an event that is triggered at the end, or as a stopwatch for an action that needs to be completed before a set time runs out.

To find the Timer device, see the instructions in [Using Devices](https://dev.epicgames.com/documentation/en-us/fortnite/using-devices-in-fortnite).

## Timer States

The Timer device has different **states** it can be in at different times. The possible states are listed below, with descriptions. Some options move the device from one state to another, or trigger an action when the device enters a particular state.

| Timer State | Description |
| --- | --- |
| **Start** | If a timer is **Paused**, this option will cause it to start ticking down to zero from its current time. |
| **Pause** | A **Paused** timer does not change time. It can be restarted. |
| **Reset** | When a timer is **Reset**, it sets the time remaining to the total duration and **Pauses** the timer. |
| **Stopped** | A **Stopped** timer does not change time. It cannot be restarted and must be reset. |
| **Complete** | Stops the timer and plays effects to let players know it has **completed**. |
| **Time-Out** | When a timer reaches zero seconds, it has **timed out** and stops counting down. This may or may not complete the timer, depending on the device settings used. |

## Contextual Filtering

Some devices are affected by a feature called contextual filtering. This feature hides or displays options depending on the values selected for certain related options. This feature will reduce clutter in the Customize panel and make options easier to manage and navigate.

However, it may not be easy to recognize which options or values trigger contextual filtering. To help you identify them, in our device docs we use italic for any values that trigger contextual filtering. All options will be listed, including those affected by contextual filtering; if they are hidden or displayed based on a specific option’s value, there will be a note about that in the Description field for that option.

## Device Options

In its [default](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#default) state, the Timer device is a countdown clock. At the start of a game, the timer shows a one-minute countdown, but by default does not start counting down. You will need to adjust the device options to use it. Players can't interact directly with the device, although they can trigger it indirectly by interacting with other devices that are [bound](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#direct-event-binding) to the timer.

Configure this device with the following options.

Default values are in **bold**. Values that trigger contextual filtering are *italic*.

| Option | Value | Description |
| --- | --- | --- |
| **Duration** | **1 minutes**, Pick an amount of time | This determines how long the timer runs. |
| **Timer Name** | Enter text into field | Type a name for the timer. The text field has a limit of 24 characters. |
| **Count Down Direction** | **Count Down**, Count Up | Determines whether the timer counts down from the **Duration** to zero, or up from zero to the **Duration**. |
| **Start at Game Start** | **Off**, On | Determines whether the timer starts when the game starts. |
| **Can Interact** | No, *Only Start*, *Only Complete*, ***Yes*** | Determines if and when players can interact with the timer. If you choose **No** the **Interact Time** option does not display. |
| **Interact Time** | **Instant** (0), Pick a time | This option only displays if you have set the **Can Interact** option to **Yes**, **Only Complete**, or **Only Start**. Determines how long a player has to interact with the timer to start or complete the countdown. |
| **Activating Team** | **Any**, Pick a team number | Determines which team's players can activate the device. If you choose **Any**, any player can activate it. |
| **Applies To** | Player, **Everyone** | When a timer starts, this determines whether it is tracked for the activating player only, or if it is tracked for everyone. Saving and loading timers only works if this is set to **Player**. |
| **Success on Timer End** | **True**, False | If timer reaches the end of the countdown instead of being triggered by an event, whether this counts as a success (true) or failure (false). For example, a success would be making it to the end of the countdown for a survival-type game, but a failure for a timed-objective game. |
| **Completion Behavior** | Disable, **Stop**, Reset, Restart | Determines what happens when the timer finishes counting.  Values for this option are:   - **Disable**: Puts the device into the Disabled state. - **Stop**: Leaves the timer in its end state, with the UI displaying success or failure; the timer cannot be restarted unless it is reset. - **Reset**: Returns the timer to its beginning state. - **Restart**: This resets the timer, then starts it again. |
| **Visible During Game** | Hidden, **Only Timer**, All | Determines whether players can see the device during the game. |
| **Timer Color** | **White**, Pick a color | If the timer is visible, this determines what color the timer is. Click the arrow to display a color picker. |
| **Display Time In** | **Minutes:Seconds**, Seconds Only | Determines if the time is displayed in minutes and seconds, or only in seconds. |
| **Timer Not Started Text** | Enter text into field | Type the text players will see if the timer is enabled, but has not started. This is displayed before the timer has begun for the first time, or after a reset. The text field has a limit of 24 characters. |
| **Timer Running Text** | Enter text into field | Type the text players will see if the timer is running. The text field has a limit of 24 characters. |
| **Paused Text** | Enter text into field | Type the text players will see if the timer is paused. The text field has a limit of 24 characters. |
| **Success Score Value** | **0**, Pick a positive or negative number | If the the **Result On Timer End** option is set to **Success**, the timer adds this much score. |
| **Failure Score Penalty** | **0**, Pick a positive or negative number | If the the **Result On Timer End** option is set to **Failure**, the timer adds this score penalty. |
| **Score Per Second Remaining** | **0**, Pick a positive or negative number | The timer awards the selected amount of score for each second remaining on the timer. |
| **Show on HUD** | **Yes**, No | Determines whether a running timer is displayed in the HUD. |
| **Timer Label Text Style** | **Default**, Bold, Pick a style | Sets the style for the countdown and any secondary text the timer has. |
| **Use Persistence** | Yes, **No** | Determines whether the timer state can be saved and loaded. If you set this option to **Yes**, additional options are displayed. This can only be set to **Yes** if **Applies To** is set to **Player**. |
| **Load Elapsed Time** | Yes, **No** | This option only displays if the **Use Persistence** option is set to **Yes**. If you set this option to **Yes**, when a saved timer is loaded, it will calculate the elapsed time since the timer was saved. |
| **Auto-Save** | **Off**, On | This option only displays if the **Use Persistence** option is set to **Yes**. Determines whether the timer is automatically saved when between game sessions, and automatically loaded when the player rejoins. If the **Save Timer** is set to **Save and Continue** the timer continues running while the player is gone, but completion behavior is delayed until the player rejoins the game. |
| **Auto-Load** | **On**, Off | This option only displays if the **Use Persistence** option is set to **Yes**. Determines whether the timer automatically loads when the player joins or rejoins the game. If set to **Off** the timer can only be loaded using event binding. |
| **Auto-Load When** | Join In Progress, **Always** | This option only displays if the **Use Persistence** option is set to **Yes**. Determines if the auto-load occurs only when the player joins a game in progress, or whether it always loads when a player joins or rejoins a game in progress. |
| **Enable Urgency Mode** | **Off**, On | Allows device to enter urgency mode at the time set in the **Urgency Mode Time** option. If this is set to **On** additional options display. |
| **Urgency Mode Time** | **Never**, Pick an amount of time | This option only displays if the **Enable Urgency Mode** option is set to **Yes**. Urgency mode begins the selected amount of time before the timer count ends. |
| **Urgency Text** | Enter text into field | This option only displays if the **Enable Urgency Mode** option is set to **Yes**. Type the text players will see when the timer is in Urgency Mode. The text field has a limit of 24 characters. *This option only appears when **Urgency Mode** is enabled*. |
| **Audio Effects** | **On**, Off | Determines whether the timer plays audio effects during the game. |
| **If Instigating Player Is Not Present** | **Random Player**, Empty Instigator | When an event is sent, and the original instigating player is no longer in the game, this determines which player is made the instigator. |
| **Set Lap Time on Success** | On, **Off** | If this is set to **On**, a lap time is set for the player whenever this timer completes successfully. |
| **Lap Time Style** | **Time Elapsed**, Time Remaining | When a lap time is set, you can choose to display either time elapsed (how many seconds have elapsed on the timer) or time remaining (how many seconds are left). |
| **Display Score Update on HUD** | **Off**, *On* | Determines whether score updates are displayed as a HUD message. If you choose **On**, several additional options are displayed. |
| **Reset HUD Message Score** | On, **Off** | When the device displays a score message on the HUD, this determines whether it starts at zero. |
| **HUD Score Update Message** | **Score!**, Enter text | Determines what message is displayed on the HUD with the score. Use the default, or enter custom text. The text field has a limit of 150 characters. |
| **HUD Score Update Message Score Color** | **#BFEBFFFF**, Pick a color | Determines the color of the score displayed on the HUD. Click the swatch to open the Color Picker. You can click to select a swatch, or enter a hex code in the search bar to find that color.  [Color Picker](https://dev.epicgames.com/community/api/documentation/image/87d685dc-5d34-4d2c-93b8-d5b595910aea?resizing_type=fit) |
| **HUD Score Update Message Color** | **#00BAFFFF**, Pick a color | Determines the color of the text in the message you set in the **HUD Score Update Message** option. Click the swatch to open the Color Picker. You can click to select a swatch, or enter a hex code in the search bar to find that color. |
| **Display Score Update if Score is 0** | On, **Off** | Determines if the Score Update displays on the HUD if the score is zero. |
| **Activating Class** | No Class, All, **Any**, Pick a class | If the **Applies To** option is set to **Everyone**, this determines which classes can activate the timer. If the **Applies To** option is set to **Player** the timer only starts if a player is assigned the activating class. |
| **Disable Timer if Failing Team or Class Check** | On, **Off** | If this is set to **On** and the **Applies To** option is set to **Everyone**, and the player who activated the timer changes to another class or team that is not allowed, the timer is disabled for everyone. If the **Applies To** option is set to **Player**, then each player with a personal timer will be monitored for class or team changes. |
| **Reset Timer if Failing Team or Class Check** | On, **Off** | If this is set to **On** and the **Applies To** option is set to **Everyone**, and the player who activated the timer changes to another class or team that is not allowed, the timer is reset for everyone. If the **Applies To** option is set to **Player**, then each player with a personal timer will be monitored for class or team changes. |

## Direct Event Binding

Following are the [direct event binding](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#direct-event-binding) options for this device.

### Functions

A [function](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) listens for an event on a device then performs an action.

1. For any function option, click the **option**, then **Select Device** to access and select from the **Device dropdown menu**.
2. Once you've selected a device, click **Select Event** and select the event that triggers this function.
3. If more than one device should be affected by a function, click the **Add** button and repeat these steps.

| Option | Description |
| --- | --- |
| **Start When Receiving From** | Starts the timer when an event occurs. |
| **Complete When Receiving From** | Completes the timer when an event occurs. |
| **Reset When Receiving From** | Resets the timer when an event occurs. |
| **Pause When Receiving From** | Pauses the timer when an event occurs. |
| **Resume When Receiving From** | Resumes the timer when an event occurs. |
| **Enable When Receiving From** | Enables the timer when an event occurs. |
| **Disable When Receiving From** | Disables the timer when an event occurs. The timer pauses when disabled. |
| **Start for All When Receiving From** | Starts the personal timers for all players when an event occurs. |
| **Pause for All When Receiving From** | Pauses all personal timers when an event occurs. |
| **Resume for All When Receiving From** | Resumes all personal timers when an event occurs. |
| **Complete for All When Receiving From** | Sets all timers to a completed state when an event occurs and starts the completed behavior. |
| **Reset for All When Receiving From** | Resets all timers to their initial times, then stops them when an event occurs. |
| **Save When Receiving From** | Saves the time on the personal timer for the instigating player when an event occurs. |
| **Load When Receiving From** | Loads the saved time on the personal timer for the instigating player when an event occurs. |
| **Clear Persistence Data When Receiving From** | Clears saved data when an event occurs. |
| **Clear Persistence Data for All When Receiving From** | Clears saved data on all personal timers when an event occurs. |
| **Set Lap Time for Player When Receiving From** | Sets the lap time for for the instigating player when an event occurs. |
| **Set Lap Time for All When Receiving From** | Sets the lap time for all players with personal timers when an event occurs. |
| **Save for All When Receiving From** | Saves the time on personal timers for all players when an event occurs. |
| **Load for All When Receiving From** | Loads all saved times when an event occurs. |

### Events

An [event](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#event) tells another device when to perform a function.

1. For any event option, click the **option**, then **Select Device** to access and select from the **Device dropdown menu**.
2. Once you've selected a device, click **Select Function** to bind the timer to a function for that device.
3. If more than one device is affected by the function, press the **Add** button and repeat.

| Option | Description |
| --- | --- |
| **On Success Send Event To** | When the timer completes or ends with success, it sends an event to the selected device, which triggers the selected function. |
| **On Failure Send Event To** | When the timer ends with a failure, it sends an event to the selected device, which triggers the selected function. |
| **On Start Urgency Mode Send Event To** | When the timer enters urgency mode, it sends an event to the selected device, which triggers the selected function. |
| **On Saved Send Event To** | Send an event to the selected device when timer data is saved. |
| **On Loaded Send Event To** | Send an event to the selected device when timer data is loaded. |
| **On Cleared Send Event To** | Send an event to the selected device when timer data is cleared. |

## Gameplay Examples Using Timer Devices

- [5 Rounds of Econ Lessons](5-rounds-of-econ-lessons-in-fortnite-creative)
- [Loo Roll Rush](loo-roll-rush-in-fortnite-creative)
- [Shooting Gallery](https://dev.epicgames.com/documentation/en-us/fortnite/shooting-gallery-in-fortnite-creative)
- [Spawner 123](spawner-123-in-fortnite-creative)
- [Timed Door](timed-door-in-fortnite-creative)
- [Top Scorer In Class](top-scorer-in-class-in-fortnite-creative)
