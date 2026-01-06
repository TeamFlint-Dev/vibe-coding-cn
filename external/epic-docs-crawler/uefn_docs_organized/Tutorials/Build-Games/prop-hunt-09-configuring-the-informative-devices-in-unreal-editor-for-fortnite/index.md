# 9. Configuring the Informative Devices

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/prop-hunt-09-configuring-the-informative-devices-in-unreal-editor-for-fortnite
> **爬取时间**: 2025-12-27T00:23:06.902839

---

This section will show you how to configure devices that can send useful information like instructions to players. This section also includes devices that send information to the game to keep track of information like player scores.

**Devices used:**

- 4 x [HUD Messages](https://dev.epicgames.com/documentation/en-us/fortnite-creative/using-hud-message-devices-in-fortnite-creative)
- 2 x [HUD Controller](https://dev.epicgames.com/documentation/en-us/fortnite-creative/using-hud-controller-devices-in-fortnite-creative)
- 2 x [Score Managers](https://dev.epicgames.com/documentation/en-us/fortnite-creative/using-score-manager-devices-in-fortnite-creative)
- 1 x [Tracker](https://dev.epicgames.com/documentation/en-us/fortnite-creative/using-tracker-devices-in-fortnite-creative)
- 2 x [Timers](https://dev.epicgames.com/documentation/en-us/fortnite-creative/using-timer-devices-in-fortnite-creative)

## HUD Message Device

[![HUD Message](https://dev.epicgames.com/community/api/documentation/image/1d4af039-2faf-4350-b5ae-053784fe59d2?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/1d4af039-2faf-4350-b5ae-053784fe59d2?resizing_type=fit)

This device sends on-screen messages to players to let them know what team they are on. These messages are activated when a player’s class and team are set through Verse.

Place four of these devices, two for each team, in an area unseen by players. One device will display the team’s title and the other device will display the team’s instructions. Both of these devices will display at the same time.

To set up the title message for the prop team, configure the **User Options** as shown in the table below.

[![Modified HUD Message](https://dev.epicgames.com/community/api/documentation/image/a67f8d7c-4aa0-4ae3-b912-6942475aa652?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/a67f8d7c-4aa0-4ae3-b912-6942475aa652?resizing_type=fit)

| Option | Value | Explanation |
| --- | --- | --- |
| **Message** | You are a Prop. | Determines what message to display. |
| **Message Recipient** | Triggering Player | Each player will have an instance of this message displayed. |
| **Text Style** | Bold Blue | Sets the text’s color. |
| **Play Sound** | Stinger\_Unlock\_01\_Cue | Sets the audio for when this message is displayed. |
| **Placement** | Custom | The placement for this message will be further customized beyond the available options. |
| **Screen Anchor** | Top Center | The message will be displayed at this location. |
| **Placement Vertical** | 465 | Sets the vertical position of this message. |
| **Layer** | 0 | Sets the priority placement this message will display in. |

To set up the instruction message for the prop team, configure the **User Options** as shown in the table below.

[![Modified HUD Message](https://dev.epicgames.com/community/api/documentation/image/3d144fcd-4ad0-4855-beab-54d451e924e8?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/3d144fcd-4ad0-4855-beab-54d451e924e8?resizing_type=fit)

| Option | Value | Explanation |
| --- | --- | --- |
| **Message** | Hide from hunters. Survive. | Determines what message to display. |
| **Message Recipient** | Triggering Player | Each player will have an instance of this message displayed. |
| **Text Style** | Blue | Sets the text’s color. |
| **Play Sound** | Stinger\_Unlock\_01\_Cue | Sets the audio for when this message is displayed. |
| **Placement** | Custom | The placement for this message will be further customized beyond the available options. |
| **Screen Anchor** | Top Center | The message will be displayed at this location. |
| **Placement Vertical** | 465 | Sets the vertical position of this message. |
| **Layer** | 1 | Sets the priority placement this message will display in. |

To set up the title message for the hunter team, configure the **User Options** as shown in the table below.

[![Modified HUD Message](https://dev.epicgames.com/community/api/documentation/image/9c1acfcf-b00f-4fcd-9346-7729da7257c4?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/9c1acfcf-b00f-4fcd-9346-7729da7257c4?resizing_type=fit)

| Option | Value | Explanation |
| --- | --- | --- |
| **Message** | You are a Hunter. | Determines what message to display. |
| **Message Recipient** | Triggering Player | Each player will have an instance of this message displayed. |
| **Text Style** | Bold Orange | Sets the text’s color. |
| **Play Sound** | Stinger\_Threat\_01\_Cue | Sets the audio for when this message is displayed. |
| **Placement** | Custom | The placement for this message will be further customized beyond the available options. |
| **Screen Anchor** | Top Center | The message will be displayed at this location. |
| **Placement Vertical** | 400 | Sets the vertical position of this message. |
| **Layer** | 0 | Sets the priority placement this message will display in. |

To set up the instruction message for the hunter team, configure the **User Options** as shown in the table below.

[![Modified HUD Message](https://dev.epicgames.com/community/api/documentation/image/25f2f769-5d3b-4a84-806c-dc9b31618a6b?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/25f2f769-5d3b-4a84-806c-dc9b31618a6b?resizing_type=fit)

| Option | Value | Explanation |
| --- | --- | --- |
| **Message** | Find props. Eliminate them. | Determines what message to display. |
| **Message Recipient** | Triggering Player | Each player will have an instance of this message displayed. |
| **Text Style** | Orange | Sets the text’s color. |
| **Play Sound** | Stinger\_Unlock\_01\_Cue | Sets the audio for when this message is displayed. |
| **Placement** | Custom | The placement for this message will be further customized beyond the available options. |
| **Screen Anchor** | Top Center | The message will be displayed at this location. |
| **Placement Vertical** | 465 | Sets the vertical position of this message. |
| **Layer** | 1 | Sets the priority placement this message will display in. |

## HUD Controller

[![HUD Controller](https://dev.epicgames.com/community/api/documentation/image/26d5dbea-216a-41a9-bbb5-51854e845eff?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/26d5dbea-216a-41a9-bbb5-51854e845eff?resizing_type=fit)

This device can modify and determine the information displayed to players. For this tutorial, this device is used to remove unneeded UI information.

Place two devices in an area unseen by players. One device will alter the UI shown during the game. The other device will alter the UI shown in the lobby.

To set up the controller for the lobby UI, configure the device’s **User Options** to match the table below.

[![Modified HUD Controller](https://dev.epicgames.com/community/api/documentation/image/5d205145-0742-4884-b237-6a9cd09fa77c?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/5d205145-0742-4884-b237-6a9cd09fa77c?resizing_type=fit)

| Option | Value | Explanation |
| --- | --- | --- |
| **Show HUD** | No | Player’s HUD will be hidden by default. |
| **Show Map Scoreboard Prompt** | Yes | Determines if the map or scoreboard prompt is visible. |
| **Show Interaction Prompts** | Yes | Determines if the interaction prompts are visible. |
| **Priority** | Highest | Determines the priority of this device’s effects. |

To set up the controller for the game UI, configure the device’s **User Options** to match the table below.

[![Modified HUD Controller](https://dev.epicgames.com/community/api/documentation/image/8f004205-da01-4451-be6d-038121d06e07?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/8f004205-da01-4451-be6d-038121d06e07?resizing_type=fit)

| Option | Value | Explanation |
| --- | --- | --- |
| **Show HUD** | No | Player’s HUD will be hidden by default. |
| **Show Map Scoreboard Prompt** | Yes | Determines if the map or scoreboard prompt is visible. |
| **Display Reticle** | Only Show Weapon Reticles | Determines the type of reticle that is displayed on the player’s screen. |
| **Show Equipped Item Info** | Yes | Determines if the info for the equipped item is visible. |
| **Show Interaction Prompts** | Yes | Determines if the interaction prompts are visible. |

## Score Manager Device

[![Score Manager](https://dev.epicgames.com/community/api/documentation/image/34a94330-2914-4db2-945d-fbf958895eef?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/34a94330-2914-4db2-945d-fbf958895eef?resizing_type=fit)

Use Score Managers to send score information to the game. This device is used with Verse to set scoring values and to award scores at the appropriate times.

Place two devices, one for each team, in an area unseen by players.

One device will be for awarding props when the score timer completes. To set up this device, configure the **User Options** as shown in the table below.

[![Modified Score Manager](https://dev.epicgames.com/community/api/documentation/image/a86a5998-3e04-4035-aebd-ea43b0f1f54a?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/a86a5998-3e04-4035-aebd-ea43b0f1f54a?resizing_type=fit)

| Option | Value | Explanation |
| --- | --- | --- |
| **Activating Team** | Team Index: 2 | Determines which Team can activate the device. |

The other Score Manager will be used for awarding hunters when they eliminate props. To set up this device, configure the **User Options** as shown in the table below.

[![Modified Score Manager](https://dev.epicgames.com/community/api/documentation/image/97d0df7a-db00-4723-9464-e26ae6211cbe?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/97d0df7a-db00-4723-9464-e26ae6211cbe?resizing_type=fit)

| Option | Value | Explanation |
| --- | --- | --- |
| **Activating Team** | Team Index: 1 | Determines which Team can activate the device. |
| **Play Audio** | False | Determines whether the device should play audio effects. |

## Tracker Device

[![Tracker](https://dev.epicgames.com/community/api/documentation/image/88f0d1d3-f454-4c4e-aa4b-9f4e7699eb89?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/88f0d1d3-f454-4c4e-aa4b-9f4e7699eb89?resizing_type=fit)

You can use this device to keep track of custom objectives like the remaining props in this gameplay. Verse is also used with this device to display the amount of props remaining on the screen.

To customize this device, configure the **User Options** to match the settings in the table below.

[![Modified Tracker](https://dev.epicgames.com/community/api/documentation/image/916e3196-0730-400a-9a3e-1d55e392ace8?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/916e3196-0730-400a-9a3e-1d55e392ace8?resizing_type=fit)

| Option | Value | Explanation |
| --- | --- | --- |
| **Stat to Track** | Event | This device will not track any statistics, but the Tracker Value can be changed using events. |
| **Target Value** | 0 | Sets the target value at which the Tracker will be considered complete. When set to 0, it will never be completed. |
| **Tracker Title** | Props Remaining | Assigns a title to the Tracker which will only be displayed if **Show On Hud** is on. |
| **Sharing** | All | The Tracker’s progress will be counted for everyone. |
| **When Target is Reached** | Do Nothing | Determines what should happen when the target Tracker Value is reached. |
| **Show on HUD** | List | Determines whether the Tracker’s information is displayed on the player’s HUD. |

## Timer Device

[![Timer](https://dev.epicgames.com/community/api/documentation/image/febe5e86-5b0e-40e4-b953-5518adbb3f2e?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/febe5e86-5b0e-40e4-b953-5518adbb3f2e?resizing_type=fit)

Use this device to set timed events in your gameplay. This tutorial uses three Timer devices for different events.

The first timer counts down after enough players have joined the game. When completed, it starts the Round Settings device and the timer that counts down for hunters to wait for props to hide.

Place the first Timer device in an area unseen by players.

This is the Timer that starts both the round and the timer that waits for props to hide. Verse is also used with this device to start the five-second countdown.

To set up this device, customize its **User Options** to match the table below.

[![Modified Timer](https://dev.epicgames.com/community/api/documentation/image/91d9a26d-2fdb-4129-a328-7afa01d8a6a9?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/91d9a26d-2fdb-4129-a328-7afa01d8a6a9?resizing_type=fit)

| Option | Value | Explanation |
| --- | --- | --- |
| **Duration** | 5.0 | Sets the timer’s length. |
| **Can Interact** | No | Players will not be able to interact with this device. |
| **Visible During Game** | Hidden | This device will not be visible during gameplay. |
| **Display Time In** | Seconds Only | Determines how the time is displayed. |
| **Timer Running Text** | Round Starting in… | This is the secondary text to display when the timer is running. |
| **Timer Label Text Style** | Bold | Sets the text’s font style. |

Place another Timer device in an area unseen by players. For this tutorial, this device is named "Hunter Wait Timer Device".

This timer will give a time limit for the hunters to find props when the game starts. When it completes, it enables the prop timer and sends an event to Verse that handles the logic for teleporting hunters into the game area.

[![Modified Timer](https://dev.epicgames.com/community/api/documentation/image/f186f284-3503-459b-b6d3-61a4a5b34845?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/f186f284-3503-459b-b6d3-61a4a5b34845?resizing_type=fit)

| Option | Value | Explanation |
| --- | --- | --- |
| **Duration** | 15.0 | Sets the timer’s length. |
| **Can Interact** | No | Players will not be able to interact with this device. |
| **Completion Behavior** | Restart | This device will start again when the timer completes. |
| **Visible During Game** | Hidden | This device will not be visible during gameplay. |
| **Display Time In** | Seconds Only | Determines how the time is displayed. |
| **Timer Running Text** | Hunters go in… | This is the secondary text to display when the timer is running. |
| **Enable Urgency Mode** | True | This allows the device to enter urgency mode at the time set in the **Urgency Mode Time** option. |
| **Urgency Mode Time** | 10.0 | Determines the time that starts urgency mode. |
| **Start** | Round Settings - On Round Start | This setting links with the Round Setting device you placed earlier to start the timer. |

## Next Section

[![10. Customize the Gameplay](https://dev.epicgames.com/community/api/documentation/image/1eafebcc-0a6a-4e5b-b4b6-a1ce64a705c5?resizing_type=fit&width=640&height=640)

10. Customize the Gameplay

Use these devices to customize the gameplay experience.](https://dev.epicgames.com/documentation/en-us/fortnite/prop-hunt-10-customizing-the-gameplay-in-unreal-editor-for-fortnite)
